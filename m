Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60CBC356C21
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 14:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239005AbhDGMcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 08:32:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:49792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231339AbhDGMb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 08:31:58 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAAED611C9;
        Wed,  7 Apr 2021 12:31:48 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1lU7LV-0064P2-VD; Wed, 07 Apr 2021 13:31:46 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] irqchip/sifive-plic: Mark two global variables __ro_after_init
Date:   Wed,  7 Apr 2021 13:31:42 +0100
Message-Id: <161779861852.1095473.7951826017831477751.b4-ty@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210330020911.26423e9e@xhacker>
References: <20210330020911.26423e9e@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: paul.walmsley@sifive.com, tglx@linutronix.de, palmer@dabbelt.com, jszhang3@mail.ustc.edu.cn, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2021 02:09:11 +0800, Jisheng Zhang wrote:
> All of these two are never modified after init, so they can be
>  __ro_after_init.

Applied to irq/irqchip-next, thanks!

[1/1] irqchip/sifive-plic: Mark two global variables __ro_after_init
      commit: e03b7c1bcbfad6f27b4682f638b98627c4e416ba

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


