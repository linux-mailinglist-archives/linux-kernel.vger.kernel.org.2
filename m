Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 052F0459492
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 19:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240243AbhKVSSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 13:18:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:28942 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233318AbhKVSSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 13:18:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637604931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vVCiEmUed2GoJ5PqcHl3o7fyXnNyNAFjYeGeAqfPvS8=;
        b=A4y+r+O17i78OeLqRNLXnTV1RA2ufzY12i0beCuRoUxLpLhTsRVMxRQ+aPoXfO2VGdEz8r
        /C4yA26SwiitF17T3axGzX5kgSDQwFc2g5SB1MTmkHXOvwXOe32ss1tPskSDcOW92hJc0t
        ocP1KJnYyYQ5KT3WiaOkwOklY9itgtQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-211-cqlcHQc_PbSW9j6ySSAEhg-1; Mon, 22 Nov 2021 13:15:30 -0500
X-MC-Unique: cqlcHQc_PbSW9j6ySSAEhg-1
Received: by mail-wm1-f71.google.com with SMTP id 205-20020a1c00d6000000b003335d1384f1so10552488wma.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 10:15:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=vVCiEmUed2GoJ5PqcHl3o7fyXnNyNAFjYeGeAqfPvS8=;
        b=B3HGgL95FJXVkqhh7cLPXYehl5FTrHJnAifBHJe7QmjoPawg6yb5fYOKY+nYSXhcWS
         tUz1Ya5vqXryJM3AcfwM7ztDnm89fC6qeP/OM+KmRmfE4bvHgcaxByaxTEjQQofpQEW6
         RXYdCo52JzITWwkDKnpMjI1GEkBkXtdVkC27gjgrbrT/wQoGOd0QMFTTM+MOd9gOjXDY
         IV30Gl7o1tOhTtPvcxbXnqkIgg1Sm8X3/vLWI7TCvxxaIOUlqp9vaEUnm0A/0J4MEts6
         /8yFoR5qru+StOgU4+HEcbXMbAXq8VVHaVQwciJ6xhBAAhbV7U6SiGZNIXMEKO+znmKA
         x4TQ==
X-Gm-Message-State: AOAM531cI23AcL2fB60Dqi48vj4BtPtH1b2F9U1wGfMFvTdcWU9dyVok
        GPNAi5GiUTY/ZLkfCmJ6L+0f6d227ephuhh4WOBdx6Eghzzkrr1qyux5ZFsetAhOoVGNpA6MDZp
        r2hT53aefzFMsYy08JacnHhhX
X-Received: by 2002:a05:6000:154b:: with SMTP id 11mr41302664wry.394.1637604929584;
        Mon, 22 Nov 2021 10:15:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzxi4YAS9tSxGUAuFMH3FMF4u8MTUYMqnxiPlwUA4wIg0m2IdSHSzeUt/GWd0Dd7cFjH96xdA==
X-Received: by 2002:a05:6000:154b:: with SMTP id 11mr41302626wry.394.1637604929374;
        Mon, 22 Nov 2021 10:15:29 -0800 (PST)
Received: from [192.168.3.132] (p5b0c667b.dip0.t-ipconnect.de. [91.12.102.123])
        by smtp.gmail.com with ESMTPSA id 4sm13044814wrz.90.2021.11.22.10.15.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Nov 2021 10:15:28 -0800 (PST)
Message-ID: <d2697d9e-92b7-649f-5afa-313350578286@redhat.com>
Date:   Mon, 22 Nov 2021 19:15:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Alistair Popple <apopple@nvidia.com>, akpm@linux-foundation.org
Cc:     willy@infradead.org, dhowells@redhat.com, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        jglisse@redhat.com, jgg@nvidia.com, rcampbell@nvidia.com,
        jhubbard@nvidia.com
References: <20211118020754.954425-1-apopple@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v4] mm/migrate.c: Rework migration_entry_wait() to not
 take a pageref
