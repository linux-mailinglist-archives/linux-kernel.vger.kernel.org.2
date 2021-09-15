Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B693740BD20
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 03:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbhIOBYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 21:24:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:58084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232017AbhIOBYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 21:24:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BAE7A61164;
        Wed, 15 Sep 2021 01:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631669013;
        bh=D47U76My5c2pHGChmPNL7NOk97rufg7hvzHTCYDS3SU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Nkm5mmnXi1Dvl4HgrqqbpLjEtmEkaDSeDuoQ25keKNl9/LIS1ApoQyJ8mW9ngY689
         XCqBVEp8UaBBnNF9+hAQa9Jc1dKouwteTJmYPMWDrvR+Xhwc66L4QvJRGauBwxbNLi
         fpSjkh23hroQkMUF3kafRGN+fsos+Q5ldlnoKMpISmM4mf+59wCypfz4P8Gz2YYUpz
         njVjssYb2VJt/hEs00umY89kLULW8aRZrrf9oZsXCcbj7BHVe62sB9F6GIseasLmjc
         kTkEAmta+ca876djXwaUowQfg4P56Nehhyfk/ffVSUtimfJrKjTA7gvoWwvQVDyF5s
         ql8RCoulPb+nw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210901222526.31065-1-miles.chen@mediatek.com>
References: <20210901222526.31065-1-miles.chen@mediatek.com>
Subject: Re: [PATCH v3 0/4] clk: mediatek: modularize COMMON_CLK_MT6779
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Wendell Lin <wendell.lin@mediatek.com>,
        Hanks Chen <hanks.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
        Miles Chen <miles.chen@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Miles Chen <miles.chen@mediatek.com>
Date:   Tue, 14 Sep 2021 18:23:32 -0700
Message-ID: <163166901247.763609.17762427178197245692@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Miles Chen (2021-09-01 15:25:23)
> This patch set makes COMMON_CLK_MEDIATEK and COMMON_CLK_MT6779*
> be able to built as kernel modules. Necessary symbols are exported
> in this patch.
>=20

The subject says 4 patches but there's really only three.
