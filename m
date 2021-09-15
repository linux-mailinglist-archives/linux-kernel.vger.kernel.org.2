Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9538040BCDD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 03:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236099AbhIOBDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 21:03:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:46902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233760AbhIOBDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 21:03:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EFFAA6115B;
        Wed, 15 Sep 2021 01:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631667755;
        bh=RRPffgxQtg0TBenyX325JZB5/u1TQGW33Q8iZNk0/4o=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=bOpHjHQfLF+yRN3d1ljIo33/ZhSeLlHmHGhbHvmv7TpaX1sFnzrcn2snsW5yavvtG
         COqYY/WzVNiFU5mKSNB7Xlvh4WyFG5ib1iwyptFXGXIICC8R+a3s6Sug0jqte7Chin
         BPSomA/QMgbj99hG5erhNTa1k/P5jkm1z35VHgoBUHvbnycfIXTbuyLxY2Bq+RsfoN
         idCnUkRnbwGtTY0KMDrPzL70HQllU04ODQDyC4IpNnmogcjY5mbFFWzmbNSSTes65q
         SJiBMjOL5DLqCNCZJMbMTpqirjzukym1liwMBZfrezr+oJhxKoNmVvcN7CcaSlwqnY
         drSYLa9k8Q99g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1631521490-17171-6-git-send-email-abel.vesa@nxp.com>
References: <1631521490-17171-1-git-send-email-abel.vesa@nxp.com> <1631521490-17171-6-git-send-email-abel.vesa@nxp.com>
Subject: Re: [PATCH 5/8] clk: imx: Rework all clk_hw_register_mux wrappers
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, Abel Vesa <abel.vesa@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>
Date:   Tue, 14 Sep 2021 18:02:33 -0700
Message-ID: <163166775386.763609.9823055816963985491@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2021-09-13 01:24:47)
> Instead of having multiple inline functions that were calling
> clk_hw_register_mux, implement a generic low-level __imx_clk_hw_mux
> and implement the rest as macros that pass on as arguments whatever
> is needed in each case.
>=20
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
