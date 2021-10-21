Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC8E4368C8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 19:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbhJURNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 13:13:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:45672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231320AbhJURNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 13:13:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1A39161A10;
        Thu, 21 Oct 2021 17:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634836284;
        bh=CSXxyTaQtIaxNFV2ImnHbTi91+q08can4AJfNYCT9ho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fGAWt/RgExFThZd2f97kjgBZGtYmPC0ye38ulaiR+bzXd3L3hvP7xqoNWIi80VlEF
         uxP8RHde9guqYWSaTRUu1yTq0qN+TvbeCwCDMVOSaHXSCsVwehuy4MOG+6w6cOhMAI
         8UwL3iG+HomuPd5uqPakye8KrIl1+noUU7tlUOb5Z+PUNVCVk5IFfMviF+/dmNqL4Z
         lAZlanTsDIWJlS/b+f2nishuBhLdiYK86NNUpt+7UbaOrxPW87dHb+p4XU7BoP3QAx
         Crygnf5cnRmtgEJaDIQZ18InCOUP9KGHOWcKy2w23mH5l8vQPgo2DGxZYVJy5r9RgQ
         2bobMAfvOVTEA==
From:   Will Deacon <will@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        mathieu.poirier@linaro.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, maz@kernel.org,
        leo.yan@linaro.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        linux-arm-kernel@lists.infradead.org, mike.leach@linaro.org
Subject: Re: [PATCH v6 00/15] arm64: Self-hosted trace related errata workarounds
Date:   Thu, 21 Oct 2021 18:11:17 +0100
Message-Id: <163483495815.3806064.5821399518548380891.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211019163153.3692640-1-suzuki.poulose@arm.com>
References: <20211019163153.3692640-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Oct 2021 17:31:38 +0100, Suzuki K Poulose wrote:
> This series adds CPU erratum work arounds related to the self-hosted
> tracing. The list of affected errata handled in this series are :
> 
>  * TRBE may overwrite trace in FILL mode
>    - Arm Neoverse-N2	#2139208
>    - Cortex-A710	#211985
> 
> [...]

Applied first four patches to arm64 (for-next/trbe-errata), thanks!

[01/15] arm64: Add Neoverse-N2, Cortex-A710 CPU part definition
        https://git.kernel.org/arm64/c/2d0d656700d6
[02/15] arm64: errata: Add detection for TRBE overwrite in FILL mode
        https://git.kernel.org/arm64/c/b9d216fcef42
[03/15] arm64: errata: Add workaround for TSB flush failures
        https://git.kernel.org/arm64/c/fa82d0b4b833
[04/15] arm64: errata: Add detection for TRBE write to out-of-range
        https://git.kernel.org/arm64/c/8d81b2a38ddf

Mathieu -- feel free to pull this into the coresight tree, as I won't be
rebasing it.

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
