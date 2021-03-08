Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE03A331114
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 15:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbhCHOkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 09:40:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:46564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhCHOkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 09:40:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA34661582;
        Mon,  8 Mar 2021 14:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615214415;
        bh=K/1K4HRPKtaKVEB+lIie78zkxFTzX6qA1JfgBRMt65I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gGke4BzWPboM7g+iopMjg3Wb7f17G9u2GOrrU+1XQqYGo88DAIScur4zcA4iZD6uW
         1Jm4CPZg7Hij3d3C5+vpTDVWPT/8qx7Kb3AF4T0T2jCmZF19lnO/hnEI2MOC855zxm
         xHTcuh534pRFjA03/9PYwATtDg+jx992fn3w+UuwGx7oyWRC239QTTFX3ci1ASE3C8
         0KOq+8BR7Qh+d+k2gkFte6lMsBRjGms2sqQG2CrknjPnWGFRwUxTSgwq1RltuMRQK1
         uGg6vLGtsSoQfRq3J4MuX9w9PSn3e/OCF+N9uhQ627eIqU/Cj7eqP3m0rAE52cpcxf
         KpjU7rjkOC4rw==
From:   Will Deacon <will@kernel.org>
To:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Rob Herring <robh@kernel.org>, Max Uvarov <muvarov@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2 0/2] Fix arm64 CONFIG_CMDLINE handling and remove CMDLINE_EXTEND
Date:   Mon,  8 Mar 2021 14:40:04 +0000
Message-Id: <161520819535.987997.16087215537245942596.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210303134927.18975-1-will@kernel.org>
References: <20210303134927.18975-1-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Mar 2021 13:49:25 +0000, Will Deacon wrote:
> This is version two of the series I previously posted here:
> 
> 	https://lore.kernel.org/r/20210225125921.13147-1-will@kernel.org
> 
> The main change since v1 is that, rather than "fix" the FDT code to
> follow the documented behaviour for CMDLINE_EXTEND, I've opted to remove
> the thing entirely for arm64 while a less ambiguous and generic
> replacement is developed, probably based on either [1] or [2].
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/2] arm64: cpufeatures: Fix handling of CONFIG_CMDLINE for idreg overrides
      https://git.kernel.org/arm64/c/df304c2d0dfd
[2/2] arm64: Drop support for CMDLINE_EXTEND
      https://git.kernel.org/arm64/c/cae118b6acc3

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
