Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2ACC418ADF
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 22:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhIZUDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 16:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhIZUDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 16:03:14 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B366AC061570
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 13:01:37 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id s69so22653428oie.13
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 13:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=4i0ebcgiZSt3iiIIOoOHYoxW7mqy1o//v1PH4SJkf08=;
        b=k66FBV1fxgJAOaMfc22JHJVjRD64cFQRTI28+9JDWm2+GCiACg8hB1gxPS2NPERyMh
         yaYjpoyKJRegO56P+NZx8xfGcO6r+EYUYlEKWTbgzQQWqWmc8yzw4QsmeDRRh5vPseI9
         /exdpKUc+ZVJWV0nK3YoLjhkjHT6Feg8bgvlWM35b4iP0eBnv3qrO30lOFAnqszvrXuE
         Mtx9KE04Na19aomkyFMUC4HE4JOcmHDDWmbXJZlX4IJUJnU5A/3b9TBBsXKgxVtsY63K
         nMrxOLHHArVoRcuENVAVECRMPa1pmyXYGu7T2LV6VUwT7FX8FZlplvwbW08bL99VsWQC
         L9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=4i0ebcgiZSt3iiIIOoOHYoxW7mqy1o//v1PH4SJkf08=;
        b=t45ywSswYJBvI3UHOARDXMtig/ivvO9pPynP5rXVIM0Ut3Tu6ftimYA/ehGPeob+mJ
         zhWIJ7ze2TUxbE1bdjjR88WJUq9KIxBH1A8uJqDhgNrP8BztrsvWY2zADe95PiwBbB40
         EnGFpqiNkQiFFI9VIu0W8FlyegWzNcOFvGc29qqZTHwYGS591VDpdkt8VThebp7RzrYW
         GrCxuW9rPmNCqZaFpwRhDeM3fjyeZXLrO5FDMlBoyS+p1wqHVDpJaLELMgAMznuWD3FF
         q4Ets3E4/VXbwbdu0WJf79C5187LSUXU9aHg/qQB2SoabuxWzOTshNfR6kwoQrODigdp
         QzXg==
X-Gm-Message-State: AOAM531jAMdyk847ERV3Lu9ovyB6bTRWCgzyKwposGx5UguYr+Gw7lPP
        v0qg6yfHQc+SC3Ex4ewn5waqrQx34TAMDA==
X-Google-Smtp-Source: ABdhPJx/Jtc2vnPaAEl/lYrasw3bxw2ZwcVy1vVPt9ZezefP6jfZJid8wAWv9Pmgd5C+CmpPqPjVPg==
X-Received: by 2002:aca:bec2:: with SMTP id o185mr9463615oif.30.1632686496463;
        Sun, 26 Sep 2021 13:01:36 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id i25sm3624270oto.26.2021.09.26.13.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 13:01:35 -0700 (PDT)
Date:   Sun, 26 Sep 2021 13:01:21 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     liuyuntao <liuyuntao10@huawei.com>
cc:     hughd@google.com, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, kirill@shutemov.name,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        liusirui@huawei.com, windspectator@gmail.com, wuxu.wu@huawei.com
Subject: Re: [PATCH v2] fix judgment error in shmem_is_huge()
In-Reply-To: <20210926064201.3416154-1-liuyuntao10@huawei.com>
Message-ID: <b2b52cfc-20f2-3f7e-8fc0-ae9b54f34e93@google.com>
References: <614538e2-16bb-2657-f374-64195c5c7c2@google.com> <20210926064201.3416154-1-liuyuntao10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Sep 2021, liuyuntao wrote:
> On Sat, 25 Sep 2021, Hugh Dickins wrote:
> > On Fri, 24 Sep 2021, Hugh Dickins wrote:
> > > On Thu, 9 Sep 2021, Liu Yuntao wrote:
> > > 
> > > > In the case of SHMEM_HUGE_WITHIN_SIZE, the page index is not rounded
> > > > up correctly. When the page index points to the first page in a huge
> > > > page, round_up() cannot bring it to the end of the huge page, but
> > > > to the end of the previous one.
> > > > 
> > > > an example:
> > > > HPAGE_PMD_NR on my machine is 512(2 MB huge page size).
> > > > After allcoating a 3000 KB buffer, I access it at location 2050 KB.
> > > 
> > > Your example is certainly helpful, but weird!  It's not impossible,
> > > but wouldn't it be easier to understand if you said "2048 KB" there?
> 
> I wanted to emphasize that access to any bit in the first page will
> trigger this problem, so I didn't use "2048 KB".

Okay, thanks, I see your point now.  (And I have to admit that, in my
confusion, I had thought 2050 KB would be index 514 - of course not!)

> > > > In shmem_is_huge(), the corresponding index happens to be 512.

...

> > Your patch makes within_size more sensible than it was for pre-sized
> > files (and I think it's fair to say that the majority of files in
> > shmem's internal mount, subject to thp/shmem_enabled, are likely to
> > be fixed-size files); and better-defined than it used to be on
> > growing files, but they won't get the huge pages they used to.
> 
> Although my patch changes shmem's behaviour, it makes shmem consistent
> with the documentation. I think with the new code, it will be easier
> for our users to understand.

Yes, I do agree with you.  But the change in behaviour when appending at
EOF is significant, and needed to be called out - I think none of quite
realized that effect at first.

Hugh
