Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99B3D36D38B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 09:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhD1H73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 03:59:29 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:55917 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236440AbhD1H7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 03:59:18 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 3FD092224E;
        Wed, 28 Apr 2021 09:58:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1619596712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7dtPxz3peg+LrXXsJS+bg5vTyzb5cCiVzwUPdlB5mPk=;
        b=aphNbo50ugLQyHgwGRpmR5HeuktvWwJ+6ONa/idWhlFMPKQjxSzNPspcCPVrH1A4a4iO0E
        7YsfjDp9FUq1Q3jMQZpEk0f+4R0AFR74+VKIwnMxgV3IS85qBfvMJ2t5zsdpze0KoYssWj
        kyv4Zs7dMz23a5IBrpVJnudfYw3L9Ms=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 28 Apr 2021 09:58:31 +0200
From:   Michael Walle <michael@walle.cc>
To:     Alexander Williams <awill@google.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mtd: spi-nor: Export SFDP access to sysfs
In-Reply-To: <20210428052725.530939-1-awill@google.com>
References: <20210428052725.530939-1-awill@google.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <dd33cf8d3a78d60eebbb6f1be90cb7d3@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

Am 2021-04-28 07:27, schrieb Alexander Williams:
> Add the ability to specify a technology-specific attribute_group, and
> expose the SFDP through spi-nor's private group. This enables user 
> space
> to have full access to the contents of the SFDP, so all information is
> available without regard for whether the kernel supports parsing it.

Please see:
https://lore.kernel.org/linux-mtd/20210318092406.5340-1-michael@walle.cc/-

-michael
