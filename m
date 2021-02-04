Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A61030F6F7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 17:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237676AbhBDP5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 10:57:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:37544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237619AbhBDP4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 10:56:37 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 240D264DA5;
        Thu,  4 Feb 2021 15:55:55 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1l7gz3-00C2bG-2Z; Thu, 04 Feb 2021 15:55:53 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     "guoren@kernel.org" <guoren@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: (subset) [PATCH v2 1/2] drivers/irqchip: Fixup csky,mpintc compile error with CPU_CK610
Date:   Thu,  4 Feb 2021 15:55:39 +0000
Message-Id: <161245410060.1472442.13488057609914274236.b4-ty@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210204074609.3553018-1-guoren@kernel.org>
References: <20210204074609.3553018-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: guoren@kernel.org, linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org, guoren@linux.alibaba.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Feb 2021 15:46:08 +0800, guoren@kernel.org wrote:
> The irq-csky-mpintc.c only could support CPU_CK860 and it will
> compile error with CPU_CK610.
> 
> It has beed selected in arch/csky/Kconfig

Applied to irq/irqchip-next, thanks!

[1/2] drivers/irqchip: Fixup csky,mpintc compile error with CPU_CK610
      commit: be1abc5ba4d2082df6749ab95ec6f87c4d3dbb23

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


