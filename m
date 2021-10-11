Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8740342998B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 00:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbhJKW7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 18:59:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60986 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229576AbhJKW7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 18:59:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633993049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qXN/vzdwnclocStV3rAgvMW+lzmIwxCoY9r4CfSlUdw=;
        b=MP6jGY0QErblbSBquwp4bxT3E1awuFlPntZHbtj2Em9mk4P8cNkIHfhdaCyBmqa5Rin1PQ
        QxjxACKG8fFRLJukpOJQbXyrRDTVtIpXv7vo10R14k4+7x3fBG22+WlV2V+3HbQ6EubmYp
        0iFtohas815dv1c0HPXm6PNUWxqH8j4=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-SqyiTHxMOaKyz-C3-CfEMQ-1; Mon, 11 Oct 2021 18:57:28 -0400
X-MC-Unique: SqyiTHxMOaKyz-C3-CfEMQ-1
Received: by mail-pg1-f197.google.com with SMTP id g26-20020a63521a000000b0029524f04f5aso7608158pgb.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 15:57:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qXN/vzdwnclocStV3rAgvMW+lzmIwxCoY9r4CfSlUdw=;
        b=0T6eoftIowMWXI9avwPHvymZiz63UIhWF1mFpAd3z45Is+TosQlXFxkogzVZv6iVnz
         gSgxDQRl4V6S9K5l2OP1R3/M8enfomdMyCC0q8COoNYUfM/2BD5NtN42rzZJvMjp5qYe
         YSl+bRUj3XU+6jA4qkcDdPglwkLWHRCzap0ZZQQt+a34B0kA7XnByzOMWqaPr+D+7HT6
         060H298jwfe8Kkp97Ngmrf328o1sz3vkaKe5Cp19u6nTp7ESYZz7igSehHq1JKDXm0en
         9D+fmBhmDKkDRdPqZbJ1UqvYJNoklOEnGGy4v/xPoAyl2zoD57mOCXHclK5gMjc9UsaE
         OOAw==
X-Gm-Message-State: AOAM530KQhuN92NiqezAl7G8IvkQWu9vMemSVwyWTTyDF08KtTm9gOXk
        o3G5f5qPgFzh+I4q1XxzWYcKmLQIi83G0fjmo5UfbfE6NepmI5yO8NqhJ9v0f4WMSw53lgk1ivj
        CzlGXk2pezRcEeaThg4nBNIWD
X-Received: by 2002:a17:903:22cc:b0:13e:fa73:6fef with SMTP id y12-20020a17090322cc00b0013efa736fefmr27329637plg.25.1633993046991;
        Mon, 11 Oct 2021 15:57:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7tlCmjti8dDtX3s90mHbpNajYA411v7qqZAafpSxBDhxylbZeGvAJU/eVUmaUhZ21fDfU6w==
X-Received: by 2002:a17:903:22cc:b0:13e:fa73:6fef with SMTP id y12-20020a17090322cc00b0013efa736fefmr27329611plg.25.1633993046632;
        Mon, 11 Oct 2021 15:57:26 -0700 (PDT)
Received: from t490s ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id k190sm8664644pfd.211.2021.10.11.15.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 15:57:25 -0700 (PDT)
Date:   Mon, 11 Oct 2021 18:57:18 -0400
From:   Peter Xu <peterx@redhat.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Yang Shi <shy828301@gmail.com>,
        HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+jIOebtOS5nyk=?= 
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
Message-ID: <YWTBTg0JCgBb14Ae@t490s>
References: <20210930215311.240774-1-shy828301@gmail.com>
 <20210930215311.240774-3-shy828301@gmail.com>
 <20211004140637.qejvenbkmrulqdno@box.shutemov.name>
 <CAHbLzkp5d_j97MizSFCgfnHQj_tUQuHJqxWtrvRo_0kZMKCgtA@mail.gmail.com>
 <20211004194130.6hdzanjl2e2np4we@box.shutemov.name>
 <CAHbLzkqcrGCksMXbW5p75ZK2ODv4bLcdQWs7Jz0NG4-=5N20zw@mail.gmail.com>
 <YV3+6K3uupLit3aH@t490s>
 <20211008093529.sb54gnlbhuiy6klr@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211008093529.sb54gnlbhuiy6klr@box.shutemov.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2021 at 12:35:29PM +0300, Kirill A. Shutemov wrote:
> JFYI, git blame -w ignores whitespace changes :P

Thanks, Kirill. :)

I must confess in reality I didn't encounter white-space changes a lot, but
mostly on moving the code around either e.g. by putting things into, or out of,
"if/for" blocks, or moving code between files.

I used git-blame a lot not to looking for people to blame but to dig history of
code changes, not sure about how others do that.  So maybe it's just that I
didn't do it right beforfe, and I'll be more than glad to learn if there's more
tricks like the "-w" one (which I don't know before..).

-- 
Peter Xu

