Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1561035DEB2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 14:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345547AbhDMM1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 08:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345513AbhDMM1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 08:27:04 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996B6C061756
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 05:26:42 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 507C322234;
        Tue, 13 Apr 2021 14:26:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1618316796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SWjqpxaDjBEgNZflrVYP73ahhMwX1Hw7GOz/1ERNy/U=;
        b=gtUln0MEqe5mYsb0ajXauJ4K9EeO/Nn020Z8jGHw+gadnSzP9DaBTsdDui/Q82OiW8r5PF
        U6Xz+LOKcPdVVWQoewfuQp3tX9lIQuGUserWkvxV0qgfcQrXxRcRdwpO0G7pZETseNFyDo
        6vb5TsrwEDtPaR08p6rmJcw9yNraXNM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 13 Apr 2021 14:26:36 +0200
From:   Michael Walle <michael@walle.cc>
To:     Ikjoon Jang <ikjn@chromium.org>
Cc:     linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spi-nor: macronix: Add block protection support to
 mx25u6435f
In-Reply-To: <20210413120210.3671536-1-ikjn@chromium.org>
References: <20210413120210.3671536-1-ikjn@chromium.org>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <51761f1db840c51bad17f5f275b4ce1a@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ikjoon,

Am 2021-04-13 14:02, schrieb Ikjoon Jang:
> This patch adds block protection support to Macronix mx25u6432f and
> mx25u6435f. Two different chips share the same JEDEC ID while only
> mx25u6423f support section protections. And two chips have slightly
> different definitions of BP bits than generic (ST Micro) 
> implementation.

What is different compared to the current implementation? Could you give
an example?

> So this patch defines a new spi_nor_locking_ops only for macronix
> until this could be merged into a generic swp implementation.

TBH, I don't really like the code duplication and I'd presume that it
won't ever be merged with the generic code.

You also assume that both the WPSEL and T/B bit are 0, which might not
be true. Please note that both are write-once, thus should only be read.

See also:
https://lore.kernel.org/linux-mtd/346332bf6ab0dd92b9ffd9e126b6b97c@walle.cc/

-michael
