Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED3D7333B9C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 12:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbhCJLkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 06:40:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:53176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229689AbhCJLkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 06:40:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F8CF64FE5;
        Wed, 10 Mar 2021 11:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615376373;
        bh=xQ6SwjdUQv3ba3jHsYuK98gEzP7tGEoWw94EqmlnRM0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sm6vpbGqGs7qn9uy1gSaWNPAgj9OMrvjQELGunOM4QL6qrKm1Q0OpMjskfoFhKwQf
         8avgwdLN68LLC1CFYZTVxK+I2FmO/Fk7Z+d+krVwVl2DXR54ti3QU4ZaxjPtjJ0waZ
         7aJMh/RKK4jk+4HcaoxDb/75wYicYJSJrOUkfhn107gkCsXwIJb821XmTNqxa1suIp
         9B4czlCw+XJ4T/hdMhS3tkKKIBpvT1RGJnPXynxh5MYakHCN6suXVdhmv01nQkewPP
         V/LanN7VBzfkkcK62U1GhcgPZcMohxOrvfdrsRsJrKH+3NWPPjx+NndzIQ6U40H2hj
         mUbhuJ99GWdhQ==
From:   Will Deacon <will@kernel.org>
To:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arm-kernel@lists.infradead.org,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>
Subject: Re: [PATCH] arm64: perf: Fix 64-bit event counter read truncation
Date:   Wed, 10 Mar 2021 11:39:19 +0000
Message-Id: <161537450433.1678552.10313003900540512459.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210310004412.1450128-1-robh@kernel.org>
References: <20210310004412.1450128-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Mar 2021 17:44:12 -0700, Rob Herring wrote:
> Commit 0fdf1bb75953 ("arm64: perf: Avoid PMXEV* indirection") changed
> armv8pmu_read_evcntr() to return a u32 instead of u64. The result is
> silent truncation of the event counter when using 64-bit counters. Given
> the offending commit appears to have passed thru several folks, it seems
> likely this was a bad rebase after v8.5 PMU 64-bit counters landed.

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: perf: Fix 64-bit event counter read truncation
      https://git.kernel.org/arm64/c/7bb8bc6eb550

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
