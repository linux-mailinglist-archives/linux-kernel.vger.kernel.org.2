Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5CE63E304C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 22:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244957AbhHFU2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 16:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbhHFU17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 16:27:59 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA84C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 13:27:42 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id bl17so3661628qkb.12
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 13:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=xzQzvEFEGoMscqJhOBHVn5b7he0gZrQNDSjY14VyYOw=;
        b=dq7DMYzv8T9XtjlGdkAS73Ksyq+eHKUjXuLdd3P7n+ajXOycUNW8tkIH668vRXCx02
         MXcW+b0icMCY0tZtxYy/1GBKWpx5Gc+1f/x+aNCLJLQHPmkGspqJPdGm465A+TIZyTYN
         Ixrj8wgaTjgZh/ylqlnj2yAC331OykBbXlO90//0ffIuBpbi46VVgKzqBTP7CafqEXxA
         szhbGbw/wLrFO65JtQR2R9FHYk6J7ofxMO7mAY6ZEXAdIXsmQwPiTFX+N1xFRgZ3NijP
         Obs82xNyl84qdSI8a2hbywUBRzbuKyutrKH9or7Piu9TlcKx/X6SGZHnRb4lsOKPXv3E
         qLIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=xzQzvEFEGoMscqJhOBHVn5b7he0gZrQNDSjY14VyYOw=;
        b=rRXehqGr/627Zyx7ZsepcO7UPy8JLzssY/86x8r7ym98dxeLnB6FJ18TIjvXGfLD1/
         b70CbJm4RjggQgKYrpdxLh9LMpRW4ECNKqMq4dzJBXcxoH0l4dx8B8DgrvNTJG5vNm9f
         iegIswrKxO1ITcc8K86xxs3yzO7yrPI45eujYC7RZWfezCjkljKiNL4iBmfvYhMuqmIR
         OGvxotkuiTY95nezg3XnacI7vdMaJyLG1QHfisrA2tB/GM/JePUJrnQz9AXeeCQ46oiH
         sFB2Ux337MdT/ONooA3RVEfKMpgO/K8UVuhQ8mp8ZxOAE/fQE+u0pAdfGpwJiLM2iiLk
         Wx8Q==
X-Gm-Message-State: AOAM533/Tstm9HIlVv1driocXVAhZXvUfLe/VU1u+aTUlmz/cj0L5l8T
        9NaKB9Z2cPU4Wr5aZMblDRDspA==
X-Google-Smtp-Source: ABdhPJxyXNuZysU3Uk0rolv02J1uEhmrw1GH2+TaNt85aEW1RoW6U5Jrq9ThDt6LOt8Sy1R2Wq8iNA==
X-Received: by 2002:a37:3c5:: with SMTP id 188mr9829169qkd.26.1628281661635;
        Fri, 06 Aug 2021 13:27:41 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id s14sm5438260qke.1.2021.08.06.13.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 13:27:41 -0700 (PDT)
Date:   Fri, 6 Aug 2021 13:27:27 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Zi Yan <ziy@nvidia.com>
cc:     Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/15] Make MAX_ORDER adjustable as a kernel boot
 time parameter.
In-Reply-To: <F34DBD0A-22DE-4CF2-B784-BBDD80A8E85A@nvidia.com>
Message-ID: <6ae6cd92-3ff4-7ed3-b337-a4dfe33da1c@google.com>
References: <20210805190253.2795604-1-zi.yan@sent.com> <0d374eed-cc52-a656-b338-1156782bdf7e@suse.cz> <F34DBD0A-22DE-4CF2-B784-BBDD80A8E85A@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Aug 2021, Zi Yan wrote:
> 
> In addition, I would like to share more detail on my plan on supporting 1GB PUD THP.
> This patchset is the first step, enabling kernel to allocate 1GB pages, so that
> user can get 1GB THPs from ZONE_NORMAL and ZONE_MOVABLE without using
> alloc_contig_pages() or CMA allocator. The next step is to improve kernel memory
> fragmentation handling for pages up to MAX_ORDER, since currently pageblock size
> is still limited by memory section size. As a result, I will explore solutions
> like having additional larger pageblocks (up to MAX_ORDER) to counter memory
> fragmentation. I will discover what else needs to be solved as I gradually improve
> 1GB PUD THP support.

Sorry to be blunt, but let me state my opinion: 2MB THPs have given and
continue to give us more than enough trouble.  Complicating the kernel's
mm further, just to allow 1GB THPs, seems a very bad tradeoff to me.  I
understand that it's an appealing personal project; but for the sake of
of all the rest of us, please leave 1GB huge pages to hugetlbfs (until
the day when we are all using 2MB base pages).

Hugh
