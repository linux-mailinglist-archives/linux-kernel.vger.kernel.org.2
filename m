Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A58F334D00C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 14:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhC2M3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 08:29:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:43650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229711AbhC2M2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 08:28:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 055C16192F;
        Mon, 29 Mar 2021 12:28:37 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     kasan-dev@googlegroups.com, will@kernel.org,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     linux@roeck-us.net, ryabinin.a.a@gmail.com, andreyknvl@gmail.com,
        yj.chiang@mediatek.com, gustavoars@kernel.org,
        tyhicks@linux.microsoft.com, rppt@kernel.org, glider@google.com,
        maz@kernel.org, akpm@linux-foundation.org, dvyukov@google.com
Subject: Re: [PATCH v4 0/5] arm64: kasan: support CONFIG_KASAN_VMALLOC
Date:   Mon, 29 Mar 2021 13:28:35 +0100
Message-Id: <161702091034.21347.12247252783807550442.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210324040522.15548-1-lecopzer.chen@mediatek.com>
References: <20210324040522.15548-1-lecopzer.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Mar 2021 12:05:17 +0800, Lecopzer Chen wrote:
> Linux supports KAsan for VMALLOC since commit 3c5c3cfb9ef4da9
> ("kasan: support backing vmalloc space with real shadow memory")
> 
> Acroding to how x86 ported it [1], they early allocated p4d and pgd,
> but in arm64 I just simulate how KAsan supports MODULES_VADDR in arm64
> by not to populate the vmalloc area except for kimg address.
> 
> [...]

Applied to arm64 (for-next/kasan-vmalloc), thanks!

[1/5] arm64: kasan: don't populate vmalloc area for CONFIG_KASAN_VMALLOC
      https://git.kernel.org/arm64/c/9a0732efa774
[2/5] arm64: kasan: abstract _text and _end to KERNEL_START/END
      https://git.kernel.org/arm64/c/7d7b88ff5f8f
[3/5] arm64: Kconfig: support CONFIG_KASAN_VMALLOC
      https://git.kernel.org/arm64/c/71b613fc0c69
[4/5] arm64: kaslr: support randomized module area with KASAN_VMALLOC
      https://git.kernel.org/arm64/c/31d02e7ab008
[5/5] arm64: Kconfig: select KASAN_VMALLOC if KANSAN_GENERIC is enabled
      https://git.kernel.org/arm64/c/acc3042d62cb

-- 
Catalin

