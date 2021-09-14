Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42DF340BB42
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 00:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbhINWVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 18:21:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:55184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235765AbhINWUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 18:20:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC94D61164;
        Tue, 14 Sep 2021 22:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631657976;
        bh=+KmAmWtMfypw9Fo3nOIC+Li00raIN7DW8K+8HiWqjv8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=pYKEq2kho+6E/8YNSJRFJHbuQFcZpmzjanSTHkAFoBx+1fv4EHsHvYy6i8v2ySqll
         TgRFzq7p6yZVCkUf0uNMOLWNkK2pfubwJF2LK+OC9MsUR0qFfUJtDUn5c+JI4P9c/V
         nyFN31s2F6gLaWXKaD8uLeSMprzOldTpSlUmnh2Gdh4XpkQG18gyJa+WBqvLzcCqvB
         enf1ZVPnXSTvSohvRfLqWpfqQnDKOzX5GGSBUq0T0SKAFDGi3R00kD87H5NSW+SvM4
         EnVW6J7plyhIVKL5DS2mEDX1BYIGuwP8N+HzFzqhEgYh/N9EiWchrPl9s+AHKy7BMN
         pX5tujO7FOelw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210914021633.26377-18-chun-jie.chen@mediatek.com>
References: <20210914021633.26377-1-chun-jie.chen@mediatek.com> <20210914021633.26377-18-chun-jie.chen@mediatek.com>
Subject: Re: [v3 17/24] clk: mediatek: Add MT8195 vdosys0 clock support
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
Date:   Tue, 14 Sep 2021 15:19:35 -0700
Message-ID: <163165797561.763609.17217948869258296181@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chun-Jie Chen (2021-09-13 19:16:26)
> Add MT8195 vdosys0 clock controller which provides clock gate
> control in video system. This is integrated with mtk-mmsys
> driver which will populate device by platform_device_register_data
> to start vdosys clock driver.
>=20
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---

Applied to clk-next
