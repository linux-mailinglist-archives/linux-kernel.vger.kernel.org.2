Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 495C638AD00
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 13:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242369AbhETLwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 07:52:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49200 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243033AbhETLo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 07:44:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621510985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JpfMFQcb7AirTe17RSUZLi9Pz4fcJVglBdNk+Vh+nI4=;
        b=HJ43+DaqP35WwTcHZhWYnx/cASC9etecqUGfK49r+xlmwKTom7QwXb8RuZ+iLrl2QF1Q55
        K+SKdLTD/XlLfLgKkacg/g7I0yq+8EG1C2qkqmzORMgNAb/vSn8lmZ6tkWx6W3qWJJjaHC
        berfRGa0I5TQdVn+VQ/Dw7hTrZoUUNk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-FzfxsE8uOQSuXfW3X_s_lw-1; Thu, 20 May 2021 07:43:01 -0400
X-MC-Unique: FzfxsE8uOQSuXfW3X_s_lw-1
Received: by mail-wr1-f71.google.com with SMTP id 7-20020adf95070000b02901104ad3ef04so8541230wrs.16
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 04:43:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JpfMFQcb7AirTe17RSUZLi9Pz4fcJVglBdNk+Vh+nI4=;
        b=Vn9a+ypu4T65EpiS2G6fZmVWuZf09FPuNCYDuNZFQA5rEBpJmp+dl5xMJQloDmGV4G
         LCBTrww4u6etWxWZ88nVCr6Eyx3cZRhefZ8FDXIVUXWA2hhQHrlhx7THReMfZOOBFvxw
         0JAirDjyDMvcQPlFk9pUFW0mk6g2N1Yo5rOfD3FcvDi850P72Qd7NUIruO+VcWJNYU18
         kfYD37GPiM1R6yCsuRNrdR9StpnkenQbRREKAsh3HlxM6r6/G7DAPwrKUYJhzoMRS6Pj
         7PCbBAMPN0Bb2IbnASLD/t+JwVUJ5f6feyw5NPjAM6qPRyWYpxr5C4Uh5jeiiYSpMAAx
         hJyQ==
X-Gm-Message-State: AOAM5319aGw9K/8yVWlcgp6myV9dVrncohLoGCTlJ9e4X2a7P1ue4dFM
        tx6gPBpF0xQRS74xQFXSI9LUEuPJUJyLpGroxtY0OGbWQXqffzHAD0oEEU5/u2601Hk1Od0KgkQ
        oMc5+AB4W+SF2BJeGA6ALnkQ=
X-Received: by 2002:a5d:498c:: with SMTP id r12mr3855237wrq.31.1621510979336;
        Thu, 20 May 2021 04:42:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6IpZw2/eLfxgKT1n96D1E30juDa2XEWW+Wc2hEL/4hxa0C/AeStspNWKWUCv4HvthYqD23w==
X-Received: by 2002:a5d:498c:: with SMTP id r12mr3855226wrq.31.1621510979140;
        Thu, 20 May 2021 04:42:59 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id f16sm2950825wrm.47.2021.05.20.04.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 04:42:58 -0700 (PDT)
Date:   Thu, 20 May 2021 12:42:57 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        mhocko@suse.com, willy@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/page_alloc: bail out on fatal signal during
 reclaim/compaction retry attempt
Message-ID: <20210520114257.huqhkqsdrhohn3u5@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <YKVn69o1UizH0kJD@casper.infradead.org>
 <20210519201743.3260890-1-atomlin@redhat.com>
 <20210519213455.97ff95f0124b4120787f8314@linux-foundation.org>
 <9b11dcd8-bc3b-aae9-feb1-43543bf9e22f@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="p5hnecwugz7gnprh"
Content-Disposition: inline
In-Reply-To: <9b11dcd8-bc3b-aae9-feb1-43543bf9e22f@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p5hnecwugz7gnprh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2021-05-20 12:20 +0200, Vlastimil Babka wrote:
> On 5/20/21 6:34 AM, Andrew Morton wrote:
> >=20
> > What observed problems motivated this change?
> >=20
> > What were the observed runtime effects of this change?
>=20
> Yep those details from the previous thread should be included here.

Fair enough.

