Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50C323CAF73
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 00:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbhGOWyJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 15 Jul 2021 18:54:09 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:42965 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbhGOWyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 18:54:08 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 8E88D40006;
        Thu, 15 Jul 2021 22:51:12 +0000 (UTC)
Date:   Fri, 16 Jul 2021 00:51:11 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Clark Wang <xiaoning.wang@nxp.com>
Cc:     conor.culhane@silvaco.com, alexandre.belloni@bootlin.com,
        vitor.soares@synopsys.com, boris.brezillon@bootlin.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] i3c: master: svc: move module reset behind clk
 enable
Message-ID: <20210716005111.3269672b@xps13>
In-Reply-To: <20210715082413.3042149-2-xiaoning.wang@nxp.com>
References: <20210715082413.3042149-1-xiaoning.wang@nxp.com>
        <20210715082413.3042149-2-xiaoning.wang@nxp.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Clark,

Clark Wang <xiaoning.wang@nxp.com> wrote on Thu, 15 Jul 2021 16:24:10
+0800:

> Reset I3C module will R/W its regs, so enable its clocks first.
> 
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miquèl
