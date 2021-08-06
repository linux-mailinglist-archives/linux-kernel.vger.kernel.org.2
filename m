Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9713A3E241F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 09:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243817AbhHFHap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 03:30:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46435 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243818AbhHFHaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 03:30:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628235009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/BY4t2yJmbfSKPEbLTSJy0hz6AF9n9YxHRdnbcJfERs=;
        b=QTasJsWZTZOWt1Vh4h8C7ojHdRjdQ5uPwVkaKb8x41R0tHPo/7POEcQpeb41TFftDn1/Xv
        QVz5UHn331GeuZp7xFOcV1cUqnb0S6KlrthLwUqdEcaBk/o/vqlJC1foruRUmqxa0DVXJA
        s81D5kDGtEmed1Rxfxj/dJJvhXEv7cI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-qRVDRg66MwW-N13EUvnejg-1; Fri, 06 Aug 2021 03:30:07 -0400
X-MC-Unique: qRVDRg66MwW-N13EUvnejg-1
Received: by mail-wr1-f69.google.com with SMTP id z10-20020adfdf8a0000b02901536d17cd63so2857977wrl.21
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 00:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/BY4t2yJmbfSKPEbLTSJy0hz6AF9n9YxHRdnbcJfERs=;
        b=A6kcz8IzKuMcY80y0kCwCtir/WmshV/VGViqHz+vmCeh0Fw1Ut4Z/46rkreVHH7ajZ
         5iAPNQ795uLOqUWToh1uljxb1pnFiwPxWKUnYrUwUjkgLCZydjyBjqnwJZ0SnfVLFox3
         J9CIieyI62juAvL6Fk2j8dCKx7naJ15KzllOEh5IOGdBl29PJBbQrDVRZRtBGGWBu1Rp
         S+VNKjjOyDhZ4rIPmR0hk8LhHF0GbDH7Us6pUe3/i6ipyfjmL6LAHvtgstvED1sQNkW5
         zs3NOAMwIzxTIg2NrSLgPZf6yTOrHs6SL3rBSl29ZepailcYrv0lpgve9JvD0xoYDIfT
         fqYw==
X-Gm-Message-State: AOAM533wDaW3jvg4ZNo0i7tEN6c8RwZQgapLDKYQBbdefecxIXp/p4g6
        2F4qjdJbWS8pPSRgVtyT5jOrqnA+Yo1j+He8Bn66Qp7w5WjZ2InDhzHsrRWCLeTl0YuEhPz/Wn3
        D5nxXGLXVkRdfDaVK/XEUTTHx
X-Received: by 2002:a05:600c:3b94:: with SMTP id n20mr1781095wms.54.1628235005748;
        Fri, 06 Aug 2021 00:30:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyVZHZyH4+bvjg65UxBPJGLejAZAJ2Ik8iYydKdbU4cBd0fD679iDO5ATxjE2sOFL4jRsl9dA==
X-Received: by 2002:a05:600c:3b94:: with SMTP id n20mr1781075wms.54.1628235005511;
        Fri, 06 Aug 2021 00:30:05 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6104.dip0.t-ipconnect.de. [91.12.97.4])
        by smtp.gmail.com with ESMTPSA id b6sm10178492wrn.9.2021.08.06.00.30.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Aug 2021 00:30:05 -0700 (PDT)
Subject: Re: [PATCH v3 02/14] KVM: s390: pv: avoid stall notifications for
 some UVCs
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc:     cohuck@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        thuth@redhat.com, pasic@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulrich.Weigand@de.ibm.com
References: <20210804154046.88552-1-imbrenda@linux.ibm.com>
 <20210804154046.88552-3-imbrenda@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <7ef282bb-d90f-9cbb-678b-4293790fb8c6@redhat.com>
Date:   Fri, 6 Aug 2021 09:30:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210804154046.88552-3-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.08.21 17:40, Claudio Imbrenda wrote:
> Improve make_secure_pte to avoid stalls when the system is heavily
> overcommitted. This was especially problematic in kvm_s390_pv_unpack,
> because of the loop over all pages that needed unpacking.
> 
> Also fix kvm_s390_pv_init_vm to avoid stalls when the system is heavily
> overcommitted.

I suggest splitting this change into a separate patch and adding a bit 
more meat to the description why using the other variant is possible in 
the called context. I was kind of surprise to find that change buried in 
this patch.

Then, you can give both patches a more descriptive patch subject.

> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Fixes: 214d9bbcd3a672 ("s390/mm: provide memory management functions for protected KVM guests")
> ---
>   arch/s390/kernel/uv.c | 29 +++++++++++++++++++++++------
>   arch/s390/kvm/pv.c    |  2 +-
>   2 files changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
> index aeb0a15bcbb7..68a8fbafcb9c 100644
> --- a/arch/s390/kernel/uv.c
> +++ b/arch/s390/kernel/uv.c
> @@ -180,7 +180,7 @@ static int make_secure_pte(pte_t *ptep, unsigned long addr,
>   {
>   	pte_t entry = READ_ONCE(*ptep);
>   	struct page *page;
> -	int expected, rc = 0;
> +	int expected, cc = 0;
>   
>   	if (!pte_present(entry))
>   		return -ENXIO;
> @@ -196,12 +196,25 @@ static int make_secure_pte(pte_t *ptep, unsigned long addr,
>   	if (!page_ref_freeze(page, expected))
>   		return -EBUSY;
>   	set_bit(PG_arch_1, &page->flags);
> -	rc = uv_call(0, (u64)uvcb);
> +	/*
> +	 * If the UVC does not succeed or fail immediately, we don't want to
> +	 * loop for long, or we might get stall notifications.
> +	 * On the other hand, this is a complex scenario and we are holding a lot of
> +	 * locks, so we can't easily sleep and reschedule. We try only once,
> +	 * and if the UVC returned busy or partial completion, we return
> +	 * -EAGAIN and we let the callers deal with it.
> +	 */
> +	cc = __uv_call(0, (u64)uvcb);
>   	page_ref_unfreeze(page, expected);
> -	/* Return -ENXIO if the page was not mapped, -EINVAL otherwise */
> -	if (rc)
> -		rc = uvcb->rc == 0x10a ? -ENXIO : -EINVAL;
> -	return rc;
> +	/*
> +	 * Return -ENXIO if the page was not mapped, -EINVAL for other errors.
> +	 * If busy or partially completed, return -EAGAIN.
> +	 */
> +	if (cc == UVC_CC_OK)
> +		return 0;
> +	else if (cc == UVC_CC_BUSY || cc == UVC_CC_PARTIAL)
> +		return -EAGAIN;
> +	return uvcb->rc == 0x10a ? -ENXIO : -EINVAL;
>   }

That looks conceptually like the right thing to me.

-- 
Thanks,

David / dhildenb

