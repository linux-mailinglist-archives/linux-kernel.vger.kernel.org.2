Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A47D3D49B3
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 21:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbhGXTMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 15:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhGXTMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 15:12:22 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22A2C061575
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 12:52:52 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id l17so6125457ljn.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 12:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lpee2uSXjqYzurXDPtFtjsJbLcrcS7+O9pSXA980Af4=;
        b=MaXZzTxCAJIwowsCCE6Fdt5US9OP43caVSTixXGxGUe+EmHdqYjF8ACbPwZmUFZzTq
         ODWJwVvcv34qH8KZtMP1sfKtg9N4icSPWeZzKNUlGyB0noOzVBAqOVDZWwi0Ng2nf+r3
         4fEBuRnwf4eViJa+iNl8/P/Lcmilq1BHRdFNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lpee2uSXjqYzurXDPtFtjsJbLcrcS7+O9pSXA980Af4=;
        b=BN/tUMDeCamBDjfbXal7m2AQdgBgm5hB3k0D936rIXlcBvCSn97InE/I8uD5M+s60d
         uVvXZstzmU9Mal5FIUqy+ipLKI1sVHqOPFagWGydYhbvAaNoRlwqC3QpgQ+0p6cOc4Fz
         KKmom65ZpwhRtcHKdBHT6/npUvmuodGsKaqLNcnc5UtZL46N4va6ruSVpSBT3B73gAUn
         IYXEpExGWm/cYrMJ2nQ4PyvaJ5MHCm0kgKtva+zCL6dDIBvY2ondVA+rE0/e/55AgyxK
         /sRiQT86ZuflDilyQvrHafKfyeNzsVxbTD/sRk/HDcRAWz4qNpD+gnvEi2jaRqzx8Qf3
         0mEQ==
X-Gm-Message-State: AOAM533JPLbMqaJeoIHuPHuBLAoVAxqhFl27esDrK4kGshdIhJWuPIqE
        q6geY+ZrizeiUcXqj9cq+3Q0wvMn8k8jQKeN
X-Google-Smtp-Source: ABdhPJzgiJS//i/PBSED3on3ylCgQpk55RBjvoOu0qwvgaLXWqU5vpQt91vvOb+BAJVzjoiBJ8rX2A==
X-Received: by 2002:a05:651c:481:: with SMTP id s1mr6871562ljc.446.1627156370981;
        Sat, 24 Jul 2021 12:52:50 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id u7sm3766361lja.58.2021.07.24.12.52.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jul 2021 12:52:50 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id d17so8087467lfv.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 12:52:50 -0700 (PDT)
X-Received: by 2002:a05:6512:3f82:: with SMTP id x2mr7023206lfa.421.1627156370007;
 Sat, 24 Jul 2021 12:52:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210724193449.361667-1-agruenba@redhat.com> <20210724193449.361667-2-agruenba@redhat.com>
In-Reply-To: <20210724193449.361667-2-agruenba@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 24 Jul 2021 12:52:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=whodi=ZPhoJy_a47VD+-aFtz385B4_GHvQp8Bp9NdTKUg@mail.gmail.com>
Message-ID: <CAHk-=whodi=ZPhoJy_a47VD+-aFtz385B4_GHvQp8Bp9NdTKUg@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] iov_iter: Introduce iov_iter_fault_in_writeable helper
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 24, 2021 at 12:35 PM Andreas Gruenbacher
<agruenba@redhat.com> wrote:
>
> +int iov_iter_fault_in_writeable(const struct iov_iter *i, size_t bytes)
> +{
...
> +                       if (fault_in_user_pages(start, len, true) != len)
> +                               return -EFAULT;

Looking at this once more, I think this is likely wrong.

Why?

Because any user can/should only care about at least *part* of the
area being writable.

Imagine that you're doing a large read. If the *first* page is
writable, you should still return the partial read, not -EFAULT.

So I think the code needs to return 0 if _any_ fault was successful.
Or perhaps return how much it was able to fault in. Because returning
-EFAULT if any of it failed seems wrong, and doesn't allow for partial
success being reported.

The other reaction I have is that you now only do the
iov_iter_fault_in_writeable, but then you make fault_in_user_pages()
still have that "bool write" argument.

We already have 'fault_in_pages_readable()', and that one is more
efficient (well, at least if the fault isn't needed it is). So it
would make more sense to just implement fault_in_pages_writable()
instead of that "fault_in_user_pages(, bool write)".

                 Linus
