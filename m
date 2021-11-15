Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F09545039E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 12:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbhKOLke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 06:40:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:60848 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230494AbhKOLkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 06:40:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636976229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fWcZZsgQOAso1mx0RHkRaCfmhEXrgIWNcifLJw+coog=;
        b=RlXbSa8MjZfdIF9NJ4UOAduZK4NnZutN7JlDmc/kGVIzPA6yX7MsSc/+uzm4L6dHtUIU6d
        7wwl5Zizgf+2utuYqiHa8Q3kbZ0g1N9ZaxD5KPSl8sXDGuulzqMVA2geftTYtTYmreOM6Z
        J2b6bYSKQWTM7u+dnL1VxW1TogmwIgY=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-glWBYO9DOa2jhw7-IxzZsw-1; Mon, 15 Nov 2021 06:37:07 -0500
X-MC-Unique: glWBYO9DOa2jhw7-IxzZsw-1
Received: by mail-pf1-f197.google.com with SMTP id 184-20020a6217c1000000b0049f9aad0040so9793898pfx.21
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 03:37:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fWcZZsgQOAso1mx0RHkRaCfmhEXrgIWNcifLJw+coog=;
        b=kDTj01dhob4PE/48O7AnOOmeOk+gx+HEpuYQ9IJ2Bb/qNXjTtT4vlBrT+NHGk8gpEb
         o+PShsbPImZwuOz+mbVaBOnH8inQ6C2BV8G8/H33IUrFtNa6OSyvm9b6kBrLkaL6iItr
         v7dYEtoPRIuX0XhxBj8QyrKE+cliMkwy/tJsKScyouf6cCk57F2Q4ICIV9aQzh0f0He5
         qFr84uRsxl37AaAxyn1YqonFGcyZPli7nK+FlDQ1YjKaH8cqaoKKeG/JwfWdYorRlUvy
         GRk/5hMFdZRU5mpqpHJiVtkdlMtcJ0xLFf41qS2sEUejX9wUx0Cf/g+e1o0jr/T24l7J
         cEmw==
X-Gm-Message-State: AOAM530IBras2qN0EfZN53EV4YPQPpRHhbX5w4NOsvutv2ex5sF6kHec
        LoKCdHOEDY0mcvRaI3c3Yo08/FqHdPkPZ5TLZ852AjWYlAfwm0UkcyFul/mxtoqpmY83ItqWcRe
        LBXLoGUl/uecEHPDjlQUkL0jO
X-Received: by 2002:a05:6a00:188a:b0:49f:c31f:b2c3 with SMTP id x10-20020a056a00188a00b0049fc31fb2c3mr32513727pfh.9.1636976226755;
        Mon, 15 Nov 2021 03:37:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwUWvk0nHKiGokqgCW4tmnKRRgIPnG7AT9YnPKPuqVrUfPf/cpmMXUHSUdBhSCVprLzSyRC+Q==
X-Received: by 2002:a05:6a00:188a:b0:49f:c31f:b2c3 with SMTP id x10-20020a056a00188a00b0049fc31fb2c3mr32513707pfh.9.1636976226519;
        Mon, 15 Nov 2021 03:37:06 -0800 (PST)
Received: from xz-m1.local ([94.177.118.80])
        by smtp.gmail.com with ESMTPSA id w192sm14640457pfd.21.2021.11.15.03.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 03:37:06 -0800 (PST)
Date:   Mon, 15 Nov 2021 19:37:00 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH RFC 2/2] mm: Rework swap handling of zap_pte_range
Message-ID: <YZJFVK8g8LhWlICo@xz-m1.local>
References: <20211110082952.19266-1-peterx@redhat.com>
 <20211110082952.19266-3-peterx@redhat.com>
 <71100340.4M9YG836mP@nvdebian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <71100340.4M9YG836mP@nvdebian>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 10:21:18PM +1100, Alistair Popple wrote:
> Hi Peter,

Hi, Alistair,

> 
> I was having trouble applying this cleanly to any of my local trees so was
> wondering which sha1 should I be applying this on top of? Thanks.

Thanks for considering trying it out.  I thought it was easy to apply onto any
of the recent branches as long as with -mm's rc1 applied, and I just did it to
Linus's 5.16-rc1 in my uffd-wp rebase:

https://github.com/xzpeter/linux/commits/uffd-wp-shmem-hugetlbfs

This commit is here:

https://github.com/xzpeter/linux/commit/c32043436282bb352e6fe10eb5fa693340fe5281

It could be that "git rebase" is normally smarter so I didn't notice it's not
applicable directly.

I'll repost a new version soon, please also consider to fetch directly from the
git tree too before I do so.

Thanks,

-- 
Peter Xu

