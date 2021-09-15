Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E199D40BCE3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 03:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhIOBEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 21:04:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:47044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231538AbhIOBEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 21:04:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 75B876115B;
        Wed, 15 Sep 2021 01:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631667766;
        bh=Wa/L/Ic49XHBxPsvtipNUBxl03xF/bfnFiAlcodnQ64=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=oa95nbNjc+8GiiGgUzqqxbuL4kO1socSUgQV4OCGox1zXLYlifN0Y6AgGw98+CC7R
         gBKyG6NxSvQjUwpgjJx0l25t9CzRjG0tdhtmQIGh80ZVuZIBFSGO9CWBkyrO2o+0sP
         n+J31EVwfIcp0/NTVonnlf7VxonR5sQ7Mdoi7w6GQWLgY1lfSUCyA4DtHCTGTw98FA
         btDEexTBRE2PXKGjrXHggaKSg8VhA6nQ8f4/+p3/WVlP8DcyW5s7/g4hJDEmXh9IKX
         NZnD+juiLrZGVqQ4S+YUjJnPydbom+8Z5WxRvReGFZLVNO7Z6X7aC3eOkV2v1s4Q1x
         Y3SyZTsSnnFCg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1631521490-17171-8-git-send-email-abel.vesa@nxp.com>
References: <1631521490-17171-1-git-send-email-abel.vesa@nxp.com> <1631521490-17171-8-git-send-email-abel.vesa@nxp.com>
Subject: Re: [PATCH 7/8] clk: imx: Rework all imx_clk_hw_composite wrappers
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, Abel Vesa <abel.vesa@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>
Date:   Tue, 14 Sep 2021 18:02:45 -0700
Message-ID: <163166776529.763609.14825761247366704451@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2021-09-13 01:24:49)
> Rather than having multiple different macros for each different type
> of imx8m_clk_hw_composite, implement them in such a way so we can
> take advantage the most of the already defined simpler types. Basically,
> we end up having one low-level __imx8m_clk_hw_composite function, a
> wrapper to simplify the parents related arguments called
> _imx8m_clk_hw_composite and then all the types can use those for each
> specific case.
>=20
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
