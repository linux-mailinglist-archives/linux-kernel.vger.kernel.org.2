Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6E040BB14
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 00:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235475AbhINWTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 18:19:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:53838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235486AbhINWTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 18:19:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8459B61164;
        Tue, 14 Sep 2021 22:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631657876;
        bh=wNbJ3NvMSPTEZMWTTi3XZaFjrIVn2Wyjuyw+PoB32Uo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ls0xKi1rn4rUs0oxUWsWjDefh3N0wuquR0md+0R0ZJTnC0XYqqRfLFPpxF3wuhZ9f
         l5J8he8/wX297qirGLhpYYKVCXCk2PFzBgwYYF9YqPICri5hlsPm2rBQmjMkKpqpf0
         h0DKSe/uSrABtJnfsX9ITj6El7vl0f6RHf/EnvOLE3YqyJom2XxfvHAymVpo9e7bsZ
         xiXG4+DlS8WwBrvR3GkYyedKBksCQewh/fdgEXA2I2vSI33mOjyLWjojXxl9i0Vaha
         mL8miefPdNj29OIrNwPSGBwWhHW4VKWkrV7+HcLCq+hnPNselbvnRO/yHeWIVJEX8G
         WyErdc0BmyKGA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210914021633.26377-3-chun-jie.chen@mediatek.com>
References: <20210914021633.26377-1-chun-jie.chen@mediatek.com> <20210914021633.26377-3-chun-jie.chen@mediatek.com>
Subject: Re: [v3 02/24] clk: mediatek: Add dt-bindings of MT8195 clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Date:   Tue, 14 Sep 2021 15:17:55 -0700
Message-ID: <163165787533.763609.14713637160945059116@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chun-Jie Chen (2021-09-13 19:16:11)
> Add MT8195 clock dt-bindings, includes topckgen, apmixedsys,
> infracfg_ao, pericfg_ao and subsystem clocks.
>=20
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---

Applied to clk-next
