Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE0B40B94F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 22:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbhINUdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 16:33:35 -0400
Received: from netrider.rowland.org ([192.131.102.5]:48555 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S233373AbhINUde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 16:33:34 -0400
Received: (qmail 169149 invoked by uid 1000); 14 Sep 2021 16:32:15 -0400
Date:   Tue, 14 Sep 2021 16:32:15 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Nechaev <petr.nechaev@cogentembedded.com>
Subject: Re: [PATCH v2] usb: gadget: storage: add support for media larger
 than 2T
Message-ID: <20210914203215.GA168961@rowland.harvard.edu>
References: <20210914151329.GD155245@rowland.harvard.edu>
 <20210914200917.24767-1-nikita.yoush@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914200917.24767-1-nikita.yoush@cogentembedded.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 11:09:17PM +0300, Nikita Yushchenko wrote:
> This adds support for READ_CAPACITY(16), READ(16) and WRITE(16)
> commands, and fixes READ_CAPACITY command to return 0xffffffff if
> media size does not fit in 32 bits.
> 
> This makes f_mass_storage to export a 16T disk array correctly.
> 
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> ---

You didn't mention here how this version of the patch differs from the 
previous version.  Some people care about things like this.

Nevertheless, the changes appear to be correct.

Acked-by: Alan Stern <stern@rowland.harvard.edu>

>  drivers/usb/gadget/function/f_mass_storage.c | 87 ++++++++++++++++++--
>  1 file changed, 80 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/f_mass_storage.c b/drivers/usb/gadget/function/f_mass_storage.c
> index 7c96c4665178..96de401f1282 100644
> --- a/drivers/usb/gadget/function/f_mass_storage.c
> +++ b/drivers/usb/gadget/function/f_mass_storage.c
> @@ -619,7 +619,7 @@ static int sleep_thread(struct fsg_common *common, bool can_freeze,
>  static int do_read(struct fsg_common *common)
>  {
>  	struct fsg_lun		*curlun = common->curlun;
> -	u32			lba;
> +	u64			lba;
>  	struct fsg_buffhd	*bh;
>  	int			rc;
>  	u32			amount_left;
> @@ -634,7 +634,10 @@ static int do_read(struct fsg_common *common)
>  	if (common->cmnd[0] == READ_6)
>  		lba = get_unaligned_be24(&common->cmnd[1]);
>  	else {
> -		lba = get_unaligned_be32(&common->cmnd[2]);
> +		if (common->cmnd[0] == READ_16)
> +			lba = get_unaligned_be64(&common->cmnd[2]);
> +		else		/* READ_10 or READ_12 */
> +			lba = get_unaligned_be32(&common->cmnd[2]);
>  
>  		/*
>  		 * We allow DPO (Disable Page Out = don't save data in the
> @@ -747,7 +750,7 @@ static int do_read(struct fsg_common *common)
>  static int do_write(struct fsg_common *common)
>  {
>  	struct fsg_lun		*curlun = common->curlun;
> -	u32			lba;
> +	u64			lba;
>  	struct fsg_buffhd	*bh;
>  	int			get_some_more;
>  	u32			amount_left_to_req, amount_left_to_write;
> @@ -771,7 +774,10 @@ static int do_write(struct fsg_common *common)
>  	if (common->cmnd[0] == WRITE_6)
>  		lba = get_unaligned_be24(&common->cmnd[1]);
>  	else {
> -		lba = get_unaligned_be32(&common->cmnd[2]);
> +		if (common->cmnd[0] == WRITE_16)
> +			lba = get_unaligned_be64(&common->cmnd[2]);
> +		else		/* WRITE_10 or WRITE_12 */
> +			lba = get_unaligned_be32(&common->cmnd[2]);
>  
>  		/*
>  		 * We allow DPO (Disable Page Out = don't save data in the
> @@ -1146,6 +1152,7 @@ static int do_read_capacity(struct fsg_common *common, struct fsg_buffhd *bh)
>  	u32		lba = get_unaligned_be32(&common->cmnd[2]);
>  	int		pmi = common->cmnd[8];
>  	u8		*buf = (u8 *)bh->buf;
> +	u32		max_lba;
>  
>  	/* Check the PMI and LBA fields */
>  	if (pmi > 1 || (pmi == 0 && lba != 0)) {
> @@ -1153,12 +1160,37 @@ static int do_read_capacity(struct fsg_common *common, struct fsg_buffhd *bh)
>  		return -EINVAL;
>  	}
>  
> -	put_unaligned_be32(curlun->num_sectors - 1, &buf[0]);
> -						/* Max logical block */
> -	put_unaligned_be32(curlun->blksize, &buf[4]);/* Block length */
> +	if (curlun->num_sectors < 0x100000000ULL)
> +		max_lba = curlun->num_sectors - 1;
> +	else
> +		max_lba = 0xffffffff;
> +	put_unaligned_be32(max_lba, &buf[0]);		/* Max logical block */
> +	put_unaligned_be32(curlun->blksize, &buf[4]);	/* Block length */
>  	return 8;
>  }
>  
> +static int do_read_capacity_16(struct fsg_common *common, struct fsg_buffhd *bh)
> +{
> +	struct fsg_lun  *curlun = common->curlun;
> +	u64		lba = get_unaligned_be64(&common->cmnd[2]);
> +	int		pmi = common->cmnd[14];
> +	u8		*buf = (u8 *)bh->buf;
> +
> +	/* Check the PMI and LBA fields */
> +	if (pmi > 1 || (pmi == 0 && lba != 0)) {
> +		curlun->sense_data = SS_INVALID_FIELD_IN_CDB;
> +		return -EINVAL;
> +	}
> +
> +	put_unaligned_be64(curlun->num_sectors - 1, &buf[0]);
> +							/* Max logical block */
> +	put_unaligned_be32(curlun->blksize, &buf[8]);	/* Block length */
> +
> +	/* It is safe to keep other fields zeroed */
> +	memset(&buf[12], 0, 32 - 12);
> +	return 32;
> +}
> +
>  static int do_read_header(struct fsg_common *common, struct fsg_buffhd *bh)
>  {
>  	struct fsg_lun	*curlun = common->curlun;
> @@ -1905,6 +1937,17 @@ static int do_scsi_command(struct fsg_common *common)
>  			reply = do_read(common);
>  		break;
>  
> +	case READ_16:
> +		common->data_size_from_cmnd =
> +				get_unaligned_be32(&common->cmnd[10]);
> +		reply = check_command_size_in_blocks(common, 16,
> +				      DATA_DIR_TO_HOST,
> +				      (1<<1) | (0xff<<2) | (0xf<<10), 1,
> +				      "READ(16)");
> +		if (reply == 0)
> +			reply = do_read(common);
> +		break;
> +
>  	case READ_CAPACITY:
>  		common->data_size_from_cmnd = 8;
>  		reply = check_command(common, 10, DATA_DIR_TO_HOST,
> @@ -1957,6 +2000,25 @@ static int do_scsi_command(struct fsg_common *common)
>  			reply = do_request_sense(common, bh);
>  		break;
>  
> +	case SERVICE_ACTION_IN_16:
> +		switch (common->cmnd[1] & 0x1f) {
> +
> +		case SAI_READ_CAPACITY_16:
> +			common->data_size_from_cmnd =
> +				get_unaligned_be32(&common->cmnd[10]);
> +			reply = check_command(common, 16, DATA_DIR_TO_HOST,
> +					      (1<<1) | (0xff<<2) | (0xf<<10) |
> +					      (1<<14), 1,
> +					      "READ CAPACITY(16)");
> +			if (reply == 0)
> +				reply = do_read_capacity_16(common, bh);
> +			break;
> +
> +		default:
> +			goto unknown_cmnd;
> +		}
> +		break;
> +
>  	case START_STOP:
>  		common->data_size_from_cmnd = 0;
>  		reply = check_command(common, 6, DATA_DIR_NONE,
> @@ -2028,6 +2090,17 @@ static int do_scsi_command(struct fsg_common *common)
>  			reply = do_write(common);
>  		break;
>  
> +	case WRITE_16:
> +		common->data_size_from_cmnd =
> +				get_unaligned_be32(&common->cmnd[10]);
> +		reply = check_command_size_in_blocks(common, 16,
> +				      DATA_DIR_FROM_HOST,
> +				      (1<<1) | (0xff<<2) | (0xf<<10), 1,
> +				      "WRITE(16)");
> +		if (reply == 0)
> +			reply = do_write(common);
> +		break;
> +
>  	/*
>  	 * Some mandatory commands that we recognize but don't implement.
>  	 * They don't mean much in this setting.  It's left as an exercise
> -- 
> 2.20.1
> 
