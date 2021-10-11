Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3697D42976C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 21:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234614AbhJKTSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 15:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234564AbhJKTSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 15:18:04 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19E9C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 12:16:03 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id t9so76327934lfd.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 12:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8GEklByxwtz5UkrPD1VA8xZriJ2DJzNE/WJEIN7V+8A=;
        b=BaraWCtYvtkSMzuRzKNgVvTF5yuwTb4Fo9FxC3NbVtpYfpe1sv/ynisHfSSDya7EuW
         PFrxkb/Kv3LRAKFFlLZuP59WIGKDKsUWQRxvyeh55cw6xngdskSjD0Z4oTpKWS+UhP2y
         hMqafTvOfghXFedCqm8oaR7ZxL9+GTUanRU6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8GEklByxwtz5UkrPD1VA8xZriJ2DJzNE/WJEIN7V+8A=;
        b=dWFCNdZUYf6YkzOIXEbExyrfHCHdFUpPvryE9n2TG6gKlrgFFyswVqY7sZrW2eD5ym
         6vfHTlzZjoR6J1fkaZ/77TCBnsxLKuxmC5szPQVk2elsc/MThk5z2mjo7JMV8m9Fz5FA
         iixlTKn4ZZEQlcl52XDFbQivyRth8yXGaJ/yJmRdYojLj903swplAaNc1dlCxdWEsje6
         6KNc6GKUu++kufIEKZo9k6vkHkAg/DbY5sY/XTeB75UCRMPbUIT/nHkMPC0zarChrrgo
         UnI/qwiTAmu2TK7f6tquJ41+LIOjVO5vjlHS3dpK6zj4EruHdlYgntimOgX39Y1wgIuS
         oJqg==
X-Gm-Message-State: AOAM532sQDDuScarFzusEGNH6IPpyXciJlRybB6Vm5KPR9tJD6LqBhyG
        52Q7IQDhat7WxLmFTyoxsjdXxXicUe4Kgb1c
X-Google-Smtp-Source: ABdhPJx9733y6K+oQXmCf+Vuj8oegBk/kd+IypcwbMIdL9yY7QQA84/n5DduLOB5w/hba2bAOrzNlw==
X-Received: by 2002:a19:c34d:: with SMTP id t74mr9328351lff.452.1633979761447;
        Mon, 11 Oct 2021 12:16:01 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id i6sm808668lfc.252.2021.10.11.12.15.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Oct 2021 12:16:00 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id x27so77516459lfa.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 12:15:59 -0700 (PDT)
X-Received: by 2002:a05:6512:12d3:: with SMTP id p19mr30204794lfg.280.1633979759600;
 Mon, 11 Oct 2021 12:15:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210827164926.1726765-6-agruenba@redhat.com> <YSkz025ncjhyRmlB@zeniv-ca.linux.org.uk>
 <CAHk-=wh5p6zpgUUoY+O7e74X9BZyODhnsqvv=xqnTaLRNj3d_Q@mail.gmail.com>
 <YSk7xfcHVc7CxtQO@zeniv-ca.linux.org.uk> <CAHk-=wjMyZLH+ta5SohAViSc10iPj-hRnHc-KPDoj1XZCmxdBg@mail.gmail.com>
 <YSk+9cTMYi2+BFW7@zeniv-ca.linux.org.uk> <YSldx9uhMYhT/G8X@zeniv-ca.linux.org.uk>
 <YSqOUb7yZ7kBoKRY@zeniv-ca.linux.org.uk> <YS40qqmXL7CMFLGq@arm.com>
 <YS5KudP4DBwlbPEp@zeniv-ca.linux.org.uk> <YWR2cPKeDrc0uHTK@arm.com>
In-Reply-To: <YWR2cPKeDrc0uHTK@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Oct 2021 12:15:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjvQWj7mvdrgTedUW50c2fkdn6Hzxtsk-=ckkMrFoTXjQ@mail.gmail.com>
Message-ID: <CAHk-=wjvQWj7mvdrgTedUW50c2fkdn6Hzxtsk-=ckkMrFoTXjQ@mail.gmail.com>
Subject: Re: [RFC][arm64] possible infinite loop in btrfs search_ioctl()
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 10:38 AM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> I cleaned up this patch [1] but I realised it still doesn't solve it.
> The arm64 __copy_to_user_inatomic(), while ensuring progress if called
> in a loop, it does not guarantee precise copy to the fault position.

That should be ok., We've always allowed the user copy to return early
if it does word copies and hits a page crosser that causes a fault.

Any user then has the choice of:

 - partial copies are bad

 - partial copies are handled and then you retry from the place
copy_to_user() failed at

and in that second case, the next time around, you'll get the fault
immediately (or you'll make some more progress - maybe the user copy
loop did something different just because the length and/or alignment
was different).

If you get the fault immediately, that's -EFAULT.

And if you make some more progress, it's again up to the caller to
rinse and repeat.

End result: user copy functions do not have to report errors exactly.
It is the caller that has to handle the situation.

Most importantly: "exact error or not" doesn't actually _matter_ to
the caller. If the caller does the right thing for an exact error, it
will do the right thing for an inexact one too. See above.

> The copy_to_sk(), after returning an error, starts again from the previous
> sizeof(sh) boundary rather than from where the __copy_to_user_inatomic()
> stopped. So it can get stuck attempting to copy the same search header.

That seems to be purely a copy_to_sk() bug.

Or rather, it looks like a bug in the caller. copy_to_sk() itself does

                if (copy_to_user_nofault(ubuf + *sk_offset, &sh, sizeof(sh))) {
                        ret = 0;
                        goto out;
                }

and the comment says

         *  0: all items from this leaf copied, continue with next

but that comment is then obviously not actually true in that it's not
"continue with next" at all.

But this is all very much a bug in the btrfs
search_ioctl()/copy_to_sk() code: it simply doesn't do the proper
thing for a partial result.

Because no, "just retry the whole thing" is by definition not the proper thing.

That said, I think that if we can have faults at non-page-aligned
boundaries, then we just need to make fault_in_pages_writeable() check
non-page boundaries.

> An ugly fix is to fall back to byte by byte copying so that we can
> attempt the actual fault address in fault_in_pages_writeable().

No, changing the user copy machinery is wrong. The caller really has
to do the right thing with partial results.

And I think we need to make fault_in_pages_writeable() match the
actual faulting cases - maybe remote the "pages" part of the name?

That would fix the btrfs code - it's not doing the right thing as-is,
but it's "close enough' to right that I think fixing
fault_in_pages_writeable() should fix it.

No?

             Linus
