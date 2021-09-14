Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15CAC40BB49
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 00:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235741AbhINWVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 18:21:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:55404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235826AbhINWVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 18:21:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9923D61164;
        Tue, 14 Sep 2021 22:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631657988;
        bh=RR6owkjzqfzaYjUSBCJsCZ4wzMipMq56ZneU/JSBVK4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ItEWaWireo9M3pR5RqDNIyv7udtH0zGCkVktgobeeXQAoqX0KN5YkNtbAmYoE6/1Z
         UP6rCZHNC0L8kr0LDBq9DF0Wki3iH/FCnaMcdCsJl418wO0IqMglQorxuSopSyrIgh
         wu4Ljutsr+2PwqklYRDzhpHNBt9xORritGrrl0zOWvcuUP4R/fqXGj6F0E5DkTTtJU
         ua+kGan9ZoDsskEVTSNUYvgIDIulKa6sOI7YXwQkVUwrOXNeEvjYXaiDwFMK2yQJF5
         wlli5m3wREeA7sWKbQYwYHt0hYyKzhOq0TpuRXeNA9DljVyDSG6rD3THkMdrTEZHNW
         LzYJh/xV1J/Vg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210914021633.26377-20-chun-jie.chen@mediatek.com>
References: <20210914021633.26377-1-chun-jie.chen@mediatek.com> <20210914021633.26377-20-chun-jie.chen@mediatek.com>
Subject: Re: [v3 19/24] clk: mediatek: Add MT8195 vencsys clock support
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
Date:   Tue, 14 Sep 2021 15:19:47 -0700
Message-ID: <163165798747.763609.1936057627703630875@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chun-Jie Chen (2021-09-13 19:16:28)
> Add MT8195 vencsys clock controllers which provide clock gate
> control for video encoder.
>=20
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---

Applied to clk-next
