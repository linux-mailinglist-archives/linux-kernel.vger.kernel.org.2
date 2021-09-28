Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9253841AF57
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 14:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240784AbhI1MuP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Sep 2021 08:50:15 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:46637 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240779AbhI1MuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 08:50:14 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 0A9DDFF803;
        Tue, 28 Sep 2021 12:48:32 +0000 (UTC)
Date:   Tue, 28 Sep 2021 14:48:32 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     mdalam@codeaurora.org
Cc:     mani@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, sricharan@codeaurora.org
Subject: Re: [PATCH 2/3] mtd: rawnand: qcom: Add sg list to handle status
 pipe request
Message-ID: <20210928144832.02e86fe1@xps13>
In-Reply-To: <07b52169db478045d409def2b5f55b01@codeaurora.org>
References: <1631699851-12172-1-git-send-email-mdalam@codeaurora.org>
        <1631699851-12172-3-git-send-email-mdalam@codeaurora.org>
        <07b52169db478045d409def2b5f55b01@codeaurora.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

mdalam@codeaurora.org wrote on Tue, 28 Sep 2021 17:50:06 +0530:

> On 2021-09-15 15:27, Md Sadre Alam wrote:
> > From QPIC V2.0 onwards there is separate pipe to read status
> > for each code word while reading in enhanced mode.

What is enhanced mode?

> page scope read and multi page read.

This is not a correct sentence.

> > This sgl list will be use to handle the request via status pipe

         ^^^              used                          the

Please use plain english in the commit description.

> > during page scope and multi page read.

What is page scope?

> > Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>

Thanks,
Miquèl
