Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9BD388DE5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 14:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349957AbhESMWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 08:22:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33131 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347770AbhESMWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 08:22:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621426871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iT4YtjBsBt0s/M51Kj84dkt6amzmmMXBn/lNki8qQn0=;
        b=ZefcU8PzDyCvDFwxwj6QzsO4ystN8p7Rbz1oSSuV7uas2fzqrp6WVZfgPW6Ir854umfZhy
        paqU0opFyPlOAVELm69pkVbh9sT8IY092TTvnukKVUIBQ442mscH2qYAOZCeLTg7inZ3L/
        c85b4iFwLo7kN8EVMmBRrZVafAv+InU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-l3ulf3dKPz2S-nmiunzhHQ-1; Wed, 19 May 2021 08:21:10 -0400
X-MC-Unique: l3ulf3dKPz2S-nmiunzhHQ-1
Received: by mail-qv1-f70.google.com with SMTP id l19-20020a0ce0930000b02901efdf1c21ecso7389165qvk.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 05:21:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iT4YtjBsBt0s/M51Kj84dkt6amzmmMXBn/lNki8qQn0=;
        b=Rd2/qS70sG4WCjqRW4UNauG3niu5g6IrUtExKnNCIDE2xgTd8aFgbc37sur2g6TLYs
         pBExaEp7s73i3oIkHhHsw15mxB2FP5OXl1yk7avkJldynydUk1sh97YCJrWouXJkRstH
         4CKcw8w80ga/zy4hUEwTYFD3mkxQ2f/n2JCLrJ63ihZZ5jh8inxu9KNzPp5ZX+NdGKRn
         g6cL4xW1RmfvXj41NnAHWDIjc8zf2v3CiZeWibzPBkq0GbkRkeWbWcyObpC2BjQZORKP
         szgvJ9uphF6XEQ0Ey/Z0L2gT5MOPE5Ubgmsssc/qo5VFTW33rtuORSGBXBO2QqQnCXSU
         k+GA==
X-Gm-Message-State: AOAM531sbInb7Xa3ysGhGypp57LL6SSIPxg5L9sOuSGVW+ryufC4yZkJ
        lM3qy28Nr8t/d4RvcZ3Zt+aWHhwKW0yoFaFz42BM6TJppV7UcfwxbGMIJ9r+Udnlp9k9nKUqsfl
        3/bTv5CWK/mz/toDOgzNiqSrj
X-Received: by 2002:a05:620a:818:: with SMTP id s24mr7432103qks.425.1621426869766;
        Wed, 19 May 2021 05:21:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJym25A+8CZrSnha27nfGC/bkh618yND6m6b6Lo8EgcNF6Oma7UyN8ZK+yut+/9S1ILrFjJgwA==
X-Received: by 2002:a05:620a:818:: with SMTP id s24mr7432081qks.425.1621426869529;
        Wed, 19 May 2021 05:21:09 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id o10sm15018668qki.72.2021.05.19.05.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 05:21:09 -0700 (PDT)
Date:   Wed, 19 May 2021 08:21:08 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, nouveau@lists.freedesktop.org,
        bskeggs@redhat.com, akpm@linux-foundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, jhubbard@nvidia.com,
        rcampbell@nvidia.com, jglisse@redhat.com, jgg@nvidia.com,
        hch@infradead.org, daniel@ffwll.ch, willy@infradead.org,
        bsingharora@gmail.com, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v8 5/8] mm: Device exclusive memory access
Message-ID: <YKUCtA4FrfmkNrn7@t490s>
References: <20210407084238.20443-1-apopple@nvidia.com>
 <47694715.suB6H4Uo8R@nvdebian>
 <YKP5Dj4Q/riGGc43@t490s>
 <2217153.lfGrokb94b@nvdebian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2217153.lfGrokb94b@nvdebian>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 09:35:10PM +1000, Alistair Popple wrote:
> I think the approach you are describing is similar to what 
> migrate_vma_collect()/migrate_vma_unamp() does now and I think it could be 
> made to work. I ended up going with the GUP+unmap approach in part because 
> Christoph suggested it but primarily because it required less code especially 
> given we needed to call something to fault the page in/break COW anyway (or 
> extend what was there to call handle_mm_fault(), etc.).

I see, thank. Would you mind add a short paragraph in the commit message
talking about these two solutions and why we choose the GUP way?

-- 
Peter Xu

