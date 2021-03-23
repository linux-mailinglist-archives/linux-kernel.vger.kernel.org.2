Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB921346337
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 16:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbhCWPn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 11:43:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35112 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232803AbhCWPn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 11:43:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616514208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fQwwd9nOnJe1+uHPoxzHuoEj26bQew0s4XHSj0Ikdsw=;
        b=HuzKUsbf6KN5VkDGpNwoZsEE4E7xHnqn7c1qdryOfkuir47gmDC/rr5uIN60Z/1Xgt/wJg
        iS/mahoAjyaKxavDU+M1PPgsL9+Lq0QR+p07STRyu41dgwOG8PXylGXoA1WVMNTPfEbIj3
        YDUZllYRywlPCo/hHJ6rduBN+a1XesM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-TbzI2IHLOcSp-XE-LQbUqA-1; Tue, 23 Mar 2021 11:43:24 -0400
X-MC-Unique: TbzI2IHLOcSp-XE-LQbUqA-1
Received: by mail-qv1-f72.google.com with SMTP id u15so1855603qvo.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 08:43:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fQwwd9nOnJe1+uHPoxzHuoEj26bQew0s4XHSj0Ikdsw=;
        b=d9cIaz78EPHOC6gEwZQ1v0Ok4vBVvB01ZYu1JRleZ8RR/MAVmoVGaYOnWrkg6lFvuC
         j1xHlnx3BQ1lqLsnVuKmNW7D5Dk9FQ94Swz4yJufpeLRaRZ025ROPzix9JEjIImIzJVg
         10jB13/14gV46ArN27X2lebwiGkQf83k5G1CVFSmZaJnCsRQLicJeDP23n4Iy1Ub+sDW
         wbe6trQnHgUiyRRFP9GCNRLLBvCLcNTJvKbpLJSTFeC6rDkGzq8+3/IWyc9LwwtCl+/x
         sT74+sQt6nPm0syXHNkkY1xZPuzF01wZhbyBC3gkiQiF61ba7kSBZMFAibNfSfM8JBQ0
         Y7RQ==
X-Gm-Message-State: AOAM531qh+PhH5V/2GdGDjRHWAUqT09GqcbDM5SiArSy0uGV0T7vhLvg
        I7ySeoxZmVaS7mwREJcQBL/0gjWXNzNptql5DUKhj685WWZ3bogOk89DGg0Ak5eEasg2Rjm6T4W
        yGMV/kWiiOUaxQ6egjHEbnF6k
X-Received: by 2002:a05:620a:981:: with SMTP id x1mr5807036qkx.501.1616514203216;
        Tue, 23 Mar 2021 08:43:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJym/kQ1w5u7o1QHL31laqkymPkn/C2lVnlgp1kv4esRLoT59gBX0FFLLopujlqx2vELTjFLBA==
X-Received: by 2002:a05:620a:981:: with SMTP id x1mr5807023qkx.501.1616514203017;
        Tue, 23 Mar 2021 08:43:23 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-82-174-91-135-175.dsl.bell.ca. [174.91.135.175])
        by smtp.gmail.com with ESMTPSA id z14sm10958800qti.87.2021.03.23.08.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 08:43:22 -0700 (PDT)
Date:   Tue, 23 Mar 2021 11:43:21 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Hugh Dickins <hughd@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH 07/23] mm: Introduce zap_details.zap_flags
Message-ID: <20210323154321.GG6486@xz-x1>
References: <20210323004912.35132-1-peterx@redhat.com>
 <20210323004912.35132-8-peterx@redhat.com>
 <20210323021129.GZ1719932@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210323021129.GZ1719932@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 02:11:29AM +0000, Matthew Wilcox wrote:
> On Mon, Mar 22, 2021 at 08:48:56PM -0400, Peter Xu wrote:
> > +/* Whether to check page->mapping when zapping */
> > +#define  ZAP_FLAG_CHECK_MAPPING             BIT(0)
> > +
> >  /*
> >   * Parameter block passed down to zap_pte_range in exceptional cases.
> >   */
> >  struct zap_details {
> > -	struct address_space *check_mapping;	/* Check page->mapping if set */
> > +	struct address_space *zap_mapping;	/* Check page->mapping if set */
> 
> Now the comment is wrong.  It used to mean "If this is NULL, zap pages
> with any mapping", but now it's always set, and the decision about whether
> to check the mapping is in the flag.
> 
> Honestly, I'd remove the comments from both these members.  They don't add
> anything to understandability now.

Agreed, I'm removing them.  Thanks,

-- 
Peter Xu

