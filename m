Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F3B3DD49B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 13:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbhHBLZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 07:25:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:60386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232553AbhHBLZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 07:25:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A610260F36;
        Mon,  2 Aug 2021 11:24:56 +0000 (UTC)
Date:   Mon, 2 Aug 2021 12:24:54 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, anshuman.khandual@arm.com,
        will@kernel.org, james.morse@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, leo.yan@linaro.org, maz@kernel.org,
        mark.rutland@arm.com
Subject: Re: [PATCH 09/10] arm64: Enable workaround for TRBE overwrite in
 FILL mode
Message-ID: <20210802112453.GD18685@arm.com>
References: <20210728135217.591173-1-suzuki.poulose@arm.com>
 <20210728135217.591173-10-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728135217.591173-10-suzuki.poulose@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 02:52:16PM +0100, Suzuki K Poulose wrote:
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
