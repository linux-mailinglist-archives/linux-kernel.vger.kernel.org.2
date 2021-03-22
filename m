Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9CF734379D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 04:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhCVDtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 23:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbhCVDsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 23:48:47 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079F0C061574;
        Sun, 21 Mar 2021 20:48:47 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id a11so11406816qto.2;
        Sun, 21 Mar 2021 20:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=NKDpDatJo338Mf3xcO1QAt0QQ7L/8l5DTa2jm0T658c=;
        b=fb+Ei3jOVcd70KYHSXsXKZYJAW6RRQI3xRRfGSHkonrc0ip0yR6LCcohadJIG9c4Rw
         38cXUi7MYjqYhFCuXFCdtg47wMA2fzDkW3+4d5by/igaP0ZT6eAfGnzBYmQZ+ygMjHAM
         F4JO1NWonjgp/NV77CKXt9UtJH3t/BwIcEnHf6ucPtv2Aok8MIKgBsUh3UXVSMNKSKUW
         R0L+u8dR5+4uoYQ+SEjPkaHHV5McxK7O2pobPIdrSNzsLu/EFuCshs85B8caY8poHfIU
         VeWBk8WM2ekXUpbJO82jkL9wazr+JpockXdpL0A1N9Fqh8y7U+wwPwOHKr27/PCX3DhK
         YXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=NKDpDatJo338Mf3xcO1QAt0QQ7L/8l5DTa2jm0T658c=;
        b=OQu1jqd0UYL8FmBcqReL9VyXI4NJcKYWtabs+6IN1qXAkWPZu10nFrajcByQVyIvLM
         1TU0Uv6AAckUlz9p/ZaJ28LNs+FHXSxcQu8RBjsa3ScBIl2Ao+0J90maWz0P0Cn1nx1U
         JneEJmcEuQAnNifihjKCvD43z6i6TTKGd4PIPSTCSKvgLQAmUj+UE7Vzkzweic0f6zWB
         mtslZ4wp8vCaVXDF4Ys7HgDZzEBpx4TpaFGFhIGpZIKwaheDYGUMl4ELSbNSSItvyYlC
         RonywFCX6oG0j+7RKbkkGWcIP6uZ5ETtb4x5HBDCys2wT9N6/KRMCuaMlUCczjPKb/Fz
         3nJg==
X-Gm-Message-State: AOAM532BnqdBZFWKFkZfMbBCxXUhni2QKitLIPDD4FHJISqcMDEhdO4J
        XxcCbzqeP8jgqw6D/qYst/Q=
X-Google-Smtp-Source: ABdhPJwXG49Sscql4SppnKXa/4t37CzBESGx5SHQecg0R3zMcabaISwnzXoArRJPA2Dm05VhGZi9cg==
X-Received: by 2002:aed:306c:: with SMTP id 99mr7906282qte.352.1616384926341;
        Sun, 21 Mar 2021 20:48:46 -0700 (PDT)
Received: from ArchLinux ([156.146.54.190])
        by smtp.gmail.com with ESMTPSA id p66sm10315108qka.108.2021.03.21.20.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 20:48:45 -0700 (PDT)
Date:   Mon, 22 Mar 2021 09:18:34 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     corbet@lwn.net, sir@cmpwn.com, gregkh@linuxfoundation.org,
        lee.jones@linaro.org, bp@alien8.de, huawei@kernel.org,
        krzk@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
Subject: Re: [PATCH] docs: submitting-patches Fix a typo
Message-ID: <YFgTkhA+IOvNVxEn@ArchLinux>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, corbet@lwn.net, sir@cmpwn.com,
        gregkh@linuxfoundation.org, lee.jones@linaro.org, bp@alien8.de,
        huawei@kernel.org, krzk@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
References: <20210322033000.2523887-1-unixbhaskar@gmail.com>
 <20210322034459.GE1719932@casper.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GmQJ6FDyuF2z6iQR"
Content-Disposition: inline
In-Reply-To: <20210322034459.GE1719932@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GmQJ6FDyuF2z6iQR
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 03:44 Mon 22 Mar 2021, Matthew Wilcox wrote:
>On Mon, Mar 22, 2021 at 09:00:00AM +0530, Bhaskar Chowdhury wrote:
>>
>> s/mesages/messages/
>
>did you test the build afterwards?  you forgot to do something.
>
What are you talking about??? It is going over my head...why the build
reqired?? A spello needs a rebuild???? Wondering....

>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>> ---
>>  Documentation/process/submitting-patches.rst | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
>> index 91de63b201c1..8b2676527b7e 100644
>> --- a/Documentation/process/submitting-patches.rst
>> +++ b/Documentation/process/submitting-patches.rst
>> @@ -679,7 +679,7 @@ generates appropriate diffstats by default.)
>>  See more details on the proper patch format in the following
>>  references.
>>
>> -Backtraces in commit mesages
>> +Backtraces in commit messages
>>  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>
>>  Backtraces help document the call chain leading to a problem. However,
>> --
>> 2.31.0
>>

--GmQJ6FDyuF2z6iQR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBYE5IACgkQsjqdtxFL
KRVdNwf9HGqh+7YQ698oo8FnSWty6r+LJsls9IGAWlIi18Ub6163loqRdro2HZPb
qjgGl4hzVsFV9ibylM/l4d0r7IK5vcKGHh6EjJ61muwceMUh4SM+5lh8gTSRDJA5
0tipyqMAG97oTWzW+4yKBeyrDtXbLgxoiKZ+6T3M+AR/nkBS5JMP1r5hgxgyKReQ
MW+fJsDmhWL5szsVmc2FjSg68jzrmUnHq3bULmWZo5IX1qw1SzlEYr+iktYkrZ2M
cUs6nDEMvQZIbNNUKSxu/S7QJRCr7NjBl6mdkiw+97QvIInFvuWIcJ03s4Z+VJpx
PVgdsEGr2DFS5WICoeDNpNs2p1foyg==
=WhA7
-----END PGP SIGNATURE-----

--GmQJ6FDyuF2z6iQR--
