Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0921A356608
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 10:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236294AbhDGIFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 04:05:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:40676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233970AbhDGIFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 04:05:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F350061151;
        Wed,  7 Apr 2021 08:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617782730;
        bh=mlyMvKhaf1o3icGWjPF64TVY48gFXxVgW8CnfXSrWZ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nq46qRCrdrX0lQjTs5Ljvmor6tWA2xpb9rl7blBxjQxqz2lajnmKpTMuSa/2RUmkM
         HIxswUO03pEkWoP+Qu6+Aj9Js7xm1EaWBer1/90j23Qgm1MAr9/OijbVpou3mNcMt4
         l46k96xnyNLEPr1/jWZUXMMirn2x3JwALnbZmEqU=
Date:   Wed, 7 Apr 2021 10:05:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mitali Borkar <mitaliborkar810@gmail.com>
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: Re: [PATCH] staging: rtl8712: fix avoid CamelCase in xmit_osdep.h
Message-ID: <YG1nyA3ZJbEzVNDu@kroah.com>
References: <YG1l6QIKRMjqgPiD@kali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG1l6QIKRMjqgPiD@kali>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 01:27:29PM +0530, Mitali Borkar wrote:
> Fixed Check:Avoid CamelCase by renaming SetFilter to set_filter
> Reported by checkpatch.
> 
> Signed-off-by: Mitali Borkar <mitaliborkar810@example.com>
> ---
>  drivers/staging/rtl8712/xmit_osdep.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8712/xmit_osdep.h b/drivers/staging/rtl8712/xmit_osdep.h
> index b76021b568f8..7ad2ac6f5ff0 100644
> --- a/drivers/staging/rtl8712/xmit_osdep.h
> +++ b/drivers/staging/rtl8712/xmit_osdep.h
> @@ -35,7 +35,7 @@ struct xmit_frame;
>  struct xmit_buf;
>  
>  int r8712_xmit_entry(_pkt *pkt, struct  net_device *pnetdev);
> -void r8712_SetFilter(struct work_struct *work);
> +void r8712_set_filter(struct work_struct *work);
>  int r8712_xmit_resource_alloc(struct _adapter *padapter,
>  			      struct xmit_buf *pxmitbuf);
>  void r8712_xmit_resource_free(struct _adapter *padapter,
> -- 
> 2.30.2
> 
> 

Did you try test-building your change?  Always do so :(


