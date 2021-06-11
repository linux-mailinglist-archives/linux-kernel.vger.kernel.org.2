Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 193283A4642
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 18:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbhFKQRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 12:17:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:47076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229530AbhFKQRr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 12:17:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F9C861285;
        Fri, 11 Jun 2021 16:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623428149;
        bh=+yrrELdlI86YRUa5iUbGADUuNof0QYpgpBj6keHVh/Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XkAvjna2+gK01owYJtNRWQoqmywdT7NYITcAqzArVZUYt2QRvdSfW+bT2Y/ufT2/s
         kj9kaJXX8YTd0s88OlQWUV2njCN+z19idj+UvIA9BvPuunHEi2sR00qGMuAqZpfOhw
         QUHTlrG6PCUb4IgMEdOZq1zdc9JGY6z9+43KRaheLgKRBs9VJVvIKFH7+Gvj7ngUAl
         SmDpQUhMoEIjB7SvTACX4gnBL6XnEWstgCYDHbuhrvd2LMmnyvwxi7iZd3yMXZS49o
         ebOzVYSVopwZC14vOLQt9eefhmHqaSdU9ltvUnXFgiVyCSm4Y95EtRGn2bHeq1CQg9
         7AtgwHnLGjPjw==
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, Qi Liu <liuqi115@huawei.com>,
        linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linuxarm@huawei.com
Subject: Re: [PATCH v4 0/7] drivers/perf: Use general macro to simplify event attributes
Date:   Fri, 11 Jun 2021 17:15:39 +0100
Message-Id: <162340672145.3038331.13069645183611797003.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1623220863-58233-1-git-send-email-liuqi115@huawei.com>
References: <1623220863-58233-1-git-send-email-liuqi115@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jun 2021 14:40:56 +0800, Qi Liu wrote:
> This patchset applies a general EVENT_ATTR_ID to simplify event
> attributes in many PMU drivers.
> 
> Changes since v3:
> - Drop changes in arm_dsu_pmu.c and hisi_uncore_pmu.c.
> - Link: https://lore.kernel.org/linux-arm-kernel/1623123201-45634-1-git-send-email-liuqi115@huawei.com/
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/7] perf: Add EVENT_ATTR_ID to simplify event attributes
      https://git.kernel.org/will/c/f8e6d24144d1
[2/7] drivers/perf: Simplify EVENT ATTR macro in SMMU PMU driver
      https://git.kernel.org/will/c/7ac87a8dfbd9
[3/7] drivers/perf: Simplify EVENT ATTR macro in qcom_l2_pmu.c
      https://git.kernel.org/will/c/0bf2d7298842
[4/7] drivers/perf: Simplify EVENT ATTR macro in qcom_l3_pmu.c
      https://git.kernel.org/will/c/78b1d3c72070
[5/7] drivers/perf: Simplify EVENT ATTR macro in xgene_pmu.c
      https://git.kernel.org/will/c/b323dfe02e56
[6/7] drivers/perf: Simplify EVENT ATTR macro in fsl_imx8_ddr_perf.c
      https://git.kernel.org/will/c/773510f4d277
[7/7] arm64: perf: Simplify EVENT ATTR macro in perf_event.c
      https://git.kernel.org/will/c/64432f09068a

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
