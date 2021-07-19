Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F3E3CEDC3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386954AbhGSTod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 15:44:33 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44094 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385824AbhGSTKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 15:10:51 -0400
Received: from notapiano (unknown [IPv6:2804:14c:1a9:2434:2e2f:cb19:fca8:1dff])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id C485E1F42E64;
        Mon, 19 Jul 2021 20:51:20 +0100 (BST)
Date:   Mon, 19 Jul 2021 16:51:15 -0300
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel@collabora.com,
        Xing Zheng <zhengxing@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-rockchip@lists.infradead.org,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: clk: Convert rockchip,rk3399-cru to DT
 schema
Message-ID: <20210719195115.cgh7fh54kwloo4o7@notapiano>
References: <20210610175613.167601-1-nfraprado@collabora.com>
 <20210624190041.GA1812802@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210624190041.GA1812802@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 01:00:41PM -0600, Rob Herring wrote:
> On Thu, 10 Jun 2021 14:56:13 -0300, Nícolas F. R. A. Prado wrote:
> > Convert the rockchip,rk3399-cru binding to DT schema format.
> > Tested with
> > ARCH=arm64 make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.yaml
> > ARCH=arm64 make dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.yaml
> > 
> > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > ---
> > 
> > One caveat is that this node expects certain external clocks, mainly 'xin24m'.
> > 
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks! Is this blocked on something else?

Thanks,
Nícolas
