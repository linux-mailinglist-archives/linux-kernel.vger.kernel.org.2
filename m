Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1625130E4FF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 22:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbhBCVc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 16:32:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:39474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230139AbhBCVcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 16:32:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C9FC364F6C;
        Wed,  3 Feb 2021 21:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612387905;
        bh=ZpTMR0gW1LpUGwa7HIq+Jy13+2Nq7mPR/mRtLQGn/Tg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mDkqbswX2zNccGbpkomRfgKvEaP30lm10rDQ1x3GHFHpq817wb27WZF6jpDvEICoh
         cJXwwSLi6sOZDEDLwfVSo9m80V01qu/v9R/cblZJ9Fhpq71aAoLoNPCgbCsglxSC7s
         GeEhzND8sOkXsa3V5+V4kyxaPTL41dGtcUVf/VUULgwfrI+BehjQFRRrC9ZU1bwOLC
         WqizeGK5RW84G4uwBPin3e/NMsqv8oMcTVUhKz4z5zNnU8ZczLebcULHVxowJH2mTo
         cnDwITeNPt14PlSRZ0DaejnSfMh9urPD/Ix3hXHEL3CnE89YfwT3DuwuAtnnt8DeeH
         D/qQMy6bAS4yQ==
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Seiya Wang <seiya.wang@mediatek.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        srv_heupstream@mediatek.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 0/2] Add support for ARM Cortex-A78 PMU
Date:   Wed,  3 Feb 2021 21:31:33 +0000
Message-Id: <161238497478.1983958.15302406214791753919.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210203055348.4935-1-seiya.wang@mediatek.com>
References: <20210203055348.4935-1-seiya.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Feb 2021 13:53:46 +0800, Seiya Wang wrote:
> Add support for ARM Cortex-A78 PMU since it will be used in
> new Mediatek SoC.
> 
> Based on v5.11-rc6
> 
> Change in v2:
> Remove change-id in commit message
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/2] arm64: perf: add support for Cortex-A78
      https://git.kernel.org/will/c/db2bb91f2e8e
[2/2] dt-bindings: arm: add Cortex-A78 binding
      https://git.kernel.org/will/c/750d43b4a79e

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
