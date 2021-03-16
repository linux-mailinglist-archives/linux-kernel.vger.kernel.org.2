Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03E4633CD59
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 06:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235494AbhCPFbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 01:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235501AbhCPFbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 01:31:06 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E71DC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 22:31:06 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id a9so34075993qkn.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 22:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=AiiaOifCVbUcWbgc/rFsb+EDAB/YETRdxTFjf7qZm8A=;
        b=vUvCjFNktmnZWJB1m5o8/8gloDroFP+Rd/qgI8O+8bPNdfEqAZxaTUDWzC/ZkN8mYX
         wszuBT3gZEwf66hvZ0nn2kC1R6ECAkx7RGDxrDJD67Nydygpf8EvQOpAkuDsoEfH7dwm
         0fWfoyS6cDoyHDn/l2SEmc243D5ERTExNpzb21nBnSsWzPOp+R41b8BcDOUNA4PvNjjC
         sPfOX1j+6+K9GH8xZJWOMUySy27kmKRC9Hl8WB6pGZPDZSnJA9M8aUcnf2IulPPM/ApJ
         mOwKqd+TnrdQxmEf0DCL+zQc2EI0/7aIJ9KRCO+/8BXv6K0eVqIG8cJtKVKx78J9Ak1g
         MkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=AiiaOifCVbUcWbgc/rFsb+EDAB/YETRdxTFjf7qZm8A=;
        b=greujxP3r3xlmKM7GGYaGDgb16YU8V/uh1Epn4C3ijBpjw8GNnTjSmbGbsMKeogGD6
         82EE7qZ2ltrQMFVrBLwlaQ48nDN94bfJH4f79iy0fshy4aJIUp7CqbIZ6ZbysK7hK65t
         2zt1riuV4OlWBEqDDozcqOdgmquwsSrx/8morTZ7Y3mjIlO4T4Ma0m1A3kDksdbveY/j
         g/S+G9I+AG/KU1AhmoGNADNuq9DJ2co9QU20e3UQmU33ESPZoE1teux8KXrmZwZ20UsF
         Y/rnmIPyUQ46Y8w4eipjX5apZXNRoWhZN/cv1qB1e9/jzWHdw85YBL8Lv98YgVZ7tBFa
         HvoA==
X-Gm-Message-State: AOAM531ORZmXHaoxewcV17unkzwMOoK29Iiq5kb6ItUSXTLgygdmZ3eE
        OEPwZLZfB7aOrumYjoPOKT4=
X-Google-Smtp-Source: ABdhPJyHgTAm93nDyiFUA6FVCBd1enibYpCEsvainHwbKIVpWRAwEaGdqe4EuuYlNdc6epLLOiScWQ==
X-Received: by 2002:ae9:f503:: with SMTP id o3mr27552057qkg.331.1615872665501;
        Mon, 15 Mar 2021 22:31:05 -0700 (PDT)
Received: from ArchLinux ([156.146.58.45])
        by smtp.gmail.com with ESMTPSA id n3sm12509312qtd.93.2021.03.15.22.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 22:31:04 -0700 (PDT)
Date:   Tue, 16 Mar 2021 11:00:48 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, tglx@linutronix.de,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: events: intel: A letter change in a word to make it
 sound right,in the file bts.c
Message-ID: <YFBCiNzEZJp3CTSv@ArchLinux>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, tglx@linutronix.de, bp@alien8.de,
        x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org
References: <20210316041913.2234069-1-unixbhaskar@gmail.com>
 <ecbefd37-1504-a167-760a-96026b9f67b0@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WbPO233QqskbBeLW"
Content-Disposition: inline
In-Reply-To: <ecbefd37-1504-a167-760a-96026b9f67b0@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WbPO233QqskbBeLW
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 22:19 Mon 15 Mar 2021, Randy Dunlap wrote:
>On 3/15/21 9:19 PM, Bhaskar Chowdhury wrote:
>>
>> s/kernal/kernel/
>>
>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>> ---
>>  arch/x86/events/intel/bts.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
>> index 731dd8d0dbb1..6320d2cfd9d3 100644
>> --- a/arch/x86/events/intel/bts.c
>> +++ b/arch/x86/events/intel/bts.c
>> @@ -594,7 +594,7 @@ static __init int bts_init(void)
>>  		 * we cannot use the user mapping since it will not be available
>>  		 * if we're not running the owning process.
>>  		 *
>> -		 * With PTI we can't use the kernal map either, because its not
>> +		 * With PTI we can't use the kernel map either, because its not
>
>		                                                        it's
>
Heck!
>>  		 * there when we run userspace.
>>  		 *
>>  		 * For now, disable this driver when using PTI.
>> --
>
>
>--
>~Randy
>

--WbPO233QqskbBeLW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBQQoUACgkQsjqdtxFL
KRVX1wgAiN4UmWhX21+mrjcaptEbGfcW9A5qC4zBoxsvcnnMe8Pu5MuFpzIhruM5
x7cHsCg6x2nfUFh/9NoqcJqjuGaFgzWmalV6pTbUhKV8ZoIyx64N/n5DNWHgwBUl
1Xklg17tibS67odLEBWiEfxPJxpX+5QuGdLHrUWlRLWd4Ur9+JR4zN8ffVo4hcIV
8yMIapdWq+UBlHGO+9PjaFxzX48N/7qPA2aGA3blDZnsS38LYoIXMql/A8AZRtLy
29rcJaCcnprUOUmjLGsetaG0hdpjoXRnZ9EhdxgUQLVI897we3DXhFysX41R8fW/
fzrdMo1av7aaesc6GBFgulWFkURjgA==
=mB6J
-----END PGP SIGNATURE-----

--WbPO233QqskbBeLW--
