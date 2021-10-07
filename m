Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6808425764
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 18:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241663AbhJGQLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 12:11:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:59570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232589AbhJGQLm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 12:11:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B664461074;
        Thu,  7 Oct 2021 16:09:46 +0000 (UTC)
Date:   Thu, 7 Oct 2021 17:09:44 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        maz@kernel.org, mark.rutland@arm.com, james.morse@arm.com,
        anshuman.khandual@arm.com, leo.yan@linaro.org,
        mike.leach@linaro.org, mathieu.poirier@linaro.org, will@kernel.org,
        lcherian@marvell.com, coresight@lists.linaro.org
Subject: Re: [PATCH v2 10/17] arm64: Enable workaround for TRBE overwrite in
 FILL mode
Message-ID: <YV8byOXAhk+ydZkY@arm.com>
References: <20210921134121.2423546-1-suzuki.poulose@arm.com>
 <20210921134121.2423546-11-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921134121.2423546-11-suzuki.poulose@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 02:41:14PM +0100, Suzuki K Poulose wrote:
> Now that we have the work around implmented in the TRBE
> driver, add the Kconfig entries and document the errata.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
