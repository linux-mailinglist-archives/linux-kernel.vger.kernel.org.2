Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E91DC329DFA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 13:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444446AbhCBCly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 21:41:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242409AbhCAT54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 14:57:56 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861A7C06178A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 11:57:16 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id z128so17845733qkc.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 11:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=lXeq5dWaonf0vSNjORgqOT9dZAuZMRMAyEZYrgDl07I=;
        b=N0D10E/FGL8mqa34bRtpKABMiGIZIUkCVxns9T5oR9P2WmPYzUBCsvX0wqB1Pdq5+V
         xYDHHIRtBMXeeMkIL985PAqVqUQilZ2SHSwBV/0i6d6B45nz1tEMgjgPFEWUw8GKqKAY
         /0qIEGFusSMIm964BeHRWMGZZr/hJnKKdlhx70gMTh79IzZRjDeu+diMDyR6prD4zfXv
         ZdxVYjhdKp1P0IYytOAEan1SjOvF9ZavbWUvIbymaoje2B4/ASqyrrkrIMqwhLc604eD
         0tAzZJW/JARDTY5+V5eoyHgKv6P0i+BiY46PcBON1+NH2XBm7osJnmOJ1Vd8OqNNygKD
         PUzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=lXeq5dWaonf0vSNjORgqOT9dZAuZMRMAyEZYrgDl07I=;
        b=XrJwZ4ax1mlTUmWwFpu5d4aulUdfNFQ+NoAhsE9nY6ZEq6sc1Q7nxfpM70Z2E8VqDg
         +zYyZY/eWPElGU8mJ297xsGws7gOgg5/suEdc3/P5RUM+vFRQbuw2zWppId2EdA5VbLM
         2QML85H1J2BhhEy6H6kvjR1Xjn5crFwCkmAky0CFgyXAwKpWJovdtGu3WJqnxMH16oY9
         o/5yfxSA5hCX/yyZF1PGhCjXpCX1o+8K3vIUgcMLRxvK63h2zJx9kxp1MVyrJrBpiOBw
         zgTaaVTjcR26bKo04TkxnjNAsjSN+v4ggubri1zrEq4LyDzKuZhwKrBsC+F7zUw/8MXg
         rhbA==
X-Gm-Message-State: AOAM530s7hweHTVp0bO5t0O2KCtIqiipDu2nmQnX1CSyl//UPgjZlnx9
        UAKqn9+SolnnI6Tfdn98HonQCf/+IGMBTw==
X-Google-Smtp-Source: ABdhPJzaLSzlnFuAm+40rRoNX1g3lsrF0jaJjtmmsRIfJU4URPt44ejm8PvR+13ebTe9aDsbNmz12w==
X-Received: by 2002:a05:620a:13ec:: with SMTP id h12mr5768219qkl.460.1614628635801;
        Mon, 01 Mar 2021 11:57:15 -0800 (PST)
Received: from Gentoo ([156.146.37.135])
        by smtp.gmail.com with ESMTPSA id e20sm5223494qtc.61.2021.03.01.11.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 11:57:14 -0800 (PST)
Date:   Tue, 2 Mar 2021 01:27:05 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] include: linux: Typos fixed in throughout the file
 lru_cache.h
Message-ID: <YD1HEa7fC458qikn@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
References: <20210301130258.32077-1-unixbhaskar@gmail.com>
 <ea27072c-e17e-8b55-24ca-7f41db597c3c@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Orp1ag/7j96iT0/c"
Content-Disposition: inline
In-Reply-To: <ea27072c-e17e-8b55-24ca-7f41db597c3c@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Orp1ag/7j96iT0/c
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 09:04 Mon 01 Mar 2021, Randy Dunlap wrote:
>On 3/1/21 5:02 AM, Bhaskar Chowdhury wrote:
>>
>> Few typos fixed throughout the file.
>>
>>
>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>
>Acked-by: Randy Dunlap <rdunlap@infradead.org>
>
>but no maintainer Cc:ed to pick it up....
>

