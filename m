Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4A23AB301
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 13:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbhFQLvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 07:51:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:60532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231593AbhFQLu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 07:50:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A9B9961241;
        Thu, 17 Jun 2021 11:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623930532;
        bh=xEwOLou2SX7KYGSlI2LYlF2SaMIoBnxyxXtNG353NqA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GxDLvy+AiMBVwrxo+6uYJ16d/YvL6ekvoEMwsRSgmhhBTX94jFEMgfwkFlZ2ulxeB
         RdNnHtvBC0kPviMNtiJGiy6V4SPOz6puuHQ4zy8lRlD5CDE/xrHZWWa+lmojSjqjDA
         3zRcXhyPQRAAaveaOLSLBuwgnL3r5qEPG+bwoZkA=
Date:   Thu, 17 Jun 2021 13:48:49 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tomas Winkler <tomas.winkler@intel.com>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [char-misc-next 2/2] mei: revamp mei extension header structure
 layout.
Message-ID: <YMs2oemOeLvwwnue@kroah.com>
References: <20210615211557.248292-1-tomas.winkler@intel.com>
 <20210615211557.248292-2-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615211557.248292-2-tomas.winkler@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 12:15:57AM +0300, Tomas Winkler wrote:
> The mei extension header was build as array of flexible structures
> which will not work if actually more headers are added

Why not?  What is wrong with what you currently have?

And did you forget a '.' here?

> Use basic type u8 for the variable sized extension.
> Define explicitly mei_ext_hdr_vtag structure.
> Fix also mei_ext_next() function to point correctly to the
> end of the header.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> ---
>  drivers/misc/mei/client.c    | 16 +++++++++-------
>  drivers/misc/mei/hw.h        | 28 ++++++++++++++++++++--------
>  drivers/misc/mei/interrupt.c | 23 ++++++++++-------------
>  3 files changed, 39 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
> index 18e49479d8b0..96f4e59c32a5 100644
> --- a/drivers/misc/mei/client.c
> +++ b/drivers/misc/mei/client.c
> @@ -1726,12 +1726,15 @@ int mei_cl_read_start(struct mei_cl *cl, size_t length, const struct file *fp)
>  	return rets;
>  }
>  
> -static inline u8 mei_ext_hdr_set_vtag(struct mei_ext_hdr *ext, u8 vtag)
> +static inline u8 mei_ext_hdr_set_vtag(void *ext, u8 vtag)
>  {
> -	ext->type = MEI_EXT_HDR_VTAG;
> -	ext->ext_payload[0] = vtag;
> -	ext->length = mei_data2slots(sizeof(*ext));
> -	return ext->length;
> +	struct mei_ext_hdr_vtag *vtag_hdr = ext;
> +
> +	vtag_hdr->hdr.type = MEI_EXT_HDR_VTAG;
> +	vtag_hdr->hdr.length = mei_data2slots(sizeof(*vtag_hdr));
> +	vtag_hdr->vtag = vtag;
> +	vtag_hdr->reserved = 0;
> +	return vtag_hdr->hdr.length;
>  }
>  
>  /**
> @@ -1745,7 +1748,6 @@ static struct mei_msg_hdr *mei_msg_hdr_init(const struct mei_cl_cb *cb)
>  {
>  	size_t hdr_len;
>  	struct mei_ext_meta_hdr *meta;
> -	struct mei_ext_hdr *ext;
>  	struct mei_msg_hdr *mei_hdr;
>  	bool is_ext, is_vtag;
>  
> @@ -1764,7 +1766,7 @@ static struct mei_msg_hdr *mei_msg_hdr_init(const struct mei_cl_cb *cb)
>  
>  	hdr_len += sizeof(*meta);
>  	if (is_vtag)
> -		hdr_len += sizeof(*ext);
> +		hdr_len += sizeof(struct mei_ext_hdr_vtag);
>  
>  setup_hdr:
>  	mei_hdr = kzalloc(hdr_len, GFP_KERNEL);
> diff --git a/drivers/misc/mei/hw.h b/drivers/misc/mei/hw.h
> index b10606550613..dfd60c916da0 100644
> --- a/drivers/misc/mei/hw.h
> +++ b/drivers/misc/mei/hw.h
> @@ -235,9 +235,8 @@ enum mei_ext_hdr_type {
>  struct mei_ext_hdr {
>  	u8 type;
>  	u8 length;
> -	u8 ext_payload[2];
> -	u8 hdr[];
> -};
> +	u8 data[];
> +} __packed;

why packed?

>  
>  /**
>   * struct mei_ext_meta_hdr - extend header meta data
> @@ -250,8 +249,21 @@ struct mei_ext_meta_hdr {
>  	u8 count;
>  	u8 size;
>  	u8 reserved[2];
> -	struct mei_ext_hdr hdrs[];
> -};
> +	u8 hdrs[];
> +} __packed;

Why packed?

> +
> +/**
> + * struct mei_ext_hdr_vtag - extend header for vtag
> + *
> + * @hdr: standard extend header
> + * @vtag: virtual tag
> + * @reserved: reserved
> + */
> +struct mei_ext_hdr_vtag {
> +	struct mei_ext_hdr hdr;
> +	u8 vtag;
> +	u8 reserved;
> +} __packed;

Why packed?

These are not being read directly from hardware are they?

thanks,

greg k-h
