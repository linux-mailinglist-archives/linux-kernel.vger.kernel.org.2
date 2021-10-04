Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB224212BF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 17:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbhJDPgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 11:36:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:55256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233700AbhJDPgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 11:36:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 559C361247;
        Mon,  4 Oct 2021 15:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633361687;
        bh=800Rt9HQy9AZ7cONHa2tYH5ltwrHkgDmC5YS8UR89QE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m1EXqTboBPigSdyEhZ6tETO8Ge/5zQlt3mha/7CjPXmIk5GN1vS4tQS/m6c0QJvYG
         vrpEOj/arjdidOOh+XKH64jET7Gr8rjhtirhYZsnVEq2ZCxCZ9HhQ7cxGc3cs53VQT
         LYPaKLTHy088J2nJSR3tjySd1BMlHwRb0VspQP6GmoCFuUjuhWf1hJCKkLMm0DZcR9
         gA/pPFdEXRrjic2ynMLxpqgY9TtWx7g39nMG/NUV6HlRh74b28ZrBs882R7DP61rmW
         t7iE/OKyKL7JjY5GGX9EMKYlHRo4FhYatb9IOccMwKxjHC2OxaRXz8y4tI2nDc1cHF
         qPcl/arLg6oWw==
From:   Will Deacon <will@kernel.org>
To:     mark.rutland@arm.com, John Garry <john.garry@huawei.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RESEND 0/2] Improve build test coverage for perf drivers
Date:   Mon,  4 Oct 2021 16:34:41 +0100
Message-Id: <163334959188.2736276.883386184657235756.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1633085326-156653-1-git-send-email-john.garry@huawei.com>
References: <1633085326-156653-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Oct 2021 18:48:44 +0800, John Garry wrote:
> Improve build test coverage by allowing some more drivers build under
> COMPILE_TEST as appropriate.
> 
> Baseline is v5.15-rc3
> 
> John Garry (2):
>   drivers/perf: thunderx2_pmu: Change data in size
>     tx2_uncore_event_update()
>   drivers/perf: Improve build test coverage
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/2] drivers/perf: thunderx2_pmu: Change data in size tx2_uncore_event_update()
      https://git.kernel.org/will/c/78cac393b464
[2/2] drivers/perf: Improve build test coverage
      https://git.kernel.org/will/c/e656972b6986

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
