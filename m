Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECCD338962F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 21:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbhESTJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 15:09:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57251 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231474AbhESTJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 15:09:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621451287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZO/Tg9gg9bn/Y0D+8WtwIa3TeflHx3GoPulbW2F+HhA=;
        b=V1WidKTuhreHMBE4/HLApr3XHD7FrrO6SDYNEI5r01eb+h3iOKcuLJIHNLz7c/4UNMbZVP
        USoA0rm1fbNPgfXbmw5Qcv3dQgcfbgj6sMpQKRgV61Sk8e6JPFT/9fP1xaiN2aF7qWpx/+
        DEsfZHrzNOVxf7GLAyIofZP/F2SpZnc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-3UDPK53QNDW5q0KRjTx2Zw-1; Wed, 19 May 2021 15:08:05 -0400
X-MC-Unique: 3UDPK53QNDW5q0KRjTx2Zw-1
Received: by mail-wr1-f70.google.com with SMTP id u5-20020adf9e050000b029010df603f280so7525632wre.18
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 12:08:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZO/Tg9gg9bn/Y0D+8WtwIa3TeflHx3GoPulbW2F+HhA=;
        b=uSozUAxQAbWCu2DvMYKt+ILdzkKfgIvvczfrgujuRrupRX5ZKfDCUxbQHZCznhYqMb
         WhVmM4FnVMfE3uSn/czQ4DZ6c3sUxnoH7aMgDEWjhMZY9nI8SZh5jx+zp7zRsL7M+DYz
         2heANYoDwV/SRLJWGKkRxD2ujmHAYr1da3IfnUmotqC0JUVrjFFOytYIe1Uj0AlW2y9v
         EnJdcy+V/qlz7PTtIX55TKZFZQ3Q1kxjdl0ZRS8DwIZ0bXkh/dUFaaOTxc19ev3H1u+U
         JTybxHHjC/hHl2hI5m7lo6AAmtZ7+g2/qoe67RUwMP3PQU+Gazyt7OMatFt3DzpK9BeN
         Jp1g==
X-Gm-Message-State: AOAM5303F9KR6Dp6T6EMRWe6d9Raiu44r7n8vbjChJYDWNL+RHBUBQsM
        458IFhLJf9gYtEMdhhSynk5V+xza8eHrGsUfp3TS1fHRz92Y25ol6nVOaqqyYzZAMXEz4T0sINU
        YaL7EWU9u1WFeHLjCX80QI5c=
X-Received: by 2002:a5d:6882:: with SMTP id h2mr401747wru.275.1621451283717;
        Wed, 19 May 2021 12:08:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+0ELM7FIfULXFR9X73ag1ofps4kkvCvWaMLxWZQH/ftcAVuGzxznKoNQ7LuytJDJ0tRGv/A==
X-Received: by 2002:a5d:6882:: with SMTP id h2mr401733wru.275.1621451283562;
        Wed, 19 May 2021 12:08:03 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id i11sm313207wrq.26.2021.05.19.12.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 12:08:02 -0700 (PDT)
Date:   Wed, 19 May 2021 20:08:01 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: bail out on fatal signal during
 reclaim/compaction retry attempt
Message-ID: <20210519190801.t7fqdtixqmobqsps@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20210519130609.r3ml6ohb2qsrfq2t@ava.usersys.com>
 <20210519145014.3220164-1-atomlin@redhat.com>
 <076e1c68-b4a2-26ea-9538-d88e6da800cc@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kaijdhkoyswy6ze5"
Content-Disposition: inline
In-Reply-To: <076e1c68-b4a2-26ea-9538-d88e6da800cc@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kaijdhkoyswy6ze5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2021-05-19 17:22 +0200, Vlastimil Babka wrote:
> Hm, indeed, if fatal_signal_pending() is true then try_to_compact_pages()=
 will
> bail out in the for-each-zone loop after trying a single zone and if that=
 zone
> keeps returning COMPACT_SKIPPED, things can get stuck.
> And direct reclaim might see compaction_ready() for another zone and retu=
rn 1,
> faking the progress.

Indeed.

> So your patch seems to be solving the issue. But maybe we should just do =
the
> test at the beginning of should_compact_retry() and not specific to
> compaction_needs_reclaim() - if there's a fatal signal, there will be no
> compaction happening, so we should just say not to retry.

Fair enough - I will post a v2.

> I suppose if the patch fixes your situation where fatal_signal_pending() =
was
> true, there's hopefully not a more general problem with the retry logic?

At the present time, not to my knowledge. That being said, I will continue
to review the relevant source code further.



Kind regards,

--=20
Aaron Tomlin

--kaijdhkoyswy6ze5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmClYf4ACgkQ4t6WWBnM
d9ZhVA/+JIMsrNtkmj/bQZxLjZSCsNMbf9a4tbnVvndL+8IRoOpH6liJXOUeK1mp
U0pkcqxWX1SiL2hbXLUwrdOtj9jQmGQG/Dj9C5jYdxq7I/a4wIfrYCduLprq0s8P
E17jIxfH0nHxL4rmN/ujZZtRiS6pTUx2jzUAAMuLipkWvYuaw3viWhoHY3zowoTI
0Vu6yuQVHj9geImwa6NeBg5UpKfMv88g7vJ6IZ6anGT7Kzpx5Zkyt20fy2a4gfgy
4Px0zCruKvjH6Y0DD4HMGLfZvLiYRdvIbjavm8IaI9qV1u22qbl9+WwY+YNw33pK
cZYWMg21J+DbagWAX1nULzXgiDQb3w07Pcez8ObuhyalJyUYPOzOwL8JsNsUyKWw
yrg/KpZVKpvWRhBX+XwLymTLJX9VL0TmY45trwA638xKb/zj2MTwx+Tfv0dTjzwy
O7K6Wp0aXzFAp4MYE/uwK0D1FaidtMPOHGH+i7jWy7q0vHAMDXw6sUMjEf2y45/J
/SscBWWmCEbs2BZU0QpfC5iqvD6bQ24B/7pAYs3S8fzl8x0ScYTSbXAPAFnqn9Wo
hQyyHth7d4U/eN/z2VnstsZjOuYb8TK+DCq1dTwm/kMB3zEolgusk5qDD5I41mB0
cJy11PUfhSrPMYi8KcvVlIUcAMqx0+6RT9pME7jp5wVA8Jy2b44=
=wzHG
-----END PGP SIGNATURE-----

--kaijdhkoyswy6ze5--

