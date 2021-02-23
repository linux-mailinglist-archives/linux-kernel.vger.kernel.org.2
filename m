Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60535322E6E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 17:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbhBWQK4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 23 Feb 2021 11:10:56 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:41615 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbhBWQKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 11:10:53 -0500
X-Originating-IP: 86.210.203.113
Received: from xps13 (lfbn-tou-1-972-113.w86-210.abo.wanadoo.fr [86.210.203.113])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 02CFB1C0009;
        Tue, 23 Feb 2021 16:10:07 +0000 (UTC)
Date:   Tue, 23 Feb 2021 17:10:06 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Md Sadre Alam <mdalam@codeaurora.org>
Cc:     mani@kernel.org, richard@nod.at, boris.brezillon@collabora.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        sricharan@codeaurora.org
Subject: Re: [PATCH] mtd: rawnand: qcom: Convert nandc to chip in Read/Write
 helper
Message-ID: <20210223171006.3e2030ce@xps13>
In-Reply-To: <1613939101-23001-1-git-send-email-mdalam@codeaurora.org>
References: <1613939101-23001-1-git-send-email-mdalam@codeaurora.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Md Sadre Alam <mdalam@codeaurora.org> wrote on Mon, 22 Feb 2021
01:55:01 +0530:

> This change will convert nandc to chip in Read/Write helper, this
> change is needed because if we wnated to access number of steps
> in Read/Write helper then we need to get the chip->ecc.steps,
> currentlly its not possible.After this change we can directly
> acces chip->ecc.steps in Read/Write helper.
> 
> Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>

Thanks for splitting your series, I think it's much easier to review
and contains much less imprecise changes.

I have a few minor comments (see the following e-mails), please address
them and then please send all your patches a single series, not like 6+
independent patches.

I'll then require someone to test it if we are good I'll merge it.

Thanks,
Miquèl
