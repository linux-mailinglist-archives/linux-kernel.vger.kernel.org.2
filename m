Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0D373144F9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 01:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbhBIAdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 19:33:35 -0500
Received: from marcansoft.com ([212.63.210.85]:35348 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229541AbhBIAdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 19:33:32 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 5BE0441F47;
        Tue,  9 Feb 2021 00:32:47 +0000 (UTC)
To:     Rob Herring <robh@kernel.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        DTML <devicetree@vger.kernel.org>, Marc Zyngier <maz@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        SoC Team <soc@kernel.org>, Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20210204203951.52105-1-marcan@marcan.st>
 <20210204203951.52105-19-marcan@marcan.st>
 <20210208110441.25qc6yken4effd6c@kozik-lap>
 <cd67b2ce-9676-31b4-85f7-de1ec9b2bf72@marcan.st>
 <20210208121325.owjjd7nfbdanszny@kozik-lap>
 <CAK8P3a0yBC3dui6vcz+NByWD-3LqRj-2MF89jpjb_k8r5xmNRA@mail.gmail.com>
 <f98dc238-6742-455e-3f76-e86ae4c0c838@marcan.st>
 <20210208175847.GB1567700@robh.at.kernel.org>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH 18/18] arm64: apple: Add initial Mac Mini 2020 (M1)
 devicetree
Message-ID: <cace3b98-b102-ffb7-2fa1-1fa896160774@marcan.st>
Date:   Tue, 9 Feb 2021 09:32:45 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210208175847.GB1567700@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/2021 02.58, Rob Herring wrote:
> I'll also highlight there's a DT only tree[1] available to import DT
> related parts to other projects. It's generated from the kernel tree.
> Probably an overkill to copying at this point though.
> 
> Rob
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/

This actually brings up something else: do we want (eventually) *all* 
Apple boards using these SoCs to have up-to-date devicetrees in the 
Linux kernel tree? Obviously not every device supported by mainline has 
proper ones in, but I don't know if that's expected or something to be 
avoided.

If this is intended to be kept in sync and be fully comprehensive, I 
might as well start planning out our longer term DT maintenance strategy 
around that (which might involve using that tree in our bootloader).

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
