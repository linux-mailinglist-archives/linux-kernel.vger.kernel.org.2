Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4CA8428168
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 14:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbhJJM4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 08:56:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:52584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231833AbhJJM4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 08:56:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 414B261076;
        Sun, 10 Oct 2021 12:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633870485;
        bh=zxsP281bRmnj1ubhDY5IwzGloqMPyxj4oCdJF8F2VC0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q1mSgdAIpzJhet4ZJQQ1NUhdaBvkmtAK///jigWxEfz+VK7QDxHZeixuBd7wfQHmT
         sIEzoddXP7UmQ1ZhTJKrtWhf/ofbrXe6SV0jHKlf01S5dpcJAnQlVIv1da3w0GIdjr
         n4OoFCjYj7t1F/KniQpLwFPMsF1ArJE0U0ehNmWk=
Date:   Sun, 10 Oct 2021 14:54:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Siou-Jhih, Guo" <hallblazzar@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: r8188eu: Fix misspelling in comment
Message-ID: <YWLik3BH1ANIzLM8@kroah.com>
References: <681b368a-d326-ffc6-3a21-ef735ad1ee54@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <681b368a-d326-ffc6-3a21-ef735ad1ee54@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 10:10:05PM +0100, Siou-Jhih, Guo wrote:
> As format check raised by scripts/checkpatch.pl, comment in the rtw_ap.c
> looks misspelled by accident. Help fix it.
> 
> The original error is as below shows:
> 
> CHECK: 'followign' may be misspelled - perhaps 'following'?
> +Set to 0 (HT pure) under the followign conditions
> 
> Signed-off-by: Siou-Jhih, Guo <hallblazzar@gmail.com>
> ---
> Changes in v3:
>   - Fix wrong signed name in "From" field in email header(mismatch with
>     sign-off).
>   - Refer to the latest commit, ecd667f5f.
>   - Add missing change log between each patch version.
> 
> Changes in v2:
>   - Remove redundant "Subject:" from Subject
>   - Fix missing public mail list in cc list
> ---
>  drivers/staging/r8188eu/core/rtw_ap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_ap.c b/drivers/staging/r8188eu/core/rtw_ap.c
> index 94e02aad96b7..205168f960f6 100644
> --- a/drivers/staging/r8188eu/core/rtw_ap.c
> +++ b/drivers/staging/r8188eu/core/rtw_ap.c
> @@ -744,7 +744,7 @@ void update_beacon(struct adapter *padapter, u8 ie_id, u8 *oui, u8 tx)
>  
>  /*
>  op_mode
> -Set to 0 (HT pure) under the followign conditions
> +Set to 0 (HT pure) under the following conditions
>      - all STAs in the BSS are 20/40 MHz HT in 20/40 MHz BSS or
>      - all STAs in the BSS are 20 MHz HT in 20 MHz BSS
>  Set to 1 (HT non-member protection) if there may be non-HT STAs
> -- 
> 2.25.1
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

- Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
  and can not be applied.  Please read the file,
  Documentation/email-clients.txt in order to fix this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
