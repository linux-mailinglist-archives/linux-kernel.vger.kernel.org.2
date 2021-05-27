Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 531A9393341
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 18:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237013AbhE0QN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 12:13:28 -0400
Received: from ms.lwn.net ([45.79.88.28]:48194 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235631AbhE0QNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 12:13:24 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 0760C2DC;
        Thu, 27 May 2021 16:11:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0760C2DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1622131910; bh=/V6X7dFIwH+ijI90SpG+HfotiquNJzXcSWfeZUVQZJU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=d4sZZsiXsjR2ff82rfNhnB14MI3OXov3P55fHna4KA21wAeFbZui72REPTg5lySqP
         OSq3SCgJMMe+2aIQp6Dr5ihJVsgUwJcdGzLj8iS7wofTjHx0tTqVRGmpqmHnmlswsq
         TggGdvTgB6gMubKiDQWBeX0d/EzpH+YFcZbeyRAqHjfckcwaWE0w0ufBU+oO1ZhRn/
         5pM6nZlmwCkvbdzZ5APkxdie6RyxAO37WQtDPdbnVae3FJ6GNTQHZM6tSfoGgZfBHQ
         waZWnn7euw3aCgqUhmU1zOdQ8KLu0zbRK4LgD11Qs2WZis5CY3VWHsc3Ddkavgm0Bl
         d2VZX73kNcmiA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Barry Song <song.bao.hua@hisilicon.com>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, will@kernel.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH] docs: kernel-parameters: mark numa=off is supported by
 a bundle of architectures
In-Reply-To: <20210524051715.13604-1-song.bao.hua@hisilicon.com>
References: <20210524051715.13604-1-song.bao.hua@hisilicon.com>
Date:   Thu, 27 May 2021 10:11:49 -0600
Message-ID: <87v9742m2i.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Barry Song <song.bao.hua@hisilicon.com> writes:

> risc-v and arm64 support numa=off by common arch_numa_init()
> in drivers/base/arch_numa.c. x86, ppc, mips, sparc support it
> by arch-level early_param.
> numa=off is widely used in linux distributions. it is better
> to document it.
>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 3 +++
>  1 file changed, 3 insertions(+)

Applied, thanks.

jon
