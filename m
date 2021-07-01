Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE0BC3B8DAB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 08:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234444AbhGAGSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 02:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234404AbhGAGSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 02:18:13 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07538C061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 23:15:44 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 94DD722205;
        Thu,  1 Jul 2021 08:15:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1625120138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nNOZQZIfkYPdDMP6ecWgezCU+qxx2h3/IFPaJaDDFKA=;
        b=QnFrRSmRsq12eXkdJMUkXh8OsXkWgr/EDei9w5Mcp2onjfwSpMe+61DGL4UBhdix4+IlxD
        oe4jC+eLiI0WwerOxuaczcV1V+mCDHSeYqBrLjVKSo1mMGmFFzt4VJVfxn35iHgQiwZ/7y
        rerC3ywU3/COxkZanXhRherVbZhLsPc=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 01 Jul 2021 08:15:35 +0200
From:   Michael Walle <michael@walle.cc>
To:     Tudor.Ambarus@microchip.com
Cc:     code@reto-schneider.ch, linux-mtd@lists.infradead.org, sr@denx.de,
        reto.schneider@husqvarnagroup.com, miquel.raynal@bootlin.com,
        p.yadav@ti.com, richard@nod.at, vigneshr@ti.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mtd: spi-nor: Add support for XM25QH64C
In-Reply-To: <a5877032-ab30-a85d-cd42-93b75a84ab49@microchip.com>
References: <20210613121248.1529292-1-code@reto-schneider.ch>
 <1ba367f93650cb65122acd32fb4a4159@walle.cc>
 <0328347c-572d-b636-5542-99cb36e9efa9@microchip.com>
 <064317e561f1ad20282efe778f633723@walle.cc>
 <a5877032-ab30-a85d-cd42-93b75a84ab49@microchip.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <3b2184a8c637e89ffba3013bbee0393a@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-06-30 20:28, schrieb Tudor.Ambarus@microchip.com:
> On 6/30/21 5:15 PM, Michael Walle wrote:
>>> 
>>> Can the SFDP dump fit in the commit message when introducing a new
>>> flash ID?
>> 
>> As ASCII hex dump? I'd guess we need some instructions how to do
>> that. 4k would be 256 lines with 16 byte per line.
>> 
>> But yes, I had the same thought.
> 
> How about asking for the SFDP data in the cover later each time a
> new flash addition is proposed?

Ahh, I like the idea to put it onto the ML only. What do you think
of putting it into the comment section of the patch (ie. the one
after "---". This way we can have a backreference with a Link:
tag of the patch.

-michael
