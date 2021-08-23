Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE20B3F47EC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 11:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbhHWJuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 05:50:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42329 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231759AbhHWJuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 05:50:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629712167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rhYJCRMkZEsXkLqbrYbAaQrmVIoehH5NK13qs7XLf9g=;
        b=CzAKVmC0z1ul2PT6iwHHx8hXlPgYCMLOubtlr7w5Xu5i5KAS8kKjigRUP9abUy7rGF1i9q
        wThXZM+Hcw3vgI5wU/GW3At/+hirO63XPRzifmR+8oDNE8qS4maWGrfgPjW2J2V0d7ScM1
        Fj6mgWQEi00vFa00tRlE8GHbvyIUop4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-nDWM83FyPcGyACM6edFw8A-1; Mon, 23 Aug 2021 05:49:25 -0400
X-MC-Unique: nDWM83FyPcGyACM6edFw8A-1
Received: by mail-wr1-f72.google.com with SMTP id l1-20020adff481000000b00156e670a09dso4956847wro.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 02:49:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=rhYJCRMkZEsXkLqbrYbAaQrmVIoehH5NK13qs7XLf9g=;
        b=i/wE2sFehb/q9zZ75r9u9h+VGqSdwbZJHyRW5arcEX+EYEoTCQ3xLBDlz+6GRgVthG
         YVu4FTc05pXtd2tDukhsoMcOT6WAI6iKZEPbZBOc4lUvfFcMio1LPkBHP0FsBmzNUMt9
         Ngy7ZsNYklIYWW+Eu9bdi75wvPnOGXs8Bj2zhEf4n/q1trr235m8/hJFDZEhBFiQMeLA
         yF/kwzcutzLRgE1hcXlcV8Ex4pdhi2D1IBWlnpgF1TozzjwiAuzkDYMagESMoAfqUrxg
         EBJhA+ox40r/05U1D9mtua6zBpw2vru/+lz+SkFLYm3w3soh8lrP+TN7TiL7ult2glnj
         CZRw==
X-Gm-Message-State: AOAM532r0ovNsUanJYtru0NzyailOd0n7Le8u/1wmGRBWxDubJ9/vjeD
        d3RgQJiWeseL0pc+qR0ixMNPsZRp/sOj04Rix1Oa6zoBbQ01dNfyEQuDFu/2lDXXRn7BKEw9M+U
        v7f/5ljiLISu02OQPa5D0KTDA
X-Received: by 2002:a05:600c:2056:: with SMTP id p22mr5321579wmg.8.1629712164735;
        Mon, 23 Aug 2021 02:49:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwhTR9x1F22AYEzpTQ9mUUJdLOKPaSvVO8Y/ebHKvclnWojMyDhYLL/VNAUhuTXxMd/9VZ8YQ==
X-Received: by 2002:a05:600c:2056:: with SMTP id p22mr5321565wmg.8.1629712164531;
        Mon, 23 Aug 2021 02:49:24 -0700 (PDT)
Received: from ?IPv6:2003:d8:2f0a:7f00:fad7:3bc9:69d:31f? (p200300d82f0a7f00fad73bc9069d031f.dip0.t-ipconnect.de. [2003:d8:2f0a:7f00:fad7:3bc9:69d:31f])
        by smtp.gmail.com with ESMTPSA id l15sm3693327wrv.84.2021.08.23.02.49.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 02:49:23 -0700 (PDT)
Subject: Re: [PATCH v2 11/61] mm: Remove rb tree.
To:     Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michel Lespinasse <walken.cr@gmail.com>
References: <20210817154651.1570984-1-Liam.Howlett@oracle.com>
 <20210817154651.1570984-12-Liam.Howlett@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <3104a9d0-b8b3-46ed-4f10-1c1f0e5eff92@redhat.com>
Date:   Mon, 23 Aug 2021 11:49:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210817154651.1570984-12-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.08.21 17:47, Liam Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> Remove the RB tree and start using the maple tree for vm_area_struct
> tracking.
> 
> Drop validate_mm() calls in expand_upwards() and expand_downwards() as
> the lock is not held.
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>


[...]


Why are we reshuffling the code below? This either needs a good 
justification or should just be dropped as it introduces noise. Maybe I 
am missing something important.

>   	/*
> @@ -427,6 +414,11 @@ struct vm_area_struct {
>   	pgprot_t vm_page_prot;
>   	unsigned long vm_flags;		/* Flags, see mm.h. */
>   
> +	/* Information about our backing store: */
> +	unsigned long vm_pgoff;		/* Offset (within vm_file) in PAGE_SIZE
> +					 * units
> +					 */
> +	struct file *vm_file;		/* File we map to (can be NULL). */
>   	/*
>   	 * For areas with an address space and backing store,
>   	 * linkage into the address_space->i_mmap interval tree.
> @@ -449,12 +441,9 @@ struct vm_area_struct {
>   	/* Function pointers to deal with this struct. */
>   	const struct vm_operations_struct *vm_ops;
>   
> -	/* Information about our backing store: */
> -	unsigned long vm_pgoff;		/* Offset (within vm_file) in PAGE_SIZE
> -					   units */
> -	struct file * vm_file;		/* File we map to (can be NULL). */
>   	void * vm_private_data;		/* was vm_pte (shared mem) */
>   
> +

Another unrelated change (there seem to some more in this patch)


-- 
Thanks,

David / dhildenb

