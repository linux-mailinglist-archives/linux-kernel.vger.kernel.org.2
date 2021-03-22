Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D088345070
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 21:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbhCVUGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 16:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbhCVUG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 16:06:26 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF82CC061574;
        Mon, 22 Mar 2021 13:06:25 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id x14so11961811qki.10;
        Mon, 22 Mar 2021 13:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=kiurOswEq0GN7tcOLD9gh5qyGXjZcTeq6DYVN7DeEus=;
        b=L9FJPXr7qr4q0/utyiCMEmo2cPprgQVoYGME5DWjmtJt9O/5Lf2Pi6V3SEnb9jY0RZ
         WAfQcPSVEoD6kx2RKQ+L5sHxLaLDSJMWIYG6DfSZd6ffmr1c13hFpDl6+skib9NtlZWq
         SqVzrJflaRA6dSEaB/b3D+AON39v4J+vusItqzizL0Qjey9mzn9M6AKmRIRR496QBmE0
         xT3i5CvAzZCtf06c2ac8Wk7bvcb1Yut/RecrglW04GUw27gSrwxHaWSq4m9ddYAxSdiT
         I54ia+/L1L6sjimRQgNK7JwW+axrxmezmuEdLG47/ArzsrRWmNRE1/G2LRYPM0rCCYmY
         d4dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=kiurOswEq0GN7tcOLD9gh5qyGXjZcTeq6DYVN7DeEus=;
        b=lPB0lcfgayDQtpQSMMzQ8YuCoF65PSUPxpzHVe31v67HQDnTfQRTlk68AxJXXu4fHZ
         fp+nW7Glwrwl9ZcMBqGiCbcdsq6enCbdxTGppEgFmRLT4zC4hj3dESMnmYZstVJZXEtQ
         Hw5imS4/NRQE3MkIBFV0l9MpqOAHWOIxEmUCVKBXL0kU5CXf9yApKhlphrVk+IThpFkt
         FJq1MDVvg56CzhChsLU3+lEGSz3qPItz262hSZsxB0OFCMBCgi8w/7oKASNcdE6zic6G
         ilXcRJo0e4HqRkYui65FQBwKaSbgZKwsZ5uw8Cg+QWbYI4UMlKJiaKiFwmfzA/+w+U9w
         sl9Q==
X-Gm-Message-State: AOAM532DVXyARr0T3yHOLid5N9FvI9rPYWOyIRhN+MvHLtu/QBqHtuaZ
        GQy7rFhA6LSGy3lukIQ9DEx6y69diBKXlK2b
X-Google-Smtp-Source: ABdhPJyCAgQslt5NV7qj8KLmSsBunyeirrlNrcFaUKACHj0Ghoc2d72FPFMy8adEH7EKZeC5fjhFMQ==
X-Received: by 2002:a05:620a:c0e:: with SMTP id l14mr1747425qki.91.1616443584977;
        Mon, 22 Mar 2021 13:06:24 -0700 (PDT)
Received: from ArchLinux ([138.199.10.68])
        by smtp.gmail.com with ESMTPSA id e18sm9562126qtr.52.2021.03.22.13.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 13:06:24 -0700 (PDT)
Date:   Tue, 23 Mar 2021 01:36:11 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Matthew Wilcox <willy@infradead.org>, sir@cmpwn.com,
        gregkh@linuxfoundation.org, lee.jones@linaro.org, bp@alien8.de,
        huawei@kernel.org, krzk@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
Subject: Re: [PATCH] docs: submitting-patches Fix a typo
Message-ID: <YFj4s6ZPh2QFd9oS@ArchLinux>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>, sir@cmpwn.com,
        gregkh@linuxfoundation.org, lee.jones@linaro.org, bp@alien8.de,
        huawei@kernel.org, krzk@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
References: <20210322033000.2523887-1-unixbhaskar@gmail.com>
 <20210322034459.GE1719932@casper.infradead.org>
 <YFgTkhA+IOvNVxEn@ArchLinux>
 <87ft0nl31i.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wSxl/1aNd87rzlEU"
Content-Disposition: inline
In-Reply-To: <87ft0nl31i.fsf@meer.lwn.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wSxl/1aNd87rzlEU
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 07:40 Mon 22 Mar 2021, Jonathan Corbet wrote:
>Bhaskar Chowdhury <unixbhaskar@gmail.com> writes:
>
>> On 03:44 Mon 22 Mar 2021, Matthew Wilcox wrote:
>>>On Mon, Mar 22, 2021 at 09:00:00AM +0530, Bhaskar Chowdhury wrote:
>>>>
>>>> s/mesages/messages/
>>>
>>>did you test the build afterwards?  you forgot to do something.
>>>
>> What are you talking about??? It is going over my head...why the build
>> reqired?? A spello needs a rebuild???? Wondering....
>
>Willy is pointing out that you have introduced an error into the docs
>build.  A few minutes of your time to learn the basics of RST are likely
>to prove more helpful then typing lots of question marks...
>
Meh ...wish people learn to more explicit be in the first place ..heck..

>Thanks,
>
>jon

--wSxl/1aNd87rzlEU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBY+LMACgkQsjqdtxFL
KRU8gwf8CjOVtyGTusYj/yFpoWjb19VBlULpxb58a03elGUSN9gabxPQHBR3+quE
LBb8GczvkiDonsaj12Bp/FqJWQzIlXiXcOf5fAzjpbCMNuneqEZ3g0Nk7x9dpIjd
7A0oo8A66R3qqGgga+DNubKMbWOruIaGCVXaiB4DhkCrQI+tgOnCd34C1lzLj3hR
7pyWe0iUxBi/DgLJiCMTheIaRoM4fAcXT9b6Uf9c5oICEAbXSdOocr6beQXc0QP3
GedYFsK++Qe68ccQE0u6kaO+T1lBCZNJiy5lZlr4vL/4kS1ehpf/hn9YBAa3K9v1
CAqLp6Vj3RGabyrIPtStBz1R0Fv0xA==
=l+T8
-----END PGP SIGNATURE-----

--wSxl/1aNd87rzlEU--
