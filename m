Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C504410894
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 22:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239147AbhIRUbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 16:31:32 -0400
Received: from relay.yourmailgateway.de ([185.244.192.111]:33215 "EHLO
        relay.yourmailgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbhIRUbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 16:31:31 -0400
X-Greylist: delayed 456 seconds by postgrey-1.27 at vger.kernel.org; Sat, 18 Sep 2021 16:31:30 EDT
Received: from relay01-mors.netcup.net (localhost [127.0.0.1])
        by relay01-mors.netcup.net (Postfix) with ESMTPS id 4HBj0t4VCdz7xDT;
        Sat, 18 Sep 2021 22:22:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=alexander-lochmann.de; s=key2; t=1631996542;
        bh=DowptoWJEbBfgFX73sqjlKlYA2EYptvjJ/OGIVkwj1k=;
        h=To:Cc:References:From:Subject:Date:In-Reply-To:From;
        b=khznvf5YcO+9tsMJ/86jWHBqGOIwLu7pKiBwSfBtwATKNyG6q7jhZ+uDrVtplfbZ2
         bPlNEwm/32xOPfvUUkT4gWEg/URBcpE+pBBodHXq2DWqjHGa5t5lSNUSEnEKTO9YOh
         tVYekqqiztGPjJRBGmTh3PDMTgJwQo8U1VmxR9KJFDt5nLG9o9O8DS4J48JfkcKdr9
         ttP4yx98ev/cpAbFbTxxl+wx8f+uTTq9gvR0Jmn7P7Hc6aHnPAgiaUiQMtbVh2LcIp
         sHDQQt+RPonfZJlR0B6SRUEsqHPSteH9fZjQgkomZn0sh032ujT/KieS1ko9ambEgj
         NkLASUfVbfhFA==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
        by relay01-mors.netcup.net (Postfix) with ESMTPS id 4HBj0t4591z7xD3;
        Sat, 18 Sep 2021 22:22:22 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.901
X-Spam-Level: 
X-Spam-Status: No, score=-2.901 required=6.31 tests=[ALL_TRUSTED=-1,
        BAYES_00=-1.9, SPF_PASS=-0.001] autolearn=ham autolearn_force=no
Received: from mx2e12.netcup.net (unknown [10.243.12.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by policy01-mors.netcup.net (Postfix) with ESMTPS id 4HBj0r4q5xz8sX7;
        Sat, 18 Sep 2021 22:22:20 +0200 (CEST)
Received: from [IPv6:2003:ed:7f18:38f0::67] (p200300ed7f1838f00000000000000067.dip0.t-ipconnect.de [IPv6:2003:ed:7f18:38f0::67])
        by mx2e12.netcup.net (Postfix) with ESMTPSA id 1E8BEA0591;
        Sat, 18 Sep 2021 22:22:18 +0200 (CEST)
Authentication-Results: mx2e12;
        spf=pass (sender IP is 2003:ed:7f18:38f0::67) smtp.mailfrom=info@alexander-lochmann.de smtp.helo=[IPv6:2003:ed:7f18:38f0::67]
Received-SPF: pass (mx2e12: connection is authenticated)
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Klychkov <andrew.a.klychkov@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Aleksandr Nogikh <nogikh@google.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Maciej Grochowski <maciej.grochowski@pm.me>,
        kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20210326205135.6098-1-info@alexander-lochmann.de>
 <CA+fCnZcTi=QLGC_LCdhs+fMrxkqX66kXEuM5ewOmjVjifKzUrw@mail.gmail.com>
From:   Alexander Lochmann <info@alexander-lochmann.de>
Subject: Re: [PATCHv3] Introduced new tracing mode KCOV_MODE_UNIQUE.
Message-ID: <aaee2292-022b-d99e-9fa9-b48ad5c2fe92@alexander-lochmann.de>
Date:   Sat, 18 Sep 2021 22:22:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CA+fCnZcTi=QLGC_LCdhs+fMrxkqX66kXEuM5ewOmjVjifKzUrw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jeoiCDS3Yo1W8TmZdEkFUwrpjDXm41xxy"
X-PPP-Message-ID: <163199653879.4199.11228245821604856147@mx2e12.netcup.net>
X-PPP-Vhost: alexander-lochmann.de
X-NC-CID: ldOtAIRfa6FXYg/2lhJBu0h6e2ToKhuNgU4pdNS2aPCKFwbzmIdRzZbn
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jeoiCDS3Yo1W8TmZdEkFUwrpjDXm41xxy
Content-Type: multipart/mixed; boundary="ijdinWyZS3cUUOiSvgMUkUAuSPyavspzk";
 protected-headers="v1"
From: Alexander Lochmann <info@alexander-lochmann.de>
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>,
 Andrey Konovalov <andreyknvl@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Randy Dunlap <rdunlap@infradead.org>,
 Andrew Klychkov <andrew.a.klychkov@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Jakub Kicinski <kuba@kernel.org>,
 Aleksandr Nogikh <nogikh@google.com>, Wei Yongjun <weiyongjun1@huawei.com>,
 Maciej Grochowski <maciej.grochowski@pm.me>, kasan-dev@googlegroups.com,
 linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Message-ID: <aaee2292-022b-d99e-9fa9-b48ad5c2fe92@alexander-lochmann.de>
Subject: Re: [PATCHv3] Introduced new tracing mode KCOV_MODE_UNIQUE.
References: <20210326205135.6098-1-info@alexander-lochmann.de>
 <CA+fCnZcTi=QLGC_LCdhs+fMrxkqX66kXEuM5ewOmjVjifKzUrw@mail.gmail.com>
In-Reply-To: <CA+fCnZcTi=QLGC_LCdhs+fMrxkqX66kXEuM5ewOmjVjifKzUrw@mail.gmail.com>

--ijdinWyZS3cUUOiSvgMUkUAuSPyavspzk
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE-1901
Content-Transfer-Encoding: quoted-printable



On 27.03.21 15:56, Andrey Konovalov wrote:
>=20
>> @@ -213,9 +223,10 @@ static void notrace write_comp_data(u64 type, u64=
 arg1, u64 arg2, u64 ip)
>>          struct task_struct *t;
>>          u64 *area;
>>          u64 count, start_index, end_pos, max_pos;
>> +       unsigned int mode;
>>
>>          t =3D current;
>> -       if (!check_kcov_mode(KCOV_MODE_TRACE_CMP, t))
>> +       if (!check_kcov_mode(KCOV_MODE_TRACE_CMP, t, &mode))
>>                  return;
>=20
> mode isn't used here, right? No need for it then.
>=20
No, it's not. However, check_kcov_mode() needs it. Dmitry suggested=20
passing a pointer to check_kcov_mode(), and let the optimizer do the rest=
=2E
>> @@ -562,12 +576,14 @@ static int kcov_ioctl_locked(struct kcov *kcov, =
unsigned int cmd,
>>   {
>>          struct task_struct *t;
>>          unsigned long size, unused;
>> -       int mode, i;
>> +       int mode, i, text_size, ret =3D 0;
>>          struct kcov_remote_arg *remote_arg;
>>          struct kcov_remote *remote;
>>          unsigned long flags;
>>
>>          switch (cmd) {
>> +       case KCOV_INIT_UNIQUE:
>> +               fallthrough;
>>          case KCOV_INIT_TRACE:
>>                  /*
>>                   * Enable kcov in trace mode and setup buffer size.
>> @@ -581,11 +597,42 @@ static int kcov_ioctl_locked(struct kcov *kcov, =
unsigned int cmd,
>>                   * that must not overflow.
>>                   */
>>                  size =3D arg;
>> -               if (size < 2 || size > INT_MAX / sizeof(unsigned long)=
)
>> -                       return -EINVAL;
>> -               kcov->size =3D size;
>> -               kcov->mode =3D KCOV_MODE_INIT;
>> -               return 0;
>> +               if (cmd =3D=3D KCOV_INIT_UNIQUE) {
>=20
> Let's put this code under KCOV_INIT_UNIQUE in the switch. This
> internal if only saves duplicating two lines of code, which isn't
> worth it.
So. Shall I skip the fallthrough and move 'my' code upwards?

--=20
Alexander Lochmann                PGP key: 0xBC3EF6FD
Heiliger Weg 72                   phone:  +49.231.28053964
D-44141 Dortmund                  mobile: +49.151.15738323


--ijdinWyZS3cUUOiSvgMUkUAuSPyavspzk--

--jeoiCDS3Yo1W8TmZdEkFUwrpjDXm41xxy
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEElhZsUHzVP0dbkjCRWT7tBbw+9v0FAmFGSnkFAwAAAAAACgkQWT7tBbw+9v2N
2RAAzeXvASCTHMOY9leID0oi73MODfrY4EW74Jq2CnbtM+lj6FjzL5kCGkILz5LkSuF5FNsY2zdN
sYeb6fK6eIIvlSSdHOn4v22lFRrHNP2VOE6ExAZCve8hcw7GlTtSBEGZcHIz4wL2i2A2jNn+furn
eQLdujoaYQ7keOck/fxVdexQZ1JxE/42VLR/R0yG90/EZLkn/0N7iaQ2jm1XQjtVdV9VkI8xxFwy
bvyXxRSsmxCHJ8m0GNQY6Jdy6f/wPg2/1hGSAOzZXsh+V0R7azpGh9oLCrECWYZWyyqO85SkGs+m
LuB3urCeMZVMHci1NccR3hiYP6Ma2B09G+m/inEdU/cf3YdzSoZ/FbqRZO2GenmkvwK5Xv03hdzb
wgEUBTbSBpD7I4EIuS/eCjsESGCeToFeG9GKhurtzDg4woustiuXkb/S8xP42C+LhXoApAz1yvaF
Son/f0gS9WzcbQSUxPM1AHE/Flq6B0P0lYAW9906b0aFwHzFW1UHIMzzwhbLJNvFJOb6F/BvtrMy
LFnp2WqL8xR+oPOXiBPWMkn8OU1pwQtJkwFWyaAlGImJdrcBNrd/qDsYnJF69jK0knIAtEvWAJGe
cHNX1Pe0/fMska+6bhPUV//2w/dnLHjP5SAlazjFKReZ2/MyujJ0YOtElvckvj3G8MIh9Lu97eye
KiI=
=oZeu
-----END PGP SIGNATURE-----

--jeoiCDS3Yo1W8TmZdEkFUwrpjDXm41xxy--
