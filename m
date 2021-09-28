Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA3D41AAF4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 10:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239650AbhI1Iu6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Sep 2021 04:50:58 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:38017 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235918AbhI1Iu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 04:50:57 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id DD91540007;
        Tue, 28 Sep 2021 08:49:15 +0000 (UTC)
Date:   Tue, 28 Sep 2021 10:49:14 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jan Hoffmann <jan@3e8.eu>
Cc:     Daniel Kestrel <kestrelseventyfour@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: rawnand: xway: No hardcoded ECC engine, use
 device tree setting
Message-ID: <20210928104914.44a90b63@xps13>
In-Reply-To: <f800c48f-8e4a-ecdc-3198-c52be0425823@3e8.eu>
References: <20210808072643.GA5084@ubuntu>
        <51f2ebf4-6df1-eba5-99f1-1ec88e475d20@3e8.eu>
        <20210917190154.76203a9a@xps13>
        <e9dd0653-139f-749b-c088-e756ee2d2132@3e8.eu>
        <20210917213246.319e60cb@xps13>
        <14eb0cb7-b0af-87bf-b9a5-3e35eeb43f54@3e8.eu>
        <20210927183150.4be87140@xps13>
        <f800c48f-8e4a-ecdc-3198-c52be0425823@3e8.eu>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

jan@3e8.eu wrote on Mon, 27 Sep 2021 22:32:13 +0200:

> Hi Miquèl,
> 
> > So what I propose is:
> > - in the driver probe: set the default to software ECC
> > - in the attach() hook: drop the line setting the engine_type to SOFT.
> > 
> > Please check the below diff and tell me if it works for you. I'll then
> > propose a wider series fixing the other drivers as well.  
> 
> I can confirm that your patch fixes the issue.
> 
> I tested using kernel 5.10 on a Fritzbox 7362 SL (with on-die ECC
> configured via device tree which was broken before). I also checked on
> a Fritzbox 7412 (this device uses software ECC). Both are working with
> this patch.

Great, thanks for the quick feedback.

Cheers,
Miquèl
