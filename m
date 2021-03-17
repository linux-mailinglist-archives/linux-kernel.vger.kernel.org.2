Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 304E933FAF7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 23:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhCQWWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 18:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhCQWV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 18:21:28 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD17C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 15:21:28 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id f124so121720qkj.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 15:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=kbdISMwcmwbN1Hvb2SlkpcwYyCNnhfVUyok4/quZGiA=;
        b=mpQeW6QR7ctt4sXlFgK8V6ed2BV/76koc7gYcz+PGcXp7jNe0DDJuozC7kxTu7rwaL
         r5wL+03hyLrlCid6zcCb6+oz1WcexbZQhYJmCeObx8qDCfiHwXf6vJO9SEvPmxqjAwBa
         rVbtBNQ0R+p4PHPhZYI9cKVGiX6jvKnI/dDn18EjEU+rShlgN/KdtcXmBdleiCchx8mD
         P/SRzoksRMUIOR4vphJkMsGfCi1WUkWfqZr2I7pCY7snir6MYV007GqyWtirbSYmBtsx
         gDjDiziT1mTC7sJi8SmntLlsG+CLZZdQoHh2KQALlymYQ+my4Y8Fo2z01/s+70JBNV9h
         KXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=kbdISMwcmwbN1Hvb2SlkpcwYyCNnhfVUyok4/quZGiA=;
        b=YdzX817csZ144240G7yB1ygwcbBU/P2Gdnkfa7LTDhvXpMer4v0hz7xr9sdx1DjcMs
         fol/qat1QEpalICL3l97eVrUE59ZARDZbaWmaAsQBXclVgBFYqpzhyvSjEj7ft+BAic2
         ipEQup8gPA4mlpKUvR0Nx8EliDbsROz2gRfrWmdFyE1IhVuMOLytOGWe5AD0MAg+Qzv6
         mprio86j3q5jf7QvSTEPSSKcQhirFnPewe4QOe+IQgBZcYSDIf3TSdXb9SaPtx9k2K33
         ZDQru9jxg8iTith2vYwG/povG5Hk/rSPfInSgXJmvwC/QLjkSx1yQyLQgoxhgRlHV4nd
         9yjw==
X-Gm-Message-State: AOAM530dOFQP7/ulymF7lhjTO67zQAChjZRfdgFowIMXw81kNatv6PFI
        PKMrgyMw3Mj6OErLRNQPLII=
X-Google-Smtp-Source: ABdhPJzdOwOuHPkUdAf6kABuc8yn33916FX+VLWDQCY6DoQyhSxwJBKWo2SgLIFqjXMBkqSHtLn1Uw==
X-Received: by 2002:a37:9bd1:: with SMTP id d200mr1530342qke.328.1616019687636;
        Wed, 17 Mar 2021 15:21:27 -0700 (PDT)
Received: from ArchLinux ([156.146.37.138])
        by smtp.gmail.com with ESMTPSA id s133sm330952qke.1.2021.03.17.15.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 15:21:26 -0700 (PDT)
Date:   Thu, 18 Mar 2021 03:51:08 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
Subject: Re: [PATCH] kernel: cpu: resctrl: Minor typo fix in the file
 pseudo_lock.c
Message-ID: <YFKA1E27BoCC+uNc@ArchLinux>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Reinette Chatre <reinette.chatre@intel.com>, fenghua.yu@intel.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, rdunlap@infradead.org
References: <20210317084016.3787380-1-unixbhaskar@gmail.com>
 <b29afbff-67f4-397b-e289-c3e21755fec0@intel.com>
 <YFJZf0VvNf6Ndp+w@ArchLinux>
 <d2d6f71a-851d-efc0-df17-bb5dcc8e776e@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uJnjiIjICa5OORNm"
Content-Disposition: inline
In-Reply-To: <d2d6f71a-851d-efc0-df17-bb5dcc8e776e@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uJnjiIjICa5OORNm
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 13:31 Wed 17 Mar 2021, Reinette Chatre wrote:
>Hi Bhaskar,
>
>On 3/17/2021 12:33 PM, Bhaskar Chowdhury wrote:
>> On 10:54 Wed 17 Mar 2021, Reinette Chatre wrote:
>>> Thank you very much for catching this typo.
>>>
>>> My feedback [1] to a previous patch from you applies here also. The
>>> prefix should be "x86/resctrl:" for contributions to this area.
>>>
>> Thanks for the heads up!
>
>This was the third time I mention this to you.
>
Meh ...heck..that means something more important than your words occupied my
mind ...anyway...

>> Do you want another revision of it, or will you
>> take it as it is???
>
>If accepted I am not the one who will merge this patch so having a
>version that is ready for merge (all feedback addressed) would be best.
>
Thanks for the explanations.

>> I am noting down your point ,so ,I might pull out next
>> time I intend to sent out something to this specific area.
>
>Please do note that my comment was not specific to resctrl. This prefix
>style is used by x86 area.
>
I do understand.
>Reinette

--uJnjiIjICa5OORNm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBSgNEACgkQsjqdtxFL
KRVdmAf8CD7R29VTZ02dLd6cxew0VZDLmFW7RpwYh4fXAooEpnh2EBJaVE2mlXKH
S9LEARh+T67prrqLSLfPj3n/osN7y1NtXp1s0ZdPAgxxNUeHusivynRn5XTDVOeB
UCNC6Tr+AHU3Y8f/fHUmheGIwI0PwAWFZWHpLR+G4SMNcKsb9OARJK5dBJgEmIcP
JI7LomSvRhKjtN6hB6pw0bBiW0D1ggsa8SmC9rLXd3oLwAMrsYBAR1Dso8Oy1nwI
QK5fvQCR92fLSxDLkz/ma6dtqqLTAvs905VSOQ0fxTZUaq2lBuhI2mJ+uheZBIGf
l+kdNOCB7EU3hpzoDsicKm0NvKEUWQ==
=bl2l
-----END PGP SIGNATURE-----

--uJnjiIjICa5OORNm--
