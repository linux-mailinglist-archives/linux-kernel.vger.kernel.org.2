Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4395E34995A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 19:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbhCYSS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 14:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbhCYSSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 14:18:16 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B99C06174A;
        Thu, 25 Mar 2021 11:18:15 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id h7so2386577qtx.3;
        Thu, 25 Mar 2021 11:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=LAlhghiYAQdF1ZeVykS90mEP5fU8MsPbtOd43fGe81o=;
        b=QmLTNedXYulGed8Q9vmYpLLGfyXgM4EuiVWcN1DrY1llt7DfjHsx/pmpASbKLxlAOh
         siSPTR8ToAhRfr/m9GZ+U1g30VTQ/j2/ogTdTtf7oR21leSTpof+vpAdo6/jgDwMnSj3
         71bJfn4ZkND/Hqdqe+L8kHUktBYEx5r7WOZolW8WzGGEg2+BWh0TKWgtKOaXNCy/44C0
         fxNnTvC/VuvtZTurNJnAh/HBBAx3TwejHbSA3X6xm6JvUuo/VgOX9eK51Bwq2PLpO4ji
         mKi7FS1rDQwERR6pMHa+V+ucV7vM96kfjhwsraZqG53+fCLiZcWOrWqGcBKSjaDW+HCI
         vOMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=LAlhghiYAQdF1ZeVykS90mEP5fU8MsPbtOd43fGe81o=;
        b=fanyPLdBZ+YtXvfMwqyXLJTCRO637GOBU6vY2ZI4tokiYs+FJZrV4oOi1LzRSmc27Y
         a0DJa4qVsAocXtNR9YSq2T1hRyuNSRoQwUA1Au8qGMp5vgd6wDo71FmLCpZJR0xFMAyG
         kCA0b1RlVxjcLNN/IXD8DwDndRJISXWBjVSTDQ8rprVgeYL/0l6W/SEK5sxuhqqeaA26
         gvwzDvnNiIrEvUqXryJnJ9bE216v64Fq2rF1YwV3D6XxiYnimBh4AfhR0gxEzJY3obIe
         XP9UAHlkuEPboe+Qr4K49e58UokOlr9qn2RAQToQHBBCdjCYlAmW9wow6OMh+UK/CCqw
         n9ew==
X-Gm-Message-State: AOAM531ez8zXSUBDZn3p5LJmPRicn0QceC038y0oeih93gN4sItmoZzy
        88Ix+5thjYxTh4jnnzu/IJaY1RRNIjBMpPRT
X-Google-Smtp-Source: ABdhPJyYN5DDjmsIs1uMwA1jClPu+viWhzn0pCMzqKGh/VlrGdxKDWkcaBHkfbtYIEkO4sZk//5t8w==
X-Received: by 2002:ac8:7215:: with SMTP id a21mr9096103qtp.199.1616696295025;
        Thu, 25 Mar 2021 11:18:15 -0700 (PDT)
Received: from Gentoo ([37.19.198.30])
        by smtp.gmail.com with ESMTPSA id a14sm3972065qtw.80.2021.03.25.11.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 11:18:14 -0700 (PDT)
Date:   Thu, 25 Mar 2021 23:48:07 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Subject: Re: [PATCH] docs: sphinx:  Trivial fix of a typo in the file
 rstFlatTable.py
Message-ID: <YFzT3/sLrrBrZQhE@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
References: <20210317102056.3003768-1-unixbhaskar@gmail.com>
 <877dlv15hu.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uwfhAObxCzy0VF27"
Content-Disposition: inline
In-Reply-To: <877dlv15hu.fsf@meer.lwn.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uwfhAObxCzy0VF27
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 11:57 Thu 25 Mar 2021, Jonathan Corbet wrote:
>Bhaskar Chowdhury <unixbhaskar@gmail.com> writes:
>
>> s/buidler/builder/
>>
>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>> ---
>>  Documentation/sphinx/rstFlatTable.py | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/sphinx/rstFlatTable.py b/Documentation/sphinx/rstFlatTable.py
>> index a3eea0bbe6ba..1d2b9be6b6c5 100755
>> --- a/Documentation/sphinx/rstFlatTable.py
>> +++ b/Documentation/sphinx/rstFlatTable.py
>> @@ -161,7 +161,7 @@ class ListTableBuilder(object):
>>          for colwidth in colwidths:
>>              colspec = nodes.colspec(colwidth=colwidth)
>>              # FIXME: It seems, that the stub method only works well in the
>> -            # absence of rowspan (observed by the html buidler, the docutils-xml
>> +            # absence of rowspan (observed by the html builder, the docutils-xml
>>              # build seems OK).  This is not extraordinary, because there exists
>>              # no table directive (except *this* flat-table) which allows to
>>              # define coexistent of rowspan and stubs (there was no use-case
>> --
>
>This was fixed in your previous patch from March 2.  Bhaskar, please
>slow down a bit and try not to create needless work for the recipients
>of your patches, OK?
>
Apologies. I am sorry to cause pain to others, this was not true intension of
the trivial work I am trying to do.

I shall be prudent in the future. My sincere apology to gobbles up peoples
time.

>Thanks,
>
>jon

--uwfhAObxCzy0VF27
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBc09sACgkQsjqdtxFL
KRWRfQgAxtlSUDaK3PRwydBMzegQn6OqiSVYMtsjm3MTxnxmOMrD7XyGK2Hf0aYC
1Nf8shTMtygZcL6nmhBB20azXxu3WjdYFGzfKVxXp7q4c5tiLfiOkRGSYAApf6d3
fj+KDwmSUPKw1Zhd2BznRVZRSakng5iz4mcGzF5IknLEYPh4io3AfY8dep4mbvxE
jPya3W/AnK2dMcgm2cwE5oYc5QG9qMeyUGdUIk2XrWfxdxuA1b9Qslgv+9Rb1nNH
XtTRcoTp+HzMPnGYyLE/m9Y1IRxvgd8ICaSoicGoRxMoE2xVKZ4pXPKSHvTNngem
2v1YAtRvAS3UfjRiwqh0RjIwRGcxGw==
=y58k
-----END PGP SIGNATURE-----

--uwfhAObxCzy0VF27--
