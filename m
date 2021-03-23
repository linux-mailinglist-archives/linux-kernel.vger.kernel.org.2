Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D97AA34677B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 19:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbhCWSWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 14:22:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:45670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231670AbhCWSVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 14:21:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 13FD2619C2;
        Tue, 23 Mar 2021 18:21:46 +0000 (UTC)
Date:   Tue, 23 Mar 2021 18:21:44 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, leo.yan@linaro.org,
        anshuman.khandual@arm.com, maz@kernel.org,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v5 05/19] arm64: Add support for trace synchronization
 barrier
Message-ID: <20210323182142.GA16080@arm.com>
References: <20210323120647.454211-1-suzuki.poulose@arm.com>
 <20210323120647.454211-6-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323120647.454211-6-suzuki.poulose@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki?

On Tue, Mar 23, 2021 at 12:06:33PM +0000, Suzuki K Poulose wrote:
> tsb csync synchronizes the trace operation of instructions.
> The instruction is a nop when FEAT_TRF is not implemented.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

How do you plan to merge these patches? If they go via the coresight
tree:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
