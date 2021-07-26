Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9D83D5616
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 11:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbhGZIYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 04:24:53 -0400
Received: from gloria.sntech.de ([185.11.138.130]:33096 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232041AbhGZIYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 04:24:51 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1m7wY2-0001MC-VM; Mon, 26 Jul 2021 11:05:18 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     cl@rock-chips.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kever.yang@rock-chips.com
Subject: Re: [PATCH 09/10] arm64: dts: rockchip: add pwm nodes for rk3568
Date:   Mon, 26 Jul 2021 11:05:18 +0200
Message-ID: <5809323.72vocr9iq0@diego>
In-Reply-To: <20210622102907.99242-1-heiko@sntech.de>
References: <20210622102907.99242-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 22. Juni 2021, 12:29:06 CEST schrieb Heiko Stuebner:
> From: Liang Chen <cl@rock-chips.com>
> 
> Add the pwm controller nodes to the core rk3568 dtsi.
> 
> Signed-off-by: Liang Chen <cl@rock-chips.com>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

moved over to
https://lore.kernel.org/r/20210726090355.1548483-1-heiko@sntech.de



