Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5C8740BCE5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 03:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbhIOBGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 21:06:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:47088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236165AbhIOBEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 21:04:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F332961185;
        Wed, 15 Sep 2021 01:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631667772;
        bh=UWjF+mQ5Odh6NCL2qtOl3dnDIvMn3mEjAub/aO8kUSk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=hQTdWKMW8YcyG7atleoro2tj8jOZkdF2AY01e60r3Wqc4BdUCkpruWbYHqrTikDPW
         C1BDUZB9kr/RnnrddWi4Yz7E8GfWchYRGIMkT7Nc9Wg1IGk7rP/TZ7trjU4aPj5mhp
         KfKST8CsXWCX/Rd2A7vdrXfFbScEqmTQPo4DDHNE2Oh8Kp9w39wYumc7sMv/q1uCK+
         Yq/vtqXa/AUqyQKImKXC071HOtBKxWgDCRX9IMe0cuFVZojM9ZIXWqzP40uUn0Lx+d
         1C61Kc7gMW622mAJ7lTBxAn1z1kdQDAnZ//FTm/lIxq5ngmmew1wrkGjOiEGf/F1ON
         2a011hNyafv7A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1631521490-17171-9-git-send-email-abel.vesa@nxp.com>
References: <1631521490-17171-1-git-send-email-abel.vesa@nxp.com> <1631521490-17171-9-git-send-email-abel.vesa@nxp.com>
Subject: Re: [PATCH 8/8] clk: imx: Rework imx_clk_hw_pll14xx wrapper
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, Abel Vesa <abel.vesa@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>
Date:   Tue, 14 Sep 2021 18:02:50 -0700
Message-ID: <163166777081.763609.7415868964928309045@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2021-09-13 01:24:50)
> It looks much cleaner to just have a macro compared to having
> a function that passes NULL as dev to the lower-level
> imx_dev_clk_hw_pll14xx.
>=20
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
