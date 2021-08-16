Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A83B3ECED7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 08:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbhHPGxJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 16 Aug 2021 02:53:09 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:58809 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233349AbhHPGxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 02:53:08 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 211171BF209;
        Mon, 16 Aug 2021 06:52:33 +0000 (UTC)
Date:   Mon, 16 Aug 2021 08:52:32 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Clark Wang <xiaoning.wang@nxp.com>
Cc:     conor.culhane@silvaco.com, alexandre.belloni@bootlin.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: Re: [PATCH V4 3/8] i3c: master: svc: separate err, fifo and disable
 interrupt of reset function
Message-ID: <20210816085232.46682b0e@xps13>
In-Reply-To: <20210809063645.2289988-4-xiaoning.wang@nxp.com>
References: <20210809063645.2289988-1-xiaoning.wang@nxp.com>
        <20210809063645.2289988-4-xiaoning.wang@nxp.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Clark,

Clark Wang <xiaoning.wang@nxp.com> wrote on Mon,  9 Aug 2021 14:36:40
+0800:

> Sometimes only need to reset err and fifo regs, so split the origin
> reset function to three functions.
> Put them at the top of the file, to let more functions can call them.
> 
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> Reviewed-by: Jun Li <jun.li@nxp.com>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miquèl
