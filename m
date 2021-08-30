Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF7E3FBA71
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 18:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237909AbhH3Qz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 12:55:28 -0400
Received: from foss.arm.com ([217.140.110.172]:44428 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231234AbhH3Qz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 12:55:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 80F696D;
        Mon, 30 Aug 2021 09:54:33 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CFB9D3F766;
        Mon, 30 Aug 2021 09:54:32 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] irqchip/gic: Convert to handle_strict_flow_irq()
In-Reply-To: <87eeav19mc.wl-maz@kernel.org>
References: <20210814194737.GA3951530@roeck-us.net> <87sfzb7jeo.mognet@arm.com> <87eeav19mc.wl-maz@kernel.org>
Date:   Mon, 30 Aug 2021 17:54:26 +0100
Message-ID: <875yvmub3x.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/21 07:54, Marc Zyngier wrote:
> In order to restore -next into a working state, I'm temporarily
> dropping this series. Hopefully, we can sort this out before the merge
> window and reinstate it.
>

So what I thought would be a small weekend job turned to be a bit more
involved...

- The throughput improvement with v4 is half of what it was on v3. I
  rebased v3 on the last tip/irq/core and this also took a hit, I'm digging
  into it.
- TX1 is being an absolute PITA to work with, I can't seem to boot anything
  else than the distro kernel ATM (grub commits seppuku).
- Last but not least, I'll soon be AWOL for 3 weeks, a good chunk of it
  involving sitting atop a mountain without electricity. So even if I can
  magically fix all of the above say tomorrow, I'd rather be available to
  ~watch~ handle any unforeseen fireworks.

Hopefully I'll catch the next revision :)

> Thanks,
>
>       M.
>
> --
> Without deviation from the norm, progress is not possible.
