Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFA9390957
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 20:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbhEYTAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 15:00:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:44964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232308AbhEYTAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 15:00:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7700D61378;
        Tue, 25 May 2021 18:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621969157;
        bh=8emlDZ9DfhLzz4+/ffb1kN2vzVTtP7vVWSeCWJsVAIA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FgfgVSkugSAZwI4k1RanbUoH0SPNtV2OLkgZrEcz1vT7T5jKAHJzzvY++h04WWYMu
         GDzZFZHSzZE8YC/XxvpDRiJV3CFExHXECJbNL+17bcsDI6ydqZKQHR/TgjtgoiAkfW
         ovLtUkSZm18G8fMEZnsk5ab8XYZyFVRn+uwJ7wgYGh91ouVQmCCl/CS4/CLUYePhda
         wayVcP2YYK6mbgh3NPNokXDeaYUgMfUBWqhwPnc+iut/SND2Us/dcBFhfRQFywtwNC
         JiUHMz/sxbY6rEL+efWbu3keNFEkfsCukyOfPPKVfpQMwVk8fEfCOZ4FACT5W0BdT2
         78Mr3TQPIQ6DQ==
From:   Will Deacon <will@kernel.org>
To:     Zou Wei <zou_wei@huawei.com>, mark.rutland@arm.com
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH -next] drivers/perf: Remove redundant dev_err call in tx2_uncore_pmu_init_dev()
Date:   Tue, 25 May 2021 19:58:52 +0100
Message-Id: <162196544252.2315380.16736063773162999391.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1620715364-107460-1-git-send-email-zou_wei@huawei.com>
References: <1620715364-107460-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 May 2021 14:42:44 +0800, Zou Wei wrote:
> There is a error message within devm_ioremap_resource
> already, so remove the dev_err call to avoid redundant
> error message.

Applied to will (for-next/perf), thanks!

[1/1] drivers/perf: Remove redundant dev_err call in tx2_uncore_pmu_init_dev()
      https://git.kernel.org/will/c/bf2367aaed73

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
