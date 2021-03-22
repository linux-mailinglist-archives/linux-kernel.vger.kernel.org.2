Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 095EF344594
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 14:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbhCVNXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 09:23:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:38844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231971AbhCVNUN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 09:20:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C6CF761930;
        Mon, 22 Mar 2021 13:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616419213;
        bh=DEM5m42T6fPO1L4ytDHAvL93o+qWMGXRGdg6w0KHqpM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d0/Tjs95plgTlxflkC/2arhZPTi+AX9eUSqC9/Iet8NbuDjHxh39zImbo+GThacHk
         g0tSDJCaV4Uf3Z0uC2N8Z5kdFnq2lg0StYVG3ePTW/VUR8oeR9Agsnte+RLgZjD1DE
         LrsqMBW2mpaA3zkMmAtcrq1SiZeFDrDHJo8orKBgOLOEJ4sy6kKRUSGU5ppAbFXnbT
         +Z6gc1kHDeSRJI8+kanQpE9xOeN9wqqBnGvY8TUVNM8OfWekznsvwcwm0kJClqxtoS
         PGqy13QjDqdKYH8McJCNX9CPs4dKXildtYiy+LADPvwLfflZtGQ9JK9mbDSGrP1/tf
         1COaFmQG7Tkag==
From:   Will Deacon <will@kernel.org>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jmorris@namei.org, catalin.marinas@arm.com,
        tyhicks@linux.microsoft.com
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>
Subject: Re: [PATCH] arm64: kdump: update ppos when reading elfcorehdr
Date:   Mon, 22 Mar 2021 13:19:57 +0000
Message-Id: <161641719902.3900979.10337880549161097433.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210319205054.743368-1-pasha.tatashin@soleen.com>
References: <20210319205054.743368-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Mar 2021 16:50:54 -0400, Pavel Tatashin wrote:
> The ppos points to a position in the old kernel memory (and in case of
> arm64 in the crash kernel since elfcorehdr is passed as a segment). The
> function should update the ppos by the amount that was read. This bug is
> not exposed by accident, but other platforms update this value properly.
> So, fix it in ARM64 version of elfcorehdr_read() as well.

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: kdump: update ppos when reading elfcorehdr
      https://git.kernel.org/arm64/c/141f8202cfa4

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
