Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE19359654
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 09:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbhDIH1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 03:27:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:46316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231566AbhDIH1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 03:27:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A58666113A;
        Fri,  9 Apr 2021 07:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617953215;
        bh=FpOhUzebZHLl4BVsDjbXQWdDJKUcWbUviGbqaC2DkIU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jJZLDQGkVSA0ZywDxttY4mEK+yppwZ+O4JEFM1ve6oL0Vh2xsVlnVE/8V2lGd9SL4
         QCbIY37WwwEcjWPkGIc2/ARXNvpQmrZl/7F1RLWhwKHeV3R3SmeP5dKI1wz5pqj/3/
         6ZPikJJpZshH1MzugvU/0hwR+EhVATj9dZAPpn0COCGSebRKBxxZmo1w4bHh8Rewx1
         dtUMPPjQBZa59a4DJM1WwxHDIrgWpKJMCrcD4BbdhiztmuSVMPtm8ps/swf27A4nev
         e4UAkWGxQGf4ZW++krti8/hB7W3q3VxlEkYmmENVsWyDzwCHjHIs5i5x5lff6MX7u4
         t5ZqmdCT+zVoQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Dinh Nguyen <dinguyen@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] clk: socfpga: fix iomem pointer cast on 64-bit
Date:   Fri,  9 Apr 2021 09:26:50 +0200
Message-Id: <161795309623.1751103.16552528876108968953.b4-ty@arndb.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210314110709.32599-1-krzysztof.kozlowski@canonical.com>
References: <20210314110709.32599-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

On Sun, 14 Mar 2021 12:07:09 +0100, Krzysztof Kozlowski wrote:
> Pointers should be cast with uintptr_t instead of integer.  This fixes
> warning when compile testing on ARM64:
> 
>   drivers/clk/socfpga/clk-gate.c: In function ‘socfpga_clk_recalc_rate’:
>   drivers/clk/socfpga/clk-gate.c:102:7: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]

I decided to pull that into the arm/drivers branch as well, to avoid the
build regression. Since the same fix is in the clk tree, there will now
be a duplicated commit in the git history, but I prefer that over introducing
warnings.

[1/1] clk: socfpga: fix iomem pointer cast on 64-bit
      commit: 36841008059caec9667459a7e126efac6379676b

       Arnd
