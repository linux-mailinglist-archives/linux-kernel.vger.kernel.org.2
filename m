Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB2CD4150F1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237343AbhIVUGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:06:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37871 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237272AbhIVUGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:06:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632341089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wfmAQj1eLnqe1D78zRkvZrSAGszWVxZZuAA8OYkxiNY=;
        b=gpOHgeX8IrkaaMI432z+oJYfW4MR9J1TM25ll6nBqvFCDF/HfXgk5LklfqAeGFAeZ0Xv7y
        9J8thm6+WHBuGBx+3vrohoUAIOMjam6iYlQvimJNerrMshuTd5+Tai2pCdgDGQk/fyQxbc
        KzOsw1tRKnQE9Mcwfs+2afPmk4GJ+Dg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-SQZYKtxgMN6S5BcUpBFZZw-1; Wed, 22 Sep 2021 16:04:48 -0400
X-MC-Unique: SQZYKtxgMN6S5BcUpBFZZw-1
Received: by mail-qk1-f200.google.com with SMTP id m10-20020a05620a290a00b004334bcdf1f4so13041637qkp.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:04:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wfmAQj1eLnqe1D78zRkvZrSAGszWVxZZuAA8OYkxiNY=;
        b=VUVxT9WTzhc34JOzIfg8KBK5fWOLjAlF+Tp2eGX/e4gxloUu/u8QhupPnJo6b0FYVr
         Y/q0oqWNKtSdN6I1fZCt41vUBUYV0Nhrfi/iiS0kIN4RUmoDTbSUkGZCdRags/eG2mnj
         WFkTecQYCNTHdt8MHzrF3MmuvFU1SAcll8bVe7008zvRqTjO0eMoUGpmIzhpThLY+SHP
         hJxqFh0u1gynj/dFHE8zJVKHzlkAtHGXJkl6KaZzTO1dASNcLkS1ar7AjaIy8/Fuc41/
         3Yx5EhjUaEV6tbTzkzJTa9YZJwtHGovzrktwJFZ/4K4KLKCQhyyS8dzvBAHCnzU9VRX+
         sbow==
X-Gm-Message-State: AOAM5330kvxxrP/6L2iOE6OBDFOrOMD1YaGD8rW6+UKGOmXZFndv4+Xs
        3ifGfCfK4nrNxxgQsJXz8IGzWy+pYosI0GjrnPu3mu040qbBVfFuXLNtCIqjd24uAejF7B1cCAP
        +NE0d2oXO1dtbaL0KNGvfPzCa
X-Received: by 2002:a37:6147:: with SMTP id v68mr1233940qkb.154.1632341087684;
        Wed, 22 Sep 2021 13:04:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx59BS+mKq7RFbazbYa4OejIGX9idyrFiC7plgv0UVXb4KSxkno+8Th2LDmkABtJdcfJe2OTg==
X-Received: by 2002:a37:6147:: with SMTP id v68mr1233831qkb.154.1632341086602;
        Wed, 22 Sep 2021 13:04:46 -0700 (PDT)
Received: from t490s ([2607:fea8:56a2:9100::d3ec])
        by smtp.gmail.com with ESMTPSA id n13sm2533690qke.100.2021.09.22.13.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 13:04:46 -0700 (PDT)
Date:   Wed, 22 Sep 2021 16:04:44 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Hugh Dickins <hughd@google.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH] mm/khugepaged: Detecting uffd-wp vma more efficiently
Message-ID: <YUuMXCFbj1mmOKec@t490s>
References: <20210922175156.130228-1-peterx@redhat.com>
 <6bbb8e29-9e21-dfbe-d23d-61de7e3cc6db@redhat.com>
 <YUt833H6eaYFyHXD@t490s>
 <CAHbLzkq7kTdEC6ADJRAxXBEOYhsjR8E9uiEFCYFmtA5cD5fMhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHbLzkq7kTdEC6ADJRAxXBEOYhsjR8E9uiEFCYFmtA5cD5fMhA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 12:29:35PM -0700, Yang Shi wrote:
> khugepqged does remove the pgtables. Please check out
> retract_page_tables(). The pmd will be cleared and the ptes will be
> freed otherwise the collapsed THP won't get PMD mapped by later
> access.

Indeed.

I should probably still properly disable khugepaged for at least VM_SHARED &&
VM_UFFD_WP, then I'd keep the anonymous && minor mode behavior untouched.

The other problem is even if current mm/vma doesn't have UFFD_WP registered,
some other mm/vma could have UFFD_WP enabled there that mapped the same file.
Checking that up within retract_page_tables() on all VMAs seems to be a bit too
late.

Checking it early may not trivially work too - I can walk the vma interval tree
at the entry of khugepaged_scan_file(), making sure no vma has UFFD_WP set.
However I don't see how it'll stop some of the vma from having UFFD_WP
registered later after that point but before retract_page_tables().

I'll need to think about it, but thanks for the input, Yang.  That's a very
important point.

-- 
Peter Xu

