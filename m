Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE1F423992
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 10:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237736AbhJFITQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 04:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237721AbhJFITO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 04:19:14 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B58C061749
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 01:17:22 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id h4so1192676uaw.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 01:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lhXiigKtSAUxKtw77/Z+UYZhqiBVhp3v/PIDZEUz4LE=;
        b=nTUzCfmkBdWSQtd1FE4SByTmPCL5bsaXqJ+H9LCqmmgbtgrwfnXlcE/hjYU6dgmMk9
         BHSg7oxwXa9qWpgJMmMAlBVIbXz4/GIYjQ2qrMFF1m43OICs79r8Mtw3a4UPmVIVpt/I
         8Uw3SeWcjmqdxq07P4qtnxsaCYY6lhhFb2VIfkJKIUf4zJVFHjoPbBsQVHqjqJUeU6DI
         OsZRCqSY/ABsPab/QEb+Gr/JNUGVhCCa91aVr2+QBaLd5LTlm+CJ91hSYrXEMu5tSKaa
         j4DGSQqN3q0z0z1gQq8n5f1ZJRZHISyCSK2ymPrEojbwYR4v/MVOFEdtKLkB2NasvR0s
         oMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lhXiigKtSAUxKtw77/Z+UYZhqiBVhp3v/PIDZEUz4LE=;
        b=aptSf4xHQgKvT+5aJSa6OK8Iv+lrFzzRH4xX0A1AmtQyM/dY2HqXemXr13x3qEMdnF
         1haieCxf03VHiZQ6WJxgRUlGEzzHIde2feXLNxiEiOrwdf+3wtURUFrJE6lEPbRLf4S+
         j7AZacOMOuCe8+QU0qHqx52DL2YpHjtCOl8cahxpr0IzneGVaavICJSabTzZZFSEif9Z
         zYODFwmfvAUXUVM2xTbade90+1KQ9qF6VaHYHYmVIrMikN06RYvxzjTxq2itoCxk0WMI
         B+TkW9P8zCgkxY8wH3WHEDHDZUl6OgxJ98331DCbQfOfDxcAfpFhniMeIf1zmxDPt4BQ
         vYlg==
X-Gm-Message-State: AOAM533ALZTzJfc2yEiy00mOJgVMNGDLKSoMyijPG22+kcy8c8ZVFMT8
        HAACyjxjzCZabX2GkA0VF4U83IfzP1iFhNanjOU=
X-Google-Smtp-Source: ABdhPJxLg8tWkAKRXDxcI63adUXT01siTkRMkz3SwGmrDKy3Io0YT4vrjUijhDroFNZMh7Uv3JjDRhzB/873UEBLnLA=
X-Received: by 2002:ab0:22c5:: with SMTP id z5mr1215925uam.67.1633508242021;
 Wed, 06 Oct 2021 01:17:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAPm50aLBfe7N_udxCkS3-PKbTmUvSpqu0sL7U6qHXZ=OWGQnTQ@mail.gmail.com>
 <914a0b38-cb44-f4be-43aa-bc42bee1553b@redhat.com>
In-Reply-To: <914a0b38-cb44-f4be-43aa-bc42bee1553b@redhat.com>
From:   Hao Peng <flyingpenghao@gmail.com>
Date:   Wed, 6 Oct 2021 16:16:51 +0800
Message-ID: <CAPm50aKRTg2=WMDw+vWvXA5+wADfSo8Kk-PHpAagftGypArU+g@mail.gmail.com>
Subject: Re: [PATCH] mm/huge_memory: disable thp if thp page size is too large
To:     David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 9:19 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 30.09.21 04:14, Hao Peng wrote:
> > From: Peng Hao <flyingpeng@tencent.com>
>
> "disable thp if thp page size is too large" you disable thp if there is
> not sufficient memory installed in the system (and for that, you use THP
> size), something doesn't add up here.
>
In addition, if THP is enabled, min_free_kbytes will be recalculated.
At this time,
min_free_kbytes is calculated based on the size of THP. If the size of
THP is too l
arge, OOM will easily be triggered.
> >
> > After seting the page size to 64k on ARM64, the supported huge page
>
> s/seting/setting/
>
> Fortunately, most distributions already switched to 4k, because 512MB
> THP is pretty much useless, especially on any system that doesn't have
> memory in the range of hundreds of megabytes or terrabytes.
But the ARM64 Server distribution version I use, such as CentOS for ARM64,
 has a page size of 16KB or 64KB.
Thanks.
>
> > size is 512M and 1TB. Therefore, if the thp is enabled, the size
> > of the thp is 512M. In this case, min_free_kbytes will be too large.
> >
> > On an arm64 server with 64G memory, the page size is 64k, with thp
> > enabled.
> > cat /proc/sys/vm/min_free_kbytes
> > 3335104
> >
> > Therefore, when judging whether to enable thp by default, consider
> > the size of thp.
> >
> > Signed-off-by: Peng Hao <flyingpeng@tencent.com>
> > ---
> >   mm/huge_memory.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 5e9ef0fc261e..03c7f571b3ae 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -437,7 +437,7 @@ static int __init hugepage_init(void)
> >           * where the extra memory used could hurt more than TLB overhead
> >           * is likely to save.  The admin can still enable it through /sys.
> >           */
> > -       if (totalram_pages() < (512 << (20 - PAGE_SHIFT))) {
> > +       if (totalram_pages() < (512 << (HPAGE_PMD_SHIFT - PAGE_SHIFT))) {
> >                  transparent_hugepage_flags = 0;
> >                  return 0;
> >          }
> > --
> > 2.27.0
> >
>
>
> --
> Thanks,
>
> David / dhildenb
>
