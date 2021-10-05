Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59AFA4222FE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 12:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233916AbhJEKDe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 5 Oct 2021 06:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234009AbhJEKBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 06:01:13 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6AD5C061762
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 02:59:15 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mXhE4-0007dd-T4; Tue, 05 Oct 2021 11:59:08 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mXhE4-0004ny-2L; Tue, 05 Oct 2021 11:59:08 +0200
Message-ID: <0cf9a2bd61bf688ea94abf6d463e80b46b1495cc.camel@pengutronix.de>
Subject: Re: [PATCH 0/3] reset: uniphier: Introduce some features and NX1
 support
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 05 Oct 2021 11:59:07 +0200
In-Reply-To: <1633399842-1402-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1633399842-1402-1-git-send-email-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-10-05 at 11:10 +0900, Kunihiko Hayashi wrote:
> This series includes the patches to add audio/video reset lines for PXs3 SoC
> and basic reset lines for new UniPhier NX1 SoC. NX1 SoC also has the same
> kinds of reset lines as the other UniPhier SoCs.
> 
> Kunihiko Hayashi (3):
>   reset: uniphier: Add audio system and video input reset control for
>     PXs3
>   dt-bindings: reset: uniphier: Add NX1 reset control binding
>   reset: uniphier: Add NX1 reset support
> 
>  .../reset/socionext,uniphier-glue-reset.yaml       |  1 +
>  .../bindings/reset/socionext,uniphier-reset.yaml   |  3 +++
>  drivers/reset/reset-uniphier-glue.c                |  4 ++++
>  drivers/reset/reset-uniphier.c                     | 27 ++++++++++++++++++++++
>  4 files changed, 35 insertions(+)

Thank you, applied to reset/next.

regards
Philipp
