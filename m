Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDDA3C5CA3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 14:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234135AbhGLMxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 08:53:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:43448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233997AbhGLMxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 08:53:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 24AFD6101E;
        Mon, 12 Jul 2021 12:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626094221;
        bh=g/bQmi6hZ1DFn6gVTu6nhSupxV/QOVQegUh4bEVPR88=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hzTErPJ/f0GsU4XvNCOXPFZWE7q+dkejYQPtOnHb25eSnwSpA4+WVHHz2cQFwu5rU
         ntjJOJnGE1etaucphAy25d04BOeljtAFwqDP334AJhil2WSZYq7cQU70W29G/2R/H0
         XmE8CrFak2eu5u9323dEb+YN7EFbSnMf9uumsFmIG3WMXDvmpF+W2e4wjmaJGsTc64
         cjjwSthOyy3zl0twIcNdAlUYFMezU8WdtZzP+a4TLxTo/ji3VX8i0iOE726b5dy78N
         EoRQvEhb1YhJ2V1bLngtLbJqclBIzouYV+VJHtTGHtHwL33s36GOu6gi36gdhWisVE
         hVyPTYdU377pg==
From:   Will Deacon <will@kernel.org>
To:     Carlos Bilbao <bilbao@vt.edu>, Mark Rutland <mark.rutland@arm.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        maz@kernel.org, linux-arm-kernel@lits.infradead.org
Subject: Re: [PATCH v1.1] arm64: Add missing header <asm/smp.h> in two files
Date:   Mon, 12 Jul 2021 13:50:15 +0100
Message-Id: <162609170391.1141491.10984414127517616347.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <4325940.LvFx2qVVIh@iron-maiden>
References: <5726396.lOV4Wx5bFT@iron-maiden> <20210708093340.GB24650@C02TD0UTHF1T.local> <4325940.LvFx2qVVIh@iron-maiden>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Jul 2021 07:15:42 -0400, Carlos Bilbao wrote:
> Add missing header <asm/smp.h> on include/asm/smp_plat.h, as it calls function
> cpu_logical_map(). Also include it on kernel/cpufeature.c since it has calls to
> functions cpu_panic_kernel() and cpu_die_early().
> 
> Both files call functions defined on this header, make the header dependencies
> less fragile.

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: Add missing header <asm/smp.h> in two files
      https://git.kernel.org/arm64/c/e62e07481486

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
