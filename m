Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 267953979F2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 20:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234539AbhFASXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 14:23:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:39202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231331AbhFASW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 14:22:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A8543613D7;
        Tue,  1 Jun 2021 18:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622571677;
        bh=NiKI03NY1F7sMsj42xiqEYE6fqIBqrnL8QSHEvMmrTY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FINGAiq7HoQoi8lXeVVjuLVrazXeMPAaRPq0MVcXumReNFOQDApYcoKnlxlmQyIfT
         2FcqVdfV0zvUCaWKxfgmq31yBk4HBV0LkwlER0vDy+lxbYl7Ur3J+yjLS3/MQueoqm
         UAzew/l13KSpqTbqyVS5nWZnX81MOLT6L1hW6i5zdM7LgdnaNKpuJ6MoJeAGQzdici
         2qHPkRNzVFgGhRjZBicebRIQ2oPAzUWG1wpVHWwuXD2aTH2RHRdBGZn4QJOcwdt9es
         l8fU/L8YQi59lG+O5j9nhsH/Vni3KHX522/JfbdEpUhyT6MLSK7abYsGLbQpfO1isp
         Gh8MYrhFDh1HA==
From:   Will Deacon <will@kernel.org>
To:     mark.rutland@arm.com, zhangshaokun@hisilicon.com,
        Hao Fang <fanghao11@huawei.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, prime.zeng@hisilicon.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/perf: hisi: use the correct HiSilicon copyright
Date:   Tue,  1 Jun 2021 19:20:59 +0100
Message-Id: <162255352800.566333.3901047872376760421.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1621679037-15323-1-git-send-email-fanghao11@huawei.com>
References: <1621679037-15323-1-git-send-email-fanghao11@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 May 2021 18:23:57 +0800, Hao Fang wrote:
> s/Hisilicon/HiSilicon/.
> It should use capital S, according to the official website
> https://www.hisilicon.com/en.

Applied to will (for-next/perf), thanks!

[1/1] drivers/perf: hisi: use the correct HiSilicon copyright
      https://git.kernel.org/will/c/2db5223731b7

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
