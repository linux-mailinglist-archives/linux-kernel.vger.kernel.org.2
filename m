Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 208CC3467FE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 19:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbhCWSoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 14:44:06 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:41459 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbhCWSnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 14:43:52 -0400
Received: from [100.102.24.121] (ip-109-40-128-185.web.vodafone.de [109.40.128.185])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id C799622234;
        Tue, 23 Mar 2021 19:43:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1616525030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nPoOEuwU9+tWbJsFhoeDobxLxpp6c1ZbdIs3ALLogA4=;
        b=GcG6hOQWuusgG4uW58n59WZyLGPYfGuJdwtAif44qwpEunGfaDGj0lObmSfATcCZbY7Blk
        EV5RpUc9nkIgny+A1phkBux6ZzB7KYYd22Xk4BKC11xHfqsscJarTTDzteuY47Y8N9HN9K
        VUXfom/Qs0t9hX90FfPoaye9N1bbXHY=
Date:   Tue, 23 Mar 2021 19:43:47 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <20210323173715.gyozhzbjyfv5osuc@ti.com>
References: <20210323143144.12730-1-michael@walle.cc> <20210323143144.12730-2-michael@walle.cc> <20210323173715.gyozhzbjyfv5osuc@ti.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/2] mtd: spi-nor: sfdp: save a copy of the SFDP data
To:     Pratyush Yadav <p.yadav@ti.com>
CC:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
From:   Michael Walle <michael@walle.cc>
Message-ID: <C88FBBF6-4F5C-43A1-951E-332AEE9E3B3A@walle.cc>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 23=2E M=C3=A4rz 2021 18:37:17 MEZ schrieb Pratyush Yadav <p=2Eyadav@ti=
=2Ecom>:
>On 23/03/21 03:31PM, Michael Walle wrote:
>> Due to possible mode switching to 8D-8D-8D, it might not be possible
>to
>> read the SFDP after the initial probe=2E To be able to dump the SFDP
>via
>> sysfs afterwards, make a complete copy of it=2E
>>=20
>> Signed-off-by: Michael Walle <michael@walle=2Ecc>
>
>Reviewed-by: Pratyush Yadav <p=2Eyadav@ti=2Ecom>

thanks for reviewing!

-michael
