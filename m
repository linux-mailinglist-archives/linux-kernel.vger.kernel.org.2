Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44EFA3EC5CF
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 00:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbhHNWcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 18:32:18 -0400
Received: from foss.arm.com ([217.140.110.172]:34692 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233223AbhHNWcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 18:32:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F404431B;
        Sat, 14 Aug 2021 15:31:47 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4EC083F70D;
        Sat, 14 Aug 2021 15:31:47 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] irqchip/gic: Convert to handle_strict_flow_irq()
In-Reply-To: <87sfzb7jeo.mognet@arm.com>
References: <20210814194737.GA3951530@roeck-us.net> <87sfzb7jeo.mognet@arm.com>
Date:   Sat, 14 Aug 2021 23:31:45 +0100
Message-ID: <87pmuf7j5a.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/08/21 23:26, Valentin Schneider wrote:
>
> Now, the above makes me feel like this is the start of a wild goose chase
> for irqchips in a similar situation.

The ones in arch/arm are easy enough to catch (I see gpc, omap-wakeupgen
and some exynos suspend thing), less so for the ones in drivers/irqchip...
