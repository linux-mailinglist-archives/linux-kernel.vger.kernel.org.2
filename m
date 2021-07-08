Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D86E3C14B1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 15:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbhGHN5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 09:57:16 -0400
Received: from ozlabs.org ([203.11.71.1]:37555 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231485AbhGHN5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 09:57:15 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4GLHpc3qWRz9sWq; Thu,  8 Jul 2021 23:54:32 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Paul Mackerras <paulus@samba.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Ingo Molnar <mingo@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bharata B Rao <bharata@linux.ibm.com>
In-Reply-To: <20210707183831.2106509-1-valentin.schneider@arm.com>
References: <20210707183831.2106509-1-valentin.schneider@arm.com>
Subject: Re: [PATCH] powerpc: preempt: Don't touch the idle task's preempt_count during hotplug
Message-Id: <162575242118.20406.3966849452752169600.b4-ty@ellerman.id.au>
Date:   Thu, 08 Jul 2021 23:53:41 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jul 2021 19:38:31 +0100, Valentin Schneider wrote:
> Powerpc currently resets a CPU's idle task preempt_count to 0 before said
> task starts executing the secondary startup routine (and becomes an idle
> task proper).
> 
> This conflicts with commit
> 
>   f1a0a376ca0c ("sched/core: Initialize the idle task with preemption disabled")
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc: preempt: Don't touch the idle task's preempt_count during hotplug
      https://git.kernel.org/powerpc/c/2c669ef6979c370f98d4b876e54f19613c81e075

cheers
