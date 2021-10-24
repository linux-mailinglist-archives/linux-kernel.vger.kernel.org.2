Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B40D438A78
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 17:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbhJXPxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 11:53:05 -0400
Received: from foss.arm.com ([217.140.110.172]:38342 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229755AbhJXPxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 11:53:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C753D6E;
        Sun, 24 Oct 2021 08:50:42 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 34C5B3F5A1;
        Sun, 24 Oct 2021 08:50:41 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 1/3] irqchip/gic-v3-its: Give the percpu rdist struct its own flags field
In-Reply-To: <87r1cct8cw.wl-maz@kernel.org>
References: <20211022103307.1711619-1-valentin.schneider@arm.com> <20211022103307.1711619-2-valentin.schneider@arm.com> <87r1cct8cw.wl-maz@kernel.org>
Date:   Sun, 24 Oct 2021 16:50:34 +0100
Message-ID: <87bl3ejub9.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/10/21 10:10, Marc Zyngier wrote:
> On Fri, 22 Oct 2021 11:33:05 +0100,
> Valentin Schneider <valentin.schneider@arm.com> wrote:
>> -#define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING	(1 << 0)
>> -#define RDIST_FLAGS_RD_TABLES_PREALLOCATED	(1 << 1)
>> +#define RDISTS_FLAGS_PROPBASE_NEEDS_FLUSHING	(1 << 0)
>> +#define RDISTS_FLAGS_RD_TABLES_PREALLOCATED	(1 << 1)
>> +
>> +#define RDIST_FLAGS_LPI_ENABLED                 BIT(0)
>
> Just to reduce the churn and for me not to misread things (because
> RDIST/RDISTS is pretty confusing), how about leaving the original
> flags as is, and name the per-RD ones like:
>
> #define	RD_LOCAL_LPI_ENABLED	BIT(0)
>
> ?
>
> Or something else that'd be adequately different from the original
> flags?
>

Aye, sounds like the right thing to do!
