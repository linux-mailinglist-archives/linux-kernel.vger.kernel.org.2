Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9923151C2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 15:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbhBIOf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 09:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbhBIOdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 09:33:52 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C46C06178B;
        Tue,  9 Feb 2021 06:33:12 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id z22so13044974qto.7;
        Tue, 09 Feb 2021 06:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=fAm7IYlzcPxcyIGE7fbs6JaVUzixxWFM8O5XHRLso0g=;
        b=ZKuZmT0HezCXrL5m/xqZS4qlsuzUMhblsTUWCxX5/+8jtkH5xRIIWQW0oI98yBSJy5
         MfQpvFh1+uOhKTjM6EVkes4lUI/29Ns4V17uzg0LImBVWYKIilA63IdkBqxYXxoZsLAE
         p4jYCSxmgkD/hjNFnQ0Ey7KE/33/EmkNvywzCQefXuAeG+wnHNVy6Z2F6cKbUWEKxLJH
         ZNeZH7DvXvewkvjHna6aBt+VBbq60yid3pdKSPawBmPT/D8KKGDBerKCqYn/hmIS40fc
         VVX/wbLqXY2p5My/E3FL0OW6g5PpT4sAKCzgXjhJpej9JM5kCs59bkylC0hkmDkR62aZ
         cTlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=fAm7IYlzcPxcyIGE7fbs6JaVUzixxWFM8O5XHRLso0g=;
        b=l+x1TqiKEHNOcfTgo8lBqQSXIledEocNkQVUrehkhsKob5thpmliKxbYI6rE/Dfl5s
         F0jmKhS6mbwMJGburmFs0b9NYFlqBWdUOsrEmz3Odk55RSTSA3WzIvL5Do9pZ2jk6uFQ
         YoGsY0b3ZwpNfHIqbhd/D30bvOivPfIwFkKjVcL4SLk6Havq7rdu8O+cD15m5Wn+BGJ3
         gD6vswlZ3kvXYUw1KnRtW2w5uXjYQXAlfIJH5AT1U3weZDjVossIE+k747KMbd0xY6uI
         CO/m8Vpsgj1zFyevCnaGLfS4Y7sDMpVfffJXPboIssu1l+LcdgW1sKh028lwPFZqMu/B
         E0hg==
X-Gm-Message-State: AOAM531st3WlyGXCfgo+X96F7gSxrQdayryrhr5Ia0sDXT+HT6UtjiC9
        z0UCK1dFN4DlJoL9m0SjrEbfgyQhPtEVcAvl
X-Google-Smtp-Source: ABdhPJxJxKs7kvB4lfgwSFO1sxxO9IFZMIlRafe4mrpnQgbjiaUo9DXSzvIuGtdGHh4VyazWw1jc4A==
X-Received: by 2002:ac8:1494:: with SMTP id l20mr20499808qtj.151.1612881191529;
        Tue, 09 Feb 2021 06:33:11 -0800 (PST)
Received: from ArchLinux ([156.146.37.186])
        by smtp.gmail.com with ESMTPSA id r4sm19121837qkf.112.2021.02.09.06.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 06:33:10 -0800 (PST)
Date:   Tue, 9 Feb 2021 20:03:02 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
Subject: Re: [PATCH] docs: maintainer: Fix the spelling mistaeks to mistakes
 in the file pull-requests.rst
Message-ID: <YCKdHhV1LZ6tsii4@ArchLinux>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
References: <20210209140155.3890715-1-unixbhaskar@gmail.com>
 <20210209142130.GX308988@casper.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/Wa9Npo/oMKrprps"
Content-Disposition: inline
In-Reply-To: <20210209142130.GX308988@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/Wa9Npo/oMKrprps
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 14:21 Tue 09 Feb 2021, Matthew Wilcox wrote:
>On Tue, Feb 09, 2021 at 07:31:55PM +0530, Bhaskar Chowdhury wrote:
>>
>> s/mistaeks/mistakes/
>
>You missed the joke.

:) it seems!

--/Wa9Npo/oMKrprps
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmAinRkACgkQsjqdtxFL
KRUhZggA2nuZx654smDQ9H9jvFj6khzbJ6UsZmkt5EfyeN7L2o/4GVC52Lp8NM5r
LvzZ1n5/bH7rTD4g++6idu8nksDNf4S7NoNmFFyW+VNh/Qrb+b5usJ5BXLu7K3ce
DdeEva/Kshx/xEwGh6ib2EeVKCoM17TQOMEGCb0Yu/f2Eei+OuByRmJeMoX9CRKT
QUiZAp+3wCAPjNV/idRgUQ68ffJe9TEjNT/KUhQYorp661IgQfZKwCvErIqYiIQV
uT1dTRr7vwnN0IPXdlh45PlwnnYQroozojQwLSZ++FkphIIRalHb86i69BUE6iW2
Wg2rAspS4Zq7h5q0TvwlxotoQeTYxw==
=DUzO
-----END PGP SIGNATURE-----

--/Wa9Npo/oMKrprps--
