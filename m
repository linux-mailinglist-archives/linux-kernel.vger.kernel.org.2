Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6D83437B4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 05:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbhCVD7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 23:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhCVD7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 23:59:04 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA21FC061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 20:59:03 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id c4so9307047qkg.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 20:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=N2eyEXwKYprrVEqEb1kH0B4OY0RaQBUaEpvA9yRQ4Yk=;
        b=eAWVu6KSl4RSKqbWKiNEPoeWZvSxhkCjVoP378cMSlwXGcwY3su2IHoohKRiLy+ebS
         +Ubo78QH1GO+mEJf3cvWWvdBGT29bvlpHWR42uZhubyeVgwspeGx0QatOMZ3cJ/ohuDi
         kIw+1QGmKb26U7WAE4gufuRITWzCr+hv3XtmtEuvAJFoGF5jEsjF4dUxIIbhFsWpXqfE
         EZYZsp3ttrfMX54Ev/sbRpeFoGkOADYFL+CsTjhRA6Borv7LGZpsBsUicebpiO9VxkKy
         snJtYtIf6F2S3tnNsKqAzb9ZjZImTBxhZV7dWuQLWu5oXm0KlAdQpCdh4lwVhHYciwiu
         SRxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=N2eyEXwKYprrVEqEb1kH0B4OY0RaQBUaEpvA9yRQ4Yk=;
        b=Lh8Pr5OZgdoTr0aHiy7NQgHIBYnpcQPyBpKZvY32c3a79WFYz95D/ho+sYhrgYaWsi
         tQRqQGfvjkwK9GIzvXz2enKf/Q+/U6oAKJhlAFCP2OHs/jsp/gkQDVfKW4+OxpmiQOli
         nz0W7k2kVuU7EBff7t3Sokej8pXqE3EQSbthXrZ1xBPJKSjior98lCrHXMP+QDt4wue9
         SxH03J77PmnrTyznMvXHbH/gt+qrBWOD0lswwywkTrl6Sz2l9UgCK/8NS6YOL8j15UGr
         o7ORQJsIb2teaFv8nEsFSx68fPJ1A5jlr8f+69JqaMgxJx6nW0mfDqQeuHzSJz8ScGGZ
         wrgA==
X-Gm-Message-State: AOAM532+UMczSTPwAxj0e7kQ1nUWxBXTah7JY6rxfaxyF7XwxumJuIUh
        QTVJ3S52hSHIizIXukvW0VY=
X-Google-Smtp-Source: ABdhPJx6WLNvYlfLBdnNOlu2902OI161LvTaIyBQN8u1w50JY5k9SU2TWmLCBXiLj+sRIHJCC6GfMQ==
X-Received: by 2002:a37:46d5:: with SMTP id t204mr8963306qka.211.1616385542992;
        Sun, 21 Mar 2021 20:59:02 -0700 (PDT)
Received: from ArchLinux ([156.146.54.190])
        by smtp.gmail.com with ESMTPSA id r2sm8314006qti.4.2021.03.21.20.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 20:59:02 -0700 (PDT)
Date:   Mon, 22 Mar 2021 09:28:52 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH] mm: Fix typos in comments
Message-ID: <YFgV/Np4ps8zFG6j@ArchLinux>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Rik van Riel <riel@redhat.com>
References: <20210322025152.GA1922846@gmail.com>
 <20210322034408.GD1719932@casper.infradead.org>
 <2cc83cd7-6fd2-2b4f-b03a-5e1a384aa137@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bpPMA1ta5HytA2u7"
Content-Disposition: inline
In-Reply-To: <2cc83cd7-6fd2-2b4f-b03a-5e1a384aa137@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bpPMA1ta5HytA2u7
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 20:52 Sun 21 Mar 2021, Randy Dunlap wrote:
>On 3/21/21 8:44 PM, Matthew Wilcox wrote:
>> On Mon, Mar 22, 2021 at 03:51:52AM +0100, Ingo Molnar wrote:
>>> +++ b/mm/huge_memory.c
>>> @@ -1794,7 +1794,7 @@ bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
>>>  /*
>>>   * Returns
>>>   *  - 0 if PMD could not be locked
>>> - *  - 1 if PMD was locked but protections unchange and TLB flush unnecessary
>>> + *  - 1 if PMD was locked but protections unchanged and TLB flush unnecessary
>>>   *  - HPAGE_PMD_NR is protections changed and TLB flush necessary
>>
>> s/is/if/
>>
>>> @@ -5306,7 +5306,7 @@ void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
>>>
>>>  	/*
>>>  	 * vma need span at least one aligned PUD size and the start,end range
>>> -	 * must at least partialy within it.
>>> +	 * must at least partially within it.
>>
>> 	 * vma needs to span at least one aligned PUD size, and the range
>> 	 * must be at least partially within in.
>>
>>>  /*
>>>   * swapon tell device that all the old swap contents can be discarded,
>>> - * to allow the swap device to optimize its wear-levelling.
>>> + * to allow the swap device to optimize its wear-leveling.
>>>   */
>>
>> Levelling is british english, leveling is american english.  we don't
>> usually "correct" one into the other.
>
>How about "labelled" (from mm/kasan/shadow.c):
>

Not sure , "levelling" and "labelling" is the same thing...I think all of us
missed the context ...isn't that dictated by the context(soruce code,
effecets) ...

>@@ -384,7 +384,7 @@ static int kasan_depopulate_vmalloc_pte(pte_t *ptep, unsigned long addr,
>  * How does this work?
>  * -------------------
>  *
>- * We have a region that is page aligned, labelled as A.
>+ * We have a region that is page aligned, labeled as A.
>  * That might not map onto the shadow in a way that is page-aligned:
>
>
>--
>~Randy
>

--bpPMA1ta5HytA2u7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBYFfwACgkQsjqdtxFL
KRVWRgf+Ofw0pOzddjp1LIPtWP66embFXJcc+md/xGyTRWWYMg7RFVlMGOA8/5CG
tmbYrBvrNHZo/7t6bif12CIlfWBqjl7k6PFAbnhUVLzg19NcOUe4eoHaooUaCPdO
s1PCnQ5tLN1sOOx9j9pc/DSvPl1fjCu7MynHxxkhlE0rV2dMMvesr8ourt08UWyh
2jQo5wjo3OapjZVZrRMmr/RmJTuM3tsLQxd9O4bZAk/HIvOujR/dslENqPmfzaGb
eNXWrLuJJkbknSBL5514ueZKy5D5wAY4RlGniOLvVnQ2CqkhKs/wBQ3NKGnWX6sS
CTlheGikZr5Zf7SUhAGPdA1MVlb+tg==
=jV6V
-----END PGP SIGNATURE-----

--bpPMA1ta5HytA2u7--
