Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C60B034933A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 14:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbhCYNns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 09:43:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:56330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230292AbhCYNnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 09:43:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 44D1A61A21;
        Thu, 25 Mar 2021 13:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616679820;
        bh=z8sgp63TKzfh0CpgZs/IbPMYrXqdov927WUBF8DnqlM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jpHAtDBlPU22z2wfd3E1PcQqdZqlzKN1g+L8TqOY27c2JRdKllT9uIQceERceY+Zt
         xSp5I45+QgLMpZPIcq++LOMTk5LFP2CS+9f+dq9s1eorQAvbn5+ThMeSCtvRkaDGgk
         rVuvZ96PYJ99C0M2g2o5i8CbJefzPsgXgmLrtw4JkqQ13SDcBupWZLvfxO5zmvTERj
         vdsB2nUniS2UUiVs62//wVHemiUyxhoMCr3TdO04UtNZRbXmfFTuslaiUMeeoPBa0y
         MkdNCewX3WURzj7Ejv6nd0PYo+Waquhv31MgGRJGOWVwvT+p5F8GStMBf0vyJqfGld
         9HpNDSan2Qing==
From:   Will Deacon <will@kernel.org>
To:     john.garry@huawei.com, zhangshaokun@hisilicon.com,
        Qi Liu <liuqi115@huawei.com>, mark.rutland@arm.com
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linuxarm@openeuler.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] drivers/perf: convert sysfs sprintf/snprintf/scnprintf to sysfs_emit
Date:   Thu, 25 Mar 2021 13:43:31 +0000
Message-Id: <161667694481.2254960.9445156993424040679.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1616148273-16374-1-git-send-email-liuqi115@huawei.com>
References: <1616148273-16374-1-git-send-email-liuqi115@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Mar 2021 18:04:30 +0800, Qi Liu wrote:
> Use the generic sysfs_emit() and sysfs_emit_at() function to take
> place of sprintf/snprintf/scnprintf, to avoid buffer overrun.
> 
> Qi Liu (2):
>   drivers/perf: convert sysfs scnprintf family to sysfs_emit_at() and sysfs_emit()
>   drivers/perf: convert sysfs sprintf family to sysfs_emit
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/3] drivers/perf: convert sysfs snprintf family to sysfs_emit
      https://git.kernel.org/will/c/700a9cf0527c
[2/3] drivers/perf: convert sysfs scnprintf family to sysfs_emit_at() and sysfs_emit()
      https://git.kernel.org/will/c/9ec9f9cf8660
[3/3] drivers/perf: convert sysfs sprintf family to sysfs_emit
      https://git.kernel.org/will/c/fb62d67586af

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
