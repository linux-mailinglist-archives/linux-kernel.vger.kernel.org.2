Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87C5534F6AE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 04:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbhCaCcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 22:32:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:57848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233411AbhCaCcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 22:32:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4E0BA619C5;
        Wed, 31 Mar 2021 02:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617157922;
        bh=k+q8TaFoKuLxinMGNfEFG+REsQxiLnl31ZVAcep92F4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=nqqe7QZnzhEXPtJH9eoMxY+G0wLr4b2+MemF3yx8uaz6eaBJnXch5F4FdV8n0wlgv
         TuDRqobE0bnljOdD2vvtEmnn0PpaqaQ5BAlMO8ijnOcFKGa33V7g2lxt8Uv0++widp
         gIp0xUiTfzmkWu1QG2BsvPuNh+uUuT6mPsn3qRd9GITDKm8CUF0Zbd3ZabHteACKva
         zyAOF2Ks3UuDxRtHgTyfOII4yhJL7wsIw6BYeZ337Y6TCQiA6NFxPhM9GN8yOzTAcH
         KKyT++Nz1H2KHslYRo4AjS99HwKL9CNbrrWsgZ3GSwC91y62UmwvyENrdm7kFTpFF7
         qoJduVJk3svuA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210302214151.1333447-3-dinguyen@kernel.org>
References: <20210302214151.1333447-1-dinguyen@kernel.org> <20210302214151.1333447-3-dinguyen@kernel.org>
Subject: Re: [PATCH 3/3] clk: socfpga: Convert to s10/agilex/n5x to use clk_hw
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     dinguyen@kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Dinh Nguyen <dinguyen@kernel.org>
Date:   Tue, 30 Mar 2021 19:32:00 -0700
Message-ID: <161715792081.2260335.10703442040302436703@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dinh Nguyen (2021-03-02 13:41:51)
> As recommended by Stephen Boyd, convert the Agilex/Stratix10/n5x clock
> driver to use the clk_hw registration method.
>=20
> Suggested-by: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---

Applied to clk-next
