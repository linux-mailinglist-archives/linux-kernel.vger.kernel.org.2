Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 767CF36C850
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 17:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238552AbhD0PIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 11:08:25 -0400
Received: from mout.web.de ([212.227.17.11]:55875 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238622AbhD0PIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 11:08:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1619536026;
        bh=doh3/trEE0DsfmTiGEXHMxnxBuJLKnYanLPLC42HBxI=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=k68+7oaRyi7q7BsFu/W7qvFrjYC8r1WZ/PJttE8Gati1mGHe7/+7lq2Q7s962nBcI
         JJUvWzUCgH4k72CTT82r23gpspFuxvj/C50pmrlUemDNP3CgD0m5dgZSn4EUgEfPIH
         LO/k3SlpeILQ7/t7mHBAUHy/5K8MZ12nONrYPNfs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.70.1] ([46.114.143.69]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M0Qkb-1lJBax1Adx-00uZTg; Tue, 27
 Apr 2021 17:07:06 +0200
Subject: Re: [PATCH] arm64: dts: rockchip: include uhs support for rockpro64
To:     Christian L?hle <CLoehle@hyperstone.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "jbx6244@gmail.com" <jbx6244@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CWXP265MB2680938B222248792AC205F9C4419@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
From:   Soeren Moch <smoch@web.de>
Message-ID: <97bcbcde-9ccf-f9cc-ef10-36cbd582825a@web.de>
Date:   Tue, 27 Apr 2021 17:07:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CWXP265MB2680938B222248792AC205F9C4419@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-Provags-ID: V03:K1:62KQFG4fzGHbguzIBmMmapWhtQisqkOd0DpjtJ65/I22axEf/hu
 x8HTWItJEHOCP7awNC7kuE+yhk+Ic8sWChD5h80A4EanyM9h9WtdWGla1/gSK5OtGi4wtxv
 NHkRqg6br0klsC6povz1WTmYW/tYeGTjUVvCJyKm9uGP81YhLS+Sy17MkhTbYkEW6oU1jrz
 NeXyrj7ov7RE1aZZSiSYA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:5osw2TnQfcA=:wZsX1Wy2hvlrmo6dQys7Gm
 XFJX5hAt1pB0erlH2m2BY6+5cJkmtCBEeyIP/1QUTJQ3dhv7cplrypYUDnjeGW5gUbow6Og6Z
 cKFD+MEP3Jh+tTT/VpeoV/hAJBqNZSRzFYU5J1MEi2/4cDNhuWrZ1LGZJttvF+iWS12ni/TTb
 yOgzqYJz8EtWBbNn7Ts1GPvpl4n0ranGv+3X2R169o2hgiJPZsEJGiXy+ollOZN/tkFvnqcnl
 Xj5ZnXj1xxSiGHXR0H3+EjFnWCOaPdi87wTFwlNzE1bf8Gsm3ghRJANp2jW28ViOzG6EVZBqL
 kSDGw17S0B9Q3fL6ckFe5AeQNZVZ4smhvs1Tg9HISgBWQ2C4D70dldFOEtJxPpSBYdRvx7UKF
 3qVklEHuCCFMKpSO5Jh/fxbdJ3iUQ+nEn1taefdI3TqLdALKk27240JugKZIUoaOD4EZCpx7i
 7u5GSgCNW3UleFnaPLAJ65D9rc2ch0zfaIP33bkDg7/qBY3vaNMt03WJXrfc+uVu1fGdOHjIm
 C1hYhdGey6Q+fVPQjTvnAZ+YOfQujZb7eze/3VtBuGCVlVvt/zz2tyUfzrRCqp5B378AUT1N8
 QAlSM0mHKoo8zyuqd1dxJDASGT9Q0RtDjG56iGba7Qvd/xl/LM8Kta18xnCxU/MvEZNBGi2Aq
 r5LAzNDh28zKTxGySn4YIHPiPMu8JJ96ODktBvV2zq2bA7cNIcU+TedCIBgjh2iKTJ5o8DK/Q
 cbttLVw0pWM97CPi0ptPCM6xxPtAunVLoogg+75omBArZPh7MVRptr1AKaApmzfKbCzGm6ZVl
 uRPLYqbVoImjakqqsXyRMV1BUp3zCupJ+JSp7yaTuf0YVaa0z8Kx9pG+TG8U3w6pP6cirHieS
 YKJtq/rWhGCohX88YGfbJqsThLurb2G5OSd+SpLlylXT7G3dxEWYUuc8GKfrP4VcU74HPG7zf
 BNOP7k6fazmZiUhG8jYswsZcthOu7pUVlsXOFTRdWicfuLvh/3BkmAdM4/J7Sau0yUuVY8VYs
 pGPiDBJwcp/DPLdQBaC25v+UV4zqGkQOwiUlClMkSZLYuSxcPNJFspfDh0G6Q+KTy3cVGFV77
 YSqMqVZIy3ys3MmgkKUjmNSeS/CjhGHlfuj0p9K15f1MIScq66QnSyhcAtHLRhrd3LEW57VHX
 rW5Xkpw2y6BAqHSNmEfjIez3h8xprdfFjoRyNS5tjiqDo7mDllP5IIITGGDIH+oLyKT74=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.04.21 08:20, Christian L?hle wrote:
> The DesignWare Host Controller has full UHS-I support, so use it.
Enabling this UHS support makes 'reboot' hang when booting the RockPro64
from SD card. It would work when booting from eMMC, or with a modified
ATF which does a power cycle on reboot.

But for general use it is not save to enable UHS support, or did I miss
some recent changes?

Regards,
Soeren
>
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
> index 6bff8db7d33e..d22a489ec214 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
> @@ -722,6 +722,7 @@ &sdmmc {
>  	max-frequency = <150000000>;
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_bus4>;
> +	sd-uhs-sdr104;
>  	vmmc-supply = <&vcc3v0_sd>;
>  	vqmmc-supply = <&vcc_sdio>;
>  	status = "okay";

