Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6CF43F97A7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 11:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245018AbhH0JsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 05:48:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:37428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244972AbhH0JsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 05:48:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EB63760E73;
        Fri, 27 Aug 2021 09:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630057639;
        bh=ADm7WMoFirwQno080nTf6x1kH25ETqKuoL7mHq+cH1Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zv/ZrsRvAjn+7XDZsUXyXrEimKEoIp8Joa7LcdrV1A4I1wLIIwadhlokKdfW5yqTw
         kxhRo+I0NBhxOtcLxbEhi75PtsWWaUohtqzwmJ1P25zqKmJagRnrrTjmKjKkzfe7iT
         lZRZxLdIG5tCz8IrZdMoPvsFG5+SYMjlPmt9CZU8=
Date:   Fri, 27 Aug 2021 11:47:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wenlong Zhang <yixiaonn@gmail.com>
Cc:     fabioaiuto83@gmail.com, ross.schm.dev@gmail.com,
        marcocesati@gmail.com, insafonov@gmail.com, cyruscyliu@gmail.com,
        yajin@vm-kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH v2] staging: rtl8723bs: prevent ->ssid overflow in
 rtw_wx_set_scan()
Message-ID: <YSi0ovuYkBHV/i7P@kroah.com>
References: <YSfjtZsISLH6cktF@kroah.com>
 <20210827090027.23158-1-yixiaonn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827090027.23158-1-yixiaonn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 05:00:27PM +0800, Wenlong Zhang wrote:
> Commit 74b6b20df8cf ("staging: rtl8188eu: prevent ->ssid overflow in rtw_wx_set_scan()")
> fixed up the staging driver rtl8188eu by adding another check
> to prevent writing beyond the end of the ->ssid[] array.
> 
> Resolve this by properly fixing up the rtl8723bs driver's version of
> rtw_wx_set_scan()
> 
> Fixes: 74b6b20df8cf ("staging: rtl8188eu: prevent ->ssid overflow in rtw_wx_set_scan()")
> Signed-off-by: Wenlong Zhang <yixiaonn@gmail.com>
> ---
>  drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> index 902ac8169948..6fc1020cea11 100644
> --- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> +++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> @@ -1351,9 +1351,9 @@ static int rtw_wx_set_scan(struct net_device *dev, struct iw_request_info *a,
>  
>  					sec_len = *(pos++); len -= 1;
>  
> -					if (sec_len > 0 && sec_len <= len) {
> +					if (sec_len > 0 && sec_len <= len && sec_len <= 32) {
>  						ssid[ssid_index].SsidLength = sec_len;
> -						memcpy(ssid[ssid_index].Ssid, pos, ssid[ssid_index].SsidLength);
> +						memcpy(ssid[ssid_index].Ssid, pos, sec_len);
>  						/* DBG_871X("%s COMBO_SCAN with specific ssid:%s, %d\n", __func__ */
>  						/* 	, ssid[ssid_index].Ssid, ssid[ssid_index].SsidLength); */
>  						ssid_index++;
> -- 
> 2.15.0
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

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
