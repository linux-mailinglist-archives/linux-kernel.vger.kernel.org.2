Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE4A30CD2F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 21:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbhBBUki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 15:40:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51079 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229870AbhBBUkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 15:40:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612298346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cxKILuRnLUyJm7OjpO6X1TfMyhzRQAP6Snl2wpeGcYk=;
        b=MUYthlLT7Gp1nQrehIhEG6Ss2ILREogRY/IV2f4uIjSSBUT5irJ8F4eFVmZaoWb/Db6C23
        8n4+MCfo7tuKRMpo5rMA4n0+LB10x3qcYKLHVw7eqkPAxkmTQdxf54ImGQRhXk+HcQaCBo
        Vx0ku7WzqfGgcETzw42V2afXZg/q420=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-QcjBs-jMMzWBSf1SlAju3g-1; Tue, 02 Feb 2021 15:39:02 -0500
X-MC-Unique: QcjBs-jMMzWBSf1SlAju3g-1
Received: by mail-qk1-f197.google.com with SMTP id e187so18463408qkf.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 12:39:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cxKILuRnLUyJm7OjpO6X1TfMyhzRQAP6Snl2wpeGcYk=;
        b=p449iDCgpWbymk2Ql+IIIGz9KvU0qNjaVEe3OrCMQDStAzDRsiiue7nQba+jFoYjLQ
         2kkYG4MZNNs0bcVcGR0aAB6mLhk4jRAh0eWlnKggqZW4+RJ7MAFFQAqwqHdZFflnjNue
         c/G0XNJ+bEZZGI1q8EiPg6iR0ZZhfFFlHK8zDNFWpQsG0c41EMX3uz/QCMfDbZXqRjUD
         L/WANiexAe50PWwwGfdWby21icDH78toNsGBVn5V5EWV+TvM168Hw/SC+hWNX3Fjc8sG
         JERqbqf7oSIuZwkaTaMyTzGPvicIOo99QCLhPu0f3wn3QizaLDICW9MkktPV5ketBofF
         e3qQ==
X-Gm-Message-State: AOAM532PGlRpJ46H7aMPUVP5f6GLaSqaNW3PXkXszEv652/u4LUHxAOy
        2EiDFjt/E9uLDUAypsweDKREqf/8rC0+Cg4TpTGh1R0ZcXH/ZRRJoug8R3J4sYXEkMIaIRl4Cuu
        LinL0+H0Hp6xEmtCjeOIw4X/v
X-Received: by 2002:a05:6214:913:: with SMTP id dj19mr22417093qvb.33.1612298341428;
        Tue, 02 Feb 2021 12:39:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyafFtJVqxfl3ZVONklJT+TkO26nkgrl/XIOWV4Fo8YGYJICgDvYe1YdGqwsJUmu7Uzfhqvhw==
X-Received: by 2002:a05:6214:913:: with SMTP id dj19mr22417072qvb.33.1612298341170;
        Tue, 02 Feb 2021 12:39:01 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id s23sm33984qke.3.2021.02.02.12.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 12:39:00 -0800 (PST)
Date:   Tue, 2 Feb 2021 15:38:59 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] userfaultfd: hugetlbfs: only compile UFFD helpers if
 config enabled
Message-ID: <20210202203859.GH6468@xz-x1>
References: <20210202203127.3596707-1-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210202203127.3596707-1-axelrasmussen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021 at 12:31:27PM -0800, Axel Rasmussen wrote:
> For background, mm/userfaultfd.c provides a general mcopy_atomic
> implementation. But some types of memory (e.g., hugetlb and shmem) need
> a slightly different implementation, so they provide their own helpers
> for this. In other words, userfaultfd is the only caller of this
> function.
> 
> This patch achieves two things:
> 
> 1. Don't spend time compiling code which will end up never being
> referenced anyway (a small build time optimization).
> 
> 2. In future patches (e.g. [1]), we plan to extend the signature of
> these helpers with UFFD-specific state (e.g., enums or structs defined
> conditionally in userfaultfd_k.h). Once this happens, this patch will be
> needed to avoid build errors (or, we'd need to define more UFFD-only
> stuff unconditionally, which seems messier to me).
> 
> Peter Xu suggested this be sent as a standalone patch, in the mailing
> list discussion for [1].
> 
> [1] https://patchwork.kernel.org/project/linux-mm/list/?series=424091
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

I meant a standalone patch along with the next version of your series would be
good enough... :) If Mike is fine I won't complain if you'd squashed it into
that patch either.  The patch itself looks correct to me.

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu

