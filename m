Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 284F031177B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 00:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhBEXyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 18:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbhBEODj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:03:39 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340F0C06178A
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 06:02:59 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id 19so6922325qkh.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 06:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=GLu9lg4ZbAu+RURJjhT4bU73xZ0HG2hZgBOTmZEyXxk=;
        b=ggpk5NUzB8TU5aNXclxcJHxzxliHqTlzlusLPQCja5Gp+PFXaOgj97QTy1k1pIlZ/B
         rw/OWgd9tNLonuF1T1ls/yZ2R+QQpO5d8214B4db6CSyvlc1jR2GB4aICbM4T91vtnHF
         3CD1bXFHtSgMOceUc0K0vGeBH6PRd9tVCTNoRTPyauO+5WDQ0hQMaoB77AVC837YNWsq
         48tJWUc76/zyanvhKXT5x9iO2gu6d2lgQsanBh7RhQBgVi5Ex+8IML4y8yCZghafoF63
         2dlnUjnk/r4LZjgfpBQsM9ELN0GMUnA2RsUfZPIPKd4LIyKiFbiLxy6qwz0vFT7Mvzpk
         m/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=GLu9lg4ZbAu+RURJjhT4bU73xZ0HG2hZgBOTmZEyXxk=;
        b=aa0rnCFpK3KqvnKfHm99lcrg2VzRslXJ02nhbty2KrWWr8VzgKm+YHCztMSMRLXeek
         i2zFVR1xcN91ytdI/q/oQoE674seUDEm470xFAbgVZhsEfhTd/qegXo9V6Tg2mDVKtKp
         U64uvdlcciTdXkX8XME1JoaPBnr1sYDi4uM6bFSacE+qwGNRC1CnfjHbOaIcuPPpNxh9
         jY+Papi4AjTQ5Tm9ciH4hg5PEjW9Y4Y2EeEbFb6tZAneHCKN410pR02SYLrbz92UY5va
         kf6HbL4SLTWt3abrLmpX/qXQBpwoIyODvs4J5ujM3Gc9rRyPAnkNnq5Ka3gwWg6Kqw6t
         MxPQ==
X-Gm-Message-State: AOAM533cgSKrEjUy9frrA8rsuA9oYxHnJxcmHW0w94ytu1t+0T5Svn37
        6T+CF/8+WvrNMm3dcBZdqXc=
X-Google-Smtp-Source: ABdhPJypgX8Dx+6q0k1J/qnJLpH/bLWvNJxWvDqgMSsmhqMj9EMAOwTyNZSvi8DrGocPFxDVK2OZQw==
X-Received: by 2002:a37:6507:: with SMTP id z7mr4246461qkb.26.1612533778490;
        Fri, 05 Feb 2021 06:02:58 -0800 (PST)
Received: from ArchLinux ([138.199.10.106])
        by smtp.gmail.com with ESMTPSA id b194sm8605469qkc.102.2021.02.05.06.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 06:02:57 -0800 (PST)
Date:   Fri, 5 Feb 2021 19:32:48 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
Subject: Re: [PATCH] drivers: mtd: Better word replace a not so good word in
 the file mtd_blkdevs.c
Message-ID: <YB1QCHGUdDptkP0M@ArchLinux>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>, richard@nod.at,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
References: <20210205124151.1386271-1-unixbhaskar@gmail.com>
 <20210205142618.116852a0@xps13>
 <YB1J53adyW4BBK3g@ArchLinux>
 <20210205145716.4083e083@xps13>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xEKPr6lbRHLv1sAw"
Content-Disposition: inline
In-Reply-To: <20210205145716.4083e083@xps13>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xEKPr6lbRHLv1sAw
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 14:57 Fri 05 Feb 2021, Miquel Raynal wrote:
>Hi Bhaskar,
>
>Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote on Fri, 5 Feb 2021
>19:06:39 +0530:
>
>> On 14:26 Fri 05 Feb 2021, Miquel Raynal wrote:
>> >Hi Bhaskar,
>> >
>> >Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote on Fri,  5 Feb 2021
>> >18:11:51 +0530:
>> >
>> >> s/fucking/invite/
>> >>
>> >>
>> >> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>> >> ---
>> >>  drivers/mtd/mtd_blkdevs.c | 2 +-
>> >>  1 file changed, 1 insertion(+), 1 deletion(-)
>> >>
>> >> diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
>> >> index fb8e12d590a1..756a0995e474 100644
>> >> --- a/drivers/mtd/mtd_blkdevs.c
>> >> +++ b/drivers/mtd/mtd_blkdevs.c
>> >> @@ -523,7 +523,7 @@ int register_mtd_blktrans(struct mtd_blktrans_ops=
 *t
>> r)
>> >>  	int ret;
>> >>
>> >>  	/* Register the notifier if/when the first device type is
>> >> -	   registered, to prevent the link/init ordering from fucking
>> >> +	   registered, to prevent the link/init ordering from invite
>> >>  	   us over. */
>> >
>> >invite us over?
>> >
>> >I'm not a native English speaker but this does not bring any value to
>> >my ears. Worse, I don't even get the point. Better rewrite the comment
>> >entirely than just swapping "fucking" with a random word, no?
>> >
>> Got your point , and I do understand "fuck" and "fucking" is so strong w=
ord
>> that it is really difficult to replace with something else.
>>
>> But..but you suggestion to rewrite the comments sounds good Miquel ...wi=
sh I
>> could have that much time in hand to replace every sentence having that =
word
>> ...all the patched sent with that word replaces...please step forward and
>>  make
>> and send patches .
>>
>> Today I sent 10 patches replacing that word(weather that make sense or n=
ot)
>> you can see those in the ML ...please pick up as you wish and send patch=
es.
>
>There are currently 21 uses of "fuck[ing]". It's not a mountain to
>climb. Nor a race.
>
=E2=9C=94 ~/git-linux/linux [master|=E2=9C=94]
19:28 $ search fuck | wc -l
15

>> I was simply replacing the word ..never bother about the meaning it
>> conveys..doesn't matter really.
>
>Are you kidding? What is the purpose of a comment if no one understands
>it after a blind change?
>
No I am not . But the sentences contains that word hardly have more meaning=
=2E But as you already said rewriting those comment would be a good idea...=
can you take up some of those??

>>
>> so...
>>

--xEKPr6lbRHLv1sAw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmAdT/wACgkQsjqdtxFL
KRU1hgf+MxLaFJXAVwby3LAb7iHwqYI6m9Z62etIZnm24hL6yjiZ6AHQMnA3hucl
eoKovogTUUeF3tY/R9f2/EYzVgO+Bfu9pFU7UP5kyO8XqxtsHvkvaf1TgF9a392Y
gXOXHMxKHjR2CUyS/tF/1PZQVuu8cEKvkF6MX0dQF9SRcsUsnwky6WZLVa9dk3az
0IxTsIWkbZKp+WfCDiiXJsnZzFSpV0OrQ4gSoQOwe/aHpky77zyOjoJr9/rvXF++
8mKXhKwpz6fTzr/aaLCkqs4xnrBNmLHQk3ftdrTLblxb2SxIklAreke3Rg4oTYO4
XRF6JX+CHS+BydUXfgNV8KQVdI0qKw==
=rldI
-----END PGP SIGNATURE-----

--xEKPr6lbRHLv1sAw--
