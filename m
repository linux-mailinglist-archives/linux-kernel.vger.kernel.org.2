Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11DE3336C43
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 07:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbhCKGZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 01:25:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbhCKGZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 01:25:08 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3F8C061574;
        Wed, 10 Mar 2021 22:25:08 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id l132so19591877qke.7;
        Wed, 10 Mar 2021 22:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=GKPb0Khp/B3fH008t606FuVlO3CYVB4rNtypOYU2ur0=;
        b=WzaAF7h4FpFY11OgnS2WVN1IdRjvQJSXXWdlMYlnC33CEAqw7bG9rCLmYIM34l9lTw
         AHDvsD4/cR8yZsllh+jvhfutGsm1KBmuLd+40mKUPdCgQ19lMGlyenjxsVjXUV+tg46n
         YYE3MGhV+i+oJOaIIfn9uc/hAxD1FK/j82y3NmZ03VvPdNHKgZ1fY0CYlTMt859T9Th0
         SEYw3y4t6Hx7Vykie5PK61/vKaIHTsExuNDy5PHSY305fa+tudhARcl+DNRibeicJwmX
         BpBxSnJHVxFubbxvhvMBXxdRxlcYj7HV2sX6B1PX1SZKDuJthJF5hndNb/PxAZohbK7O
         AEdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=GKPb0Khp/B3fH008t606FuVlO3CYVB4rNtypOYU2ur0=;
        b=mOS35OL2virYimzm7IP7NCAaAI0ucSHfYrJ9D0mIFuXv0vi3FslmfZ73MsCFlutd/P
         Nm3hdJlPv0h9uVb877BYTq0RUltVB+fH8QBbKVtmJyteo27r1H6ZIzfmpADgO9vc57yJ
         pi8lKlXh/bh+J7VJ5vZPQeZhxDLLBf38rGJ1v87KqURIz+satjTAqeV3o67ZdJ3bVwpc
         gpf0zETWHj6uD4HJGlxAf9htHZA5rXhJKquQTrrGUyrRl97sdc09vVwDA4GLRD+QagSI
         rE/g2Xd0EONsZ92PvX2KfkmZ0FpKlsKcBL1TIqsXhD6jtF/sdorVAJXShsFMOALtvWA0
         acag==
X-Gm-Message-State: AOAM532VhD3EwLeMeVmr6RIcZFjy69PEoIkslq2t4MOFsoy7UhnaGhJp
        mq/1eD35IGupSKYh6BDI7+g=
X-Google-Smtp-Source: ABdhPJy2/k9WFVcf6xCuYXLXbySFGb9XRG9kY/ylVl1wtaeyoUKPGEhF8dzbhawZFNiFnFGb8aJFKA==
X-Received: by 2002:a05:620a:12da:: with SMTP id e26mr5837266qkl.92.1615443907453;
        Wed, 10 Mar 2021 22:25:07 -0800 (PST)
Received: from Gentoo ([156.146.55.115])
        by smtp.gmail.com with ESMTPSA id z6sm1117329qto.70.2021.03.10.22.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 22:25:06 -0800 (PST)
Date:   Thu, 11 Mar 2021 11:54:57 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ia64: kernel: Few typos fixed in the file fsys.S
Message-ID: <YEm3ubX2Jqu49MwF@Gentoo>
Mail-Followup-To: Randy Dunlap <rdunlap@infradead.org>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210311061058.29492-1-unixbhaskar@gmail.com>
 <e26a1461-0d05-d79c-7688-de45d285e068@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="f3/NkMV43tbOhWPO"
Content-Disposition: inline
In-Reply-To: <e26a1461-0d05-d79c-7688-de45d285e068@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--f3/NkMV43tbOhWPO
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 22:15 Wed 10 Mar 2021, Randy Dunlap wrote:
>On 3/10/21 10:10 PM, Bhaskar Chowdhury wrote:
>>
>> Mundane spelling fixes.
>>
>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>
>Acked-by: Randy Dunlap <rdunlap@infradead.org>
>
>but no maintainer Cc:ed to pick it up...
>
I have seen "maintainer less" files and you have pointed out that too in the
past...what do I do Randy??? Should run "git blame" to find out ,who touch the file and
include those mail??? I don't think that would be good idea.

Bemused!! Throw some light.
>> ---
>>  arch/ia64/kernel/fsys.S | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/ia64/kernel/fsys.S b/arch/ia64/kernel/fsys.S
>> index 0750a716adc7..2094f3249019 100644
>> --- a/arch/ia64/kernel/fsys.S
>> +++ b/arch/ia64/kernel/fsys.S
>> @@ -172,7 +172,7 @@ ENTRY(fsys_gettimeofday)
>>  	// r25 = itc_lastcycle value
>>  	// r26 = address clocksource cycle_last
>>  	// r27 = (not used)
>> -	// r28 = sequence number at the beginning of critcal section
>> +	// r28 = sequence number at the beginning of critical section
>>  	// r29 = address of itc_jitter
>>  	// r30 = time processing flags / memory address
>>  	// r31 = pointer to result
>> @@ -432,7 +432,7 @@ GLOBAL_ENTRY(fsys_bubble_down)
>>  	 *	- r29: psr
>>  	 *
>>  	 * We used to clear some PSR bits here but that requires slow
>> -	 * serialization.  Fortuntely, that isn't really necessary.
>> +	 * serialization.  Fortunately, that isn't really necessary.
>>  	 * The rationale is as follows: we used to clear bits
>>  	 * ~PSR_PRESERVED_BITS in PSR.L.  Since
>>  	 * PSR_PRESERVED_BITS==PSR.{UP,MFL,MFH,PK,DT,PP,SP,RT,IC}, we
>> --
>
>
>--
>~Randy
>

--f3/NkMV43tbOhWPO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBJt7kACgkQsjqdtxFL
KRWCYwf9HIUR47y/MsISUVH8Q5YejyL0nMZ6cZy/y8HALqb91B//F7rP1vDACDYe
OHEzG4qK9TuY5c0UmzpUbS2bLK46R3rIwSH2O4vTXXjHbYiR51jGTop7GxGcmz4C
5tFvRNXAyLiiFJvPpxspACKkN+DBIC06LW6F9bYPOXLEOKJD6NMQwpDCHXqna7bB
YKWS+OtCiqVQPWVZx/P5/RHNeDmrq50SbTMceYIAN/tokYCiCE8yFMcoyo3cGd0C
S/esiN+e0um44b8J3HNuIuojJI22NqKWvoMXExITsuHUa8HQwdqCJBOrNuMgFfo9
hBfUSc4s/BJZ4Z1UfRl7SnXh6+zuoA==
=idG8
-----END PGP SIGNATURE-----

--f3/NkMV43tbOhWPO--
