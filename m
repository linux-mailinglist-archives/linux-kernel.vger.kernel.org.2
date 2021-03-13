Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE58633A1CB
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 23:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbhCMWze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 17:55:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:56814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234385AbhCMWzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 17:55:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E478B64E87;
        Sat, 13 Mar 2021 22:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615676113;
        bh=nmj/YjrCki02M7Zkgk1um+80r1CXKmId8/fAOXULvTA=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=HB93rejFx5mLTzFS91LT4Y4PlDidGj1C41H/uk7bsqeCCmv60oZSm/B3272CQENwm
         /Ea399K1Jq/hTanTDlX/UXtvPWy9/JR/0gJ4+73D+xXig2XTesjh00QrPTjUA1Jo8Y
         LDSmMrkDoyi1FITmq4La+qBbCGcfQAmIgjVd61F/faPHgxu/DXl8CKCF0WraBtQJRX
         6Syh0nSSs9pj3ENczuU16Q5HZoqCF/0IM66J/QE7lVU1Dj/NaoM+HgS+LBChNi0nRe
         dAIpxMDXmL9lk5YzMh5SRtW1z/acpdkxdiu+EilnAnXi3LPPXb3ytGxb2klm2JG+M0
         7l1IpynwjZ9wA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210225194201.17001-2-noltari@gmail.com>
References: <20210225194201.17001-1-noltari@gmail.com> <20210225194201.17001-2-noltari@gmail.com>
Subject: Re: [PATCH 1/4] mips: bmips: add BCM63268 timer clock definitions
From:   Stephen Boyd <sboyd@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Michael Turquette <mturquette@baylibre.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        devicetree@vger.kernel.org, jonas.gorski@gmail.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alvaro Fernandez Rojas <noltari@gmail.com>
Date:   Sat, 13 Mar 2021 14:55:11 -0800
Message-ID: <161567611170.1478170.3306012721372270137@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject should probably be clk related instead of mips prefixed. Or
dt-bindings: clk: ?
