Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3976644E272
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 08:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233781AbhKLHoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 02:44:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:40344 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232791AbhKLHoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 02:44:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636702884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LmIYVgQWINOS/4GPj7vitVLbYIw2tQyXzHOCJlZ5erE=;
        b=UxZhEqJGMm6mkqEnPEhkGCOBuG2nL0w6JJGw3DMOf/FQwuXNQPIJ4fu7zXSOz2WDG/4kdE
        QhGsCf57aH4BaXL7MEk1LnKZUAs9ojIe/thshGDttaNK7zrZmBldymL607gI1OMHuw3Nsj
        j299/FxdfNIwcS338jSetHf/q3J+ohA=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-sC5bvMJMOo-zfTFzOSsEBw-1; Fri, 12 Nov 2021 02:41:23 -0500
X-MC-Unique: sC5bvMJMOo-zfTFzOSsEBw-1
Received: by mail-pl1-f200.google.com with SMTP id j6-20020a17090276c600b0014377d8ede3so3883444plt.21
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 23:41:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LmIYVgQWINOS/4GPj7vitVLbYIw2tQyXzHOCJlZ5erE=;
        b=PYurhCy2LsdrD4Z9C8Of4GzfkkEeMDGCBMn9CQFid473kvpkiP96YPREMHWcNg2SKj
         y7r1/+bwhNri4Cu4QCMI1pfm2qXhBg8p4jvV0ZSp1TVBlBUagtX8jXo2QYHJmfalmloc
         Tzg+7lWNcKweaITuDj/z5iujBwzsb1MtMq+L7Iq+DluhXDJtK0sHlJUZhiv86L+hEGVv
         cWGkbF4J8rk4I6LgryVPhBJReAHdcwRW3KAXVTcZ11+0tE3ARRS3vw6T5JDVl5ktQcoH
         J8gxrLtIfw1vmCbepK7JlTVGeauEHocCQ52nbymAi7SNJ3h1pSLbFJF5ji5tPpqFLNn+
         SZjA==
X-Gm-Message-State: AOAM532EZddQJvbQEsQtZj9XPHuHAvPF6Kt4vpFDjVOv25B45mtkVo2o
        n4zAwuxvo4AUApUxXzO6IuuK58olBmcaEM6lt33AJGEqMXXoCJgFogLhL8is9S8s8dBHfi86bzw
        dsVc+rwKxwKFUoKYHLmm91db+
X-Received: by 2002:a17:90a:6583:: with SMTP id k3mr34161321pjj.147.1636702882449;
        Thu, 11 Nov 2021 23:41:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwYU6pU2s+wZvuogOQ3U+/jYMIOI6bwB5fRtApXzVv4JQPB8e07gFu11espB+vV+ZhMupPz8w==
X-Received: by 2002:a17:90a:6583:: with SMTP id k3mr34161288pjj.147.1636702882161;
        Thu, 11 Nov 2021 23:41:22 -0800 (PST)
Received: from xz-m1.local ([94.177.118.141])
        by smtp.gmail.com with ESMTPSA id w5sm5755612pfu.219.2021.11.11.23.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 23:41:21 -0800 (PST)
Date:   Fri, 12 Nov 2021 15:41:14 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Mina Almasry <almasrymina@google.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Paul E . McKenney" <paulmckrcu@fb.com>,
        Yu Zhao <yuzhao@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Florian Schmidt <florian.schmidt@nutanix.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v4] mm: Add PM_HUGE_THP_MAPPING to /proc/pid/pagemap
Message-ID: <YY4amnb1kcBEVw3E@xz-m1.local>
References: <20211107235754.1395488-1-almasrymina@google.com>
 <YYtuqsnOSxA44AUX@t490s>
 <c5ed86d0-8af6-f54f-e352-8871395ad62e@redhat.com>
 <YYuCaNXikls/9JhS@t490s>
 <793685d2-be3f-9a74-c9a3-65c486e0ef1f@redhat.com>
 <YYuJd9ZBQiY50dVs@xz-m1.local>
 <8032a24c-3800-16e5-41b7-5565e74d3863@redhat.com>
 <CAHS8izPKN96M2GbHBC6_-XCr1pYy7uA-vNw2FHe01XbYMVdKUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHS8izPKN96M2GbHBC6_-XCr1pYy7uA-vNw2FHe01XbYMVdKUQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 09:42:25AM -0800, Mina Almasry wrote:
> Sorry, yes I should update the commit message with this info. The
> issues with smaps are:
> 1. Performance: I've pinged our network service folks to obtain a
> rough perf comparison but I haven't been able to get one. I can try to
> get a performance measurement myself but Peter seems to be also seeing
> this.

No I was not seeing any real issues in my environment, but I remembered people
complaining about it because smaps needs to walk the whole memory of the
process, then if one program is only interested in some small portion of the
whole memory, it'll be slow because smaps will still need to walk all the
memory anyway.

> 2. smaps output is human readable and a bit convoluted for userspace to parse.

IMHO this is not a major issue.  AFAIK lots of programs will still try to parse
human readable output like smaps to get some solid numbers.  It's just that
it'll be indeed an perf issue if it's only a part of the memory that is of
interest.

Could we consider exporting a new smaps interface that:

  1. allows to specify a range of memory, and,
  2. expose information as "struct mem_size_stats" in binary format
     (we may want to replace "unsigned long" with "u64", then also have some
      versioning or having a "size" field for the struct, though; seems doable)

I'm wondering whether this could be helpful in even more scenarios.

-- 
Peter Xu

