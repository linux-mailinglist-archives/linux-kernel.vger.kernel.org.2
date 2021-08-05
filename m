Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB0083E12E4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 12:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240519AbhHEKnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 06:43:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:32836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240524AbhHEKnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 06:43:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 817FA60F02;
        Thu,  5 Aug 2021 10:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628160212;
        bh=WPW+099jCWQFswbfNHI98R3QSSOtgUtsUZb+/HnroHg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gEdpzqMiCBVXZ/gBxrgS+XpnM0g6gv4aWvpQiQ1dvPRldexfQjUbiJh/bRihReIaq
         FTvW+a8cVKPAE5aU/VCpgt+jpvRGvhg7KN7+k5zmyNNoYFXhUBOJ2ZMo+CruqYUDVZ
         rPkjj2brAqJbKEpvvVeoudqx8fJWNZ+IGACPgoXQ=
Date:   Thu, 5 Aug 2021 12:43:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, martin@kaiser.cx
Subject: Re: [PATCH 00/15] staging: r8188eu: remove core dir RT_TRACE calls
Message-ID: <YQvAyd2meIE8btpR@kroah.com>
References: <20210801190437.82017-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210801190437.82017-1-phil@philpotter.co.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 01, 2021 at 08:04:22PM +0100, Phillip Potter wrote:
> This series removes all RT_TRACE calls from code within the core directory.
> 
> Phillip Potter (15):
>   staging: r8188eu: remove RT_TRACE calls from core/rtw_cmd.c
>   staging: r8188eu: remove RT_TRACE calls from core/rtw_pwrctrl.c
>   staging: r8188eu: remove RT_TRACE calls from core/rtw_wlan_util.c
>   staging: r8188eu: remove RT_TRACE calls from core/rtw_ieee80211.c
>   staging: r8188eu: remove RT_TRACE calls from core/rtw_io.c
>   staging: r8188eu: remove RT_TRACE calls from core/rtw_ioctl_set.c
>   staging: r8188eu: remove RT_TRACE calls from core/rtw_mlme.c
>   staging: r8188eu: remove RT_TRACE calls from core/rtw_mlme_ext.c
>   staging: r8188eu: remove RT_TRACE calls from core/rtw_mp.c
>   staging: r8188eu: remove RT_TRACE calls from core/rtw_security.c
>   staging: r8188eu: remove RT_TRACE calls from core/rtw_sta_mgt.c
>   staging: r8188eu: remove RT_TRACE calls from core/rtw_xmit.c
>   staging: r8188eu: remove RT_TRACE calls from core/rtw_led.c
>   staging: r8188eu: remove RT_TRACE calls from core/rtw_mp_ioctl.c
>   staging: r8188eu: remove RT_TRACE calls from core/rtw_recv.c

I applied the patches here that I could, others conflicted with other
changes I have taken recently.  Can you rebase and resend the remaining
ones now?

thanks,

greg k-h
