Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35B83438C0A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 23:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbhJXVUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 17:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbhJXVUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 17:20:17 -0400
Received: from out10.migadu.com (out10.migadu.com [IPv6:2001:41d0:2:e8e3::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00337C061745;
        Sun, 24 Oct 2021 14:17:55 -0700 (PDT)
Date:   Sun, 24 Oct 2021 17:18:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svmhdvn.name;
        s=key1; t=1635110273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I2srHi4l+H7WQZ20ytbQbEmN/fUPwHrv/T99xatcrc8=;
        b=oGg/e+7NARwmp+9bAIj/kFpilrzhd/lH2Pc9AhD56Uva/Oo77Yx9/5fR3AWu7+nzT7rm6K
        ElqfCXl7dcsYQ51E5Zx03TCHmYIsAP7L8Tw7FNrROCPrK3OjaLAiAH0o0I00zwTeUYxE3N
        Uaa7doxGpM2LpkE+V/8nY7ZznQ3ltQA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Siva Mahadevan <me@svmhdvn.name>
To:     Jian-Hong Pan <jhp@endlessos.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, Soeren Moch <smoch@web.de>,
        Tobias Schramm <t.schramm@manjaro.org>,
        Johan Jonker <jbx6244@gmail.com>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Hugh Cole-Baker <sigmaris@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@endlessm.com
Subject: Re: [PATCH] arm64: dts: rockchip: disable USB type-c DisplayPort
Message-ID: <YXXNsdVTo8pVfs4/@think.localdomain>
References: <20200924063042.41545-1-jhp@endlessos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200924063042.41545-1-jhp@endlessos.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: mbsync-msmtp@svmhdvn.name
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jian-Hong Pan wrote:
> The cdn-dp sub driver probes the device failed on PINEBOOK Pro.
> 
> kernel: cdn-dp fec00000.dp: [drm:cdn_dp_probe [rockchipdrm]] *ERROR* missing extcon or phy
> kernel: cdn-dp: probe of fec00000.dp failed with error -22
> 
> Then, the device halts all of the DRM related device jobs. For example,
> the operations: vop_component_ops, vop_component_ops and
> rockchip_dp_component_ops cannot be bound to corresponding devices. So,
> Xorg cannot find the correct DRM device.
> 
> The USB type-C DisplayPort does not work for now. So, disable the
> DisplayPort node until the type-C phy work has been done.
> 
> Link: https://patchwork.kernel.org/patch/11794141/#23639877
> Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
> index 06d48338c836..d624c595c533 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
> @@ -380,7 +380,7 @@ mains_charger: dc-charger {
>  };
>  
>  &cdn_dp {
> -	status = "okay";
> +	status = "disabled";
>  };
>  
>  &cpu_b0 {
> -- 
> 2.28.0

I saw a similar patch posted at https://lkml.org/lkml/2021/7/15/752. I
was wondering if one of these patches will be submitted to mainline, or
what the status on this patch is. I can confirm that this does solve
the issue on my Pinebook Pro. Will this go forward?
