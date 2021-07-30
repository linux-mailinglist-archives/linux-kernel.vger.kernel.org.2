Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC313DB75A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 12:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238517AbhG3Krb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 06:47:31 -0400
Received: from foss.arm.com ([217.140.110.172]:40290 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238438AbhG3Kr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 06:47:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 191291FB;
        Fri, 30 Jul 2021 03:47:25 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 63E1E3F73D;
        Fri, 30 Jul 2021 03:47:24 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 1/2] irqchip/gic-v3: Add __gic_get_ppi_index() to find the PPI number from hwirq
In-Reply-To: <20210729172748.28841-2-james.morse@arm.com>
References: <20210729172748.28841-1-james.morse@arm.com> <20210729172748.28841-2-james.morse@arm.com>
Date:   Fri, 30 Jul 2021 11:47:19 +0100
Message-ID: <87fsvwkrig.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/07/21 17:27, James Morse wrote:
> gic_get_ppi_index() is a useful concept for ppi partitions, as the GIC
> has two PPI ranges but needs mapping to a single range when used as an
> index in the gic_data.ppi_descs[] array.
>
> Add a double-underscore version which takes just the intid. This will
> be used in the partition domain select and translate helpers to enable
> partition support for the EPPI range.
>
> Signed-off-by: James Morse <james.morse@arm.com>

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
