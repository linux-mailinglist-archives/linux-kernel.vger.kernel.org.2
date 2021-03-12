Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00B9338BC0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 12:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbhCLLok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 06:44:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:48638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229866AbhCLLoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 06:44:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 988F264EE8;
        Fri, 12 Mar 2021 11:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615549449;
        bh=qOOpPM0PimfCNmlssEftJPWBTDw0C9J3K2Suh+QrGvo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uijsOZgB6UQqUP0GJLhW2izhpqV4IuvqhKBpCatknMYS31IlerQYgNzDbkRYbKBTa
         MD2pO/nIrEyYNZK+tc0inI4Huc5pFaR0kfYh9hlW251O9a9kHnYz6V6MjfXAa+0bse
         28eT7mbnlX7D3C4/PJpi8dysXJ4C2VcGvM7CTBjhdIzbMcFrBzJ4GW8Tz4xPkrbeGL
         LL7jhKTK/7z5UnXhNhubi5WPYAlnIjvlv5V7sVX+09APVMwbkITH7SbGHIbVOdbxoQ
         KTRYMd1vWxkAO7hYD7jkmXi6PXQfjdfH3SYIugVi9+VA979UFigAdplnXVcoRSzBaj
         7GmQg2fndWbQQ==
From:   Will Deacon <will@kernel.org>
To:     'Wei Yongjun <weiyongjun1@huawei.com>,
        Tuan Phan <tuanphan@os.amperecomputing.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, Hulk Robot <hulkci@huawei.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH -next] perf/arm_dmc620_pmu: Fix error return code in dmc620_pmu_device_probe()
Date:   Fri, 12 Mar 2021 11:44:03 +0000
Message-Id: <161554863180.2696599.4016909489580618575.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210312080421.277562-1-weiyongjun1@huawei.com>
References: <20210312080421.277562-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Mar 2021 08:04:21 +0000, 'Wei Yongjun wrote:
> Fix to return negative error code -ENOMEM from the error handling
> case instead of 0, as done elsewhere in this function.

Applied to arm64 (for-next/fixes), thanks!

[1/1] perf/arm_dmc620_pmu: Fix error return code in dmc620_pmu_device_probe()
      https://git.kernel.org/arm64/c/c8e386683652

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