In-Reply-To: <20211118020754.954425-1-apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.11.21 03:07, Alistair Popple wrote:
> This fixes the FIXME in migrate_vma_check_page().
> 
> Before migrating a page migration code will take a reference and check
> there are no unexpected page references, failing the migration if there
> are. When a thread faults on a migration entry it will take a temporary
> reference to the page to wait for the page to become unlocked signifying
> the migration entry has been removed.
> 
> This reference is dropped just prior to waiting on the page lock,
> however the extra reference can cause migration failures so it is
> desirable to avoid taking it.
> 
> As migration code already has a reference to the migrating page an extra
> reference to wait on PG_locked is unnecessary so long as the reference
> can't be dropped whilst setting up the wait.
> 
> When faulting on a migration entry the ptl is taken to check the
> migration entry. Removing a migration entry also requires the ptl, and
> migration code won't drop its page reference until after the migration
> entry has been removed. Therefore retaining the ptl of a migration entry
> is sufficient to ensure the page has a reference. Reworking
> migration_entry_wait() to hold the ptl until the wait setup is complete
> means the extra page reference is no longer needed.
> 

I really like this, thanks for this work!

[...]

> +#ifdef CONFIG_MIGRATION
> +/**
> + * migration_entry_wait_on_locked - Wait for a migration entry to be removed
> + * @folio: folio referenced by the migration entry.
> + * @ptep: mapped pte pointer. This function will return with the ptep unmapped.
> + * @ptl: already locked ptl. This function will drop the lock.
> + *
> + * Wait for a migration entry referencing the given page to be removed. This is
> + * equivalent to put_and_wait_on_page_locked(page, TASK_UNINTERRUPTIBLE) except
> + * this can be called without taking a reference on the page. Instead this
> + * should be called while holding the ptl for the migration entry referencing
> + * the page.
> + *
> + * Returns after unmapping and unlocking the pte/ptl with pte_unmap_unlock().

You could maybe make it clear that callers have to pass the ptep only
for PTE migration entries. For a PMD migration entry, pass NULL.

> + *
> + * This follows the same logic as wait_on_page_bit_common() so see the comments

s/wait_on_page_bit_common/folio_wait_bit_common/ ?

> + * there.
> + */
> +void migration_entry_wait_on_locked(struct folio *folio, pte_t *ptep,
> +				spinlock_t *ptl)
> +{
> +	struct wait_page_queue wait_page;
> +	wait_queue_entry_t *wait = &wait_page.wait;
> +	bool thrashing = false;
> +	bool delayacct = false;
> +	unsigned long pflags;
> +	wait_queue_head_t *q;
> +
> +	q = folio_waitqueue(folio);
> +	if (!folio_test_uptodate(folio) && folio_test_workingset(folio)) {
> +		if (!folio_test_swapbacked(folio)) {
> +			delayacct_thrashing_start();
> +			delayacct = true;
> +		}
> +		psi_memstall_enter(&pflags);
> +		thrashing = true;
> +	}
> +
> +	init_wait(wait);
> +	wait->func = wake_page_function;
> +	wait_page.folio = folio;
> +	wait_page.bit_nr = PG_locked;
> +	wait->flags = 0;
> +
> +	spin_lock_irq(&q->lock);
> +	folio_set_waiters(folio);
> +	if (!folio_trylock_flag(folio, PG_locked, wait))
> +		__add_wait_queue_entry_tail(q, wait);
> +	spin_unlock_irq(&q->lock);
> +
> +	/*
> +	 * If a migration entry exists for the page the migration path must hold
> +	 * a valid reference to the page, and it must take the ptl to remove the
> +	 * migration entry. So the page is valid until the ptl is dropped.
> +	 */
> +	if (ptep)
> +		pte_unmap_unlock(ptep, ptl);
> +	else
> +		spin_unlock(ptl);
> +
> +	for (;;) {
> +		unsigned int flags;
> +
> +		set_current_state(TASK_UNINTERRUPTIBLE);
> +
> +		/* Loop until we've been woken or interrupted */
> +		flags = smp_load_acquire(&wait->flags);
> +		if (!(flags & WQ_FLAG_WOKEN)) {
> +			if (signal_pending_state(TASK_UNINTERRUPTIBLE, current))
> +				break;
> +
> +			io_schedule();
> +			continue;
> +		}
> +		break;
> +	}
> +
> +	finish_wait(q, wait);
> +
> +	if (thrashing) {
> +		if (delayacct)
> +			delayacct_thrashing_end();
> +		psi_memstall_leave(&pflags);
> +	}
> +}
> +#endif
> +

I'm fairly new to the glory details of core migration entry and page bit
waiting code, but it makes sense to me and removing the temporary extra
references is very nice! Feel free to add my

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

