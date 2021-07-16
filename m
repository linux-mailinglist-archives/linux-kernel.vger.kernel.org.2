Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E35FB3CB20E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 07:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbhGPFws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 01:52:48 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39568 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbhGPFwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 01:52:46 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 199FA22B37;
        Fri, 16 Jul 2021 05:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1626414591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h8PAYPEK4+MS0FrJRkYupjRXBGho7fDC4xEGwlkrTCo=;
        b=Zyl79cBchiMZFmmY+SmyrA4qyl6PehrsKFOSfz8hYYKCYyR4k+nY+aWXT3UGC2kMkDllrA
        mqtKZFGwV4TmLd2WI+t95RB6nEgq6h1HmSk0CiF5++hiHyYYi8UP4vh/ZJ6uxEmPJW18v+
        ERku03lb/6u/PiZgOHiGwj2Vz7meMdw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1626414591;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h8PAYPEK4+MS0FrJRkYupjRXBGho7fDC4xEGwlkrTCo=;
        b=76kMZhfZmqsydbvq64OBPT6Q7a0jTikUzWmU1vufa0uSCC3yCSeIWP9QvUSDCZ63lAyhMw
        Drl/K9lB/R2X6LAQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id B631E13357;
        Fri, 16 Jul 2021 05:49:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id MK06Kv4d8WCDNwAAGKfGzw
        (envelope-from <hare@suse.de>); Fri, 16 Jul 2021 05:49:50 +0000
Subject: Re: [RFC 2/6] block: add flag for add_disk() completion notation
To:     Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk
Cc:     bvanassche@acm.org, ming.lei@redhat.com, hch@infradead.org,
        jack@suse.cz, osandov@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210715202341.2016612-1-mcgrof@kernel.org>
 <20210715202341.2016612-3-mcgrof@kernel.org>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <cbaa9f73-92f8-d5a2-4fd7-c05bda112c56@suse.de>
Date:   Fri, 16 Jul 2021 07:49:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210715202341.2016612-3-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/15/21 10:23 PM, Luis Chamberlain wrote:
> Often drivers may have complex setups where it is not
> clear if their disk completed their respective *add_disk*()
> call. They either have to invent a setting or, they
> incorrectly use GENHD_FL_UP. Using GENHD_FL_UP however is
> used internally so we know when we can add / remove
> partitions safely. We can easily fail along the way
> prior to add_disk() completing and still have
> GENHD_FL_UP set, so it would not be correct in that case
> to call del_gendisk() on the disk.
> 
> Provide a new flag then which allows us to check if
> *add_disk*() completed, and conversely just make
> del_gendisk() check for this for drivers so that
> they can safely call del_gendisk() and we'll figure
> it out if it is safe for you to call this.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>   block/genhd.c         |  8 ++++++++
>   include/linux/genhd.h | 11 ++++++++++-
>   2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index c6c9c196ff27..72703d243b44 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -630,6 +630,8 @@ static int __device_add_disk(struct device *parent, struct gendisk *disk,
>   	if (ret)
>   		goto exit_del_events;
>   
> +	disk->flags |= GENHD_FL_DISK_ADDED;
> +
>   	return 0;
>   exit_del_events:
>   	disk_del_events(disk);
> @@ -677,6 +679,9 @@ EXPORT_SYMBOL(device_add_disk_no_queue_reg);
>    * with put_disk(), which should be called after del_gendisk(), if
>    * __device_add_disk() was used.
>    *
> + * Drivers can safely call this even if they are not sure if the respective
> + * __device_add_disk() call succeeded.
> + *
>    * Drivers exist which depend on the release of the gendisk to be synchronous,
>    * it should not be deferred.
>    *
> @@ -686,6 +691,9 @@ void del_gendisk(struct gendisk *disk)
>   {
>   	might_sleep();
>   
> +	if (!blk_disk_registered(disk))
> +		return;
> +
>   	if (WARN_ON_ONCE(!disk->queue))
>   		return;
>   
> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
> index dc07a957c9e1..73024416d2d5 100644
> --- a/include/linux/genhd.h
> +++ b/include/linux/genhd.h
> @@ -56,6 +56,10 @@ struct partition_meta_info {
>    * Must not be set for devices which are removed entirely when the
>    * media is removed.
>    *
> + * ``GENHD_FL_DISK_ADDED`` (0x0002): used to clarify that the
> + * respective add_disk*() call completed successfully, so that
> + * we know we can safely process del_gendisk() on the disk.
> + *
>    * ``GENHD_FL_CD`` (0x0008): the block device is a CD-ROM-style
>    * device.
>    * Affects responses to the ``CDROM_GET_CAPABILITY`` ioctl.
> @@ -94,7 +98,7 @@ struct partition_meta_info {
>    * Used for multipath devices.
>    */
>   #define GENHD_FL_REMOVABLE			0x0001
> -/* 2 is unused (used to be GENHD_FL_DRIVERFS) */
> +#define GENHD_FL_DISK_ADDED			0x0002
>   /* 4 is unused (used to be GENHD_FL_MEDIA_CHANGE_NOTIFY) */
>   #define GENHD_FL_CD				0x0008
>   #define GENHD_FL_UP				0x0010
> @@ -189,6 +193,11 @@ struct gendisk {
>   #define disk_to_cdi(disk)	NULL
>   #endif
>   
> +static inline bool blk_disk_registered(struct gendisk *disk)
> +{
> +	return disk && (disk->flags & GENHD_FL_DISK_ADDED);
> +}
> +
>   static inline int disk_max_parts(struct gendisk *disk)
>   {
>   	if (disk->flags & GENHD_FL_EXT_DEVT)
> 
Bah. The flag is named 'DISK_ADDED', and the wrapper 'disk_registered'.
Please use the same wording (either 'added' or 'registered') for both to 
avoid confusion.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
