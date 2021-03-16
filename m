Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C77D33DC9E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 19:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236992AbhCPSeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 14:34:03 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44182 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236941AbhCPSd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 14:33:28 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id 884551F44E05
Subject: Re: next/master bisection: baseline.login on kontron-kbox-a-230-ls
To:     Shawn Guo <shawnguo@kernel.org>,
        Sahil Malhotra <sahil.malhotra@nxp.com>
References: <6050bf47.1c69fb81.59c4d.85f2@mx.google.com>
Cc:     "kernelci-results@groups.io" <kernelci-results@groups.io>,
        Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <38c31f5c-4400-eed7-d561-8f45e261ab01@collabora.com>
Date:   Tue, 16 Mar 2021 18:33:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <6050bf47.1c69fb81.59c4d.85f2@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sahil,

Please see the bisection report below about a boot failure on
kontron-kbox-a-230-ls on linux-next.

Reports aren't automatically sent to the public while we're
trialing new bisection features on kernelci.org but this one
looks valid.

The kernel is hitting this issue:

[    5.326403] kernel BUG at arch/arm64/kernel/traps.c:406!

Full log:

  https://storage.kernelci.org/next/master/next-20210316/arm64/defconfig/gcc-8/lab-kontron/baseline-kontron-kbox-a-230-ls.html

The issue can be reproduced with a plain arm64 defconfig, and
doesn't seem to be impacting other platforms on kernelci.org.
More details can be found here:

  https://kernelci.org/test/case/id/605057a041fc669ff0addccc/

Please let us know if you need any help debugging the issue on
this platform or to try a fix.

Best wishes,
Guillaume


