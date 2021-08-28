Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7B2F3FA6EA
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 19:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbhH1ROY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 13:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbhH1ROV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 13:14:21 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7151C061756
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 10:13:29 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id w4so17398149ljh.13
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 10:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PG8z+XIonuWGdu3czEMXRzaWItNuzacbk0dZJgvuswY=;
        b=daw0rvbIk5V4Zm8DIXbqAHGUuI91vkfb3EyX9zrL+a+hl26XvDgDL8r9dYETKE/Ae6
         NVz34RW6KNXXaquZKrMsm4y3n1D2vXOf6KLPgIF3dO3k1XtDxSAoVKVtq5UPuEzZOwXY
         C+6YEcQF+K1cqgH+D2AtQjtQx4cGEZE99d2fs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PG8z+XIonuWGdu3czEMXRzaWItNuzacbk0dZJgvuswY=;
        b=ii25bu5up2LtFMbNc/x4lLcAHU6hsUuMTxS70L17wkjVmxwHNXzGbFf6MeO969yEWn
         +y/sgV6B/SHNCGqgMKGRGi4564a1uSkDZscWgUgJzaeOjqi/nuTfZmHN5y7Qg/jYZWIM
         j+Mpg1F0kiBuWpMRXw/tP3y+pSepXkhQ2rylpK2ELv9MAUvGxy9hv0CJNe7pRcwB/V72
         /xZlW2mbLObdjacFaxwtep5a4gALRwvgi05ehXgTDrUuCUpsSlqPctuP7Dj61bQs1AXI
         D21UK6vbtoFzpJjgn8v7NApZQcK58Z1hXWm1QcjFYqwYtJlvKUdGyb8bGfD9H9ruYrmu
         z/qQ==
X-Gm-Message-State: AOAM533FW2/fjyyrPnDeKNfblLHiOprdOPO/hIwEiGIL16wrUrvadNt2
        C+Eg+2i9HwPzWWYzp70cZ4CQBwWNLkpVBZnS
X-Google-Smtp-Source: ABdhPJzEEZYumkA8EJFYVpgY9bt3yxmK5AvIebY0820zd9nmzIQoiJxa3dOssaVkA2iQaFS0h8l0AA==
X-Received: by 2002:a2e:b613:: with SMTP id r19mr3043709ljn.136.1630170807953;
        Sat, 28 Aug 2021 10:13:27 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id r199sm585979lff.266.2021.08.28.10.13.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Aug 2021 10:13:27 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id y6so17494042lje.2
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 10:13:27 -0700 (PDT)
X-Received: by 2002:a2e:7d0e:: with SMTP id y14mr12752568ljc.251.1630170807239;
 Sat, 28 Aug 2021 10:13:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210827164926.1726765-1-agruenba@redhat.com> <20210827164926.1726765-5-agruenba@redhat.com>
 <20210827205644.lkihrypv27er5km3@kari-VirtualBox>
In-Reply-To: <20210827205644.lkihrypv27er5km3@kari-VirtualBox>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 28 Aug 2021 10:13:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh-TeAeraYo9jM7FsAVDtfCji_5ao=B3eoO10Sf2SdeTA@mail.gmail.com>
Message-ID: <CAHk-=wh-TeAeraYo9jM7FsAVDtfCji_5ao=B3eoO10Sf2SdeTA@mail.gmail.com>
Subject: Re: [PATCH v7 04/19] iov_iter: Turn iov_iter_fault_in_readable into fault_in_iov_iter_readable
To:     Kari Argillander <kari.argillander@gmail.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com, ntfs3@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 1:56 PM Kari Argillander
<kari.argillander@gmail.com> wrote:
>
> At least this patch will break ntfs3 which is in next. It has been there
> just couple weeks so I understand. I added Konstantin and ntfs3 list so
> that we know what is going on. Can you please info if and when do we
> need rebase.

No need to rebase. It just makes it harder for me to pick one pull
over another, since it would mix the two things together.

I'll notice the semantic conflict as I do my merge build test, and
it's easy for me to fix as part of the merge - whichever one I merge
later.

It's good if both sides remind me about the issue, but these kinds of
conflicts are not a problem.

And yes, it does happen that I miss conflicts like this if I merge
while on the road and don't do my full build tests, or if it's some
architecture-specific thing or a problem that doesn't happen on my
usual allmodconfig testing.  But neither of those cases should be
present in this situation.

                    Linus
