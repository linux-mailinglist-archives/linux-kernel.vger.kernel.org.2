Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1043979F7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 20:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbhFASXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 14:23:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:39424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234685AbhFASXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 14:23:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F4EB613B4;
        Tue,  1 Jun 2021 18:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622571694;
        bh=XU+xRWt85rrg29YKi9fU+QLJQESEj237LJvor5EajwQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bqb8enXQ4GRj7mcFcVMXnbtF8rdVo+zwFf2X5cmkDoItHAOTZ1EjfXnuyc7rZ1v3x
         ASjmP0XoJc4HghLJqoA4YeccVzHf91AIz/kAiqPNoG/WzIIL5oHYcU2ZanWyC5PKzR
         btBL4eCEbCyu5z1ffVqQAKPEpudmcoJnlvMF2rJfmvYnlP3L3jOEPpVOOLe7NJipm2
         reFZiTVulJf6rMobKJrhFdRb+SCZLXJ1NV/PgavYoimPwms/PZtSG5d8U852nxIMVu
         sxKTDojUN/zP939+u1Mf1GC+F7cp6uzWD0VNA+7mKppKM4VeEk+c+KrT8Q5bFG5k0Y
         soSorsFfQz0QA==
From:   Will Deacon <will@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>, mark.rutland@arm.com,
        msalter@redhat.com, khuong@os.amperecomputing.com
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: xgene_pmu: use DEVICE_ATTR_RO macro
Date:   Tue,  1 Jun 2021 19:21:08 +0100
Message-Id: <162255382675.566937.4976196311631137956.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210528014940.4184-1-yuehaibing@huawei.com>
References: <20210528014940.4184-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 May 2021 09:49:40 +0800, YueHaibing wrote:
> Use DEVICE_ATTR_RO() helper instead of plain DEVICE_ATTR(),
> which makes the code a bit shorter and easier to read.

Applied to will (for-next/perf), thanks!

[1/1] perf: xgene_pmu: use DEVICE_ATTR_RO macro
      https://git.kernel.org/will/c/21ad02e6b4c8

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
