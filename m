Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0D73AB321
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 13:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbhFQMBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 08:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbhFQMBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 08:01:33 -0400
Received: from mxout017.mail.hostpoint.ch (mxout017.mail.hostpoint.ch [IPv6:2a00:d70:0:e::317])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDBEC061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 04:59:24 -0700 (PDT)
Received: from [10.0.2.44] (helo=asmtp014.mail.hostpoint.ch)
        by mxout017.mail.hostpoint.ch with esmtp (Exim 4.94.2 (FreeBSD))
        (envelope-from <code@reto-schneider.ch>)
        id 1ltqg3-000CfJ-TB; Thu, 17 Jun 2021 13:59:19 +0200
Received: from [2a02:168:6182:1:d64b:e086:4fb7:9a87]
        by asmtp014.mail.hostpoint.ch with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2 (FreeBSD))
        (envelope-from <code@reto-schneider.ch>)
        id 1ltqg3-0008sS-PS; Thu, 17 Jun 2021 13:59:19 +0200
X-Authenticated-Sender-Id: reto-schneider@reto-schneider.ch
Subject: Re: [PATCH v1] mtd: spi-nor: Add support for XM25QH64C
To:     Michael Walle <michael@walle.cc>
Cc:     linux-mtd@lists.infradead.org, Stefan Roese <sr@denx.de>,
        Reto Schneider <reto.schneider@husqvarnagroup.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
References: <20210613121248.1529292-1-code@reto-schneider.ch>
 <1ba367f93650cb65122acd32fb4a4159@walle.cc>
From:   Reto Schneider <code@reto-schneider.ch>
Message-ID: <f022abf3-a6fe-d060-9868-985303c4e8a0@reto-schneider.ch>
Date:   Thu, 17 Jun 2021 13:59:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1ba367f93650cb65122acd32fb4a4159@walle.cc>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

Thanks for your feedback.

On 14.06.21 08:56, Michael Walle wrote:
> Could you add that as a "Datasheet:" tag before your Sob tag?

Will do for v2.

>> This chip has been (briefly) tested on the MediaTek MT7688 based GARDENA
>> smart gateway.
> 
> Could you also apply my SFDP patch [1] and send the dump? Unfortunately,
> I can't think of a good way to do that along with the patch and if this
> in some way regarded as copyrighted material. So feel free to send it to
> me privately. I'm starting to build a database.

Will do. If interested, I could also include the predecessor (XM25QH64A).

> NB. XMC ignores the continuation codes and this particular device will
> collide with M25PE64/M45PE64. Although I couldn't find any datasheet,
> so I don't know if these devices actually exist.

M25PE64 yields quite some hits on Google. Is supporting this (all?) XMC 
device in upstream a good idea nevertheless? Does "first come, first 
served" apply here?

Kind regards,
Reto
