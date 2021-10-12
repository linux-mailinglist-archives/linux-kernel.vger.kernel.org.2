Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07A21429B23
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 03:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbhJLBqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 21:46:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37544 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229847AbhJLBqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 21:46:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634003062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N7XuxV1xdve3zt5mwi5zf9rSsN0pawUAPW+pIisdSIo=;
        b=ax131Si4wF6HBCBurh5MKfTQ53AiYwmsU+iAF0zhelt0JGdnFHnA6BtZ2M+ZrzhAXdi1Ca
        leTF/rVTyfPmV0yiPYI3hJQ3xbtn5lVBfo7q4aplZkd5rzx5kOqtrwGVGUgsu/0VmrFXDc
        odDzbtOA7xtSXXVFgY/Ku3ots82LYk0=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-AGjqv4S6PNuudrXC1ETRrg-1; Mon, 11 Oct 2021 21:44:21 -0400
X-MC-Unique: AGjqv4S6PNuudrXC1ETRrg-1
Received: by mail-pg1-f200.google.com with SMTP id z7-20020a63c047000000b0026b13e40309so7781229pgi.19
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 18:44:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N7XuxV1xdve3zt5mwi5zf9rSsN0pawUAPW+pIisdSIo=;
        b=iWnjfravcAOTdP+V8NzcLdl0s6HxGJZpvi84dO2Qt8Wg7fLvUbX/kKVfpVYcOnSRyX
         EKC8nFjuJJ04h5hBRbXS8Qm9QkTd7Nvd6yoiswHxyJZ5kRSEhr6RX4Y5cYxcoPoezI5c
         WormLpFzZF7L9Dlo5vN1vUF8EBNUxO7+cHn5fIuninOV2ZvMOD5QcBrSpwtdMHmPurHT
         Uju5JWWMQKfoI0ZWY3lQWHm4b3Ax5yB4EVQ3TfuSnCjF+QhIrteXOUro+q9TfwlMmZ58
         j+YmoHWjl5ZGr12dPubAsYYTlk6qNiBeKkGRJHphsTgmg9w0YWLG++LKDYkbISWeJahS
         iZPQ==
X-Gm-Message-State: AOAM532gtJkGcjyX+6NGGW8VaXH/TQm9D38sm69p5krHHMOtsytyZgnH
        qn6aNL89eGWuLc4JYxaY9fPbu8TWq+IqZFf+09LJYyvAnJvoWcWqG2yzPDL2/85mLMvUuVjeyce
        V46C01LvKGL/kEr5eIfM1Ta9o
X-Received: by 2002:a17:90b:3852:: with SMTP id nl18mr2829332pjb.9.1634003060510;
        Mon, 11 Oct 2021 18:44:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwlbuOxtzFHegnIMLUhs4POPvF85B+TNSTe0D0W5qKedOJQ0nmMQPvf79G11R3u3blaCXq0jw==
X-Received: by 2002:a17:90b:3852:: with SMTP id nl18mr2829308pjb.9.1634003060166;
        Mon, 11 Oct 2021 18:44:20 -0700 (PDT)
Received: from t490s ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id a22sm9062988pfg.61.2021.10.11.18.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 18:44:19 -0700 (PDT)
Date:   Tue, 12 Oct 2021 09:44:12 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+jIOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>, Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [v3 PATCH 2/5] mm: filemap: check if THP has hwpoisoned subpage
 for PMD page fault
Message-ID: <YWTobPkBc3TDtMGd@t490s>
References: <20210930215311.240774-1-shy828301@gmail.com>
 <20210930215311.240774-3-shy828301@gmail.com>
 <YV4Dz3y4NXhtqd6V@t490s>
 <CAHbLzkp8oO9qvDN66_ALOqNrUDrzHH7RZc3G5GQ1pxz8qXJjqw@mail.gmail.com>
 <CAHbLzkqm_Os8TLXgbkL-oxQVsQqRbtmjdMdx0KxNke8mUF1mWA@mail.gmail.com>
 <YWTc/n4r6CJdvPpt@t490s>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YWTc/n4r6CJdvPpt@t490s>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 08:55:26PM -0400, Peter Xu wrote:
> Another thing is I noticed soft_offline_in_use_page() will still ignore file
> backed split.  I'm not sure whether it means we'd better also handle that case
> as well, so shmem thp can be split there too?

Please ignore this paragraph - I somehow read "!PageHuge(page)" as
"PageAnon(page)"...  So I think patch 5 handles soft offline too.

-- 
Peter Xu

