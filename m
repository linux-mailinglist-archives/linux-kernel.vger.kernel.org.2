Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF02F33FB72
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 23:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbhCQWpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 18:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbhCQWpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 18:45:22 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E37C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 15:45:22 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id o19so2308953qvu.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 15:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=uJa/6pXTw6/CAv4WIT8j9OKwQQwr0MLgOLjANEhGySs=;
        b=aN9WByi2PNfl8mRCm2Io96kKO978y75Pm9z6VOoKa1DdUNGFTVhgF25Dn31vTbx6nL
         Mg2NH6xAvao7Zo9+fO8kWcK9TWVdMqRm9rofzWAkp2Nk2QUw7th9dl7P+aJsUVJfZkw/
         3t0v2eicFACnlFPgZYEMuGjyLwsO3JEMTuSWhNSU5Ik6gVJ0kmi29BVOTj6PQxpwZnz1
         fT3ozKIxc1ubITNOJOxYsSl4nJ6JcRXpxGu+Rk/vbrHXkJpNrlUq4u/9bDfHCRCr2gkz
         n4FKgasdfIMbgjyMjC9zicpg3bzwzGkaFwKYJq7zoW1JLZnDtsetd4YwMCT5y5tchlwb
         fllw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=uJa/6pXTw6/CAv4WIT8j9OKwQQwr0MLgOLjANEhGySs=;
        b=AEdu9AXP3ZqAidKjYj4JZxQtYK3iemYg0iZhmg+Xw3DbSZAeFMfIT6cr8HK6BbZbOw
         P4QdGCHeU1ErCdM/KQsZ/Imlfqng0mHnNKd/JZS5yqoB3iRXK3jlcGmmX1f+pRn+O5vR
         LF25vx3aVyS8rfEukI1tFtmk95U848zcDJ4Xrsm9Aw7o0JQb/Z761KWCq3SmUTfNdmdQ
         tAhgQr0c0vGjEYeLIu8/UOJGiTLhvAAJ8W0l0WlEbN2lXldEYdF9KkwB/aKPL0bwd9lb
         MyLpm/vfS9aHyFRerFHrPYGmD6YYDk76K5eJRqWd6denPsrZqsTdsNAeZSMUqzP13ucX
         DSkw==
X-Gm-Message-State: AOAM531mGwMXQ08Pgdfkj6Tu3wP+A1p+qY9Zqwgf6BHHLEp/SC46BIF/
        JJ6J+GaQgQxzP8VAeu9s4vho11Z71MWLAlBs
X-Google-Smtp-Source: ABdhPJzVyhikKY+XTeIEja8THQ7KGJDY9cXrd0SVm2F9lMJFu3zoS/mayvvtNDPRzl3Wu7dGtZAeOA==
X-Received: by 2002:a0c:bec3:: with SMTP id f3mr1489545qvj.49.1616021121946;
        Wed, 17 Mar 2021 15:45:21 -0700 (PDT)
Received: from ArchLinux ([156.146.37.138])
        by smtp.gmail.com with ESMTPSA id l8sm156448qtr.19.2021.03.17.15.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 15:45:21 -0700 (PDT)
Date:   Thu, 18 Mar 2021 04:15:04 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
Subject: Re: [PATCH] mm: Typo fix in the file util.c
Message-ID: <YFKGcL5n6fd0HuXZ@ArchLinux>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
References: <20210317033439.3429411-1-unixbhaskar@gmail.com>
 <20210317114810.GF3420@casper.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4ihC1VnjC4Wioed8"
Content-Disposition: inline
In-Reply-To: <20210317114810.GF3420@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4ihC1VnjC4Wioed8
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 11:48 Wed 17 Mar 2021, Matthew Wilcox wrote:
>On Wed, Mar 17, 2021 at 09:04:39AM +0530, Bhaskar Chowdhury wrote:
>>
>>
>> s/condtion/condition/
>
>The usual subject line for this would be:
>
>mm/util: Fix typo
>
I am keeping this in mind. Thanks for the heads up!

>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>> ---
>>  mm/util.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/util.c b/mm/util.c
>> index 54870226cea6..f85da35b50eb 100644
>> --- a/mm/util.c
>> +++ b/mm/util.c
>> @@ -775,7 +775,7 @@ int overcommit_policy_handler(struct ctl_table *table, int write, void *buffer,
>>  	 * The deviation of sync_overcommit_as could be big with loose policy
>>  	 * like OVERCOMMIT_ALWAYS/OVERCOMMIT_GUESS. When changing policy to
>>  	 * strict OVERCOMMIT_NEVER, we need to reduce the deviation to comply
>> -	 * with the strict "NEVER", and to avoid possible race condtion (even
>> +	 * with the strict "NEVER", and to avoid possible race condition (even
>>  	 * though user usually won't too frequently do the switching to policy
>>  	 * OVERCOMMIT_NEVER), the switch is done in the following order:
>>  	 *	1. changing the batch
>> --
>> 2.30.2
>>
>>

--4ihC1VnjC4Wioed8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBShmwACgkQsjqdtxFL
KRWYKwgAziEPleBaruW5akyyZYz7UgkGFJCjITUSuHFf8EPJB3/5U9AzINJy/kNU
v48bvf8JVGsHuiAQwqgaiHxxa4XqerZ0pnCQADZkCZmmBhS0DPB21sZV3PUa+zSw
ia2wRlqhZ9SJMkOvQKXOyKPTv9ShYVQNbfAqdn/mXkS6Z8lqtPkhNWrxgWZKkCUr
NKG9nDkCqMi7aa+c3f7+00G80ifreoPl/BNBhlW+3tk/dbz7fsnzX0+FXYEsGA5I
UoRMk0ilZ7m72WJlXljfvPGXqnG2JLMzT3RxsKFJ/mHdkoN71XOGJm9GDR7euVJy
/3eEzxCy9J90tJi9dtqQkQUVW9bhCg==
=z1GT
-----END PGP SIGNATURE-----

--4ihC1VnjC4Wioed8--
