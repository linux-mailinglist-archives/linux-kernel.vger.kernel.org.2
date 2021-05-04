Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD01372B7E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 15:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbhEDN5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 09:57:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:37356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231393AbhEDN5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 09:57:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 34EBE61027;
        Tue,  4 May 2021 13:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620136615;
        bh=b2AeokgYv9BBNOB9kdU8IH5+Ru9PhpBrRTY6A59eIxw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EvejC2252e2Zl+OmgVpDTt2QniEI2j/aZi0nxrm5tVAKnUdDBiChcy3beCRGx854k
         AyfcApo0828t1WAq2RsjmIWG05msuLQJ72QkaqzrgSPG9tLRccEE8kfvmrbiecN4xe
         EXHni88bKs2i3y4hqa0nSy7OjN8FisMDGbNIO3NoAXD7or5xFJqbj4cwZYgzCzOUNF
         xLJf5sG1OXztno2rLSpoFKlqCzZQ+Qxe3wXTH3pyQUVtYjJFQBNdLr39aESK/oyAjj
         bhyAMz98EXmblhaKp7ApVLFjpak1kJXeR8b2vmp7i+mcAVXIt6tcCSDac2vW+D1QSi
         TmIs5QFZ0sLgQ==
Received: by mail-ed1-f48.google.com with SMTP id bf4so10531551edb.11;
        Tue, 04 May 2021 06:56:55 -0700 (PDT)
X-Gm-Message-State: AOAM5331by95P0P5FeiswgSyfsbKloQj5fHVGLqRYSibT9Z0avwuWDv/
        4zp+SXFbZFFvF0PF6/rnTamjwzOslsNcWzH7JRc=
X-Google-Smtp-Source: ABdhPJxj2ZxVi8v0/3asz2FqD9vZBl4BAkavlevVxCat2TqvVFsZdO9hzV3Jap0mmoo+TMnsiVtcLhdsWKFzrcWhkGw=
X-Received: by 2002:a05:6402:441:: with SMTP id p1mr26213488edw.298.1620136613729;
 Tue, 04 May 2021 06:56:53 -0700 (PDT)
MIME-Version: 1.0
References: <1618565538-6972-1-git-send-email-pk.chi@mediatek.com>
In-Reply-To: <1618565538-6972-1-git-send-email-pk.chi@mediatek.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 4 May 2021 09:56:41 -0400
X-Gmail-Original-Message-ID: <CAJKOXPdpBjmHgcE1=vox9YbdtR82LT5F8anx0dKP_fp1JstTpg@mail.gmail.com>
Message-ID: <CAJKOXPdpBjmHgcE1=vox9YbdtR82LT5F8anx0dKP_fp1JstTpg@mail.gmail.com>
Subject: Re: [PATCH v2] memory: mediatek: add DRAM controller driver
To:     Po-Kai Chi <pk.chi@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        wsd_upstream@mediatek.com, CC Hwang <cc.hwang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Apr 2021 at 06:30, Po-Kai Chi <pk.chi@mediatek.com> wrote:
>
> These patch series introduces the MediaTek DRAM controller driver (DRAMC)
> on MT6779 SoC, and enables to be built as a module by default for the
> ARM64 builds.
>
> MediaTek DRAMC driver provides cross-platform features as below:
>   - API provided to other kernel modules for querying DRAM type,
>     rank count, rank size, channel count and mode register settings.
>   - Sysfs interface used to pass DRAM mode register settings and current
>     DRAM data rate to user-space for MediaTek ecosystem.
>
> The API user includes MediaTek External Memory Interface (EMI) and
> DVFS Resource Control (DVFSRC), which will be sent to mainline later.
>
> Changes since v1:
> - add prefix to vendor properties in device tree, dt-binding and drivers
> - fix dt-binding check fail
>
> Po-Kai Chi (4):
>   dt-bindings: memory: Add binding for MediaTek DRAM Controller
>   memory: mediatek: add DRAM controller driver
>   arm64: dts: add DRAMC node for MT6779
>   arm64: defconfig: Enable MediaTek DRAMC common driver
>
>  .../memory-controllers/mediatek,dramc.yaml    | 162 ++++
>  arch/arm64/boot/dts/mediatek/mt6779-evb.dts   |   9 +
>  arch/arm64/boot/dts/mediatek/mt6779.dtsi      |  18 +
>  arch/arm64/configs/defconfig                  |   1 +
>  drivers/memory/Kconfig                        |   1 +
>  drivers/memory/Makefile                       |   1 +
>  drivers/memory/mediatek/Kconfig               |   9 +
>  drivers/memory/mediatek/Makefile              |   3 +
>  drivers/memory/mediatek/mtk-dramc.c           | 711 ++++++++++++++++++
>  include/memory/mediatek/dramc.h               |  18 +

I found this patchset by coincidence as you never cc-ed me. Please use
scripts/get_maintainer.pl to get the list of people you need to Cc.

All this should go via memory drivers tree.


Best regards,
Krzysztof
