Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5F5833A9FC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 04:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbhCOD1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 23:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhCOD0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 23:26:34 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589B5C061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 20:26:34 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id l4so30419018qkl.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 20:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=uUydBSlgVr1bgB3fgHkH0tdR13fMyNSnZM4O4Ua8siU=;
        b=BvHC6wmn8Od8FYfb70CSfrzWzH9+g60gVg6T8xdEtN0OpsZEysXuJRPnbhm6muZc1+
         jU7ittciq2njAMXAJgIYtI7xw24t6PJXYUe2lD/AsI5lPNjzAUnjJnomlMPuyVyTLEPa
         ap5tcjyZOp0GBlXo+55BmzJyqY7GEKT5RaN5oANyy54P676k0awclQ4zVp0G69aWJ/6B
         PZxx6bDNi5AdBTqNCJDMYIt7YTrrC/+9uK7PzsDJIVar6qph/1cln6BC+MZ872h6zaSP
         gQcBdvcaRMzTk+jILr/iUIJNfu2iDoQamyEXKJAOGsnCfE1dl6G+Q67KkNzFZZ6/ylfT
         T/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=uUydBSlgVr1bgB3fgHkH0tdR13fMyNSnZM4O4Ua8siU=;
        b=CflNypG5Wd1YmhUlng2zdkW2uXp+UM6s3uZwAhGHUe3Y1EOYMsywhd1iWe4B4pjpRZ
         ckCqz/Dj5mCHK/Q4j2TkKAtszsbP6eIgqIOWpGSt0sB0lu1uj14m4211j/95ySw5H7Z7
         FC+MKygSLRRQ1f3GKvIokLEwJ1bLtahie2J4SPhQ/mss6bE1t+WHeFAzAU2WJTBLNcV2
         ONBk5QX5WKQ4KjCJPP2MJz8I1e1TjgVS5RklQ5F2jkiJmyuxqHxRbp3O/uVsxlYj+lRg
         6cihA3H7Jjd/JYsbZ/Mx8+VbGIPdLSfBQhsJKuW/hnKchd1r4EPX52dctGvJsIGWuljs
         ykgQ==
X-Gm-Message-State: AOAM5331qH6i7V6Js4s6WBcx1oFh5UvpQDs2gd0JmS899TZQMSrv+URF
        WE1T723KeAnc623cQ/lq5Io=
X-Google-Smtp-Source: ABdhPJwIQZPkmQnaF0KdIGFTrq0lUPYP1L8r1glWKTx+BK/GJN/htmXXPHS0UE3BVbWwJm3j4iQcrw==
X-Received: by 2002:a37:9d8b:: with SMTP id g133mr22898960qke.10.1615778793668;
        Sun, 14 Mar 2021 20:26:33 -0700 (PDT)
Received: from ArchLinux ([156.146.55.217])
        by smtp.gmail.com with ESMTPSA id b2sm1533993qtb.54.2021.03.14.20.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 20:26:32 -0700 (PDT)
Date:   Mon, 15 Mar 2021 08:56:19 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Randy Dunlap <rdunlap@infradead.org>, benh@kernel.crashing.org,
        paulus@samba.org, akpm@linux-foundation.org, rppt@kernel.org,
        oss@buserror.net, christophe.leroy@csgroup.eu,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: kernel: Trivial spelling fixes throughout the
 file head_fsl_booke.S
Message-ID: <YE7T2+/6AjOxshUV@ArchLinux>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Randy Dunlap <rdunlap@infradead.org>, benh@kernel.crashing.org,
        paulus@samba.org, akpm@linux-foundation.org, rppt@kernel.org,
        oss@buserror.net, christophe.leroy@csgroup.eu,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20210314220436.3417083-1-unixbhaskar@gmail.com>
 <f8dc3cbe-54f4-1da1-b14f-4735d28aad13@infradead.org>
 <87r1kh3zeu.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0h8yTNnxCDFgEAPZ"
Content-Disposition: inline
In-Reply-To: <87r1kh3zeu.fsf@mpe.ellerman.id.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0h8yTNnxCDFgEAPZ
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 13:48 Mon 15 Mar 2021, Michael Ellerman wrote:
>Randy Dunlap <rdunlap@infradead.org> writes:
>> On 3/14/21 3:04 PM, Bhaskar Chowdhury wrote:
>>>
>>> Trivial spelling fixes throughout the file.
>>>
>>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>>> ---
>>>  arch/powerpc/kernel/head_fsl_booke.S | 8 ++++----
>>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
>>> index fdd4d274c245..c6fcfca0b0d7 100644
>>> --- a/arch/powerpc/kernel/head_fsl_booke.S
>>> +++ b/arch/powerpc/kernel/head_fsl_booke.S
>>> @@ -403,7 +403,7 @@ interrupt_base:
>>>  	EXCEPTION(0x2900, AP_UNAVAIL, AuxillaryProcessorUnavailable, \
>>>  		  unknown_exception, EXC_XFER_STD)
>>>
>>> -	/* Decrementer Interrupt */
>>> +	/* Decremented Interrupt */
>>
>> No, the comment matches the macro (or whatever that is).
>
>Right. I dropped this hunk. Please update your script or whatever to not
>"correct" that spelling.
>
Hmmmm ...V2 on the way...

>cheers

--0h8yTNnxCDFgEAPZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBO09cACgkQsjqdtxFL
KRXnkAgAoQe+fjFbsaDe//4BHrcEkDyQcBya7D6Bbo40PXbWS19N4uxxcA7w87u7
KZkMnmnRzNR1Xyv1Eykde//1MmQBdGudjElLW51HqMi1G90a95I80GMjvNPEHhOw
+9Tnnh9zFGAueL3PzC7+V9jsFl3VbbCzEE0u7ppfvyNJ99FVTgtIcF0aBoZD6F49
R0UyqVD8LRCQAuvkYeSpbYiD3fVnllflfsnM/Q1a4b2q2xLZHc7b/hOqbJXbVzRQ
0K5pfHupQZDjrQJghr026ZcuZWP04RbZRQYW6Asn05iNsATlAaxBYdg7RoVRUANl
XWIOeH3De6RAp04QNqOarSIAbSco9Q==
=+yEE
-----END PGP SIGNATURE-----

--0h8yTNnxCDFgEAPZ--
