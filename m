Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C322351A4D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236126AbhDAR67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 13:58:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:42954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235598AbhDARnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:43:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 33C56613C1;
        Thu,  1 Apr 2021 17:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617298417;
        bh=VHhMllu2s4a5nXAlhfYG1ZhOBbqGAbBndSDATjQYUGA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oEL6bQox1StEQh++WEwoIRz9Gt5Hv7vKcCQ0Yl7vd2JT+RNXHINdxsCAd2sEyVuvm
         j0H4ouYVyltc7KuIOQlDaUZamJRJzcIrjFXY8rYmAThMbnudQ2aBN2ar15SzzkDGUs
         1hVHYxl/DV/N7wBYERyG2TfPFG75XW92/Zfsug1qyr24/oj5hioPjsjkNRtCXT3Se7
         ir7fuHuBJiqEBu7svXl8cN80Sfw1bDKPnQ9RcIqX8QxwwGo7XDXXdQ5lItJn+qFC49
         XSjlvoD0cFjli4cwkOLlSTaCtQ8EOH8TFBbx85KEWKyBmqxQkKXVC6Rn0Lfwie+cQ2
         mFp62oPHVoQhQ==
From:   Will Deacon <will@kernel.org>
To:     mark.rutland@arm.com, Qi Liu <liuqi115@huawei.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH] arm64: perf: Remove redundant initialization in perf_event.c
Date:   Thu,  1 Apr 2021 18:33:31 +0100
Message-Id: <161729673248.2265527.16326375852509765963.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1617275801-1980-1-git-send-email-liuqi115@huawei.com>
References: <1617275801-1980-1-git-send-email-liuqi115@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Apr 2021 19:16:41 +0800, Qi Liu wrote:
> The initialization of value in function armv8pmu_read_hw_counter()
> and armv8pmu_read_counter() seem redundant, as they are soon updated.
> So, We can remove them.

Applied to will (for-next/perf), thanks!

[1/1] arm64: perf: Remove redundant initialization in perf_event.c
      https://git.kernel.org/will/c/2c2e21e78a94

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