On 16/03/2021 14:23, KernelCI bot wrote:
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> * This automated bisection report was sent to you on the basis  *
> * that you may be involved with the breaking commit it has      *
> * found.  No manual investigation has been done to verify it,   *
> * and the root cause of the problem may be somewhere else.      *
> *                                                               *
> * If you do send a fix, please include this trailer:            *
> *   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
> *                                                               *
> * Hope this helps!                                              *
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> 
> next/master bisection: baseline.login on kontron-kbox-a-230-ls
> 
> Summary:
>   Start:      0f4b0bb396f6 Add linux-next specific files for 20210316
>   Plain log:  https://storage.kernelci.org/next/master/next-20210316/arm64/defconfig+CONFIG_ARM64_64K_PAGES=y/clang-11/lab-kontron/baseline-kontron-kbox-a-230-ls.txt
>   HTML log:   https://storage.kernelci.org/next/master/next-20210316/arm64/defconfig+CONFIG_ARM64_64K_PAGES=y/clang-11/lab-kontron/baseline-kontron-kbox-a-230-ls.html
>   Result:     48787485f8de arm64: dts: ls1028a: enable optee node
> 
> Checks:
>   revert:     PASS
>   verify:     PASS
> 
> Parameters:
>   Tree:       next
>   URL:        https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>   Branch:     master
>   Target:     kontron-kbox-a-230-ls
>   CPU arch:   arm64
>   Lab:        lab-kontron
>   Compiler:   clang-11
>   Config:     defconfig+CONFIG_ARM64_64K_PAGES=y
>   Test case:  baseline.login
> 
> Breaking commit found:
> 
> -------------------------------------------------------------------------------
> commit 48787485f8de44915016d4583e898b62bb2d5753
> Author: Sahil Malhotra <sahil.malhotra@nxp.com>
> Date:   Fri Mar 5 14:03:51 2021 +0530
> 
>     arm64: dts: ls1028a: enable optee node
>     
>     optee node was disabled in ls1028a.dtsi, enabling it by default.
>     
>     Signed-off-by: Sahil Malhotra <sahil.malhotra@nxp.com>
>     Signed-off-by: Shawn Guo <shawnguo@kernel.org>
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> index c1f2f402ad53..3d96c6beb7e2 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> @@ -95,7 +95,6 @@
>  		optee {
>  			compatible = "linaro,optee-tz";
>  			method = "smc";
> -			status = "disabled";
>  		};
>  	};
> -------------------------------------------------------------------------------
> 
> 
> Git bisection log:
> 
> -------------------------------------------------------------------------------
> git bisect start
> # good: [1e28eed17697bcf343c6743f0028cc3b5dd88bf0] Linux 5.12-rc3
> git bisect good 1e28eed17697bcf343c6743f0028cc3b5dd88bf0
> # bad: [0f4b0bb396f6f424a7b074d00cb71f5966edcb8a] Add linux-next specific files for 20210316
> git bisect bad 0f4b0bb396f6f424a7b074d00cb71f5966edcb8a
> # bad: [edd84c42baeffe66740143a04f24588fded94241] Merge remote-tracking branch 'drm-misc/for-linux-next'
> git bisect bad edd84c42baeffe66740143a04f24588fded94241
> # bad: [a76f62d56da82bee1a4c35dd6375a8fdd57eca4e] Merge remote-tracking branch 'cel/for-next'
> git bisect bad a76f62d56da82bee1a4c35dd6375a8fdd57eca4e
> # bad: [38872831aa5ec902b861d14e641cfeea97ca913a] Merge remote-tracking branch 'qcom/for-next'
> git bisect bad 38872831aa5ec902b861d14e641cfeea97ca913a
> # good: [287bccb5b7f13f88cae2e14f49b0572a3bd43a1c] Merge remote-tracking branch 'dma-mapping/for-next'
> git bisect good 287bccb5b7f13f88cae2e14f49b0572a3bd43a1c
> # bad: [b56586a8bfe0fb60a81b804cba49deb0d93e6623] Merge remote-tracking branch 'imx-mxs/for-next'
> git bisect bad b56586a8bfe0fb60a81b804cba49deb0d93e6623
> # bad: [8b5531915cf217d205ca813a10fc79987fb528fb] Merge branch 'imx/defconfig' into for-next
> git bisect bad 8b5531915cf217d205ca813a10fc79987fb528fb
> # bad: [3a28e405ca096d692df2dd4b61f179b6fbed0da3] arm64: dts: imx8mm: Reorder flexspi clock-names entry
> git bisect bad 3a28e405ca096d692df2dd4b61f179b6fbed0da3
> # good: [21480ffda0da794c26a206203c28620ecd5765bb] arm64: dts: imx8mm: Add Engicam i.Core MX8M Mini C.TOUCH 2.0
> git bisect good 21480ffda0da794c26a206203c28620ecd5765bb
> # good: [9c5d3663dc1a0f8bb7c14b0b694d63dad2e9b964] arm64: dts: imx8: add adma lpcg clocks
> git bisect good 9c5d3663dc1a0f8bb7c14b0b694d63dad2e9b964
> # good: [7add607242d1178b11d8d9a1e9207b73d9058224] arm64: dts: imx8qm: add dma ss support
> git bisect good 7add607242d1178b11d8d9a1e9207b73d9058224
> # bad: [48787485f8de44915016d4583e898b62bb2d5753] arm64: dts: ls1028a: enable optee node
> git bisect bad 48787485f8de44915016d4583e898b62bb2d5753
> # good: [fb054e1356c0943f70b9b6db542175cd728bd3f6] arm64: dts: imx: add imx8qm mek support
> git bisect good fb054e1356c0943f70b9b6db542175cd728bd3f6
> # first bad commit: [48787485f8de44915016d4583e898b62bb2d5753] arm64: dts: ls1028a: enable optee node
> -------------------------------------------------------------------------------
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Groups.io Links: You receive all messages sent to this group.
> View/Reply Online (#8517): https://groups.io/g/kernelci-results/message/8517
> Mute This Topic: https://groups.io/mt/81377141/924702
> Group Owner: kernelci-results+owner@groups.io
> Unsubscribe: https://groups.io/g/kernelci-results/unsub [guillaume.tucker@collabora.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 

