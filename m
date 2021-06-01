Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1AB33979F4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 20:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234668AbhFASXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 14:23:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:39368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234650AbhFASXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 14:23:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D8C2613D6;
        Tue,  1 Jun 2021 18:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622571690;
        bh=QcA9L5YGdNQ+/+0ZEfFO8nkWFVI2VU2WkgFNC6krH18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YP2/k1Ua963pufEk0loKQn2+Bpdpeo4lVd1U+DeuS5KJr9jjQyeWI5uUwU2IOX4ly
         NLxPjekz7G/AYgGMTFRPjaqnIKnmPYVdhlYLDbJuJpZz4w8Hqon8iomEg8Qn5y0hd8
         x1X+uWtfVdsJRky9XzeF/qweoRfkDfWaVLZdoro5oDWGnmPocNQ4mOtgfpRn2zNS0z
         PGoIx0AN7a93rveK1IWu8zlqwhTcxB/cYQ0eha4H42fLsFM6xFzWVKxD8V0RYxo2Zk
         NyeoCzZQOHAQ10Hc0bxRz6iwaGYBkJKRXCOpp2sMkAu56ssfRteV6mRoaB281/drP4
         sZicVDxz8jKWQ==
From:   Will Deacon <will@kernel.org>
To:     julien.thierry.kdev@gmail.com, YueHaibing <yuehaibing@huawei.com>,
        mark.rutland@arm.com
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] perf: arm_pmu: use DEVICE_ATTR_RO macro
Date:   Tue,  1 Jun 2021 19:21:06 +0100
Message-Id: <162255376490.566610.18422586796152278321.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210528014130.7708-1-yuehaibing@huawei.com>
References: <20210528014130.7708-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 May 2021 09:41:30 +0800, YueHaibing wrote:
> Use DEVICE_ATTR_RO helper instead of plain DEVICE_ATTR,
> which makes the code a bit shorter and easier to read.

Applied to will (for-next/perf), thanks!

[1/1] perf: arm_pmu: use DEVICE_ATTR_RO macro
      https://git.kernel.org/will/c/29c043760eea

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
