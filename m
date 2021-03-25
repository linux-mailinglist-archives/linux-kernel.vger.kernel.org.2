Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11EDD348511
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 00:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238953AbhCXXJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 19:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234723AbhCXXJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 19:09:40 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD20FC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 16:09:39 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id q26so45390qkm.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 16:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=cuOj5//9riQXrPV0AOArTf2D2hzQCDXJelqtkIQ3CS4=;
        b=Dq8ykserwOD6vHjFVyUbjFISKppu2VCHryCiVU2plJN1BX9YcV3VmAIlIlTWIB2teT
         my8Mu+S+XLFbrJdCp9Payj6xXq8NeBhlM18bm0ZcG3Lnx0vafuorUPU0BxXrV+D7dV1k
         hnLmPTGZCf1kmFJYXaNbAeWfSyCSSTFjSmxxfLU1vTjbUbxcgItxDyOaoF/q2HGPYOYR
         HBY03TZa4K7uh9dIx6ywRcwIV8yBEN3qGgkVn5lrLmxeU2EjCU1AnHfAgMg7bNKF6dLZ
         67QjajFhiWzWEkE5xEFSF1LMSLQfIL1OcdiFf/htLO3+W4/VrUoTKO5Nzwfour4Q8y5G
         JxMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=cuOj5//9riQXrPV0AOArTf2D2hzQCDXJelqtkIQ3CS4=;
        b=htrpJNr+HJJVj/3w9oOvTBxepmvD/NfT9eNQzbD7kkHJhIbDn4Jz6xtlSJSr2ULxGy
         AW6l3Lw3WNr/oR1tMAzK9mSbYCzXZ/4daJ05QsPDrkMBlEaL7OGHZ6lRdkELpULxgIf2
         2UuAdxPxKsDw0KCgpObWoXGg13BMiKONX5PicOkW4wqbShhFozPr0taV86RXWctf52RS
         lKMXcqN2ChbNNXqtXhn4GGtzHrwtijZa0SoxuLhJbiyQmbVIflIzyHjRf2DOjqEN+Aie
         rEneX75LkcOlKrWai+DaoX63ppjeFfOHe7+ebtHp7Qc2fB/to07xBsJcbsj77/u96ywI
         +CRw==
X-Gm-Message-State: AOAM533B/mIDbWuhlPFxJC7aorsxtT4z/fI/8XWWSX0Mi8Zb/BmZ3zzH
        hY8JZk34Kavi/le5neFveLZ3ZgblUejGjbO7
X-Google-Smtp-Source: ABdhPJwH5VYmja6bELjKhI250JOH0T6FUwOYJCtXm5RsZa+5LFw0byBP9fCRBofE+B7zkIZH+5z40A==
X-Received: by 2002:a05:620a:14f:: with SMTP id e15mr5429307qkn.315.1616627379109;
        Wed, 24 Mar 2021 16:09:39 -0700 (PDT)
Received: from Slackware ([156.146.55.193])
        by smtp.gmail.com with ESMTPSA id z24sm2865453qkz.65.2021.03.24.16.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 16:09:38 -0700 (PDT)
Date:   Thu, 25 Mar 2021 10:09:28 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     David Rientjes <rientjes@google.com>
Cc:     cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
Subject: Re: [PATCH] mm/slub.c: Trivial typo fixes
Message-ID: <YFwUAGytY+/9bqZn@Slackware>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        David Rientjes <rientjes@google.com>, cl@linux.com,
        penberg@kernel.org, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
References: <20210324130619.16872-1-unixbhaskar@gmail.com>
 <8a21e996-93f9-d22a-65b9-4bdafc43b36e@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Nb6rbk1WH+Fwfqhe"
Content-Disposition: inline
In-Reply-To: <8a21e996-93f9-d22a-65b9-4bdafc43b36e@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Nb6rbk1WH+Fwfqhe
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 11:49 Wed 24 Mar 2021, David Rientjes wrote:
>On Wed, 24 Mar 2021, Bhaskar Chowdhury wrote:
>
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 3021ce9bf1b3..cd3c7be33f69 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -3,7 +3,7 @@
>>   * SLUB: A slab allocator that limits cache line use instead of queuing
>>   * objects in per cpu and per node lists.
>>   *
>> - * The allocator synchronizes using per slab locks or atomic operatios
>> + * The allocator synchronizes using per slab locks or atomic operation
>
>operations

Thanks..V2 on the way..

--Nb6rbk1WH+Fwfqhe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBcFAAACgkQsjqdtxFL
KRUjyQgAizd8ZubhIzA0IV+JSW9zwO/chPRXez6PgaWGaBCg69GlXKw9wHSnBZzJ
7eU3EtLkog4V+6tBuMfngjSB1cnhCtA+urVIL0lZIdyggky8h06pEdjK9Auxr0Iq
LSQztArHcKBNp07yVSb2MT8thHeIRBhFgk4//aZLAgmOWpM/3+3qP4coyzPDnywY
gsm6yTYC/drhXV5gj3xbOz0vuuoZhZ+NjUpK6EJtcSEo3BD4ENMw8IfjAHArwPSu
M2L87JgZlyvlZHwTyoR5UtAH02g5dKB/UrwLxF3rPgqkWIGNMFkmmy6uDt2JL7Yc
oxJ+mPLZ4ttYp2IOEpfaRdcacFM6NA==
=rFhS
-----END PGP SIGNATURE-----

--Nb6rbk1WH+Fwfqhe--
