Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA864113B7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 13:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237221AbhITLqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 07:46:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:56118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237196AbhITLqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 07:46:23 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABBFF60F9B;
        Mon, 20 Sep 2021 11:44:56 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mSHjC-00BkWM-Rs; Mon, 20 Sep 2021 12:44:54 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Zenghui Yu <yuzenghui@huawei.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        David Brazdil <dbrazdil@google.com>, suzuki.poulose@arm.com,
        james.morse@arm.com, alexandru.elisei@arm.com,
        wanghaibin.wang@huawei.com
Subject: Re: [PATCH] KVM: arm64: nvhe: Fix missing FORCE for hyp-reloc.S build rule
Date:   Mon, 20 Sep 2021 12:44:43 +0100
Message-Id: <163213827748.1972803.17900179981983234782.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210907052137.1059-1-yuzenghui@huawei.com>
References: <20210907052137.1059-1-yuzenghui@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, yuzenghui@huawei.com, masahiroy@kernel.org, dbrazdil@google.com, suzuki.poulose@arm.com, james.morse@arm.com, alexandru.elisei@arm.com, wanghaibin.wang@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Sep 2021 13:21:37 +0800, Zenghui Yu wrote:
> Add FORCE so that if_changed can detect the command line change.
> 
> We'll otherwise see a compilation warning since commit e1f86d7b4b2a
> ("kbuild: warn if FORCE is missing for if_changed(_dep,_rule) and
> filechk").
> 
> arch/arm64/kvm/hyp/nvhe/Makefile:58: FORCE prerequisite is missing

Applied to fixes, thanks!

[1/1] KVM: arm64: nvhe: Fix missing FORCE for hyp-reloc.S build rule
      commit: a49b50a3c1c3226d26e1dd11e8b763f27e477623

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


