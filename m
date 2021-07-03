Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5F1A3BA978
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jul 2021 18:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbhGCQ2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jul 2021 12:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhGCQ2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jul 2021 12:28:42 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFD1C061762
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jul 2021 09:26:07 -0700 (PDT)
Received: from [IPv6:2a02:6d40:3433:fe01:3924:339d:7699:b3c9] (unknown [IPv6:2a02:6d40:3433:fe01:3924:339d:7699:b3c9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 8821322236;
        Sat,  3 Jul 2021 18:26:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1625329563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pyBp0q4SVf2MSK2XfgyJCK59ZJNUPQ1pVvNVAWQSMkI=;
        b=JrBfohToQLp2rt6aXBVPFjFBZOeZljlR1IKKY6xuPa94OckCoYUVK8A6yOYzVFnoH3uVBh
        kodapbtmet+MtzmTMXQozWuQFICiqLxaSU0XtPiSOAqYQwEDCjIbV8d1wdol4Mu62b9nRK
        KfoQS7PLE76cddf6Y8mPwNf9Wje/yrM=
Date:   Sat, 03 Jul 2021 18:08:38 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <9bb2acac-aeb8-d2b2-8df0-9acfd972ec5d@microchip.com>
References: <20210702093841.32307-1-michael@walle.cc> <9bb2acac-aeb8-d2b2-8df0-9acfd972ec5d@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] mtd: core: handle flashes without OTP gracefully
To:     Tudor.Ambarus@microchip.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
CC:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux@roeck-us.net
From:   Michael Walle <michael@walle.cc>
Message-ID: <9F46D75C-D00D-4577-A337-7411049EC7D9@walle.cc>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 3=2E Juli 2021 11:56:14 MESZ schrieb Tudor=2EAmbarus@microchip=2Ecom:
>On 7/2/21 12:38 PM, Michael Walle wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you
>know the content is safe
>>=20
>> There are flash drivers which registers the OTP callbacks although
>the
>> flash doesn't support OTP regions and return -ENODATA for these
>> callbacks if there is no OTP=2E If this happens, the probe of the whole
>
>why do they register the OTP callback if they don't support OTP?

I don't know=2E But I certainly won't touch that code :p


>> flash will fail=2E Fix it by handling the ENODATA return code and skip
>> the OTP region nvmem setup=2E
>>=20
>> Fixes: 4b361cfa8624 ("mtd: core: add OTP nvmem provider support")
>> Reported-by: Guenter Roeck <linux@roeck-us=2Enet>
>> Signed-off-by: Michael Walle <michael@walle=2Ecc>
>> ---
>>  drivers/mtd/mtdcore=2Ec | 10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/drivers/mtd/mtdcore=2Ec b/drivers/mtd/mtdcore=2Ec
>> index b5ccd3037788=2E=2E6881d1423dd6 100644
>> --- a/drivers/mtd/mtdcore=2Ec
>> +++ b/drivers/mtd/mtdcore=2Ec
>> @@ -880,7 +880,10 @@ static int mtd_otp_nvmem_add(struct mtd_info
>*mtd)
>>=20
>>         if (mtd->_get_user_prot_info && mtd->_read_user_prot_reg) {
>>                 size =3D mtd_otp_size(mtd, true);
>> -               if (size < 0)
>> +               /* ENODATA means there is no OTP region */
>> +               if (size =3D=3D -ENODATA)
>
>If no OTP data, maybe it's more appropriate for the clients to just
>return a retlen of 0=2E

you mean already checking ENODATA in mtd_otp_size() and return 0=2E That w=
ould also make the hunk below unnecessary=2E I'll change it=2E=20

-michael

>
>
>> +                       size =3D 0;
>> +               else if (size < 0)
>>                         return size;
>>=20
>>                 if (size > 0) {
>> @@ -896,7 +899,10 @@ static int mtd_otp_nvmem_add(struct mtd_info
>*mtd)
>>=20
>>         if (mtd->_get_fact_prot_info && mtd->_read_fact_prot_reg) {
>>                 size =3D mtd_otp_size(mtd, false);
>> -               if (size < 0) {
>> +               /* ENODATA means there is no OTP region */
>> +               if (size =3D=3D -ENODATA) {
>> +                       size =3D 0;
>> +               } else if (size < 0) {
>>                         err =3D size;
>>                         goto err;
>>                 }
>> --
>> 2=2E20=2E1
>>=20
>>=20
>> ______________________________________________________
>> Linux MTD discussion mailing list
>> http://lists=2Einfradead=2Eorg/mailman/listinfo/linux-mtd/
>>=20

