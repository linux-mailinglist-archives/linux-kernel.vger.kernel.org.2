Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 235A734933B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 14:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbhCYNnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 09:43:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:56320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230239AbhCYNni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 09:43:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 14291619F2;
        Thu, 25 Mar 2021 13:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616679817;
        bh=a+gs5qtBpnxjQzv7uMhEqBDdWDK3chi2j8lrDSu0hco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lHidKnqjjDQC8ojmJr8rM7KNBeuG4QozCEvIKf1Th/chnfQsz9qIYdmdGc6QFpSdH
         IWNW4e1vXupIVmek4x9uKYzsSCHpvJZbPzmA6DGF02HrttsjckV01vG/9aOo2vGfaM
         ue1QltsuFRl9XD8oreZNMkvzcfXe3hppo0y6FCgIr+sFUrRhdGhx4aMc0FhFJ8gkjk
         8QLvjGP8jj3mtEIMSI5BoQRH/WiukeMPdHgZsK7fRcAWRQMPXQwqKcpZRVSPUaLSzQ
         4ngteX68AxBaIECgcsFJ/VJ5pTKk/91eNVRnRkNhYLnmLP1DPhcqD6yeXhJFKeaZcs
         0gydVOV8MWd6w==
From:   Will Deacon <will@kernel.org>
To:     mark.rutland@arm.com, zhangshaokun@hisilicon.com,
        john.garry@huawei.com, Qi Liu <liuqi115@huawei.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linuxarm@openeuler.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/perf: Simplify the SMMUv3 PMU event attributes
Date:   Thu, 25 Mar 2021 13:43:30 +0000
Message-Id: <161667712017.2255709.18358299918664263461.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1612789498-12957-1-git-send-email-liuqi115@huawei.com>
References: <1612789498-12957-1-git-send-email-liuqi115@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Feb 2021 21:04:58 +0800, Qi Liu wrote:
> For each PMU event, there is a SMMU_EVENT_ATTR(xx, XX) and
> &smmu_event_attr_xx.attr.attr. Let's redefine the SMMU_EVENT_ATTR
> to simplify the smmu_pmu_events.

Applied to will (for-next/perf), thanks!

[1/1] drivers/perf: Simplify the SMMUv3 PMU event attributes
      https://git.kernel.org/will/c/174744136dcb

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
