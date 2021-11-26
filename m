Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E846845E391
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 01:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351698AbhKZAGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 19:06:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46800 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350988AbhKZAEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 19:04:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637884854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0fqUjxGJvAmNwh+9GycDzUAaW22WJkGJ7g2kBi0jBnA=;
        b=igqa0aaS3oIPkR0vnhp5z7HfaGuoUWKV3yRJlXxnO9gePDqcbxMCA1kssum1GlRceb+3ZI
        BE56QGlEg21fL25AFbMwZI6iq/v0bDHVQU1wVFvvG3WmtvGpQhafvT/JQx88fXCjNdqU0s
        1ElnEaiw81IJMd1uLJo0yiGCsxGgbDQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-312-db-Guo8rNy-J8aP2Wu1axQ-1; Thu, 25 Nov 2021 19:00:53 -0500
X-MC-Unique: db-Guo8rNy-J8aP2Wu1axQ-1
Received: by mail-pj1-f72.google.com with SMTP id mv1-20020a17090b198100b001a67d5901d2so5110507pjb.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 16:00:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0fqUjxGJvAmNwh+9GycDzUAaW22WJkGJ7g2kBi0jBnA=;
        b=5+Y/OMwzbhTaFemG2/LGce3xD+0JAXeFs6PcdpUjVaF6kjV2NKUdhiABRylqwvwL90
         tRIVCsWpV1KMq9aR+Bvpyh8EiTdS21NrLa1AFUdaZUW70b52tH68N9y4fY2sfTnnMHAI
         bzLYq6PEc2km8CuYDWMAH31yj+GFn5Q9jLOAX6Z1V+PZ0M4BN608idFaA5vCO+ntEcia
         kq3peH1YcbO0sYkuNIxNPYTa0RkW74eeQ5I5D84C9mCscEOGQoco1rnaoyN7fXizqB4Z
         a7ITN7zzc+lTNPJdRzIMJnAdoU3pLntMrSb3ShhQLWu/KslEgQ/TUgnYyZWyj0Cq1u2w
         gFJg==
X-Gm-Message-State: AOAM531EadAvPMTxM/mCEWqeQZ4E9Q1slZOJgyppLDYBLFeQ/x+AK+Lb
        nkWmrkamZqCznCJ+MOuatyPFdjReoc/RByeMTkqaFt04567dxBr5Yrz7DDvUajD+8j3WUdyO+gF
        HejKZs4A0RsPXZweewEqh2n7q
X-Received: by 2002:a17:902:e547:b0:141:ddbc:a8d6 with SMTP id n7-20020a170902e54700b00141ddbca8d6mr34238858plf.27.1637884852216;
        Thu, 25 Nov 2021 16:00:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxugDhZXUCujZt/BGJr90/hD7civMzObjEEBQ1B3/fLPPeUdpRiGWVp+WALh3ykiP0XE9Nb5A==
X-Received: by 2002:a17:902:e547:b0:141:ddbc:a8d6 with SMTP id n7-20020a170902e54700b00141ddbca8d6mr34238830plf.27.1637884851916;
        Thu, 25 Nov 2021 16:00:51 -0800 (PST)
Received: from xz-m1.local ([94.177.118.150])
        by smtp.gmail.com with ESMTPSA id k14sm4579753pff.6.2021.11.25.16.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 16:00:51 -0800 (PST)
Date:   Fri, 26 Nov 2021 08:00:44 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     David Hildenbrand <david@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: split thp synchronously on MADV_DONTNEED
Message-ID: <YaAjrJiImYSqjTvB@xz-m1.local>
References: <1b30d06d-f9c0-1737-13e6-2d1a7d7b8507@redhat.com>
 <CALvZod5sFQbf3t_ZDW6ob+BqVtezn-c7i1UyOeev6Lwch96=7g@mail.gmail.com>
 <92fe0c31-b083-28c4-d306-da8a3cd891a3@redhat.com>
 <CALvZod4C1V6Gk96oMCMguaqChjggH0KH3KKcU1QOmjRG+QEAbQ@mail.gmail.com>
 <c61a6f30-ed62-7773-3371-981102f6804f@redhat.com>
 <CALvZod7xTfg5aeQC7-EaOZJ47Twb8CkoS6u4C=8+y+AX-NREVw@mail.gmail.com>
 <1b400921-8bef-8073-10f9-a7cbb09cfefe@redhat.com>
 <CALvZod6wyF7v1v888StoXSSWtb7ujaeBUnUB8Vs2RfMzUsj+Gw@mail.gmail.com>
 <YZ9gz8WGic8QOTxE@xz-m1.local>
 <CALvZod5166ReiM7J6kbky6+nRxiY5KbAdx4Yh8njnPddR+nXdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALvZod5166ReiM7J6kbky6+nRxiY5KbAdx4Yh8njnPddR+nXdQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 09:14:30AM -0800, Shakeel Butt wrote:
> On Thu, Nov 25, 2021 at 2:09 AM Peter Xu <peterx@redhat.com> wrote:
> >
> [...]
> >
> > Hi, Shakeel,
> >
> > I saw your v2 has started to pass in zap_details, then we need know the side
> > effect on that skip-swap-entry thing because with your v2 code munmap() will
> > start to skip swap entry too (while it was not before).
> >
> > I saw that you didn't mention this in v2 patch either in commit message or
> > code, not sure whether you digged that up.  I think it needs some double check
> > (or feel free to start this digging by reviewing my small patch above :).
> >
> 
> I remember mentioning in the patch that this has dependency on your
> rfc patch. Just checked again and yeah I only mentioned in the
> 'changes since v1' section. I will add it more explicitly in the
> following versions.

Apologize for missing that section.  Yeah depending on that patch should work.

> 
> I will take a close look at your patch as well.

Thanks a lot,

-- 
Peter Xu

