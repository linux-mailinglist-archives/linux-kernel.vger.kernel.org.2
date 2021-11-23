Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7B8B459988
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 02:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbhKWBN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 20:13:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:26537 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230201AbhKWBN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 20:13:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637629851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jSNsXUxZeHRu0Q3CAyM4RATVnGjbqHemvgQDThYQQv4=;
        b=MNaq5YQ26iZCCSh5LAtShkvSKot1HrUkqMHoxzS+v+o92qNaOrIfpuR3VXRBI9/GfRVBUE
        j0BW8BTtRF1FFMTZQ6b/yAWh3uGqlTRz9xe2fpoc4eKEq1CrFwAJVNH8S3rSQfMIF7bjYY
        osXEUiYBI3YZ4fRV+eug44qb1vIVEVA=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-387-ioY1_n94OxWwMsEnW3FLOQ-1; Mon, 22 Nov 2021 20:10:50 -0500
X-MC-Unique: ioY1_n94OxWwMsEnW3FLOQ-1
Received: by mail-pf1-f197.google.com with SMTP id c21-20020a62e815000000b004a29ebf0aa7so10798411pfi.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 17:10:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jSNsXUxZeHRu0Q3CAyM4RATVnGjbqHemvgQDThYQQv4=;
        b=j/6QOmbn9E23ve7N7AQ4yoVYxJiSQ10vOdrhNqB/kwgHrFP9O5h+cJHVcq7l7JKOht
         4L/Bqzm2Abfo/alcqiJjyEOkF6bDVbX/0c+q8fYGVXMcFqbjsXij3t92nX1yZ0TeIFGg
         SZgRQUYrdNvAbKVg0rTF7bSdSwahCD1Bh4VOiTXaEVyQHwgJXZPx13n9Fvu8Gk2ag4Oo
         dzdHhBJwTQcY4n75Ykx1ZWqZYnrSy7IHKkfvUojMtFrrcvWdtTmRKXi0NdJ3r2rlLJJ4
         A9LaBXM8mEigD8jG717DsuTJD6OJD4MRSW+tWqHG0cXxSRm4xF4JqAEgJYt1uEKuuArA
         rVeA==
X-Gm-Message-State: AOAM533d/qCP2CDKvw2PpuO/AkOECDEtNqVIIR7AGpqUFcOOhauWKhk+
        EDvbSQ4DCBCwHVc6ztn68uV6/ATJtKWojjdcPHKVpwdHtO/8AHMznzzMw1Moyzh+inhNVK9eq86
        egzJim46T2hV5kuI+dlcqii/K
X-Received: by 2002:a05:6a00:24cd:b0:49f:bf3f:c42c with SMTP id d13-20020a056a0024cd00b0049fbf3fc42cmr1258154pfv.54.1637629848929;
        Mon, 22 Nov 2021 17:10:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyr+K6p+Ta9LDXXKzVi141QLJFFFwRJJs9XYA9zCFJq4acwgirIvACPF1I3gsGqa7J5/Al6vg==
X-Received: by 2002:a05:6a00:24cd:b0:49f:bf3f:c42c with SMTP id d13-20020a056a0024cd00b0049fbf3fc42cmr1258124pfv.54.1637629848607;
        Mon, 22 Nov 2021 17:10:48 -0800 (PST)
Received: from xz-m1.local ([191.101.132.71])
        by smtp.gmail.com with ESMTPSA id n1sm9671176pfj.193.2021.11.22.17.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 17:10:48 -0800 (PST)
Date:   Tue, 23 Nov 2021 09:10:40 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Mina Almasry <almasrymina@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Paul E . McKenney" <paulmckrcu@fb.com>,
        Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Florian Schmidt <florian.schmidt@nutanix.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v7] mm: Add PM_THP_MAPPED to /proc/pid/pagemap
Message-ID: <YZw/kIl0XYdlcIUR@xz-m1.local>
References: <20211123000102.4052105-1-almasrymina@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211123000102.4052105-1-almasrymina@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 04:01:02PM -0800, Mina Almasry wrote:
> Add PM_THP_MAPPED MAPPING to allow userspace to detect whether a given virt
> address is currently mapped by a transparent huge page or not.  Example
> use case is a process requesting THPs from the kernel (via a huge tmpfs
> mount for example), for a performance critical region of memory.  The
> userspace may want to query whether the kernel is actually backing this
> memory by hugepages or not.
> 
> PM_THP_MAPPED bit is set if the virt address is mapped at the PMD
> level and the underlying page is a transparent huge page.
> 
> A few options were considered:
> 1. Add /proc/pid/pageflags that exports the same info as
>    /proc/kpageflags.  This is not appropriate because many kpageflags are
>    inappropriate to expose to userspace processes.
> 2. Simply get this info from the existing /proc/pid/smaps interface.
>    There are a couple of issues with that:
>    1. /proc/pid/smaps output is human readable and unfriendly to
>       programatically parse.
>    2. /proc/pid/smaps is slow because it must read the whole memory range
>       rather than a small range we care about.  The cost of reading
>       /proc/pid/smaps into userspace buffers is about ~800us per call,
>       and this doesn't include parsing the output to get the information
>       you need. The cost of querying 1 virt address in /proc/pid/pagemaps
>       however is around 5-7us.
> 
> Tested manually by adding logging into transhuge-stress, and by
> allocating THP and querying the PM_THP_MAPPED flag at those
> virtual addresses.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

