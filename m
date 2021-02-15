Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D929231B400
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 02:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbhBOBkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 20:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhBOBkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 20:40:20 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F275C061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 17:39:40 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id g24so1415655qts.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 17:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=B6zq0vzXYaRhnHymKxrHNMxtbCbINXUZGSwr8/tH3hk=;
        b=ohKlX0z+sOw4HZruokG92Xp39qB+FaAzvvdEP097+XH3lKG6koi+5kM+2YNiGhiCVM
         VMUaqELW+bvgYhQpo6SUf/8INhK56Izv8AlZU6ttbLf/dLdMqlWnZB6iWX+9cfhqrhCv
         UqxH2htE2+xwe/fMDiKyBhF2aVGzHSRz7KcHvrFG7BEQWshglJflMRIdco9Y3g6AB8nf
         wsPLo3dJmtR+LySQU/YlQvcX12vht1MK0C+Sm2Wv3VM52mtADZnCkQWAwcZKxJfcvgcx
         Anem7FxQd1VvdYLq0yfXFeBqT6XvNb3eHG0OGMlPpdMqRQW/vh6p5BzNS3lkeADxuPH0
         w9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=B6zq0vzXYaRhnHymKxrHNMxtbCbINXUZGSwr8/tH3hk=;
        b=t9m52G/0d3Gg53SH6AZgH5hg/+sQUO+VqZr4C0LlF7WK3BP7ahfUoBGD183ZzIIfBo
         qdvgQV6u0egirMoPRU8x0uhpYjBndMcSmQNNWc+88doQcELh3VZ+H+SWJA11IKi7kZEZ
         wB5LVCKCr075ncYDs+kWEQ82b/yNv4EFZKyT2bLM7edr364k3ZMg6KFi4UdMm7m1IiJM
         6KbkschKWM/nKVtePpFRmQQ3kpICZTLQSZ4615uUUpcoBma2BR9btibylR8FY26ZuBh0
         8OGMN6zxJLKm8kiHCtHIeTGdWWAjz4dvAli+Lz9lL7hHHHWj6uWalZmb2Q+LiJOoeHqW
         SmuQ==
X-Gm-Message-State: AOAM53003t0Hk50S7TKJ5yXIb3KV/ZamDEGd3qtbQMs/1jv/F4QCvFMN
        W6LpHqYGi7MG9slRMv88Gsd/LzznHs3QlA==
X-Google-Smtp-Source: ABdhPJxPdPL29rlxI6KNvEDYiemM2oJFW2wr79qd81WaL4gMo2nk/CgzAgAT0D26A7wHGgf8rJTFdw==
X-Received: by 2002:ac8:1c92:: with SMTP id f18mr12509904qtl.234.1613353179426;
        Sun, 14 Feb 2021 17:39:39 -0800 (PST)
Received: from OpenSuse ([138.199.10.7])
        by smtp.gmail.com with ESMTPSA id q6sm11060582qkd.41.2021.02.14.17.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 17:39:38 -0800 (PST)
Date:   Mon, 15 Feb 2021 07:09:32 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     jlbec@evilplan.org, hch@lst.de, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Subject: Re: [PATCH] fs: configfs: Fix sentence with a better word in the
 file symlink.c
Message-ID: <YCnQ1Erq6XhEnSSN@OpenSuse>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>, jlbec@evilplan.org, hch@lst.de,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
References: <20210205123235.1365780-1-unixbhaskar@gmail.com>
 <YClDypipbJHTvhyJ@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="q3IEkXq9SugOhH4Y"
Content-Disposition: inline
In-Reply-To: <YClDypipbJHTvhyJ@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--q3IEkXq9SugOhH4Y
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 15:37 Sun 14 Feb 2021, Al Viro wrote:
>On Fri, Feb 05, 2021 at 06:02:35PM +0530, Bhaskar Chowdhury wrote:
>>
>> s/fucking/wonderful/
>
>NAK.  For one thing, your crusade (pardon the obscenity) is idiotic.
>For another, in this particular case your attempt of improvement
>changes the meaning to nearly opposite.  "Magic" here is no
>compliment - read the comment and try to understand what it says.


As expected Al, you are spot on. I will improve, honestly.

You haven't read my other mail ...it should be lying somewhere in you
inbox...that contain enough clue.  :)

Thanks, man!

--q3IEkXq9SugOhH4Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmAp0NAACgkQsjqdtxFL
KRUW8ggAjIKif/Hp5TM04N1YgFmPmz2tdaQpVYXOX05IQsgD1tfQsBa+TsqpXboK
sK/N029902g4wOIYnqCOdrxGIAKtpO+XVvvwuLLcNkH4TforLo0AHN7AvZhp8hBW
BQbFBGi2MN41zAWEcGp9Wh0tfR+vnR5YqAqe+X9qcvxvgOEGgbA14XDQKiOLer4U
vgAC5c6Ta9Mld1RzrMOvXf8tlCas0E0j0GYPsKgTFhjUetInBqRx9jjbl3tSUiXP
Zv/gw+9RqMd5oAKiKw3at9ak+pXP5mlLJ9w2eFVs32cWFKRcHEy0mQgwHPWJ45OZ
59sBwwZvLlYTBW7URbRpGc3BPTI2Pg==
=6bQ3
-----END PGP SIGNATURE-----

--q3IEkXq9SugOhH4Y--
