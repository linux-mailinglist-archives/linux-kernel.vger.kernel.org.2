Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5417234D6C7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 20:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbhC2SPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 14:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbhC2SOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 14:14:49 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF31C061756
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 11:14:48 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id y32so8784510pga.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 11:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=oB8mQckDRnsTb566Y1OIh92fjWMFYN90pj2v+1svesc=;
        b=LtS2XQ8OsTYyLEyieazx1fVe9lv5ECNTIHdS8eRuymA/HmfyvTHCFM3Y/LCSd7uIIC
         kaVVm5ISV3V8o3gdnQWF9R5cvi718RCTh1MFVhbkRie9PBMAmv/jbiUSUa1lmCm/bdvu
         7ziHmT7sHME7vAXMAl5xPKXYdrMmaJwkxyD/M82eraJCtWefTX4z+O7Q/nHMVeAGNW63
         GgwAVSJ6+mXmZuDpNl/hCC+eyvVIjgrIblnWksagjyrID/1iuFEauDoKvEHbUJtSFLlh
         SeS+/xITQaDDwq1n9JXfw/XWzKzvnBgKT/olj0aE47hEa7x2rZGnEdeG7Y0TU9Ygf9KY
         kPFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=oB8mQckDRnsTb566Y1OIh92fjWMFYN90pj2v+1svesc=;
        b=P4oB5xGpDLRO3qlKsc0+H+Zyvmi2c+T9crHM8iICoDgT7tvF6fNr5OWmJjIBk1/Ms2
         Uau2Jwkkpoq0J7UxZlM3BPW5DlHssNj20k3j6SR8Yh3pJDFLTgwKqKxKKAKsCiX6RkBw
         tNxH7Za8iFWPJOfSiEuvRz97sPwY5BWWzKuW+IDZLLBfofd/TPguW3oGEaT/ns21UFsL
         IJnMgNrWFmtRYsR0lnMA4m8W+BnHQ1qF12SyrIW2ukXBX23XjttOdXCXyOtmaDwzZwwF
         spQjzbEB4jOUJf2LT+A09zb7baVK5TiTDgYmzUqZYcIoOmvmbp7CiAyJGpLq33zrteie
         dKJg==
X-Gm-Message-State: AOAM532jYyTktNmr5i5MdCQan2q2hHwQ7HAlvKdUlxd/MKU7evdPy88k
        /pD6PEfLwk8L0GtM9P6pGPFtXw==
X-Google-Smtp-Source: ABdhPJzkNxKJpmXrRgtT2GYqOHHQUJSsGW/bbbasp2fN107GukPpXaJeREfMIcjj0s4AquWwRPXzZA==
X-Received: by 2002:a62:aa0a:0:b029:1ef:fe5:b172 with SMTP id e10-20020a62aa0a0000b02901ef0fe5b172mr26441136pff.9.1617041688402;
        Mon, 29 Mar 2021 11:14:48 -0700 (PDT)
Received: from ?IPv6:2600:1010:b06a:1311:e806:6d31:5a5:2c5c? ([2600:1010:b06a:1311:e806:6d31:5a5:2c5c])
        by smtp.gmail.com with ESMTPSA id g28sm17716454pfr.120.2021.03.29.11.14.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 11:14:47 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
Date:   Mon, 29 Mar 2021 11:14:46 -0700
Message-Id: <0E03D727-3A22-4E29-AB6E-D6D5065615C7@amacapital.net>
References: <CAJvTdKkKhCFpaWm1hb8r3GHx10KBRQvpJNTtYPSAc6m28A7sQA@mail.gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        libc-alpha <libc-alpha@sourceware.org>,
        Florian Weimer <fweimer@redhat.com>,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Linux API <linux-api@vger.kernel.org>
In-Reply-To: <CAJvTdKkKhCFpaWm1hb8r3GHx10KBRQvpJNTtYPSAc6m28A7sQA@mail.gmail.com>
To:     Len Brown <lenb@kernel.org>
X-Mailer: iPhone Mail (18D61)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 29, 2021, at 9:39 AM, Len Brown <lenb@kernel.org> wrote:
>=20
> =EF=BB=BF
>>=20
>> In particular, the library may use instructions that main() doesn't know e=
xist.
>=20
> And so I'll ask my question another way.
>=20
> How is it okay to change the value of XCR0 during the run time of a progra=
m?
>=20
> I submit that it is not, and that is a deal-killer for a request/release A=
PI.
>=20
> eg.  main() doesn't know that the math library wants to use AMX,
> and neither does the threading library.  So main() doesn't know to
> call the API before either library is invoked.  The threading library star=
ts up
> and creates user-space threads based on the initial value from XCR0.
> Then the math library calls the API, which adds bits to XCRO,
> and then the user-space context switch in the threading library corrupts d=
ata
> because the new XCR0 size doesn't match the initial size.
>=20

In the most extreme case, userspace could require that every loaded DSO be t=
agged with a new ELF note indicating support for dynamic XCR0 before changin=
g XCR0.

I would like to remind everyone that kernel enablement of AVX512 *already* b=
roke old userspace. AMX will further break something. At least with dynamic X=
CR0 we can make the breakage opt-in.

The ISA could have helped here by allowing the non-compacted XSTATE format t=
o be frozen even in the face of changing XCR0.  But it didn=E2=80=99t.  At t=
he end of the day, we are faced with the fact that XSTATE is a poor design, a=
nd we have to make the best of it.=
