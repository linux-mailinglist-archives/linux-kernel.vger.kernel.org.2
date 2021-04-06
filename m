Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88E6C3554DC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 15:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbhDFNVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 09:21:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:57076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231684AbhDFNVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 09:21:06 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19159613B7;
        Tue,  6 Apr 2021 13:20:59 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1lTldY-005riK-1V; Tue, 06 Apr 2021 14:20:56 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     alexandru.elisei@arm.com, will@kernel.org,
        Wang Wensheng <wangwensheng4@huawei.com>,
        linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com,
        dbrazdil@google.com, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, james.morse@arm.com,
        kvmarm@lists.cs.columbia.edu
Cc:     rui.xiang@huawei.com
Subject: Re: [PATCH -next] KVM: arm64: Fix error return code in init_hyp_mode()
Date:   Tue,  6 Apr 2021 14:20:48 +0100
Message-Id: <161771524130.1078033.5622332810036336940.b4-ty@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210406121759.5407-1-wangwensheng4@huawei.com>
References: <20210406121759.5407-1-wangwensheng4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: alexandru.elisei@arm.com, will@kernel.org, wangwensheng4@huawei.com, linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com, dbrazdil@google.com, linux-kernel@vger.kernel.org, catalin.marinas@arm.com, james.morse@arm.com, kvmarm@lists.cs.columbia.edu, rui.xiang@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Apr 2021 12:17:59 +0000, Wang Wensheng wrote:
> Fix to return a negative error code from the error handling
> case instead of 0, as done elsewhere in this function.

Applied to kvm-arm64/misc-5.13, thanks!

[1/1] KVM: arm64: Fix error return code in init_hyp_mode()
      commit: 52b9e265d22bccc5843e167da76ab119874e2883

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


