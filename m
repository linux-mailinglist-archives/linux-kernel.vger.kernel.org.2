Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17690409905
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 18:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237566AbhIMQ1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 12:27:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:57820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237290AbhIMQ1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 12:27:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A65F86023B;
        Mon, 13 Sep 2021 16:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631550358;
        bh=k2gjCgqIRciyyDVHRUfYHy8eLkHaUsw4OJP6DmYTCeo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z350u0T1rMBl/EKHNv9LAI/QocjghKC+Qf2vJce4bbOxLjiKlU1terzrbpBQHluat
         dg3H0bT13pXwXCI5dGNxJVnONBmm5K68MpdjT6tdGCbGHjXUlhKV+0PHofh4le4NnF
         jFSPMEy02et4JrWKnET1rBsonSytWZflFLKdxi+4=
Date:   Mon, 13 Sep 2021 18:25:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: define wowlan_stub only when
 CONFIG_PM is enabled
Message-ID: <YT97lJVU8cx3wxwN@kroah.com>
References: <20210913140937.1490133-1-hello@bryanbrattlof.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913140937.1490133-1-hello@bryanbrattlof.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 02:10:12PM +0000, Bryan Brattlof wrote:
> The wake-on-lan stub is needed only when the device power management
> functionality is enabled in the kernel. Conditionally define
> wowlan_stub to avoid potential unused object warnings.
> 
> Signed-off-by: Bryan Brattlof <hello@bryanbrattlof.com>
> ---
>  drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> index 34da8a569709..f4a9b4b7c97e 100644
> --- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> +++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> @@ -47,6 +47,7 @@ static const u32 rtw_cipher_suites[] = {
>   * Moreover wowlan has to be enabled via a the nl80211_set_wowlan callback.
>   * (from user space, e.g. iw phy0 wowlan enable)
>   */
> +#if defined(CONFIG_PM)
>  static const struct wiphy_wowlan_support wowlan_stub = {
>  	.flags = WIPHY_WOWLAN_ANY,
>  	.n_patterns = 0,
> @@ -54,6 +55,7 @@ static const struct wiphy_wowlan_support wowlan_stub = {
>  	.pattern_min_len = 0,
>  	.max_pkt_offset = 0,
>  };
> +#endif
> 
>  static struct ieee80211_rate rtw_rates[] = {
>  	RATETAB_ENT(10,  0x1,   0),
> --
> 2.30.2
> 
> 

Do you get a build warning with the code as-is?

Having #if in .c files is generally a bad idea, are you sure there is no
other way to solve this?

thanks,

greg k-h
