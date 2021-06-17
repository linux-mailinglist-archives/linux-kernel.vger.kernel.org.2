Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40A383AB6E7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 17:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbhFQPJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 11:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbhFQPJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 11:09:09 -0400
Received: from mxout014.mail.hostpoint.ch (mxout014.mail.hostpoint.ch [IPv6:2a00:d70:0:e::314])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436F7C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 08:07:01 -0700 (PDT)
Received: from [10.0.2.46] (helo=asmtp013.mail.hostpoint.ch)
        by mxout014.mail.hostpoint.ch with esmtp (Exim 4.94.2 (FreeBSD))
        (envelope-from <code@reto-schneider.ch>)
        id 1lttbd-000Fys-JU; Thu, 17 Jun 2021 17:06:57 +0200
Received: from [2a02:168:6182:1:d64b:e086:4fb7:9a87]
        by asmtp013.mail.hostpoint.ch with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2 (FreeBSD))
        (envelope-from <code@reto-schneider.ch>)
        id 1lttbd-000FSt-Gl; Thu, 17 Jun 2021 17:06:57 +0200
X-Authenticated-Sender-Id: reto-schneider@reto-schneider.ch
Subject: Re: [PATCH v1] mtd: spi-nor: Add support for XM25QH64C
To:     linux-mtd@lists.infradead.org
Cc:     Stefan Roese <sr@denx.de>,
        Reto Schneider <reto.schneider@husqvarnagroup.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>
References: <20210613121248.1529292-1-code@reto-schneider.ch>
 <1ba367f93650cb65122acd32fb4a4159@walle.cc>
 <f022abf3-a6fe-d060-9868-985303c4e8a0@reto-schneider.ch>
 <3bb5ae427dc01b82be4434dff39e6c8e@walle.cc>
From:   Reto Schneider <code@reto-schneider.ch>
Message-ID: <d9ff3a7a-7c2e-80a2-7910-3cc1a530833e@reto-schneider.ch>
Date:   Thu, 17 Jun 2021 17:06:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <3bb5ae427dc01b82be4434dff39e6c8e@walle.cc>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On 17.06.21 16:19, Michael Walle wrote:
> That is up to the maintainers, but sooner or later we will have to face
> the problem regarding the duplicate IDs.

A strongly worded statement by the maintainer(s) ("the Linux crowd") 
against ignoring the continuation codes might help (me) to put pressure 
on non-compliant manufacturers.

Any chance something like this is already out there? Could not find 
anything.

Kind regards,
Reto
