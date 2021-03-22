Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28AC734504D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 20:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbhCVTvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 15:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbhCVTvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 15:51:23 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A32C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 12:51:23 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id g15so11931051qkl.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 12:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=MYscncn7bZn1Z+8X1ehgy/OBYdwKEuqCWFhBIrPSGB8=;
        b=VMPXEo9r7gMHIUNl/uo/+tvolz7ZMWjlds5ONa4oiOL3D2M5pbxh2cSdhSK/DvgBu4
         28//yMGslr6IvfhBN+ZPSbInADRflacpeVlo+owA2bWU0nviLoueS6FeV3hE332qFjTs
         rwLFCCEhSjs2DgoIIA4RSjpqybbTexj6g4ZYzMkjWhpXNPYhA+373sPyK805WlOmpg9l
         3XKE+ImfdnBfTeNRXGa/IkzzDcJff3Y6aOF9IvEuAPtyR/o6bAB6CTD2aaRw4fAoZlwx
         T1LrkFCU43t176r3DXjNEWFmTuRWN2NKJ6i8cUzK4sClnZVzXJO+FA5F9r/VI9Lyabyi
         D9NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=MYscncn7bZn1Z+8X1ehgy/OBYdwKEuqCWFhBIrPSGB8=;
        b=nULz7F5gIPlpuF9Wd1yg8yWvFYeFCVkn/RcXg8H6IxuFsi5OjJtufvaa51qPgbXKbV
         6txyy0APdR7TNm/yM40OfA0k6DsPKrWEPsPdUfwHscwIap6GlOD9W+/omuVJ+VKHfbWR
         ceMLQCmZqi2TRYaxJXQLdTvU0MMB8v2k27wULcKMXWze5osr91p7+UfGc+EOyHuGABgd
         A3gVWPR9T9MPexdwnrn6xuXCN7QoKBNV8CWui/JNq9ZU3szxg4d/AX6uNP6G4kwcokOE
         aWGSLnD0ABNXYn+vFrsFb5MXqIFonPIO4UPxmApU+TTbI91ulzNBKZ0VyAeVR7lQI5zr
         Pr7A==
X-Gm-Message-State: AOAM532ui4WhPm6brgNpH1D7AfyR6tl5RUtToBU8HVukIXPYFxBvRJk9
        wa8frdU7vacdnx2SIP9tFYg=
X-Google-Smtp-Source: ABdhPJx5EReLVNQDaaUoPQKOV2t3J3Hsn9rNA/sZzJNjxOuuB8lpkkQKYSapiL/kfM8Lz5XZRZmrPw==
X-Received: by 2002:a37:d17:: with SMTP id 23mr1760376qkn.191.1616442682424;
        Mon, 22 Mar 2021 12:51:22 -0700 (PDT)
Received: from ArchLinux ([138.199.10.68])
        by smtp.gmail.com with ESMTPSA id f9sm9721890qto.46.2021.03.22.12.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 12:51:20 -0700 (PDT)
Date:   Tue, 23 Mar 2021 01:21:07 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     vgupta@synopsys.com, akpm@linux-foundation.org,
        keescook@chromium.org, shorne@gmail.com, walken@google.com,
        viro@zeniv.linux.org.uk, jhubbard@nvidia.com,
        daniel.m.jordan@oracle.com, tsbogend@alpha.franken.de,
        peterx@redhat.com, axboe@kernel.dk,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Subject: Re: [PATCH] arcc/kernel/process: Few mundane typo fixes
Message-ID: <YFj1KwTBcCNh6xYm@ArchLinux>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        vgupta@synopsys.com, akpm@linux-foundation.org,
        keescook@chromium.org, shorne@gmail.com, walken@google.com,
        viro@zeniv.linux.org.uk, jhubbard@nvidia.com,
        daniel.m.jordan@oracle.com, tsbogend@alpha.franken.de,
        peterx@redhat.com, axboe@kernel.dk,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
References: <20210322125155.3401540-1-unixbhaskar@gmail.com>
 <20210322132314.mtky3gx2oqqucoob@wittgenstein>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="55xydjBtY3xHGVoL"
Content-Disposition: inline
In-Reply-To: <20210322132314.mtky3gx2oqqucoob@wittgenstein>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--55xydjBtY3xHGVoL
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 14:23 Mon 22 Mar 2021, Christian Brauner wrote:
>On Mon, Mar 22, 2021 at 06:21:55PM +0530, Bhaskar Chowdhury wrote:
>> s/defintion/definition/
>> s/succeded/succeeded/
>> s/commiting/committing/
>> s/interrutps/interrupts/
>>
>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>> ---
>
>Since you aim to be mirroring the path arc/kernel/process there's a typo
>in the patch subject :)
>s/arcc/arc/
>
Thanks, will be careful in the future.

>otherwise
>
>Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>

--55xydjBtY3xHGVoL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBY9SsACgkQsjqdtxFL
KRXF6AgArySyuCmPI1K58rXuFNOJezNjLDKA01ecnzbob7pHvUKiBHV1o6+ulJFv
fzaXEb9wNOOKH9NGw0t0NcMHRPSNWLZW0cHyKnV1bGOIwzH0YdsFaBIRybernRnu
hr+xfYBKqQMN2LxcMLFQ+bv0ssWauHvYFWwGKSUveUI6Pcdpb8fkU0jl5jCOVyR+
cDIs2Rw5mJYhBZJU1dHZCZr6IlXjC79AGdpVnXSjb3u1Wlf6i2zUJCjCp3Ekp+tf
z7frxqE940UWz1/ccEdsSoy2hhcMnDRFO9xWVI0tdNV0TK7vfig6nKG4ayYfBt79
p41CGI4rI+cI4OuLSbARnjuP2zB0HQ==
=8a55
-----END PGP SIGNATURE-----

--55xydjBtY3xHGVoL--
