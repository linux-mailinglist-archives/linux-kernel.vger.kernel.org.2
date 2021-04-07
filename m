Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C195A356C1E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 14:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352191AbhDGMbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 08:31:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:49710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242715AbhDGMbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 08:31:39 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48219611C9;
        Wed,  7 Apr 2021 12:31:30 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1lU7LE-0064Og-8h; Wed, 07 Apr 2021 13:31:28 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Hao Fang <fanghao11@huawei.com>, tglx@linutronix.de
Cc:     wuyun.wu@huawei.com, majun258@huawei.com, prime.zeng@hisilicon.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irqchip/hisi: Use the correct HiSilicon copyright
Date:   Wed,  7 Apr 2021 13:31:23 +0100
Message-Id: <161779861852.1095473.4957575997192543701.b4-ty@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <1617086780-8521-1-git-send-email-fanghao11@huawei.com>
References: <1617086780-8521-1-git-send-email-fanghao11@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: fanghao11@huawei.com, tglx@linutronix.de, wuyun.wu@huawei.com, majun258@huawei.com, prime.zeng@hisilicon.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2021 14:46:20 +0800, Hao Fang wrote:
> s/Hisilicon/HiSilicon/
> It should use capital S, according to
> https://www.hisilicon.com/en/terms-of-use.

Applied to irq/irqchip-next, thanks!

[1/1] irqchip/hisi: Use the correct HiSilicon copyright
      commit: 64ec2ad3b84d43926e618bb515f2382c266535ee

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


