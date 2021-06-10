Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8573A32AD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 20:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhFJSGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 14:06:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33065 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229963AbhFJSGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 14:06:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623348279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CEoL5V4Mmey/+otE2j2URoJUKULpKPt4rB1iuEzrSWg=;
        b=G6norW3i4bK27LW6BCb6fBgCQx1yBFMpw9I0bWinL1NMtiLwv6uNCH3gwJNc8YdXUraUU0
        708WvDvpOGVtvn3Ht61kyV0PkpLgiGCGSdF26qFkcchEqXSm+MhgZAhrfyhOt5+xy6CePH
        dVIZy3NdrrfEaUVnKIV1BzOVlvZNksE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-oRf-DWo2M_-2fr0ocTPvUg-1; Thu, 10 Jun 2021 14:04:38 -0400
X-MC-Unique: oRf-DWo2M_-2fr0ocTPvUg-1
Received: by mail-qt1-f199.google.com with SMTP id r1-20020ac85c810000b02901fa9798cdb5so370031qta.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 11:04:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CEoL5V4Mmey/+otE2j2URoJUKULpKPt4rB1iuEzrSWg=;
        b=M1nGGCyeZ/It00AOYKA3NsRpl3lc3JDFqhYPuJnJxtDtq/JAJB+63KuXzVbUIs224K
         LQoLpWTsFyCc+Y0FVhfEr04V+ezmd/HqX8JmKD5WbmjMyHCPYWGZ19kH1mM5qQcMuOkY
         RLWvapQddJdwlvfmdt/p0Mj+624SwlM5qhcmaTTBJqovbk6H8Hx3rbMqAGNXVDwRudX2
         sag8vSTmPVCXGL2xGtZVi15RPo8PhIJixBXTp7ZqinJ2Lvq9LTLAoWHNul1waIVU7m9M
         YuzhAj+Y4aTpZ/3SseGbd4PXTS2eBuKBOswV92Ga3ZQN5cuHxmxz5e+3ZjbN52kjgq7s
         wrag==
X-Gm-Message-State: AOAM533UbptPXfk02YpJ2Tmqs6a1C2WhTDwHySk1BG59VQf2gm2KGN4s
        pv3R5RD21MbdPTtk3+Ku7R4m6lbmz828XsFHFL9waCfnyTiBpEYB10YcqxLzVmO3s5/hWPnwyBW
        dc3y/pMzFy/hEDra9aheBpsgI
X-Received: by 2002:aed:306f:: with SMTP id 102mr3467qte.197.1623348277897;
        Thu, 10 Jun 2021 11:04:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxTTO+KkTdxTZkkMrHOmkbo6ejQaZkDXpeywK0BwU0l5R3cowlkisPdpRInl2BsP3WxC79JBQ==
X-Received: by 2002:aed:306f:: with SMTP id 102mr3418qte.197.1623348277505;
        Thu, 10 Jun 2021 11:04:37 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-88-174-93-75-200.dsl.bell.ca. [174.93.75.200])
        by smtp.gmail.com with ESMTPSA id o3sm2731692qkc.93.2021.06.10.11.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 11:04:36 -0700 (PDT)
Date:   Thu, 10 Jun 2021 14:04:35 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        rcampbell@nvidia.com, linux-doc@vger.kernel.org,
        nouveau@lists.freedesktop.org, hughd@google.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        hch@infradead.org, bskeggs@redhat.com, jgg@nvidia.com,
        shakeelb@google.com, jhubbard@nvidia.com, willy@infradead.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v10 07/10] mm: Device exclusive memory access
Message-ID: <YMJUM4sx1VclR7oz@t490s>
References: <20210607075855.5084-1-apopple@nvidia.com>
 <270551728.uXnuCZxQlr@nvdebian>
 <YMDmsha6GDtUf3Vs@t490s>
 <2773835.D95cIkl9rl@nvdebian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2773835.D95cIkl9rl@nvdebian>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 10:18:25AM +1000, Alistair Popple wrote:
> > > The main problem is split_huge_pmd_address() unconditionally calls a mmu
> > > notifier so I would need to plumb in passing an owner everywhere which could
> > > get messy.
> > 
> > Could I ask why?  split_huge_pmd_address() will notify with CLEAR, so I'm a bit
> > confused why we need to pass over the owner.
> 
> Sure, it is the same reason we need to pass it for the exclusive notifier.
> Any invalidation during the make exclusive operation will break the mmu read
> side critical section forcing a retry of the operation. The owner field is what
> is used to filter out invalidations (such as the exclusive invalidation) that
> don't need to be retried.

Do you mean the mmu_interval_read_begin|retry() calls?

Hmm, the thing is.. to me FOLL_SPLIT_PMD should have similar effect to explicit
call split_huge_pmd_address(), afaict.  Since both of them use __split_huge_pmd()
internally which will generate that unwanted CLEAR notify.

If that's the case, I think it fails because split_huge_pmd_address() will
trigger that CLEAR notify unconditionally (even if it's not a thp; not sure
whether it should be optimized to not notify at all... definitely another
story), while FOLL_SPLIT_PMD will skip the notify as it calls split_huge_pmd()
instead, who checks the pmd before calling __split_huge_pmd().

Does it also mean that if there's a real THP it won't really work?  As then
FOLL_SPLIT_PMD will start to trigger that CLEAR notify too, I think..

-- 
Peter Xu

