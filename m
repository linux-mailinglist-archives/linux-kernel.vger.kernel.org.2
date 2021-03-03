Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0716332BA83
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 21:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357821AbhCCLYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 06:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244788AbhCCCq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 21:46:57 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62C5C061793
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 18:46:08 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id e2so19500462ljo.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 18:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PlAt31SpIg8w5ZqFFQBggiEL5ACV+/LKER4FjGh9+/s=;
        b=P5C+z30lvIe7LfJvguY5pepEjmeAtyVqyzNYuqvoJxVQ7MvSOVo+RjJi7UUaeC16QR
         LA4v/h3O7YbLbvcPYMXLRGjOSr1tPwiaO6ezb9Yh0cF82Svvw/5xrHN7sQsc3EPlvX2z
         HC6XWZJ6PCGabd9JJxSpUrnCF/Q4eB2gZS5rY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PlAt31SpIg8w5ZqFFQBggiEL5ACV+/LKER4FjGh9+/s=;
        b=LqwlPtBtuCeGVkA0V9TO7bgxbHrv6g8tTzSCMBKfP0fRsUBLNghElSTa8FpsIv6LT5
         Ic85e0UTWXYiiUVSAkeH6XaQ4Sp39Umfa4aUlqaT3c+6nx9/Z4j41k/ADowsrcqGZsVe
         nX7SktLpSRlQv+ZakmXxqeY9H3hPbXi551QKHe+lQ5oEmUr9Y43kh9c+ZDTo8uCiUu5F
         i7oP+3h/U7iYmJEargK1rOCm243bDCcbLigHG+YbCscyx2xnPg3GBCOItr+7ifK7dIyv
         7zF3BtptYCq2ELcLQ0z+TuWUjk4qhYloGPTk+qf9IFDDdUHU5AiTv/Gpie5PYOeDrPZA
         DPdQ==
X-Gm-Message-State: AOAM533tYCFV4rpgyj3EQxkld6HfgUCBSGUzusjeUGS1wsX/GgAtyRh0
        iM1VvM+Fb144u50sEYMC/+FU96SeDcwbFg==
X-Google-Smtp-Source: ABdhPJyrwH+kIhTQ0yHeY34fignClZ+b+SqKBT+n3ZHg4V7x51sIRQUFecbGCMdtSpYYAVhfROuN2w==
X-Received: by 2002:a2e:a583:: with SMTP id m3mr4560322ljp.133.1614739566844;
        Tue, 02 Mar 2021 18:46:06 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id v129sm315631lfa.43.2021.03.02.18.46.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Mar 2021 18:46:05 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id k12so17668101ljg.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 18:46:05 -0800 (PST)
X-Received: by 2002:a05:651c:3c1:: with SMTP id f1mr12804554ljp.507.1614739564909;
 Tue, 02 Mar 2021 18:46:04 -0800 (PST)
MIME-Version: 1.0
References: <20210217233547.93892-1-peterx@redhat.com> <20210301141151.GA397383@xz-x1>
 <20210301162846.c1f684a5662d37bbec3f1892@linux-foundation.org> <20210303014655.GS397383@xz-x1>
In-Reply-To: <20210303014655.GS397383@xz-x1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 2 Mar 2021 18:45:49 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgh+f7+qj5pgfvZnJa_v+=BKuUS7d33e5xvk1Fa0esCXQ@mail.gmail.com>
Message-ID: <CAHk-=wgh+f7+qj5pgfvZnJa_v+=BKuUS7d33e5xvk1Fa0esCXQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] mm/hugetlb: Early cow on fork, and a few cleanups
To:     Peter Xu <peterx@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gal Pressman <galpress@amazon.com>,
        Matthew Wilcox <willy@infradead.org>,
        Wei Zhang <wzam@amazon.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        David Gibson <david@gibson.dropbear.id.au>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jann Horn <jannh@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrea Arcangeli <aarcange@redhat.com>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 2, 2021 at 5:47 PM Peter Xu <peterx@redhat.com> wrote:
>
> As Jason and Wei pointed out, I think some userspace still got corrupted data
> without this series when using hugetlb backend.  I don't think it'll suite for
> a late RC release but it'll still be great if it can be considered as an early
> rc candidate, ideally rc1 of course.  If you prefer the other way, I can also
> repost it before 5.13 merge window opens.

I think with my merge window delay issue, you guys have the perfect
excuse for pushing it a bit late and it still hitting 5.12

                Linus
