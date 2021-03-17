Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C68433F781
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 18:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbhCQRu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 13:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhCQRuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 13:50:51 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130A2C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 10:50:51 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id AB4A522238;
        Wed, 17 Mar 2021 18:50:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1616003449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0uX4a5pODJdDNUMqLG8CU+20HuPGvlsPYfESg66SL6o=;
        b=boqbQMVM7v9iaMAXLSnDxGpy19fhxBAn5JkBmLbxXeoSZY6iNJWg3Sc55OzTlyRlw09QeO
        kU2JSOGCzR+4+Qzxt3GKg2mcZmlm/IWWCsbnkjjkJ7qfWotAWK3EwhZ6uSn+v4kaGmMS6j
        y7tzS+epo3eZW0qFmPqJkRPxn1DgMIg=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 17 Mar 2021 18:50:48 +0100
From:   Michael Walle <michael@walle.cc>
To:     Tudor.Ambarus@microchip.com
Cc:     vigneshr@ti.com, p.yadav@ti.com, linux-mtd@lists.infradead.org,
        miquel.raynal@bootlin.com, richard@nod.at,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] mtd: spi-nor: Move Software Write Protection logic
 out of the core
In-Reply-To: <fe28e8f9-a3a5-b445-e7fc-01c8743bacbe@microchip.com>
References: <20210306095002.22983-1-tudor.ambarus@microchip.com>
 <20210306095002.22983-5-tudor.ambarus@microchip.com>
 <963232a4-9100-ebca-927c-7f5a1e947fbe@ti.com>
 <9889bae0-8eba-7cbc-d9bb-04e038bd28c8@microchip.com>
 <6016b725-a779-1d2c-9884-099c58f53557@ti.com>
 <45d00a12-cb79-774e-f8e8-d65602629a90@microchip.com>
 <a9e1e18c034dfa185eeb5492acf2dff7@walle.cc>
 <fe28e8f9-a3a5-b445-e7fc-01c8743bacbe@microchip.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <c02857fe33611ba5794f233ef117c687@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-03-17 10:30, schrieb Tudor.Ambarus@microchip.com:
>>>>>> soft-wr-protect.c or software-write-protect.c ?
>>> 
>>> Having in mind that we have the SWP configs, I think I prefer swp.c.
>>> But let's see what majority thinks, we'll do as majority prefers.
>>> Michael, Pratyush?
>> 
>> It's just an internal name, thus as long as it remotely makes sense,
>> I'm fine. It's just a matter of taste, isn't it?
> 
> Sure, it's a matter of preference. What's yours?

if i have to choose, swp.c

>> But here's one technical reason that would bother me more: name
>> clashes between the core modules: core, sfdp, otp, swp and the
>> vendor names. It is very unlikely, but there is a non-zero chance ;)
>> 
> 
> We can move all manufacturers to a manufacturers/ folder. Each 
> manufacturer
> driver will have to #include "../core.h", about what I have some mixed
> feelings.

I don't think it makes sense as long as there is no clash; or until 
there
are many more core modules, so you can't keep them apart anymore.
It will just make it harder to follow the git history.

-michael
