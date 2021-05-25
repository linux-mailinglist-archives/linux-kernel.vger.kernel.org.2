Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A40A3907D7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 19:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234155AbhEYRhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 13:37:02 -0400
Received: from foss.arm.com ([217.140.110.172]:33176 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232832AbhEYRgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 13:36:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 566411516;
        Tue, 25 May 2021 10:35:05 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 58F963F73B;
        Tue, 25 May 2021 10:35:04 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [RFC PATCH v2 00/10] irqchip/irq-gic: Optimize masking by leveraging EOImode=1
In-Reply-To: <20210525173255.620606-1-valentin.schneider@arm.com>
References: <20210525173255.620606-1-valentin.schneider@arm.com>
Date:   Tue, 25 May 2021 18:34:59 +0100
Message-ID: <87eeduhg3g.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/05/21 18:32, Valentin Schneider wrote:
> Hi folks!
>
> This is the spiritual successor to [1], which was over 6 years ago (!).
>

This went missing from the wall of text:

[1]: https://lore.kernel.org/lkml/1414235215-10468-1-git-send-email-marc.zyngier@arm.com/
