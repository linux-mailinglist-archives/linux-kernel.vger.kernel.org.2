Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2E9230FE7F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 21:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240262AbhBDUfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 15:35:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240252AbhBDUej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 15:34:39 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07EBC0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 12:33:58 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id w1so7727113ejf.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 12:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CcswhGyfXRiTPz9gofVZNM6e1Bjyjyjbhu9XEf22VTI=;
        b=G/UQyzZ2rkb5i0SW1/XtGktTNH8JMArV7APS+ybJgQxaCj8OPAOXA0GKbsn22jmUtj
         If6gprW4MJe9pVcfZknvlVBZmxBDaik1LmlRUgPjdGL3bcas0L50Xfq147xno8zaEfWD
         np0IUJ+CKiao9iNXejHqxHOA67/1Jizs/45sU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CcswhGyfXRiTPz9gofVZNM6e1Bjyjyjbhu9XEf22VTI=;
        b=b+ApaO7oIWOOMrDvKxZ5SsWTl0x09pGkpWBwjrFQl1ZUudSj9CObZF+bNmOEueb8Sp
         lKuRoRmbITx2j5crDCUsRgNkEH/R53JRI8Zsb4vL4j4yxlO8a7fHf3w5TfzlK4tNZUsi
         pqBaqpEEM4y7lCKF3oAr68ybfSwFrd2z0DgKUw0I4JuprhKsnigz3jLui5Ubrsj9+bMB
         tUTF+55DDSUbXV0pv0s8CMTOTUHMyiQMbAhkp/hZwKcKz2yeRNDfBiOwEutAk76R9/9g
         Xs3z1n4qQsBoY+wyDuKShT7axYLIC4PdcIHNadvm2XX/36ELOJyAiIXy7ZU6SPhTbAXi
         8o9A==
X-Gm-Message-State: AOAM533vJbZrdb/+wwzr0A/+HY5a/dhZ7LrQv0sos7+zu+hHAxdB5ZA+
        W6nn8vZh//nO2WOiNQONRsHBzwcJUHN7fg==
X-Google-Smtp-Source: ABdhPJxN9W6VEiSCz+w04Yt2bxuwu01xpUr3VhE8p96A2bg1+iaIIikNPvGNJrghl1hFK5WpVh41vg==
X-Received: by 2002:a17:906:388a:: with SMTP id q10mr842074ejd.496.1612470834796;
        Thu, 04 Feb 2021 12:33:54 -0800 (PST)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id a25sm2946951eds.48.2021.02.04.12.33.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Feb 2021 12:33:54 -0800 (PST)
Received: by mail-wr1-f43.google.com with SMTP id p15so5083180wrq.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 12:33:54 -0800 (PST)
X-Received: by 2002:a05:6512:2287:: with SMTP id f7mr592095lfu.40.1612470381750;
 Thu, 04 Feb 2021 12:26:21 -0800 (PST)
MIME-Version: 1.0
References: <20210204145033.136755-1-peterx@redhat.com> <20210204202055.192260-1-peterx@redhat.com>
In-Reply-To: <20210204202055.192260-1-peterx@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 4 Feb 2021 12:26:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj=w599jsY_OhRQF2hUn6ciOyL0=-VyVMZV=znQfaH0jQ@mail.gmail.com>
Message-ID: <CAHk-=wj=w599jsY_OhRQF2hUn6ciOyL0=-VyVMZV=znQfaH0jQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/4] mm: Use is_cow_mapping() across tree where proper
To:     Peter Xu <peterx@redhat.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jan Kara <jack@suse.cz>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Gal Pressman <galpress@amazon.com>,
        Wei Zhang <wzam@amazon.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alexey Dobriyan <adobriyan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 4, 2021 at 12:21 PM Peter Xu <peterx@redhat.com> wrote:
>
> After is_cow_mapping() is exported in mm.h, replace some manual checks
> elsewhere throughout the tree but start to use the new helper.

Thanks,

                  Linus
