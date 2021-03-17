Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3281933F95F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 20:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbhCQTdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 15:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233249AbhCQTdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 15:33:39 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FA5C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 12:33:38 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id l132so40144892qke.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 12:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=70OVYrliPV0Gq5DcBmTEGM1/ezPnxqjpYxy0H6q3oXU=;
        b=iSRMqNjafmayI4oRkKhyRMWMLPYcbwGBmfAaVgMWD3TgFfCWeUYellbdTpJkB8Pb7G
         KABacBwbMYOGb6CBEy8HsgRmghhRpi4++EaeP/CXjsafGdBWZwa81HRrR2lc53tLnDcq
         vbcvPvo4zyTJ+NXP0EGz0KG0RkM7eVmCYlsXzzBkUoUNtBVg+KipZ95+JCMNVzh0CfyI
         vafiu1COkYwHfnCtgTG2KMO3AQ7t3lWIPT8j+CaaDZA4ophrDFUQscDiRAkQVGyIQq7p
         MV7amBg43HiwRsLCdqHUJF/+9ZPUhindpyKGmfJxR7iZWBDgs1sWJhQo1BQJZCSdpgxI
         T35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=70OVYrliPV0Gq5DcBmTEGM1/ezPnxqjpYxy0H6q3oXU=;
        b=NJtHF3H1AZldV3g92jtrpysKunKMnBvNztZG3ZWRLf9+J2xYSTjDbTzq2OITy6rtY4
         1/6JxWdQAIXDQlEBEfAMTes9X7QdSPhiMET+YII9X5+6O+5x23MgWSbKHHzdm3hY09QJ
         9/w2kM5qwzFwWyNL59G+PDPUddRSf9gb2cRkRLBfwlYvkQhetp2pmhUu8m9Kc3L3Oe7K
         CeQBHlUD/KSCA+EjOMutOIzfk9aqCPlReW4VXsb4IUIztYBvKrCvQCSd0/bYTJnIIjtO
         +Kielk2TsXsGV4p292fPVnWgQT5czCv2Cig+TelK9N/TgacVxES/QeTRDiDtDL6RZg9c
         f4dQ==
X-Gm-Message-State: AOAM532n6WqpIz7XBi9Vx9oDA0XU/lqieHd8VXoQ2T4vo03z9kkf4KG0
        k5HbLIixllMCKPmg2N5LyuXOJUpwNXFuJ5b2
X-Google-Smtp-Source: ABdhPJyLxSujTcxARdPv5gd29LU24QqYPYY4KJgMb7f/UUUIVHUcUu3Uxb5LsuAXYWFb76PDGdqW6w==
X-Received: by 2002:a05:620a:1442:: with SMTP id i2mr821522qkl.469.1616009618204;
        Wed, 17 Mar 2021 12:33:38 -0700 (PDT)
Received: from ArchLinux ([156.146.37.138])
        by smtp.gmail.com with ESMTPSA id l5sm15562669qtj.21.2021.03.17.12.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 12:33:37 -0700 (PDT)
Date:   Thu, 18 Mar 2021 01:03:19 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
Subject: Re: [PATCH] kernel: cpu: resctrl: Minor typo fix in the file
 pseudo_lock.c
Message-ID: <YFJZf0VvNf6Ndp+w@ArchLinux>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Reinette Chatre <reinette.chatre@intel.com>, fenghua.yu@intel.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, rdunlap@infradead.org
References: <20210317084016.3787380-1-unixbhaskar@gmail.com>
 <b29afbff-67f4-397b-e289-c3e21755fec0@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fFJf89DNL19XkO1c"
Content-Disposition: inline
In-Reply-To: <b29afbff-67f4-397b-e289-c3e21755fec0@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fFJf89DNL19XkO1c
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 10:54 Wed 17 Mar 2021, Reinette Chatre wrote:
>Hi Bhaskar,
>
>Thank you very much for catching this typo.
>
>My feedback [1] to a previous patch from you applies here also. The
>prefix should be "x86/resctrl:" for contributions to this area.
>
Thanks for the heads up! Do you want another revision of it, or will you
take it as it is??? I am noting down your point ,so ,I might pull out next
time I intend to sent out something to this specific area.
>[1]
>https://lore.kernel.org/lkml/7e3a5c13-db5c-7399-2b80-f1284786ea77@intel.com/
>
>On 3/17/2021 1:40 AM, Bhaskar Chowdhury wrote:
>>
>> s/derefence/dereference/
>>
>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>> ---
>>   arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
>> index e916646adc69..43990a882b36 100644
>> --- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
>> +++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
>> @@ -1307,7 +1307,7 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp)
>>   		 * If the thread does not get on the CPU for whatever
>>   		 * reason and the process which sets up the region is
>>   		 * interrupted then this will leave the thread in runnable
>> -		 * state and once it gets on the CPU it will derefence
>> +		 * state and once it gets on the CPU it will dereference
>>   		 * the cleared, but not freed, plr struct resulting in an
>>   		 * empty pseudo-locking loop.
>>   		 */
>> --
>> 2.30.2
>>
>
>Reinette

--fFJf89DNL19XkO1c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBSWX8ACgkQsjqdtxFL
KRWGbQf/T4ghF7FUR7dxPsg8sBiO4mwK8Pf0wGB1nBLh/wgkhIwlJFZ/AjdLPvFd
2wy56eV28fWuajBhTGfw1wEtKjPeRO8lbb7CIzNIViYct2Z++DvRp3AOywjalQKR
Qy9QSLxXNxXd5Ep+CNnicuTyel4r9wjcR3lWHM6dvdGvh2p8DJMDXfpAoQQPLePB
WnxnLqZ7ZpoG/QpL/NenGIwo/X2gaum77f98fqDld5FRdE/wJmduxErvQQvzTv1B
wWb2FpwmX6UdHT2iXodMJQB1Gq3gfZumUWcCdqG8Oply06ljtQgOtxS7dvjVx2ZM
9SLJWGhMeeCjpaaJH2sMKWEWlDJHPA==
=PPK6
-----END PGP SIGNATURE-----

--fFJf89DNL19XkO1c--
