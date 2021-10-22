Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4D4437003
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 04:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbhJVCdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 22:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbhJVCdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 22:33:07 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BFFC061764
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 19:30:50 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id p16so264444lfa.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 19:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cbgzVLDCT8DipeBdsMkDowoxxylwz2da/ifUpbOh8z0=;
        b=aYdcT/n7CqiA/S03OD1v/gZ0kFeK1PDL0lbPxqn104neWrT3qjy5Y6eL+8vHQrxt+h
         oDvWfNFAoUdvOICh0XHKZOWmwBJf6fUUWWLjSlhQrvjMiomhUTFGWClWL1HzZ9q2WL4O
         1ego9HzyYIvaXZ0i0rLIDMjdtPo9LTw/DYSYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cbgzVLDCT8DipeBdsMkDowoxxylwz2da/ifUpbOh8z0=;
        b=aMfZ71r99GUN4bpbfHQBd3GnHfs+g0E/ieR+sumOAYUGNSLQaDiZRECl+QRxTdXTAg
         KVjNysu5bzPEP9ehToqfz+5LBf9ki9c8grQTdDgA5zmUAE/HA9Htut6b7Mekc73h3Ajr
         YWbr8KOApijrvIVo2L0sZ8UB1n1PUYCz23gDYQkcCXpUvPoVD1GGdYpScTXEqtZ2fiOO
         3OXEHKqc2JO3nRJhDsbOj74RBeOIK3pO82Pvf9OwvZQDYdy3IfEeKkjnSwpvXcnEu2xc
         FDZooK2XZ6ifqLRQbKCOtwcByD/7ieVHzkLcnmT9jjhfVbILZkqMLWaPare+2O/ikf2d
         C0dg==
X-Gm-Message-State: AOAM532U0M/7uT49mAXQXp47A202+ClUN3pbsi0jd8AAc0WqSom/CE+E
        IfIHdDZJMgPxVD0WWNIQPcNit7Gf9OCLA1TL
X-Google-Smtp-Source: ABdhPJwNWvXVHPblx/6d8qxSKyiDvWzWzPkLKuh39uQnxNHBUdlUbO1zcDoJko/tmGvAcUYmu7KZKw==
X-Received: by 2002:a05:6512:692:: with SMTP id t18mr8594543lfe.572.1634869848135;
        Thu, 21 Oct 2021 19:30:48 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id g5sm603923lfr.115.2021.10.21.19.30.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 19:30:47 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id s19so2324075ljj.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 19:30:46 -0700 (PDT)
X-Received: by 2002:a2e:a407:: with SMTP id p7mr10376944ljn.68.1634869846779;
 Thu, 21 Oct 2021 19:30:46 -0700 (PDT)
MIME-Version: 1.0
References: <YSk+9cTMYi2+BFW7@zeniv-ca.linux.org.uk> <YSldx9uhMYhT/G8X@zeniv-ca.linux.org.uk>
 <YSqOUb7yZ7kBoKRY@zeniv-ca.linux.org.uk> <YS40qqmXL7CMFLGq@arm.com>
 <YS5KudP4DBwlbPEp@zeniv-ca.linux.org.uk> <YWR2cPKeDrc0uHTK@arm.com>
 <CAHk-=wjvQWj7mvdrgTedUW50c2fkdn6Hzxtsk-=ckkMrFoTXjQ@mail.gmail.com>
 <YWSnvq58jDsDuIik@arm.com> <CAHk-=wiNWOY5QW5ZJukt_9pHTWvrJhE2=DxPpEtFHAWdzOPDTg@mail.gmail.com>
 <CAHc6FU7bpjAxP+4dfE-C0pzzQJN1p=C2j3vyXwUwf7fF9JF72w@mail.gmail.com>
 <YXE7fhDkqJbfDk6e@arm.com> <CAHc6FU5xTMOxuiEDyc9VO_V98=bvoDc-0OFi4jsGPgWJWjRJWQ@mail.gmail.com>
In-Reply-To: <CAHc6FU5xTMOxuiEDyc9VO_V98=bvoDc-0OFi4jsGPgWJWjRJWQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 21 Oct 2021 16:30:30 -1000
X-Gmail-Original-Message-ID: <CAHk-=wgvnU2PXFMpsNErdwE=tXGymLHe275jWkBhCbGiixWU5g@mail.gmail.com>
Message-ID: <CAHk-=wgvnU2PXFMpsNErdwE=tXGymLHe275jWkBhCbGiixWU5g@mail.gmail.com>
Subject: Re: [RFC][arm64] possible infinite loop in btrfs search_ioctl()
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
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

On Thu, Oct 21, 2021 at 4:42 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> But probing the entire memory range in fault domain granularity in the
> page fault-in functions still doesn't actually make sense. Those
> functions really only need to guarantee that we'll be able to make
> progress eventually. From that point of view, it should be enough to
> probe the first byte of the requested memory range

That's probably fine.

Although it should be more than one byte - "copy_from_user()" might do
word-at-a-time optimizations, so you could have an infinite loop of

 (a) copy_from_user() fails because the chunk it tried to get failed partly

 (b) fault_in() probing succeeds, because the beginning part is fine

so I agree that the fault-in code doesn't need to do the whole area,
but it needs to at least do some <N bytes, up to length> thing, to
handle the situation where the copy_to/from_user requires more than a
single byte.

                 Linus