None showed up ...except this :

=E2=9C=94 ~/git-linux/linux [patch L|=E2=9C=94]
01:24 $ owner include/linux/lru_cache.h
Bhaskar Chowdhury <unixbhaskar@gmail.com> (commit_signer:1/1=3D100%,authore=
d:1/1=3D100%,added_lines:4/4=3D100%,removed_lines:4/4=3D100%)
linux-kernel@vger.kernel.org (open list)


get_maintainer.pl returns those.



>> ---
>>  include/linux/lru_cache.h | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/lru_cache.h b/include/linux/lru_cache.h
>> index 429d67d815ce..f65c6734be3c 100644
>> --- a/include/linux/lru_cache.h
>> +++ b/include/linux/lru_cache.h
>> @@ -32,7 +32,7 @@ This header file (and its .c file; kernel-doc of funct=
ions see there)
>>    Because of this later property, it is called "lru_cache".
>>    As it actually Tracks Objects in an Active SeT, we could also call it
>>    toast (incidentally that is what may happen to the data on the
>> -  backend storage uppon next resync, if we don't get it right).
>> +  backend storage upon next resync, if we don't get it right).
>>
>>  What for?
>>
>> @@ -152,7 +152,7 @@ struct lc_element {
>>  	 * for paranoia, and for "lc_element_to_index" */
>>  	unsigned lc_index;
>>  	/* if we want to track a larger set of objects,
>> -	 * it needs to become arch independend u64 */
>> +	 * it needs to become arch independent u64 */
>>  	unsigned lc_number;
>>  	/* special label when on free list */
>>  #define LC_FREE (~0U)
>> @@ -263,7 +263,7 @@ extern void lc_seq_dump_details(struct seq_file *seq=
, struct lru_cache *lc, char
>>   *
>>   * Allows (expects) the set to be "dirty".  Note that the reference cou=
nts and
>>   * order on the active and lru lists may still change.  Used to seriali=
ze
>> - * changing transactions.  Returns true if we aquired the lock.
>> + * changing transactions.  Returns true if we acquired the lock.
>>   */
>>  static inline int lc_try_lock_for_transaction(struct lru_cache *lc)
>>  {
>> @@ -275,7 +275,7 @@ static inline int lc_try_lock_for_transaction(struct=
 lru_cache *lc)
>>   * @lc: the lru cache to operate on
>>   *
>>   * Note that the reference counts and order on the active and lru lists=
 may
>> - * still change.  Only works on a "clean" set.  Returns true if we aqui=
red the
>> + * still change.  Only works on a "clean" set.  Returns true if we acqu=
ired the
>>   * lock, which means there are no pending changes, and any further atte=
mpt to
>>   * change the set will not succeed until the next lc_unlock().
>>   */
>> --
>
>
>--
>~Randy
>

--Orp1ag/7j96iT0/c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmA9Rw0ACgkQsjqdtxFL
KRW6xgf+PSkozVvF1vWZsAfEWiwm03LksCXJQ8eDGF/MkZ4nG0vTLOnP7dtRlIYD
6cefJFd1Z/da7YEVmVsa/QpdzIi8Zk2RpoYXoIpRzUcT5oPAGBrLjAQl5OT5X6pb
7+vDN2+lWvTiW5QxB3RJDLjU7EtWawmvMsyee6zhCDta6J077+nLk61k1u2mkEL0
c2XE7qnSMJEkCwow1emEWGVgBpOGvb065IOBvt6AA9Cu+jBvAB+kj3xWry3oxZC0
1jUHhR5Tck7YiDd6h3aIz1JR4lKuBR82nUP4Ejr3usO5ZTl7ImeNKsv6+wQZ+2ha
iHG+/lf/E7m5JmDCFq6VrDziyfKy0Q==
=lsTp
-----END PGP SIGNATURE-----

--Orp1ag/7j96iT0/c--
