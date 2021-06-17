Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C88183AB5B7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 16:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbhFQOVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 10:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbhFQOVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 10:21:45 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA92C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 07:19:38 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 8DC832224E;
        Thu, 17 Jun 2021 16:19:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1623939575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wx+5UmqijqNtHgfTJre4bvhnb/XrYaC5F0NIuouRxPA=;
        b=ruMVyV0pGjEPRIiNTFIPi+0xBD9roaxS82PV/lSpcpOTRkajEF8TP2+3ITi4iXHkr6sdsN
        JEucsOTX8Usb/LrUyMTvVogfgUybEEuJWrtK7woK0aHhx+ielp+LTj9lzPpTkQQirxDVYH
        IvAEBLcTtow3txnywow2rDCdw3KPRVA=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 17 Jun 2021 16:19:34 +0200
From:   Michael Walle <michael@walle.cc>
To:     Reto Schneider <code@reto-schneider.ch>
Cc:     linux-mtd@lists.infradead.org, Stefan Roese <sr@denx.de>,
        Reto Schneider <reto.schneider@husqvarnagroup.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mtd: spi-nor: Add support for XM25QH64C
In-Reply-To: <f022abf3-a6fe-d060-9868-985303c4e8a0@reto-schneider.ch>
References: <20210613121248.1529292-1-code@reto-schneider.ch>
 <1ba367f93650cb65122acd32fb4a4159@walle.cc>
 <f022abf3-a6fe-d060-9868-985303c4e8a0@reto-schneider.ch>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <3bb5ae427dc01b82be4434dff39e6c8e@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reto,

Am 2021-06-17 13:59, schrieb Reto Schneider:
>> NB. XMC ignores the continuation codes and this particular device will
>> collide with M25PE64/M45PE64. Although I couldn't find any datasheet,
>> so I don't know if these devices actually exist.
> 
> M25PE64 yields quite some hits on Google. Is supporting this (all?)
> XMC device in upstream a good idea nevertheless? Does "first come,
> first served" apply here?

That is up to the maintainers, but sooner or later we will have to face
the problem regarding the duplicate IDs.

-michael
