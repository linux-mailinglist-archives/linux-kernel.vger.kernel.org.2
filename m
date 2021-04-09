Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B76C35A0B8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 16:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbhDIOKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 10:10:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22618 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233009AbhDIOKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 10:10:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617977422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EWNREvrOtHiS/gdxlthAoSyaX95CLmAUl3lJOVpNYCw=;
        b=c69PVkQPjTFGc7JIumKw59bMWstrVDN32l4cqWo1wNYz9r5wTwyEt18yamBKDTwxeY2qXG
        mY8oVgp59wrcwix185Aa7LmVaGPa3VCJ7e3r1ua4JeegzFY47g4tX5mr344MCNrANGJ2Vf
        FTErhDBAdx50ABq8b39T9thPMS1hiRg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-533-z92XHroaMyisCL3gja52_Q-1; Fri, 09 Apr 2021 10:10:18 -0400
X-MC-Unique: z92XHroaMyisCL3gja52_Q-1
Received: by mail-wm1-f70.google.com with SMTP id 18-20020a05600c2312b029011e88b0f2baso850475wmo.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 07:10:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=EWNREvrOtHiS/gdxlthAoSyaX95CLmAUl3lJOVpNYCw=;
        b=g5gMUDSyEP2c4mWzxOMlqJZFnlJOpD4uvkj7JjZr+P7pXlBhGXdDi33YH8FHD3djEW
         CClZPuYumCz79O7qXWLay4n+6lcQhmH3Jtt42TNoibUdVAZkBTHTrTP+OZ0eRJlcvv1D
         +y9CwAsEdQTxrI4amHswhdQXkvkb7Fmx2wlMeDy9QjJ9tpjBrhgxCGfCf6bKDiuFpJ6V
         KUAEHQwk7qt4D16qIFio2V6G90wfVFfFf/6qoHLYgx3q2mkgBLAcGxZd6/hAGBoQYGxI
         CqGkljVgAXh+jx22etWMLdpt3Izhy1fL7/uiKR0php1mDWzMvVpR2MUbgkLbA7GKNTGz
         kyfA==
X-Gm-Message-State: AOAM532xNwx8jLjCtUvKkvTda2oeJAq00O/FMZOXAhpdzho3j4niV+1Z
        rhB6yuJ63uWoqdcNkfnpGSR2qxOIph9vBUcsXZpMu1tUvF5F4RizlBEuKW9jrX1rPvxDUJgOQgH
        aZ95IPYn/cTQAcWw+VKxgDMbR
X-Received: by 2002:a1c:49d5:: with SMTP id w204mr14121440wma.51.1617977417370;
        Fri, 09 Apr 2021 07:10:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxK2eQJebQQhfMGzxEK9Jzyvz7ElE085TfiU8H50Wp6kUuTBF1Ga0ilIdJhVRoRW8OfQyc2eA==
X-Received: by 2002:a1c:49d5:: with SMTP id w204mr14121423wma.51.1617977417130;
        Fri, 09 Apr 2021 07:10:17 -0700 (PDT)
Received: from [192.168.3.108] (p5b0c6302.dip0.t-ipconnect.de. [91.12.99.2])
        by smtp.gmail.com with ESMTPSA id u8sm4960453wrr.42.2021.04.09.07.10.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Apr 2021 07:10:16 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v7] RISC-V: enable XIP
Date:   Fri, 9 Apr 2021 16:10:15 +0200
Message-Id: <F096121C-8F7A-4E9A-B319-2C5F656610EA@redhat.com>
References: <YHBdzPsHantT9r8t@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>, Alex Ghiti <alex@ghiti.fr>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        Vitaly Wool <vitaly.wool@konsulko.com>
In-Reply-To: <YHBdzPsHantT9r8t@linux.ibm.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
X-Mailer: iPhone Mail (18D70)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 09.04.2021 um 15:59 schrieb Mike Rapoport <rppt@linux.ibm.com>:
>=20
> =EF=BB=BFOn Fri, Apr 09, 2021 at 02:46:17PM +0200, David Hildenbrand wrote=
:
>>>>> Also, will that memory properly be exposed in the resource tree as
>>>>> System RAM (e.g., /proc/iomem) ? Otherwise some things (/proc/kcore)
>>>>> won't work as expected - the kernel won't be included in a dump.
>>> Do we really need a XIP kernel to included in kdump?
>>> And does not it sound weird to expose flash as System RAM in /proc/iomem=
? ;-)
>>=20
>> See my other mail, maybe we actually want something different.
>>=20
>>>=20
>>>> I have just checked and it does not appear in /proc/iomem.
>>>>=20
>>>> Ok your conclusion would be to have struct page, I'm going to implement=
 this
>>>> version then using memblock as you described.
>>>=20
>>> I'm not sure this is required. With XIP kernel text never gets into RAM,=
 so
>>> it does not seem to require struct page.
>>>=20
>>> XIP by definition has some limitations relatively to "normal" operation,=

>>> so lack of kdump could be one of them.
>>=20
>> I agree.
>>=20
>>>=20
>>> I might be wrong, but IMHO, artificially creating a memory map for part o=
f
>>> flash would cause more problems in the long run.
>>=20
>> Can you elaborate?
>=20
> Nothing particular, just a gut feeling. Usually, when you force something
> it comes out the wrong way later.
>=20
>>>=20
>>> BTW, how does XIP account the kernel text on other architectures that
>>> implement it?
>>=20
>> Interesting point, I thought XIP would be something new on RISC-V (well, a=
t
>> least to me :) ). If that concept exists already, we better mimic what
>> existing implementations do.
>=20
> I had quick glance at ARM, it seems that kernel text does not have memory
> map and does not show up in System RAM.
>=20

Does it show up in a different way or not at all?

> --=20
> Sincerely yours,
> Mike.
>=20

