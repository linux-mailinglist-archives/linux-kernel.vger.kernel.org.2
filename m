Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCCB53D7CDA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 19:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbhG0R46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 13:56:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:46604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229529AbhG0R44 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 13:56:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ADB3360F11;
        Tue, 27 Jul 2021 17:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627408616;
        bh=/JE9CGQQa0Lu/VOUB7HHBRvNBpkPRzdpiUBTomM8n6w=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=WLJhHdJZlrIWqULlBQpWG1YVkqXimVm0F50DLRRlUSGZMrmTzPa055GP58qQ+HO7w
         e+Jr4+rtQ6muigxkbcGauujBU1neDVnwx/o0dGrYtZMAKcZH7slojomi7YtaD+4MUU
         It4FwyOQ1w5Ap0oHb9tvC+y9s0fjclJG6YQRahnytO01Y4s7whhtA+wrnjG4YozUX2
         WbTXrC9yUl8OryFlK8zY8UuDTB3q6A68vJI4OvBbIAduGg5Ve1XGadhwCXHqI1XKLt
         uObczhgpeo6psLkD6w1eWi6vJ92R5jqhVKWTJ5pvhXIswJ8wqT09EX7HLcs+yBd2y9
         h/Trr3KLLKZ3g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210726105719.15793-17-chun-jie.chen@mediatek.com>
References: <20210726105719.15793-1-chun-jie.chen@mediatek.com> <20210726105719.15793-17-chun-jie.chen@mediatek.com>
Subject: Re: [v14 16/21] clk: mediatek: Add MT8192 mfgcfg clock support
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Date:   Tue, 27 Jul 2021 10:56:54 -0700
Message-ID: <162740861465.2368309.8626055730410519223@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chun-Jie Chen (2021-07-26 03:57:14)
> Add MT8192 mfgcfg clock provider
>=20
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---

Applied to clk-next
