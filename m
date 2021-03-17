Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A472E33EE80
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 11:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhCQKlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 06:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbhCQKlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 06:41:35 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711F4C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 03:41:35 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id n79so38332082qke.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 03:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=kjJsqlR0fyfSDHJB1HR0lEtR0RM09NgVL/yiqvl4tUg=;
        b=hTNCMXWzeQ8fyVLRxAKIZT6cH27NKCREqF/80EMhEha0yWtmlyzBeL0jBDBTqQkeaK
         smcFVoHR2Ajwc3/1gqPawxYjdcnVgsve3gNw/khYL1cwEjSrcBczHnNLcnt/lXv+eCAB
         5koDJzbrfRPEr6Xs6BQO56jnBDGDiLfkHSO+mzUA+Xag87nMkRSr3N4o7UCJdHUNpt6g
         WqnUEaAOsvJf4Cxns8R4BIHgnaqgiHrP2L/5Szo74G1IPyKdsUlWRHhANEMayAgYyEhv
         Cp9yDtOJYpbD4bRUnul2+VSy1cv6qxjTZ1wprVkwY7HShL+/NrPzl2Th1JzPsIQ+BdD/
         vcwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=kjJsqlR0fyfSDHJB1HR0lEtR0RM09NgVL/yiqvl4tUg=;
        b=EdW0Kp3xzQ8nompOe4i1aOSAB7HwcyPbf8T0xp4GRsPPi7hZaEJVzETrJ+zYVyo/JV
         nbmDgGBE9UEp5H5fh62Dhmp9abalW5HI4Y0SIqfTNyZCZ6O6bzf8CfeKEPrxPCdn1WOm
         nrWBdRmF3Q9m/FvD2Br/E/3739cM8XZcLu6Drk+pZYPOPO53ryOWCZTkNMlIku3vqalw
         6kBWFlvt1laDhsVTf9P9TKbW68/mX6tm+2etPD+DKR11WiJ1sRtXYmxsfn540pDIoPxq
         T/2MLe+BQMqnMmmbypZEPofnboV8sbLl4rRjRPhPKQdI4ODpFlc6pgKNBDfwNGe5W7tR
         xPWg==
X-Gm-Message-State: AOAM533hPdb2f3x0zO6ial6XJa7pXg0wIPwEBqeB458ekKZp1+dKrhKI
        tpcKx+bcquLW8TlUKLo2YhTQ38gZD64Iy8dU
X-Google-Smtp-Source: ABdhPJxwwmRmLuebwbk5cUWb5uNrbPlcl/JSAFx+tEkDtMzMzaR0Uodj6Lqfr5GzV3lykqVJbpY1Vw==
X-Received: by 2002:ae9:f10b:: with SMTP id k11mr263570qkg.62.1615977694756;
        Wed, 17 Mar 2021 03:41:34 -0700 (PDT)
Received: from ArchLinux ([37.19.198.48])
        by smtp.gmail.com with ESMTPSA id a2sm15100580qtj.76.2021.03.17.03.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 03:41:33 -0700 (PDT)
Date:   Wed, 17 Mar 2021 16:11:17 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     jason.wessel@windriver.com, dianders@chromium.org,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Subject: Re: [PATCH] kernel: debug: Ordinary typo fixes in the file gdbstub.c
Message-ID: <YFHczQgtyISU8ApU@ArchLinux>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        jason.wessel@windriver.com, dianders@chromium.org,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
References: <20210317091022.347258-1-unixbhaskar@gmail.com>
 <20210317103638.sw4wqq4p4hg7dhco@maple.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kJgzpVU/ZNrZmetf"
Content-Disposition: inline
In-Reply-To: <20210317103638.sw4wqq4p4hg7dhco@maple.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kJgzpVU/ZNrZmetf
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 10:36 Wed 17 Mar 2021, Daniel Thompson wrote:
>On Wed, Mar 17, 2021 at 02:40:22PM +0530, Bhaskar Chowdhury wrote:
>>
>> s/'O'utput/'Output/
>> s/overwitten/overwritten/
>> s/procesing/processing/
>>
>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>> ---
>>  kernel/debug/gdbstub.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/debug/gdbstub.c b/kernel/debug/gdbstub.c
>> index e149a0ac9e9e..5c96590725f1 100644
>> --- a/kernel/debug/gdbstub.c
>> +++ b/kernel/debug/gdbstub.c
>> @@ -204,7 +204,7 @@ void gdbstub_msg_write(const char *s, int len)
>>  	if (len == 0)
>>  		len = strlen(s);
>>
>> -	/* 'O'utput */
>> +	/* 'Output */
>
>This is not a typo.
>
>It is showing that the 'O' being writing into the message buffer is a
>mnemonic and describing what it expands to.
>
>Other changes look good, please can you resend with this one removed?
>
>
Sure, thanks Daniel....V2 on the way...

>Daniel.
>
>
>>  	gdbmsgbuf[0] = 'O';
>>
>>  	/* Fill and send buffers... */
>> @@ -321,7 +321,7 @@ int kgdb_hex2long(char **ptr, unsigned long *long_val)
>>  /*
>>   * Copy the binary array pointed to by buf into mem.  Fix $, #, and
>>   * 0x7d escaped with 0x7d. Return -EFAULT on failure or 0 on success.
>> - * The input buf is overwitten with the result to write to mem.
>> + * The input buf is overwritten with the result to write to mem.
>>   */
>>  static int kgdb_ebin2mem(char *buf, char *mem, int count)
>>  {
>> @@ -952,7 +952,7 @@ static int gdb_cmd_exception_pass(struct kgdb_state *ks)
>>  }
>>
>>  /*
>> - * This function performs all gdbserial command procesing
>> + * This function performs all gdbserial command processing
>>   */
>>  int gdb_serial_stub(struct kgdb_state *ks)
>>  {
>> --
>> 2.30.2
>>

--kJgzpVU/ZNrZmetf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBR3M0ACgkQsjqdtxFL
KRUIogf9FUAOLSeznaVBHsfQghVvM4DMw9muyTB4f9WZ2Rufq5M+3md99+/a+gWJ
7+HSsoq+gXn0+ppotOgpVdowiJsSaNBaxIqIly51o/Y1z3pTPdPjZT2q9lJ2jrv3
av9AfIJ2qJKf83D/4PmNL8j9cN5NRhs2evOZXpuo0KCbpu4EkSkkDKgDwpDziBi6
40F8SpT+AbouHzIfW4/VdwVV7CQ7oA3Fk+xhJV32VY91xIy9EA0urNO9svzW6h0+
MbVB1gROxQBFBS1XARL8fOzwbNtsOqxej2JFK9tBu8WuNNx9jW1/JnrhAuaIqcDG
QbzGLRf3IXesRCUOZqv0o+rFb87RZg==
=+olO
-----END PGP SIGNATURE-----

--kJgzpVU/ZNrZmetf--
