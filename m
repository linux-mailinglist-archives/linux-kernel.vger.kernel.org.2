Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0DDC357E3B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 10:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbhDHIgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 04:36:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:43180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229554AbhDHIgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 04:36:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD19A610CC;
        Thu,  8 Apr 2021 08:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617870995;
        bh=PUqvAkqf03KqgMQY3Yt1e9jEPab7tHPz6v3xsENaPKA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dwm8AKJ3UC/du4JbTDGv6CEEeEnpwGyIayhV2aylqNeaoDAElkK36XbBzmcBocfUz
         drAmYtEKMahZIY5byX3UvKkZYjv/njw7nfFwTOmzZWsL5357IiBlOLyeXbxDRDN0Bt
         Zr7yTFUZ72k8CIJ/EotUEHaQT5oUwtKA6SGPlA6Q=
Date:   Thu, 8 Apr 2021 10:36:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] staging: rtl8723bs: Remove camelcase
 in several files
Message-ID: <YG7AkJjSThRbb/f5@kroah.com>
References: <20210408080714.29481-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408080714.29481-1-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 10:07:14AM +0200, Fabio M. De Francesco wrote:
> Remove camelcase in a symbol that is used by several files.

What symbol?

> --- a/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
> +++ b/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
> @@ -203,7 +203,7 @@ struct pwrctrl_priv {
>  	u8 LpsIdleCount;
>  	u8 power_mgnt;
>  	u8 org_power_mgnt;
> -	u8 bFwCurrentInPSMode;
> +	u8 b_fw_current_in_ps_mode;

The "b" here means "byte" so you can drop the "b_" as that means
nothing, we do not use this type of notation in the kernel as the
compiler can check it for us.

thanks,

greg k-h
