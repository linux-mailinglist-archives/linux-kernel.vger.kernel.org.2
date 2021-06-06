Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36E0839CE96
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 12:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhFFKdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 06:33:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:47302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229465AbhFFKdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 06:33:12 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01CE4613EF;
        Sun,  6 Jun 2021 10:31:23 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1lpq3s-005kHi-V4; Sun, 06 Jun 2021 11:31:21 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 06 Jun 2021 11:31:20 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     will@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com,
        catalin.marinas@arm.com, suzuki.poulose@arm.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] KVM: arm64: Unify MMIO and mem host stage-2 pools
In-Reply-To: <20210602094347.3730846-5-qperret@google.com>
References: <20210602094347.3730846-1-qperret@google.com>
 <20210602094347.3730846-5-qperret@google.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <b4e4647166447d8fd22b360369de4acb@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: qperret@google.com, will@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com, catalin.marinas@arm.com, suzuki.poulose@arm.com, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, kernel-team@android.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-02 10:43, Quentin Perret wrote:
> We currently maintain two separate memory pools for the host stage-2,
> one for pages used in the page-table when mapping memory regions, and
> the other to map MMIO regions. The former is large enough to map all of
> memory with page granularity and the latter can cover an arbitrary
> portion of IPA space, but allows to 'recycle' pages.
> 
> However, this split makes accounting difficult to manage as pages at
> intermediate levels of the page-table may be used to map both memory 
> and
> MMIO regions. Simplify the scheme by merging both pools into one. This
> means we can now hit the -ENOMEM case in the memory abort path, but
> we're still guaranteed forward-progress in the worst case by unmapping
> MMIO regions. On the plus side this also means we can usually map a lot
> more MMIO space at once if memory ranges happen to be mapped with block
> mappings.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>

This patch fails to apply on top of -rc4. Did you use some more exotic
base or, as I suspect, a development tree?

Please check and respin the series if necessary.

         M.
-- 
Jazz is not dead. It just smells funny...
