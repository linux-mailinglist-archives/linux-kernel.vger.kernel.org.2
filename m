Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9503B84DB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 16:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235000AbhF3OSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 10:18:15 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:37549 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234851AbhF3OSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 10:18:14 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 3159622256;
        Wed, 30 Jun 2021 16:15:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1625062543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SX/9eBY4x1bVLRTwmiIGVEkZkYCSKmmnZrPEoWHtXIU=;
        b=N+BllY4qWN167p/5p2A3RHLWXTSjgV7a7Snl2DCKBGFDPqSRz3VhdezBPNHTmQKCX9+GAM
        iZokpON3cjU14LP9HBylBhq7Qj9UDfvKng/RJzg2YmU+EQzIuCx4sxcl4V7X5YaMrTcF+F
        +W4ReEyki485TzXPQyp8rsEGExDGy6A=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 30 Jun 2021 16:15:43 +0200
From:   Michael Walle <michael@walle.cc>
To:     Tudor.Ambarus@microchip.com
Cc:     code@reto-schneider.ch, linux-mtd@lists.infradead.org, sr@denx.de,
        reto.schneider@husqvarnagroup.com, miquel.raynal@bootlin.com,
        p.yadav@ti.com, richard@nod.at, vigneshr@ti.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mtd: spi-nor: Add support for XM25QH64C
In-Reply-To: <0328347c-572d-b636-5542-99cb36e9efa9@microchip.com>
References: <20210613121248.1529292-1-code@reto-schneider.ch>
 <1ba367f93650cb65122acd32fb4a4159@walle.cc>
 <0328347c-572d-b636-5542-99cb36e9efa9@microchip.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <064317e561f1ad20282efe778f633723@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-06-28 06:55, schrieb Tudor.Ambarus@microchip.com:
> On 6/14/21 9:56 AM, Michael Walle wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know 
>> the content is safe
>> 
>> Hi Reto,
>> 
>> Am 2021-06-13 14:12, schrieb Reto Schneider:
>>> From: Reto Schneider <reto.schneider@husqvarnagroup.com>
>>> 
>>> The data sheets can be found here:
>>> http://xmcwh.com/Uploads/2020-12-17/XM25QH64C_Ver1.1.pdf
>> 
>> Could you add that as a "Datasheet:" tag before your Sob tag?
>> 
>>> This chip has been (briefly) tested on the MediaTek MT7688 based
>>> GARDENA
>>> smart gateway.
>> 
>> Could you also apply my SFDP patch [1] and send the dump? 
>> Unfortunately,
>> I can't think of a good way to do that along with the patch and if 
>> this
>> in some way regarded as copyrighted material. So feel free to send it 
>> to
>> me privately. I'm starting to build a database.
>> 
> 
> Can the SFDP dump fit in the commit message when introducing a new 
> flash ID?

As ASCII hex dump? I'd guess we need some instructions how to do
that. 4k would be 256 lines with 16 byte per line.

But yes, I had the same thought.

> The SFDP standard is public. SFDP reveals just what the flash
> supports, why would that be sensitive information?

copyright material must not be sensitive information, no? I'm no
laywer, thus I'd played it safe.

> Reto, would you please dump the SFDP tables here?

FWIW, he already provided me a binary dump for the flash (actually
for the former version, too) and its already in my DB which you
should have access, too.

If we mandate that (and I am all for it) for new flashes, we will
have to come up with a common format. Something like

  echo "-----BEGIN SFDP (JEDEC ID ...)------"
  cat sfdp | xxd -ps -c 20
  echo "-----END SFDP------"

I really don't know if such meta data belongs into the
commit logs, though.

-michael
