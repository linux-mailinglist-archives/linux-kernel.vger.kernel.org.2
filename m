Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F613435FF8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 13:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhJULKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 07:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbhJULKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 07:10:47 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A962C06161C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 04:08:32 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4HZl8X2Zmpz4xbT;
        Thu, 21 Oct 2021 22:08:28 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Nathan Lynch <nathanl@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc:     mpe@ellerman.id.au, clg@kaod.org, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com, srikar@linux.vnet.ibm.com,
        peterz@infradead.org, mingo@kernel.org
In-Reply-To: <20211015173902.2278118-1-nathanl@linux.ibm.com>
References: <20211015173902.2278118-1-nathanl@linux.ibm.com>
Subject: Re: [PATCH v2] powerpc/smp: do not decrement idle task preempt count in CPU offline
Message-Id: <163481445875.3437586.10466955312828450807.b4-ty@ellerman.id.au>
Date:   Thu, 21 Oct 2021 22:07:38 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Oct 2021 12:39:02 -0500, Nathan Lynch wrote:
> With PREEMPT_COUNT=y, when a CPU is offlined and then onlined again, we
> get:
> 
> BUG: scheduling while atomic: swapper/1/0/0x00000000
> no locks held by swapper/1/0.
> CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.15.0-rc2+ #100
> Call Trace:
>  dump_stack_lvl+0xac/0x108
>  __schedule_bug+0xac/0xe0
>  __schedule+0xcf8/0x10d0
>  schedule_idle+0x3c/0x70
>  do_idle+0x2d8/0x4a0
>  cpu_startup_entry+0x38/0x40
>  start_secondary+0x2ec/0x3a0
>  start_secondary_prolog+0x10/0x14
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/smp: do not decrement idle task preempt count in CPU offline
      https://git.kernel.org/powerpc/c/787252a10d9422f3058df9a4821f389e5326c440

cheers
