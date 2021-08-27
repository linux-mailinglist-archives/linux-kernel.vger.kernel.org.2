Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5563F9D81
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 19:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240134AbhH0RRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 13:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239913AbhH0RRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 13:17:47 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FECCC061757
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 10:16:58 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id p38so15962783lfa.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 10:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j79aTkkV7QWLMRm7gv45CG9ALkTrZZR1j0Lx/8G3d6o=;
        b=fj/ZxCs8ur2rBha43Ay0HYB7+91H8QbKZzf8dL12yK9YzzNVZrCZbQRf5t7oQpJsoI
         Wgz8k7xy+geN1KnmohU7DOJais9Vhl6IrRuWDBIc20zyIyuMKAlU0hx94AqlBsRcWyd+
         95xQ+kewg4rcEfCorLbNVHCfZaK90xSHRzBSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j79aTkkV7QWLMRm7gv45CG9ALkTrZZR1j0Lx/8G3d6o=;
        b=sGwh5Tjq6uh7TLJ2nK1VS9NtCPIEszhvNY8w5bpfcF8MUlCPR9Fe6nPAeAc3WU46iM
         o0xWWYsmy4KyrmLgK9h0fKZfJTTME8DXXawYDT+UfKneAh37g7kQbx6yJ4FNRF9VRFGj
         /CksBsiliMoCaSWv2b6rnayEWtxDni0wAmD1NiEMviJgaGjGd8C2H1ymoZWWFnZEsPwV
         lhLPmoGEnSUCJ7mK0++RZuOlItwMrJG/OaXutuXabYFWgSrZKQz1cRtH8TI2tUhcS5EM
         zv29j28Kv6j1SbX2IKqJAKU7HVqHmoKPktvVoYNb00Y+/n+Hb8vSk5MvIltpa1MXW6rX
         JbgA==
X-Gm-Message-State: AOAM5317BhwV4k8yIo1YT94sFYbVQB7SXWDgKYltFvN8H5a1lYGLZzVe
        CgBeSh0qkTx4SH6CXovSzaeDL4gzIU4jyQsN
X-Google-Smtp-Source: ABdhPJz64l3Yc03T5r/mcL8cHQZjB+GoTb8rWmI9IqKkwXQPrv/BWYcowsUnIAD9FkFlt82EU8Rzvw==
X-Received: by 2002:a05:6512:3096:: with SMTP id z22mr120324lfd.475.1630084616393;
        Fri, 27 Aug 2021 10:16:56 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id h17sm642657lfr.287.2021.08.27.10.16.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 10:16:54 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id h1so12619561ljl.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 10:16:53 -0700 (PDT)
X-Received: by 2002:a2e:3004:: with SMTP id w4mr8318181ljw.465.1630084613565;
 Fri, 27 Aug 2021 10:16:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210827164926.1726765-1-agruenba@redhat.com>
In-Reply-To: <20210827164926.1726765-1-agruenba@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 27 Aug 2021 10:16:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiUtyoTWuzroNJQwQDM9GHRXvq4974VL=y8T_3tUxDbkA@mail.gmail.com>
Message-ID: <CAHk-=wiUtyoTWuzroNJQwQDM9GHRXvq4974VL=y8T_3tUxDbkA@mail.gmail.com>
Subject: Re: [PATCH v7 00/19] gfs2: Fix mmap + page fault deadlocks
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com, kvm-ppc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 9:49 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> here's another update on top of v5.14-rc7.  Changes:
>
>  * Some of the patch descriptions have been improved.
>
>  * Patch "gfs2: Eliminate ip->i_gh" has been moved further to the front.
>
> At this point, I'm not aware of anything that still needs fixing,

From a quick scan, I didn't see anything that raised my hackles.

But I skipped all the gfs2-specific changes in the series, since
that's all above my paygrade.

                 Linus
