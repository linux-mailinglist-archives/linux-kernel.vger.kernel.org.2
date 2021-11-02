Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 005A2442CCE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 12:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbhKBLlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 07:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbhKBLk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 07:40:59 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1659FC061714;
        Tue,  2 Nov 2021 04:38:24 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Hk7FS5YY5z4xcB;
        Tue,  2 Nov 2021 22:38:20 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20211013220532.24759-1-agust@denx.de>
References: <20211013220532.24759-1-agust@denx.de>
Subject: Re: [PATCH 0/4] Update mpc5200 dts files to fix warnings
Message-Id: <163584790458.1845480.6370187649421665314.b4-ty@ellerman.id.au>
Date:   Tue, 02 Nov 2021 21:11:44 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Oct 2021 00:05:28 +0200, Anatolij Gustschin wrote:
> This series fixes localbus, memory and pci node build warnings.
> It was tested with current linux-next on digsy_mtc and tqm5200
> boards.
> 
> Anatolij Gustschin (4):
>   powerpc/5200: dts: add missing pci ranges
>   powerpc/5200: dts: fix pci ranges warnings
>   powerpc/5200: dts: fix memory node unit name
>   powerpc/5200: dts: fix localbus node warnings
> 
> [...]

Patches 1-3 applied to powerpc/next.

[1/4] powerpc/5200: dts: add missing pci ranges
      https://git.kernel.org/powerpc/c/e9efabc6e4c31517394be13c2f0c5abadd33f328
[2/4] powerpc/5200: dts: fix pci ranges warnings
      https://git.kernel.org/powerpc/c/7855b6c66dc458e2f5abfb2b50f527ea4101df77
[3/4] powerpc/5200: dts: fix memory node unit name
      https://git.kernel.org/powerpc/c/aed2886a5e9ffc8269a4220bff1e9e030d3d2eb1

cheers
