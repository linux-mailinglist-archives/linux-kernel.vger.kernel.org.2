Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12D52392C3F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 13:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236307AbhE0LCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 07:02:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:40698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236191AbhE0LCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 07:02:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 11412613C3;
        Thu, 27 May 2021 11:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622113244;
        bh=R3U01n0SOesq4D24l2wTXcjroI1vb8jfyz5Fx+ZJ07Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fasTU9kz3kS1wy+sotUw4IFi4ohHEs6u/wjqT1UkbHr7s+sj6jBaINW5wRBf5KRtq
         eROCqvaov4TGMLL6plNQiFWIQUrqBGrPU2d+VbPVYj7AAGgRyyjVIgUy3E9nLwSJsf
         4P+XI7MfSECnK3WQzI2boA2dQXQATyTYEQ2ZWiV8=
Date:   Thu, 27 May 2021 13:00:42 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sean Gloumeau <sajgloumeau@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6655: key.c: Fix coding style issues
Message-ID: <YK972ue67b8nNOjH@kroah.com>
References: <20210526140309.23376-1-sajgloumeau@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526140309.23376-1-sajgloumeau@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 10:03:09AM -0400, Sean Gloumeau wrote:
> The following changes were made to comply with the suggestions present
> in Documentation/process/coding-style.rst as a requirement for Task 10
> of the Eudyptula challenge.
> 
> Signed-off-by: Sean Gloumeau <sajgloumeau@gmail.com>
> ---
>  drivers/staging/vt6655/key.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/staging/vt6655/key.c b/drivers/staging/vt6655/key.c
> index 94665ddc36a5..d1470ff55e06 100644
> --- a/drivers/staging/vt6655/key.c
> +++ b/drivers/staging/vt6655/key.c
> @@ -64,7 +64,7 @@ static int vnt_set_keymode(struct ieee80211_hw *hw, u8 *mac_addr,
>  		key_mode |= (mode << 4);
>  		key_mode |= VNT_KEY_GROUP;
>  		break;
> -	case  VNT_KEY_PAIRWISE:
> +	case VNT_KEY_PAIRWISE:
>  		key_mode |= mode;
>  		key_inx = 4;
>  		break;
> @@ -82,8 +82,8 @@ static int vnt_set_keymode(struct ieee80211_hw *hw, u8 *mac_addr,
>  			key->key[15] |= 0x80;
>  	}
>  
> -	MACvSetKeyEntry(priv, key_mode, entry, key_inx,
> -			bssid, (u32 *)key->key, priv->byLocalID);
> +	MACvSetKeyEntry(priv, key_mode, entry, key_inx, bssid, (u32 *)key->key,
> +			priv->byLocalID);
>  
>  	return 0;
>  }
> @@ -103,7 +103,7 @@ int vnt_set_keys(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
>  
>  	switch (key->cipher) {
>  	case 0:
> -		for (u = 0 ; u < MAX_KEY_TABLE; u++)
> +		for (u = 0; u < MAX_KEY_TABLE; u++)
>  			MACvDisableKeyEntry(priv, u);
>  		return ret;
>  
> @@ -112,8 +112,8 @@ int vnt_set_keys(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
>  		for (u = 0; u < MAX_KEY_TABLE; u++)
>  			MACvDisableKeyEntry(priv, u);
>  
> -		vnt_set_keymode(hw, mac_addr,
> -				key, VNT_KEY_DEFAULTKEY, KEY_CTL_WEP, true);
> +		vnt_set_keymode(hw, mac_addr, key, VNT_KEY_DEFAULTKEY,
> +				KEY_CTL_WEP, true);
>  
>  		key->flags |= IEEE80211_KEY_FLAG_GENERATE_IV;
>  
> @@ -132,14 +132,14 @@ int vnt_set_keys(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
>  	}
>  
>  	if (key->flags & IEEE80211_KEY_FLAG_PAIRWISE) {
> -		vnt_set_keymode(hw, mac_addr,
> -				key, VNT_KEY_PAIRWISE, key_dec_mode, true);
> +		vnt_set_keymode(hw, mac_addr, key, VNT_KEY_PAIRWISE,
> +				key_dec_mode, true);
>  	} else {
> -		vnt_set_keymode(hw, mac_addr,
> -				key, VNT_KEY_DEFAULTKEY, key_dec_mode, true);
> +		vnt_set_keymode(hw, mac_addr, key, VNT_KEY_DEFAULTKEY,
> +				key_dec_mode, true);
>  
> -		vnt_set_keymode(hw, (u8 *)conf->bssid,
> -				key, VNT_KEY_GROUP_ADDRESS, key_dec_mode, true);
> +		vnt_set_keymode(hw, (u8 *)conf->bssid, key,
> +				VNT_KEY_GROUP_ADDRESS, key_dec_mode, true);
>  	}
>  
>  	return 0;
> -- 
> 2.31.1
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
