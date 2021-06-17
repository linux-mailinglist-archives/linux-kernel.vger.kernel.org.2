Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E19D3ABF0A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 00:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbhFQWkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 18:40:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:33582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231295AbhFQWkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 18:40:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 35AFE60FD8;
        Thu, 17 Jun 2021 22:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623969521;
        bh=qqHRTTZGb8fmRoew8uf2CS8qX5xAPH3gA6rFAi+Yplw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R5Ly58EFnYZGK9sLng2WwQ0BQZkeW2iMVad/RKf5RRMyF4JtKMgmbyVRQnQZRtHpO
         9P7vcq4Vg5J42eK0prvofVOdygMMmedXoSjoM9nLhDquvxM3vlI7+jWJHvJnwKT37V
         kJmxqFrA/9C479jZ4u+Bu5jPxx/m7ylQnqRPuwO6LNP6e+VFd58L5DQB9cdjvuf+ve
         k9OByJV9wHetNfRyiyaq2mN24njiLyUu30ThvhxbU1o11Pg5nbjjPCnlQFHDApul45
         E74Eoc/WVZCANFhhVhDRTAAjFSkqn0pdwzcfUineCsFy0E+8TJP57nNT9jqIsVQEeJ
         bRRerckKd1oZg==
From:   Will Deacon <will@kernel.org>
To:     shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        linux-imx@nxp.com, kernel@pengutronix.de, mark.rutland@arm.com,
        Jing Xiangfeng <jingxiangfeng@huawei.com>, Frank.li@nxp.com
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] drivers/perf: fix the missed ida_simple_remove() in ddr_perf_probe()
Date:   Thu, 17 Jun 2021 23:38:33 +0100
Message-Id: <162395552450.941285.1019877721781779869.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210617122614.166823-1-jingxiangfeng@huawei.com>
References: <20210617122614.166823-1-jingxiangfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jun 2021 20:26:14 +0800, Jing Xiangfeng wrote:
> ddr_perf_probe() misses to call ida_simple_remove() in an error path.
> Jump to cpuhp_state_err to fix it.

Applied to will (for-next/perf), thanks!

[1/1] drivers/perf: fix the missed ida_simple_remove() in ddr_perf_probe()
      https://git.kernel.org/will/c/d96b1b8c9f79

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