During kernel crash dump/or vmcore analysis: I discovered in the context of
__alloc_pages_slowpath() the value stored in the no_progress_loops variable
was found to be 31,611,688 i.e. well above MAX_RECLAIM_RETRIES; and a fatal
signal was pending against current.


     #6 [ffff00002e78f7c0] do_try_to_free_pages+0xe4 at ffff00001028bd24
     #7 [ffff00002e78f840] try_to_free_pages+0xe4 at ffff00001028c0f4
     #8 [ffff00002e78f900] __alloc_pages_nodemask+0x500 at ffff0000102cd130

                                                             //      w28 =
=3D *(sp + 148)      /* no_progress_loops */
     0xffff0000102cd1e0 <__alloc_pages_nodemask+0x5b0>:      ldr     w0, [s=
p,#148]
                                                             //      w0 =3D=
 w0 + 0x1
     0xffff0000102cd1e4 <__alloc_pages_nodemask+0x5b4>:      add     w0, w0=
, #0x1
                                                             //      *(sp +=
 148) =3D w0
     0xffff0000102cd1e8 <__alloc_pages_nodemask+0x5b8>:      str     w0, [s=
p,#148]
                                                             //      if (w0=
 >=3D 0x10)
                                                             //          go=
to __alloc_pages_nodemask+0x904
     0xffff0000102cd1ec <__alloc_pages_nodemask+0x5bc>:      cmp     w0, #0=
x10
     0xffff0000102cd1f0 <__alloc_pages_nodemask+0x5c0>:      b.gt    0xffff=
0000102cd534

 - The stack pointer was 0xffff00002e78f900

     crash> p *(int *)(0xffff00002e78f900+148)
     $1 =3D 31611688

     crash> ps 521171
        PID    PPID  CPU       TASK        ST  %MEM     VSZ    RSS  COMM
     > 521171      1  36  ffff8080e2128800  RU   0.0 34789440  18624  speci=
al

     crash> p &((struct task_struct *)0xffff8080e2128800)->signal.shared_pe=
nding
     $2 =3D (struct sigpending *) 0xffff80809a416e40

     crash> p ((struct sigpending *)0xffff80809a416e40)->signal.sig[0]
     $3 =3D 0x804100

     crash> sig -s 0x804100
     SIGKILL SIGTERM SIGXCPU

     crash> p ((struct sigpending *)0xffff80809a416e40)->signal.sig[0] & 1U=
 << (9 - 1)
     $4 =3D 0x100


Unfortunately, this incident was not reproduced, to date.





Kind regards,

--=20
Aaron Tomlin

--p5hnecwugz7gnprh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmCmSzsACgkQ4t6WWBnM
d9YBLBAAoJRnCKOIc23LwajJoo5uFmSIWFNDG9YM0/iHSaiWQNA5zBCqa3VtINlS
ORjeBzihiNP/juBqX6YRUQ1C+BjA+Rcw7tSyFLhoxmmgE9Zha+saLlCZUOTruqCz
oTbAcLi8D3vGW4NP6MMLjl5RFPsmiqHluUOpMXUQ2J2UEeJzfU2IUZl32HgP8TA5
ofQHyCvaKrLnmMmioxNuuxzXsNH0kpd5oRhDABTEjokOlCmKcXeB7npEQP1rf3xB
dGdGF4Nra3W5m+eNolpomdoYGNDaCJ3k/UFnomXyPk0hFknJ6Ijy5tpVT2eqmS8v
1Qo6UTwLoPu6cjtXD5mccCTX85RVxUYSNAA8I4omR8uQyN3OgSt8LEKUjSb3j9YM
CkoEKPzb6hLUt9za2PMGmaCd54rYX4irwvXVJgzWE70bQw6g6FFRwQLIKc4sSQzD
Jg7t2QN5BPsMyAwJg4wdYdrKq/WthdcmldU3cJ104/BJSFOomyZiTI911X7T3QvY
tG7/uvStfw/3vWI5YeX4p2DrjSzoU+flE95rgTd6z/hWCk4F4ELdwSJoCPgsWa6t
1lpA5OAG1RElhtqcfeCU2xM1v3Yc3TpkD6KzI0RqlybEMCRQdkFlQzCZGPd5RfSq
s6Z/MKHyi/rlW6DFe+CK2+6v7Tw3GR02wr1acAfhcAI3DO1hhdU=
=r3HN
-----END PGP SIGNATURE-----

--p5hnecwugz7gnprh--

