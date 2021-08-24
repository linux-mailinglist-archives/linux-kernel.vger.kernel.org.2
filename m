Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD643F5900
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 09:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234886AbhHXH3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 03:29:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:53286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234954AbhHXH27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 03:28:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9D0E7611AF;
        Tue, 24 Aug 2021 07:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629790093;
        bh=v3V3gtIfdXypMfJxsPR2tdERiRsNvF4tzk2w1+WRlc4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T7LaUs3QPTbubiICdPERyGAd0OnAqhLgp1SJB6hPNnWUNnfsSpaAwDzfyvWWxENQg
         wCrqmSyvOUHynhMjH2mwJnKHI5yxwck829XuwrvdPCL14L4acnq9nto+4SR/85C3YD
         h+FyRxLgcWVPU1ZCE72lXY9Qhfs1TmSSqdSQyAbg=
Date:   Tue, 24 Aug 2021 09:28:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     iLifetruth <yixiaonn@gmail.com>
Cc:     Fabio Aiuto <fabioaiuto83@gmail.com>, ross.schm.dev@gmail.com,
        marcocesati@gmail.com, insafonov@gmail.com,
        linux-kernel@vger.kernel.org, Qiang Liu <cyruscyliu@gmail.com>,
        yajin@vm-kernel.org
Subject: Re: staging: possible buffer overflow in rtw_wx_set_scan function in
 driver/staging/rtl8723bs
Message-ID: <YSSfiSnFSE/D7sw3@kroah.com>
References: <CABv53a_q4jzsXib7ovRs=eOwqcQ-oKb8c7DA7uUSPf+0tt6aog@mail.gmail.com>
 <20210823170624.GA1420@agape.jhs>
 <CABv53a9aR8mXE_quxRX06aX3WAKGSOyMqrG8AmqrsvftjH7xyg@mail.gmail.com>
 <CABv53a_9GstHzLbbbghFxU_YDxC0ckh3+bGu4RqAmGL39BHMMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABv53a_9GstHzLbbbghFxU_YDxC0ckh3+bGu4RqAmGL39BHMMg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 03:04:04PM +0800, iLifetruth wrote:
> Here are the fixes and the contents of the patch file we suggest.
> 
> [PATCH]staging: rtl8723bs: prevent ->ssid overflow in rtw_wx_set_scan()
> 
> This fixing patch is ported from the upstream commit
> 74b6b20df8cf(staging: rtl8188eu: prevent ->ssid overflow in
> rtw_wx_set_scan()) which fixes on another driver numbered rtl8188eu.
> This code has a check to prevent read overflow but it needs another
> check to prevent writing beyond the end of the ->ssid[] array in
> driver rtl8723bs.
> 
> ---
>  drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> index f95000df8942..3b859b71bf43 100644
> --- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> +++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> @@ -1222,9 +1222,9 @@ static int rtw_wx_set_scan(struct net_device
> *dev, struct iw_request_info *a,
> 
>                                 sec_len = *(pos++); len -= 1;
> 
> -                               if (sec_len > 0 && sec_len <= len) {
> +                               if (sec_len > 0 && sec_len <= len &&
> sec_len<= 32) {
>                                         ssid[ssid_index].SsidLength = sec_len;
> -                                       memcpy(ssid[ssid_index].Ssid,
> pos, ssid[ssid_index].SsidLength);
> +                                       memcpy(ssid[ssid_index].Ssid,
> pos, sec_len);
>                                         ssid_index++;
>                                 }
> 
> --

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

- Your patch does not have a Signed-off-by: line.  Please read the
  kernel file, Documentation/SubmittingPatches and resend it after
  adding that line.  Note, the line needs to be in the body of the
  email, before the patch, not at the bottom of the patch or in the
  email signature.

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

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file, Documentation/SubmittingPatches
  for how to do this correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
