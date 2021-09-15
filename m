Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7544B40BCE2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 03:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbhIOBEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 21:04:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:47008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235578AbhIOBD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 21:03:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 092996115B;
        Wed, 15 Sep 2021 01:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631667761;
        bh=QA8Z5VPzrcbJPNeGTUyXXk4+hBp39vocPTWMXVD0mTM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Zy5thlRk1hLvfERyJUNGQKaX/o1HOF2R1anT9WiAdjRFoEBG+V0IRRQ8UakqkAOLG
         4Kw0uWzVNKPY2pTZiOohIz5MNtjMUEkzjyJ0vxvaetMgLihN1N4w1DHBQy1cojMzt7
         YpYwY+kbLMYFhWgt3OygxRAQbyViErH+oixLX+o3DECDTRMh1+EBMa7sOQbOcHBdjT
         KRb+0lrWSGs2MGx2LjCL7A8xrD+n1jCXyos4/hDfqZlbW/wx6+2x01ZFbweXkwmCr9
         pBWcweUdhRpQr3CYBCuZKC9hEaALelfWP1ubfTFBu5/be+66i7xxLD3UQ042t0/1+6
         T4g3k2Un6Oxag==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1631521490-17171-7-git-send-email-abel.vesa@nxp.com>
References: <1631521490-17171-1-git-send-email-abel.vesa@nxp.com> <1631521490-17171-7-git-send-email-abel.vesa@nxp.com>
Subject: Re: [PATCH 6/8] clk: imx: Rework all clk_hw_register_divider wrappers
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, Abel Vesa <abel.vesa@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>
Date:   Tue, 14 Sep 2021 18:02:39 -0700
Message-ID: <163166775986.763609.5671531072101852437@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2021-09-13 01:24:48)
> Instead of having multiple inline functions that were calling
> clk_hw_register_divider, implement a generic low-level
> __imx_clk_hw_divider and implement the rest as macros that
> pass on as arguments whatever is needed in each case.
>=20
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
