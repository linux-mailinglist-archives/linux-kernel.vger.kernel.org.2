Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B30139F59B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 13:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbhFHLxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 07:53:47 -0400
Received: from mail-pj1-f41.google.com ([209.85.216.41]:37380 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbhFHLxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 07:53:46 -0400
Received: by mail-pj1-f41.google.com with SMTP id 22-20020a17090a0c16b0290164a5354ad0so13918143pjs.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 04:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=33qUIItaWV8iU0maz7SfEHZWO+xjznU3PiPkfVFxVEc=;
        b=ucvtPg+HlYZ8tqnZs6JrapTooEnRGmebxESXuGhQj0/kLP5o2dXv5i72CxBrG1QyEB
         Md1sjRo+ek617Y20+/qriDA/IO2hofnCiSY/mvwjhbwwsl92MwspA/HTQRQwJDscIc5q
         rSb7M/hu3KcP4DSRUCwLk05XBuw7vz9Vvq9OuuR/hr1u/xttgW2Cc9G3X4J+nBNppUBY
         +vMuL0ZsZtkfrOBsvYD8BZQ3/DgyMGZHdQlXMYVDnCJbZsnWpsvomtXVqOiq9ZGBeR6L
         /LbLKtpIQdScEXK7C+T4AgBvEXsMjq5rs96Hp0IgVJcrcJEU2nFsyAvhbrZJ8xWsn2Ch
         EDcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=33qUIItaWV8iU0maz7SfEHZWO+xjznU3PiPkfVFxVEc=;
        b=Jre3JgM0TbP6Oqlpj/wm0jHZzWvT5osvBTsf0RuO1wPU6UCojHLDMeXXSiKq0Z1/vB
         rOZsYadkj18AoQrUEpJ8kuWGMSoKou+YRmP0fD8aD16qd7RzQtRIqQyxjmYavniVwUdW
         jkXp7Gb4tru07bfzYU1D8z+yQ72UDey1M3fV8pKcdEKz6hNgG57nGOfaMiSMKQXcRRHR
         WJSskYdMne1oOQPY1X89L9obDNNbMwimk2AS60qug/dd4GSSRVFOwFGjstMIQMn59UfV
         8LXv05Mg6rE/vtBkHeR/D6OXBmuyU1io5VyavHiaXkqfmliubJI9zasSdHEATLJje+/O
         47Dw==
X-Gm-Message-State: AOAM533XY5ohFC7vli9RrSulALorewsMudmGGBoplhMXmG1o1BzTQgcT
        FMqCFO7AUTBhRWz8x09WygwwNUEPF0b+qXAUy/w=
X-Google-Smtp-Source: ABdhPJyApDJyTdnWKyOyGV3tWF6munYZNdD0DZqolmNToOfXuZ3gCLfOJEleko0R/Gg+pwXt3JPv6ZY29jFoPT1x69U=
X-Received: by 2002:a17:902:b190:b029:105:cb55:3a7a with SMTP id
 s16-20020a170902b190b0290105cb553a7amr18934867plr.17.1623153039020; Tue, 08
 Jun 2021 04:50:39 -0700 (PDT)
MIME-Version: 1.0
References: <1623141934-7699-1-git-send-email-faiyazm@codeaurora.org>
In-Reply-To: <1623141934-7699-1-git-send-email-faiyazm@codeaurora.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 8 Jun 2021 14:50:22 +0300
Message-ID: <CAHp75VcwW6RGALAjzcK4W9xy_hDPyFti4cNY_pCwJnjUr+VYVQ@mail.gmail.com>
Subject: Re: [PATCH v11] mm: slub: move sysfs slab alloc/free interfaces to debugfs
To:     Faiyaz Mohammed <faiyazm@codeaurora.org>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg KH <greg@kroah.com>, glittao@gmail.com,
        vinmenon@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 8, 2021 at 11:45 AM Faiyaz Mohammed <faiyazm@codeaurora.org> wrote:
>
> alloc_calls and free_calls implementation in sysfs have two issues,
> one is PAGE_SIZE limitation of sysfs and other is it does not adhere
> to "one value per file" rule.
>
> To overcome this issues, move the alloc_calls and free_calls
> implementation to debugfs.
>
> Debugfs cache will be created if SLAB_STORE_USER flag is set.
>
> Rename the alloc_calls/free_calls to alloc_traces/free_traces,
> to be inline with what it does.
>
> Signed-off-by: Faiyaz Mohammed <faiyazm@codeaurora.org>
> ---

It seems you missed the version bump along with changelog.
Note, some maintainers (actually quite many I think) are using tools
to fetch up the patches and two patches with the same version is a
problem. Hence I do not consider it a nit-pick.

-- 
With Best Regards,
Andy Shevchenko
