Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E32421865
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 22:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236120AbhJDU2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 16:28:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:54980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235444AbhJDU2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 16:28:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D9D9B611F0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 20:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633379200;
        bh=+j6iW1HJ6VNM1YovE/pabuUcnQL+weiXJ3J12Bf98GM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZCksl3VXuTapt4dY5+83zKtOxoamasb/PEfHx+bjJnkX/cQd7vAJ8a/lC30xnukEi
         MZwFS3SXf1Ex1g3HMUb/9IqYuG/WWj5Xh5hxmwBNRNnY16lTTVgINO0rR7/b6zFsoA
         KUpyVgyJ7+G+41+GGCaSmw22b5kxNYjj6/MYzbnMBWatmBu6KO1rUuyjVNf5ZP5RtS
         26a4Z67naja839ozfzTGjgzAL7UjBztU7Zum4rXhQT58aHE35G1AZ+U2zFWG2mKLIz
         Pvk6E1DUC29XZb/d+Hkeu7rCBMUXBs7IKTgi1EV8ct7YAaKWFCp+LDszmyr9ak5Ewr
         V3XhccxwJd1eA==
Received: by mail-lf1-f44.google.com with SMTP id i24so27211686lfj.13
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 13:26:40 -0700 (PDT)
X-Gm-Message-State: AOAM530NP7UXeRZvCRgn0OP7NNy0z+dhlkfwhdFg/RgGvv5QwRajhQ8l
        L+op3Gk6qWrgrDfzkOwYQk5TOARXW8y08/KqXE8=
X-Google-Smtp-Source: ABdhPJwNYjngyoyIQvFka4I+W59Xe0gV4hu9BjHZ8BwMzckuI+GmD7/CAgeUK6oarsdN14IcqWiO+5bCXk+2hmmVngE=
X-Received: by 2002:a05:6512:39c4:: with SMTP id k4mr16294730lfu.14.1633379197973;
 Mon, 04 Oct 2021 13:26:37 -0700 (PDT)
MIME-Version: 1.0
References: <BC145393-93AC-4DF4-9CF4-2FB1C736B70C@linux.alibaba.com>
 <20210923194343.ca0f29e1c4d361170343a6f2@linux-foundation.org>
 <9e41661d-9919-d556-8c49-610dae157553@linux.alibaba.com> <CAPhsuW4cP4qV2c_wXP89-2fa+mALv-uEe+Qdqr_MD3Ptw03Wng@mail.gmail.com>
 <68737431-01d2-e6e3-5131-7d7c731e49ae@linux.alibaba.com> <CAPhsuW4x2UzMLwZyioWH4dXqrYwNT-XKgzvrm+6YeWk9EgQmCQ@mail.gmail.com>
 <dde441c4-febe-cfa1-7729-b405fa331a4e@linux.alibaba.com> <CAPhsuW5FONP=1rPh0oPLHsehjfGSDQWn8hKH4v=azdd=+WK2sA@mail.gmail.com>
 <YVSopxYWegtQJ3iD@casper.infradead.org> <CAPhsuW6_2_LxQRrs7xF3omgO22+6goDR=bEjKGRopaS-pHJB2Q@mail.gmail.com>
 <YVT+KWFA8hfSKU+m@casper.infradead.org> <CAPhsuW7tDh2cbA6QpZ993fuwOK=LKVsDYjymA4983riQw4QTkA@mail.gmail.com>
 <8d8fb192-bd8d-8a08-498d-ca7204d4a716@linux.alibaba.com>
In-Reply-To: <8d8fb192-bd8d-8a08-498d-ca7204d4a716@linux.alibaba.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 4 Oct 2021 13:26:26 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5pTyfnfxB11duwxvt5TutYN-1=uP2gu4BwzuEVKrHrsw@mail.gmail.com>
Message-ID: <CAPhsuW5pTyfnfxB11duwxvt5TutYN-1=uP2gu4BwzuEVKrHrsw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm, thp: check page mapping when truncating page cache
To:     Rongwei Wang <rongwei.wang@linux.alibaba.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        William Kucharski <william.kucharski@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 4, 2021 at 10:26 AM Rongwei Wang
<rongwei.wang@linux.alibaba.com> wrote:
>
> Hi,
> I have run our cases these two days to stress test new Patch #1. The new
> Patch #1 mainly add filemap_invalidate_{un}lock before and after
> truncate_pagecache(), basing on original Patch #1. And the crash has not
> happened.
>
> Now, I keep the original Patch #1, then adding the code below which
> suggested by liu song (I'm not sure which one I should add in the next
> version, Suggested-by or Signed-off-by? If you know, please remind me).
>
> -               if (filemap_nr_thps(inode->i_mapping))
> +               if (filemap_nr_thps(inode->i_mapping)) {
> +                       filemap_invalidate_lock(inode->i_mapping);
>                          truncate_pagecache(inode, 0);
> +                       filemap_invalidate_unlock(inode->i_mapping);
> +               }

It is mostly suggested by Matthew. If the patch goes that way, you can add

Tested-by: Song Liu <song@kernel.org>
