Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B43F425768
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 18:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242068AbhJGQNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 12:13:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:60284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231366AbhJGQNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 12:13:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B55F6109F;
        Thu,  7 Oct 2021 16:11:26 +0000 (UTC)
Date:   Thu, 7 Oct 2021 17:11:24 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        maz@kernel.org, mark.rutland@arm.com, james.morse@arm.com,
        anshuman.khandual@arm.com, leo.yan@linaro.org,
        mike.leach@linaro.org, mathieu.poirier@linaro.org, will@kernel.org,
        lcherian@marvell.com, coresight@lists.linaro.org
Subject: Re: [PATCH v2 17/17] arm64: Advertise TRBE erratum workaround for
 write to out-of-range address
Message-ID: <YV8cLD2bYVtMBWGU@arm.com>
References: <20210921134121.2423546-1-suzuki.poulose@arm.com>
 <20210921134121.2423546-18-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921134121.2423546-18-suzuki.poulose@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 02:41:21PM +0100, Suzuki K Poulose wrote:
> Add Kconfig entries for the errata workarounds for TRBE writing
> to an out-of-range address.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
