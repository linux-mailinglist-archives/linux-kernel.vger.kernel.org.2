Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B4A396CF8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 07:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbhFAFtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 01:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbhFAFt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 01:49:29 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA67C061574
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 22:47:47 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id t17so7902867ljk.7
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 22:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rVw8no+yV8oB3wz5djeZPnCWS3j2O3cetrETqnASBLc=;
        b=LxxywmlOdMylQC+6NS46kAlF9f/RiIoTq9gjw+8eBv6QkEYkFQCE8uSUzz5w9gkSpQ
         6B2eNbVehSY8QYIreQhEdA1oxQiOtjGwW1J5ftT2LsWFvgH4d22o6yvUexfnGa7FFcDH
         l7s+M0MmYYYj+X0iQ+rL9V/7TTbkSMWKfENyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rVw8no+yV8oB3wz5djeZPnCWS3j2O3cetrETqnASBLc=;
        b=iDbDbX4U6cUkrNjPSaXZT5eRvXQS7P+Quf8DiJt7USf1GOTsPcZ3frXN6sPiLTR3rM
         /5V3MqrQVD1PM//mRpDcrRdaXPeZ/bmnSe+oy/ndWTc4tLVQDRiznrhjjGFInB7oQDn3
         o7wQBb0KxODwGcwroDPTBl5mWb5vI/qJT9mAyhN78H3dNMjtFU+dGaOIGY58bSOHW/1w
         gZcRaC+l7JxsJ8Celr4gxl4GkwuI7c8025HJO/7AI9TOU52Gv2/YQsuC2yCUM79ZD0Qd
         FuIu/+6nTXhexqdVDfEClKACRjQAUqogiuUyAUz9ThB0/GDGkWZl0GlE6sARV4PUThVb
         Dn3A==
X-Gm-Message-State: AOAM533/oyl2pH3lTMYJPLosNesVrNSkX2EVOb2UvXpP3ofMmtKllGyJ
        PUjCqxYjNSH6me3hnD+xYib+ON+M+zTDqdxE
X-Google-Smtp-Source: ABdhPJzdDX58HMiyB9mQ7rjjAR1f36nQEDN9h//CR2PLe10ejM/HgRfZ8ChSbdfqQiPXjLGulmLgrA==
X-Received: by 2002:a2e:2c0a:: with SMTP id s10mr19209827ljs.171.1622526465534;
        Mon, 31 May 2021 22:47:45 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id b29sm1809540ljf.64.2021.05.31.22.47.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 22:47:44 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id q7so19917878lfr.6
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 22:47:44 -0700 (PDT)
X-Received: by 2002:a05:6512:3f82:: with SMTP id x2mr11242558lfa.421.1622526464531;
 Mon, 31 May 2021 22:47:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210531170123.243771-1-agruenba@redhat.com> <20210531170123.243771-10-agruenba@redhat.com>
In-Reply-To: <20210531170123.243771-10-agruenba@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 31 May 2021 19:47:28 -1000
X-Gmail-Original-Message-ID: <CAHk-=whZWgwbyXMdC0JE+dM0zLyG1TU4gyAxv0FxbwZPwaEX7Q@mail.gmail.com>
Message-ID: <CAHk-=whZWgwbyXMdC0JE+dM0zLyG1TU4gyAxv0FxbwZPwaEX7Q@mail.gmail.com>
Subject: Re: [RFC 9/9] gfs2: Fix mmap + page fault deadlocks (part 2)
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     cluster-devel <cluster-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 31, 2021 at 7:02 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> @@ -807,13 +824,20 @@ static ssize_t gfs2_file_direct_read(struct kiocb *iocb, struct iov_iter *to,
> [...]
>         ret = iomap_dio_rw(iocb, to, &gfs2_iomap_ops, NULL, 0);
>         gfs2_glock_dq(gh);
> +       if (unlikely(current_needs_retry())) {
> +               set_current_needs_retry(false);
> +               if (ret == -EFAULT &&
> +                   !iov_iter_fault_in_writeable(to, PAGE_SIZE))
> +                       goto retry;
> +       }

Hmm. I haven't walked through this all, but is that "ret == -EFAULT"
test the right thing to do?

Can iomap_dio_rw() not instead just return a partial success if it hit
a missing page half-way?

Shouldn't you retry for that case too?

                Linus
