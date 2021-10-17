Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB80430604
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 03:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244815AbhJQBrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 21:47:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:34810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244778AbhJQBrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 21:47:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB904611C1;
        Sun, 17 Oct 2021 01:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634435123;
        bh=hWu3naWLEljaXZ6tCZEQaxOp96L1LV3vPZgdeT/1r/0=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=j0NccPw45ETG4C3Etjd4vW0JPRmNpLqmnDm555cthALGKxuJkothgDDrzIcgDmfTq
         wkHAOxvZfE8WD9F8uPj4ya26RpIzIVXQuKenoNpCpNaHm6KAi/iNKorf06/kvYXWoU
         +wjsg54Qh5o18hFotjEd0guNEGmLou92bjMIV0lXz1jmmSdTKpiN5OxnDx4Um45gK3
         nHcFuoXePVTj6t7lUx2Skjtku0PUm1wvhM6Tf/j/TECVwzqcxuelYeDkRcaOhUvgwL
         D/bOqYfSdlovqt5Fm5Z76S75ltgmDBKDstT1RHWkzLAeoI/CyRgELiwQJQfAE0mtIT
         aoZdPYXJop30Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211005064513.27655-1-ryan_chen@aspeedtech.com>
References: <20211005064513.27655-1-ryan_chen@aspeedtech.com>
Subject: Re: [PATCH] clk:aspeed:Fix reset driver probe from builtin_platform to core_initcal
From:   Stephen Boyd <sboyd@kernel.org>
To:     Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        ryan_chen <ryan_chen@aspeedtech.com>
Date:   Sat, 16 Oct 2021 18:45:21 -0700
Message-ID: <163443512161.1557475.9840437799108931135@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ryan Chen (2021-10-04 23:45:13)
> Change the reset probe sequence from builtin_platform to core_initcal.
> For avoid some driver is probe but failed due to reset driver not probe.

I don't get it. Does something never try probe again because it can't
get the reset it wants? I understand that builtin_platform_driver()
moves the initcall level later than core_initcall() so this is a
workaround for some driver probe ordering problem?

>=20
> Fixes: d3d04f6c330a ("clk: Add support for AST2600 SoC")
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
