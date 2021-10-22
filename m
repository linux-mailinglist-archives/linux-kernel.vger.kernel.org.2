Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08099438022
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 00:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234196AbhJVWQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 18:16:06 -0400
Received: from relay.yourmailgateway.de ([188.68.61.106]:56685 "EHLO
        relay.yourmailgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbhJVWQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 18:16:05 -0400
X-Greylist: delayed 607 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Oct 2021 18:16:04 EDT
Received: from mors-relay-8405.netcup.net (localhost [127.0.0.1])
        by mors-relay-8405.netcup.net (Postfix) with ESMTPS id 4Hbddv2B5yz6w03;
        Sat, 23 Oct 2021 00:03:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=alexander-lochmann.de; s=key2; t=1634940211;
        bh=jtUzDXvaR8hHXjywNo+4aj/Qd4yRV+sSG1NHKsnVZuM=;
        h=To:Cc:References:From:Subject:Date:In-Reply-To:From;
        b=aqtQLCPAmhRVc1Ual9aluO8IxBavtf44InjrqyKS429p5R68ZiXOUrmrRhJhKfVrj
         aXsPR7blZ7RUAS9UqJqzO7V2J5qm7q2geeHsSjfxLAKG1M/84hpilVAwlBSNeFPIG/
         KTLIlCKSyh/J7Fv85/gobsINjlc+E7rYvuIsVZqaqFJceRerrk94UqLTQQHL8HGd/6
         daX1GhgziWdYYP/KIOEiWMcQ3fJ7MuUjm0dNOkP/quGBsn+9hP5qDlDEecj8QbFZbj
         WSuu2mGc/P9iQFVFJMVSy78aOCYQiBdfSwTzggji51L0+A3wTRrm5/HwAzZpObZysM
         j7kcDjJZStEAQ==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
        by mors-relay-8405.netcup.net (Postfix) with ESMTPS id 4Hbddv1pmhz6w01;
        Sat, 23 Oct 2021 00:03:31 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy02-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.901
X-Spam-Level: 
X-Spam-Status: No, score=-2.901 required=6.31 tests=[ALL_TRUSTED=-1,
        BAYES_00=-1.9, SPF_PASS=-0.001] autolearn=ham autolearn_force=no
Received: from mx2e12.netcup.net (unknown [10.243.12.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by policy02-mors.netcup.net (Postfix) with ESMTPS id 4Hbddr3XTvz8svs;
        Sat, 23 Oct 2021 00:03:28 +0200 (CEST)
Received: from [10.128.131.224] (unknown [37.120.132.67])
        by mx2e12.netcup.net (Postfix) with ESMTPSA id 5B203A04FB;
        Sat, 23 Oct 2021 00:03:20 +0200 (CEST)
Authentication-Results: mx2e12;
        spf=pass (sender IP is 37.120.132.67) smtp.mailfrom=info@alexander-lochmann.de smtp.helo=[10.128.131.224]
Received-SPF: pass (mx2e12: connection is authenticated)
To:     Peter Zijlstra <peterz@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Klychkov <andrew.a.klychkov@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Jakub Kicinski <kuba@kernel.org>,
        Aleksandr Nogikh <nogikh@google.com>,
        kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210927173348.265501-1-info@alexander-lochmann.de>
 <YVQkzCryS9dkvRGB@hirez.programming.kicks-ass.net>
From:   Alexander Lochmann <info@alexander-lochmann.de>
Subject: Re: [PATCHv2] Introduced new tracing mode KCOV_MODE_UNIQUE.
Message-ID: <927385c7-0155-22b0-c2f3-7776b6fe374c@alexander-lochmann.de>
Date:   Sat, 23 Oct 2021 00:03:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YVQkzCryS9dkvRGB@hirez.programming.kicks-ass.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="CDzUVjhiPtClmKUvK9yUQsAHucLgloZvz"
X-PPP-Message-ID: <163494020654.20467.833133958238456166@mx2e12.netcup.net>
X-PPP-Vhost: alexander-lochmann.de
X-NC-CID: yTucXSprgOVIdQ7m3pFnHtEZSL80pRmPiiPjZRCUXJtPlaTCDtHB87NH
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CDzUVjhiPtClmKUvK9yUQsAHucLgloZvz
Content-Type: multipart/mixed; boundary="UBwMM8vn54PR4LUbz1olAyRhXFoyVHnMk";
 protected-headers="v1"
From: Alexander Lochmann <info@alexander-lochmann.de>
To: Peter Zijlstra <peterz@infradead.org>, Dmitry Vyukov <dvyukov@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Andrew Klychkov <andrew.a.klychkov@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 Johannes Berg <johannes@sipsolutions.net>, Ingo Molnar <mingo@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Jakub Kicinski <kuba@kernel.org>, Aleksandr Nogikh <nogikh@google.com>,
 kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <927385c7-0155-22b0-c2f3-7776b6fe374c@alexander-lochmann.de>
Subject: Re: [PATCHv2] Introduced new tracing mode KCOV_MODE_UNIQUE.
References: <20210927173348.265501-1-info@alexander-lochmann.de>
 <YVQkzCryS9dkvRGB@hirez.programming.kicks-ass.net>
In-Reply-To: <YVQkzCryS9dkvRGB@hirez.programming.kicks-ass.net>

--UBwMM8vn54PR4LUbz1olAyRhXFoyVHnMk
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE-1901
Content-Transfer-Encoding: quoted-printable

Maybe Dmitry can shed some light on this. He actually suggested that=20
optimization.

- Alex

On 29.09.21 10:33, Peter Zijlstra wrote:
> On Mon, Sep 27, 2021 at 07:33:40PM +0200, Alexander Lochmann wrote:
>> The existing trace mode stores PCs in execution order. This could lead=

>> to a buffer overflow if sufficient amonut of kernel code is executed.
>> Thus, a user might not see all executed PCs. KCOV_MODE_UNIQUE favors
>> completeness over execution order. While ignoring the execution order,=

>> it marks a PC as exectued by setting a bit representing that PC. Each
>> bit in the shared buffer represents every fourth byte of the text
>> segment.  Since a call instruction on every supported architecture is
>> at least four bytes, it is safe to just store every fourth byte of the=

>> text segment.
>=20
> I'm still trying to wake up, but why are call instruction more importan=
t
> than other instructions? Specifically, I'd think any branch instruction=

> matters for coverage.
>=20
> More specifically, x86 can do a tail call with just 2 bytes.
>=20

--=20
Alexander Lochmann                PGP key: 0xBC3EF6FD
Heiliger Weg 72                   phone:  +49.231.28053964
D-44141 Dortmund                  mobile: +49.151.15738323


--UBwMM8vn54PR4LUbz1olAyRhXFoyVHnMk--

--CDzUVjhiPtClmKUvK9yUQsAHucLgloZvz
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEElhZsUHzVP0dbkjCRWT7tBbw+9v0FAmFzNSQFAwAAAAAACgkQWT7tBbw+9v3r
3w/7Bv8kyg3mPcCinEzZ9AnnM/yQ20THcNhazgLOZNfSMOqGKhyu2lCwY8A8TakScZAd+si/iU/v
d6n14El+O4hTXzqjq42Kyukl9F56f45qPd8CXciiSnkCcH2LO7t0MEck6KobaGDe1km0QBoXc/kN
hhyG5Yp5qduw34Ltj8kaylCUzSOqYiRFmZ2Ws7aA5HkGTA8zgoRm4BZj/YEqpUsoFeGsUglvMtlt
vPyG479llRhv3DVE3Kal7pxGTSVccFg4uCMsBGFzl5nwLhrkC9P3c2gzkbzcQ6rUTTCnBEZAnU6o
6G4lZER0xOW41J8ZxdCfk3JadcKM/w245pu6SBDHKNE+oLm//+BCbhAReB/74WqPI4XvkQP623Gk
x6mFm6EeXA72C/bWQg+V0VrFdbnkBACI88QMcEyzDHTddNno3/jkFx3rOQx7ZbVjY98Xw0p6Nf/P
YjPM3qj1LEg7wKV12oQEBIHGo6oLUC4f2NUpl4DtYKCpBjBF4iMqCbkTmTtGi7GCyzFfiUDscafB
3Y9BzfzJKM5zlgsd9n29jAWzUCFhAByzJsFUY78c5JjVylnUugdLuBoichLvh1r4Hg67AX1TB84N
cvS0Y+c/jgXEV4/EeqnfaBW9Uk8yhdGLytC6UpAhGNNkK3r5bhU1WY6PiCGGR5XbFIkbw9+i6L5Q
ST8=
=9qA3
-----END PGP SIGNATURE-----

--CDzUVjhiPtClmKUvK9yUQsAHucLgloZvz--
