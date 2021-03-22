Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF74343665
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 02:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbhCVBrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 21:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhCVBqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 21:46:40 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B73C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 18:46:40 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id c13so5035433uao.10
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 18:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KDT2f09MXVbOmHcou2TiE6dueEKdk8Bes3XxuA8S9lo=;
        b=bf5Rb7uOgJNkcZyD4ssx3OUSPJ3NXi8uOLDGOCe74yS7Ui4G/F2BvZ8vn3g3421i1r
         205+5mdbPnI2OsA5JkCX/1fozlkOcvCTiUsrBK1eiVLiR+f2qZQP15suPSNFTwX8LGRE
         5wwwmWtwtneH4XB5gNJrRWjNVSsEob53szL84KUX8M7gUY4o6jaArROhgeVoeUdjJ5Ao
         tFGls/mfSSTD7nzH9d0rPW7A93nbBRmKKBUsCkw5IQeQk9ZjeH2v97S08WwKomH+nYrv
         6VhLomWCrgXHoX0KS/mibNaB2NQrXtZU2dD7fegVkN9vo8wa9hdfbBe6pF0AMWhdrmbK
         bMUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KDT2f09MXVbOmHcou2TiE6dueEKdk8Bes3XxuA8S9lo=;
        b=iFVf+luu+iU2lyQQb0+KyR7wwsIXZBL6vE+Y8NpyFYt0fckwTxAzJ5jnXiLCxOqn42
         A7RByQp1tsneh0TufdmJZxiiX7r2z5DFnQXfMnAwNHqAU7ksp4Dqcbxr+pWLNFdQqmJN
         JLUGtRy0MskWfTZG7SIeT5NT2VwIFEkrKTqQkL78MfLEMc6RWUTAZ1o1DJrnS3STika7
         49sl8RuuFW9YqgmgYSee9dEbUIISukvlohkZC4YxDCSvqyzK8iYyeQCkOZCtDJygDErQ
         +HQX2yjbXGhc4Iu59foTzIIpdDyz/0vO703X9D8PTmAUDhv0ePWu1wm0eXYXwgZtGgxX
         Y80w==
X-Gm-Message-State: AOAM530dMEBtlH8FAYfy3jjchJTS1o5bvtSI/t1LGerZke8c3RTPyTsD
        zrczgwnzw1D1ZC/dJgK1JWXN3/WkeXhDyrMLZ2I=
X-Google-Smtp-Source: ABdhPJy3cbxmAhndYEZo9ey6gJkAl7UFtYdJxY1Fx9L7qqzObfPrK2ZX0mNGJ3dAssqcSvH2rRfsA6vjrldhU05TIzs=
X-Received: by 2002:ab0:66c9:: with SMTP id d9mr3823838uaq.29.1616377599379;
 Sun, 21 Mar 2021 18:46:39 -0700 (PDT)
MIME-Version: 1.0
References: <1615967692-80524-1-git-send-email-xlpang@linux.alibaba.com>
 <1615967692-80524-2-git-send-email-xlpang@linux.alibaba.com>
 <42b5dba7-f89f-ae43-3b93-f6e4868e1573@suse.cz> <34a07677-3afe-465c-933e-dc9503e9634d@linux.alibaba.com>
In-Reply-To: <34a07677-3afe-465c-933e-dc9503e9634d@linux.alibaba.com>
From:   Shu Ming <sming56@gmail.com>
Date:   Mon, 22 Mar 2021 09:46:27 +0800
Message-ID: <CANt8P=vwbshvNntPLAkEQFrRfeSHfd1bkxLUhmRXNS2CD_mO_w@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] mm/slub: Introduce two counters for partial objects
To:     Xunlei Pang <xlpang@linux.alibaba.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
        Christoph Lameter <cl@gentwo.de>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <guro@fb.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Wen Yang <wenyang@linux.alibaba.com>,
        James Wang <jnwang@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

More precisely, ss will count partial objects like denty objects with
"/sys/kernel/slab/dentry/partial"   whose number can become huge.

On Thu, Mar 18, 2021 at 8:56 PM Xunlei Pang <xlpang@linux.alibaba.com> wrote:
>
>
>
> On 3/18/21 8:18 PM, Vlastimil Babka wrote:
> > On 3/17/21 8:54 AM, Xunlei Pang wrote:
> >> The node list_lock in count_partial() spends long time iterating
> >> in case of large amount of partial page lists, which can cause
> >> thunder herd effect to the list_lock contention.
> >>
> >> We have HSF RT(High-speed Service Framework Response-Time) monitors,
> >> the RT figures fluctuated randomly, then we deployed a tool detecting
> >> "irq off" and "preempt off" to dump the culprit's calltrace, capturing
> >> the list_lock cost nearly 100ms with irq off issued by "ss", this also
> >> caused network timeouts.
> >
> > I forgot to ask, how does "ss" come into this? It displays network connections
> > AFAIK. Does it read any SLUB counters or slabinfo?
> >
>
> ss may access /proc/slabinfo to acquire network related slab statistics.
