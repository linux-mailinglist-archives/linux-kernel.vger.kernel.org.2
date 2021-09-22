Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16DDF41507D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 21:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237202AbhIVTfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 15:35:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28985 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237186AbhIVTfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 15:35:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632339216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f2f6GY/k+WHkP8PIaS49hP7if2E/jVetS1Wkw8ZmRZ4=;
        b=iTi6h/Z3fLq5MTOXshwN2hrtmCO6ZKNh0pfUTMhnP6JAdF9fGHJtnSoG9xcsOtbyqQrIGa
        N08XFYywKhGbuPngEcpQiyKg74ZlLzwLkdc61+e5EDoirwBWucJTSycxeUiEyJWUM9NHkk
        O5cyWvqkbTkFydo3qP99U1w/Tt7ZzR8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-fM9JfjukO9CGOSc64Y8_Aw-1; Wed, 22 Sep 2021 15:33:35 -0400
X-MC-Unique: fM9JfjukO9CGOSc64Y8_Aw-1
Received: by mail-qk1-f200.google.com with SMTP id bl32-20020a05620a1aa000b004330d29d5bfso11851275qkb.23
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 12:33:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f2f6GY/k+WHkP8PIaS49hP7if2E/jVetS1Wkw8ZmRZ4=;
        b=HGAFy1Hqu2JZpQmYCkbUKbzODsyJUZuJZneBPRpVlqR+YCgjWI6P9/8QXXkopWsc3f
         rRwis73f5qnUuUJ8mx1k4ek2bRCT+mXOTk0Aa3fsawKYcvKpHfT14sU4Wkt0RAyv/2KU
         JVrV1OpfsoDASK0ij9cYaAuMMgk0lHtRvwqGVtJ+I4vk4yJ2PGpYaaNP/pDb6OK+9q0Y
         c+kIkh4fuzFeQ5CJ4YJyYrBF3sl1rskopWM1TDoARm54lHjRNOzfHrV3QN3KNx85lxa+
         0+lRbOhN2zzsGJL838cru8R9hElDElDcDm7URaHmVDNsP3kCDfyjszc+uVJj8OKJCAjq
         hT0w==
X-Gm-Message-State: AOAM5312dGygJpTMblpdP4I+/p0APRDAX7R0m45XdxwAy7BQNa+qd/tt
        BoAaSiaYJzclx0KvaB/v+ezkqxnq7ctPTi4eESq7SEXEmLTv2urHUYMDFtb42kAaL160JWmqxIf
        GwCvcAmIGyATVfFHzwzQivJF1NqSaUwqeq5zoWEHnEOY6bsyDWXbxwsR74lqVjINOfbJ5+4FTwA
        ==
X-Received: by 2002:ad4:496d:: with SMTP id p13mr545496qvy.52.1632339214775;
        Wed, 22 Sep 2021 12:33:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEskVJDI8LuI1oLFi2/J9rYgsc5EpRwJ36kYV2MjmbtvADCj+y/xroIs/VbeLdU5PgFkJOvA==
X-Received: by 2002:ad4:496d:: with SMTP id p13mr545202qvy.52.1632339211549;
        Wed, 22 Sep 2021 12:33:31 -0700 (PDT)
Received: from t490s ([2607:fea8:56a2:9100::d3ec])
        by smtp.gmail.com with ESMTPSA id l1sm2030263qti.94.2021.09.22.12.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 12:33:30 -0700 (PDT)
Date:   Wed, 22 Sep 2021 15:33:29 -0400
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Hugh Dickins <hughd@google.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH] mm/khugepaged: Detecting uffd-wp vma more efficiently
Message-ID: <YUuFCcuHn74STTlZ@t490s>
References: <20210922175156.130228-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210922175156.130228-1-peterx@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 01:51:56PM -0400, Peter Xu wrote:
> Axel: as I asked in the other thread, please help check whether minor mode will
> work properly with shmem thp enabled.  If not, I feel like this patch could be
> part of that effort at last, but it's also possible that I missed something.

Hmm, this seems to be a false-alarm too.

UFFDIO_CONTINUE is fine with thp because shmem_getpage() only returns small
pages.

Khugepaged is fine too on merging small shmem pages into thps, the same reason
as uffd-wp: it zaps ptes only, so previous pte_none() ptes will keep the same,
it makes sure all old pte_none ptes will not continue until a UFFDIO_CONTINUE.

The only last problem is when khugepaged merged small ptes into a thp, then it
could zap ptes even if they existed before.  So for minor mode fault, the uffd
service thread needs to be prepared for false positive messages.

That shouldn't be a problem either, because file-backed memory pgtables are
unstable and prone to lost, so uffd minor fault handler should always be
prepared for false positives anyway..

In summary: please feel free to ignore the above note, and sorry for the noise.

-- 
Peter Xu

