Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D073835E558
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 19:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347349AbhDMRtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 13:49:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:44360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347340AbhDMRtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 13:49:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7913861176;
        Tue, 13 Apr 2021 17:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618336169;
        bh=vVFLQF2+aAfAI9X6fd/5rZhsOERCf9IaqsSJSSngM0o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tTsfsWnBuupxa8UwAdqBkf7Wixz09yUDa50pOyErcmYgnLZpatPfHd1W9doC2IdcK
         pTxsOBp7wbPy3SR/27DQb2FI5QWHayyyeg15K/YP5sUR8Y7TYBb3oJdr6LZYq2Ux0c
         oCX9gcOFAdFlamLdC4uKuTEXWjY01qlDrH427s9KNDgPAUgUjCbgj3F40GGAfY3Ipm
         xmX5hAPHQDQ9+19z7DYd5vDmx91FYRG1EqCXjU01LIWMgw7qHuCoMJM9wW/8us6ko0
         +4Jn6FvW+cdC1PGDNUHahLBlvmiTbS5HekkKIR4uprgGPEXbQ0azCSdCWEBt+zNPQp
         q9cKGgoP7x1vA==
From:   Will Deacon <will@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Liao Chang <liaochang1@huawei.com>
Subject: Re: [PATCH] arm64: kprobes: Restore local irqflag if kprobes is cancelled
Date:   Tue, 13 Apr 2021 18:49:22 +0100
Message-Id: <161830261625.3702418.8292373763983690459.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210412174101.6bfb0594@xhacker.debian>
References: <20210412174101.6bfb0594@xhacker.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Apr 2021 17:41:01 +0800, Jisheng Zhang wrote:
> If instruction being single stepped caused a page fault, the kprobes
> is cancelled to let the page fault handler continue as a normal page
> fault. But the local irqflags are disabled so cpu will restore pstate
> with DAIF masked. After pagefault is serviced, the kprobes is
> triggerred again, we overwrite the saved_irqflag by calling
> kprobes_save_local_irqflag(). NOTE, DAIF is masked in this new saved
> irqflag. After kprobes is serviced, the cpu pstate is retored with
> DAIF masked.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: kprobes: Restore local irqflag if kprobes is cancelled
      https://git.kernel.org/arm64/c/738fa58ee132

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
