Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAC7042C038
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 14:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbhJMMl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 08:41:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:42190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230219AbhJMMl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 08:41:56 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A9D760527;
        Wed, 13 Oct 2021 12:39:53 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1madXz-00GUGU-7F; Wed, 13 Oct 2021 13:39:51 +0100
MIME-Version: 1.0
Date:   Wed, 13 Oct 2021 13:39:51 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     guoren@kernel.org
Cc:     anup@brainfault.org, atish.patra@wdc.com, tglx@linutronix.de,
        palmer@dabbelt.com, heiko@sntech.de, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Rob Herring <robh@kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: Re: [PATCH V3 1/2] dt-bindings: update riscv plic compatible string
In-Reply-To: <20211013012149.2834212-1-guoren@kernel.org>
References: <20211013012149.2834212-1-guoren@kernel.org>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <5eb20b41ca611f410cf802d4d4a9e945@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: guoren@kernel.org, anup@brainfault.org, atish.patra@wdc.com, tglx@linutronix.de, palmer@dabbelt.com, heiko@sntech.de, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, guoren@linux.alibaba.com, robh@kernel.org, palmerdabbelt@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-10-13 02:21, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Add the compatible string "thead,c900-plic" to the riscv plic
> bindings to support SOCs with thead,c9xx processor cores.
> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> Cc: Anup Patel <anup@brainfault.org>
> Cc: Atish Patra <atish.patra@wdc.com>

Please add a cover letter when sending more than a single patch.

This isn't complicated, and git will do it for you if you kindly ask.

         M.
-- 
Jazz is not dead. It just smells funny...
