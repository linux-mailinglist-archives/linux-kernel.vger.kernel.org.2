Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD733439C99
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 19:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234745AbhJYREM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 13:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234454AbhJYRDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 13:03:10 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13644C06122B
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 10:00:42 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id x27so10832366lfu.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 10:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r01MkiSCG9b3TSsHY0W4NczLTYFEWZms6aPmneDz2xs=;
        b=bE/Bst06Kjrh/j2f7v/jjGc5oWEpo28WFU8VIDdfWsn67gql0qEa6ytxVFmCGipq6e
         5xyvdjBLKAH7QGe/ybfSbsxq1D1ydrZy7a4KFiywoAnv3kJl6ME9IIv73cAZxuYt8gpW
         CyEogC1yjezBkixJGnRSOhu39HQ/YcPD5htvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r01MkiSCG9b3TSsHY0W4NczLTYFEWZms6aPmneDz2xs=;
        b=v99ZA0Mzvi8GDsGk6bj/Vl4G+uA7SulL/+XkvykPDu4HZfFmV8f/IWURowc7EL/rGN
         RUJ3/dgCQg6S19DmOLhAWOKOQjjMdndseCJiWvvb62Vvwvw+xO55JdtdYRBT5gaUOLUu
         VLp3KPZgtD+Y9tY7VakY7h+qNulQkksdwJUA2t9bjeHd7ogB/8g0Gvz4smMIvRkJf2Ut
         NoMQxs4NVr+MZrcqxV2n578nn8tlRJG8OSniBXSWKVmm8K4I8gu5wTXYW/LxyIuLeie3
         BhbVCunFoQsv6f43LsQrIOaSyBHNHSuEKVfid59JGRdeClSeGu+jFowqW0xmUjUL4wMN
         gDWQ==
X-Gm-Message-State: AOAM533sYtgGZ3kuzmYRpEPH1a1NGmfcbTpVfD440IvBW8PoK8G9zsBq
        vMGPgnGZPnfuPpmo86ssIF+Pd/6aJ1wP8A==
X-Google-Smtp-Source: ABdhPJxklktUC08yUISK5y8WjucVGFK/SDiIhAzbIvW5tGtKUIADHut9y2pINQLS+eZHSf1yo6rB1w==
X-Received: by 2002:ac2:4f02:: with SMTP id k2mr18251743lfr.455.1635181239712;
        Mon, 25 Oct 2021 10:00:39 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id bu5sm1603014lfb.50.2021.10.25.10.00.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 10:00:38 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id u11so5220330lfs.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 10:00:38 -0700 (PDT)
X-Received: by 2002:a05:6512:13a5:: with SMTP id p37mr17105725lfa.474.1635181238328;
 Mon, 25 Oct 2021 10:00:38 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000064451505cf0a3aa2@google.com> <CAHk-=wj=jthBt0XOjqstiYYROGhJAM0xrsWBVQgGMk79JBaKDg@mail.gmail.com>
 <YXW9lmQVx1PLX9aj@casper.infradead.org>
In-Reply-To: <YXW9lmQVx1PLX9aj@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 25 Oct 2021 10:00:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiJRdV-7NYvh+8mzDtuPvTg6PHHUedeVXjY92+gxhYJbw@mail.gmail.com>
Message-ID: <CAHk-=wiJRdV-7NYvh+8mzDtuPvTg6PHHUedeVXjY92+gxhYJbw@mail.gmail.com>
Subject: Re: [syzbot] WARNING: refcount bug in memfd_secret
To:     Matthew Wilcox <willy@infradead.org>
Cc:     syzbot <syzbot+75639e6a0331cd61d3e2@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        jordy@jordyzomer.github.io, jordy@pwning.systems,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 24, 2021 at 1:10 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> I agree with you and suggested that if anybody really cares (I mean,
> you need a multi-TB machine to produce this problem) that we simply do
> what we did with the page refcount:

Ack. That looks like the right thing to do.

> +       if (atomic_read(&secretmem_users) < 0)
> +               return -ENFILE;

If somebody sends me a proper patch with a sign-off etc, I'll happily
apply that two-liner. Hint hint.

              Linus
