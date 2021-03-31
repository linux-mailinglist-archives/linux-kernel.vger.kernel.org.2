Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFC334FB63
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 10:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234063AbhCaITY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 04:19:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:58528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233838AbhCaISs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 04:18:48 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 282F861883;
        Wed, 31 Mar 2021 08:18:48 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1lRW3q-004qqx-54; Wed, 31 Mar 2021 09:18:46 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Xu Jia <xujia39@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] KVM: arm64: Make symbol '_kvm_host_prot_finalize' static
Date:   Wed, 31 Mar 2021 09:18:42 +0100
Message-Id: <161717868791.3935399.17356180043799496626.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <1617176179-31931-1-git-send-email-xujia39@huawei.com>
References: <1617176179-31931-1-git-send-email-xujia39@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: catalin.marinas@arm.com, will@kernel.org, xujia39@huawei.com, linux-arm-kernel@lists.infradead.org, kernel-janitors@vger.kernel.org, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Mar 2021 15:36:19 +0800, Xu Jia wrote:
> The sparse tool complains as follows:
> 
> arch/arm64/kvm/arm.c:1900:6: warning:
>  symbol '_kvm_host_prot_finalize' was not declared. Should it be static?
> 
> This symbol is not used outside of arm.c, so this
> commit marks it static.

Applied to kvm-arm64/host-stage2, thanks!

[1/1] KVM: arm64: Make symbol '_kvm_host_prot_finalize' static
      commit: b1306fef1f48c0af1d659c18c53cf275fdcc94be

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


