Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D64D437EF3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 21:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234209AbhJVUBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 16:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbhJVUBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 16:01:05 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC192C061766
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 12:58:47 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id e19so206737edy.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 12:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OyTESXkijXq7pnJGTLADUG+9VskuYUOHv78z9I+1K/4=;
        b=hM/XQhqnuwClqFHl0xmMUwVFiZI2zWX0Fsvmyov2HtrZf+eht/rZgRbn7tgV6JR5/t
         oaUf+A7xemNq2BqlSo7CgdMlfz4uNIfFdFMMG/GRhS1ONKFBhEIzCT11CSLKS+TAVP9U
         qBUMJuZF6FSADRHZc19vWgXXWGONFvtcXh0sM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OyTESXkijXq7pnJGTLADUG+9VskuYUOHv78z9I+1K/4=;
        b=YBG+vWcglfyS0tRHGhy2i+9PJr+7hX0M5l47F6LvmuV3XSzZOXyfTvvFdlCU//lyJL
         sbhSZr4I5A+vrP4RuH9zJrsFtuR/eQ+loZ4yjJsMHAQtP4nan5du0ciQCvKD4cfk1RL4
         v5qPiU91TLNV98UJHIOPRPZIhYB9vS8CwXakm+TIInq0qv1q9Q0CL9OXcxh4/tQ3qHSm
         YBlFIBW+65ZBY1w3oSzx1+QRvYExKMwX8R9RASxKnWOCvqKvZflLNWN0pW44Pmu3g6/P
         PKvswSvavMkofPFvFkHFrEU7erleEatPDB6V4s4yShN6T5xVF1H8TDynM0TpuixS7pAj
         uTsA==
X-Gm-Message-State: AOAM530AG9hugGWLkATBLn8Seilt11jpsyORY5ukCBhAkOWyKzuEqMav
        pxC1bF+LzqbpDwsMPdb3NCfUazIHEX3NNH6Y774=
X-Google-Smtp-Source: ABdhPJyCV5vxYxpgIEp5OYbZuuY3MLH/weKJRfxnrH4X9GM0DOl7hPQxrxbxpGS9JvpBtWce0BwjaA==
X-Received: by 2002:a05:6402:4409:: with SMTP id y9mr2813866eda.184.1634932725280;
        Fri, 22 Oct 2021 12:58:45 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id nb42sm4364504ejc.23.2021.10.22.12.58.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 12:58:42 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id y12so5148479eda.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 12:58:39 -0700 (PDT)
X-Received: by 2002:a2e:5cc7:: with SMTP id q190mr2066391ljb.494.1634932708154;
 Fri, 22 Oct 2021 12:58:28 -0700 (PDT)
MIME-Version: 1.0
References: <163492911924.1038219.13107463173777870713.stgit@warthog.procyon.org.uk>
 <CAHk-=wjmx7+PD0hzWj5Bg2b807xYD2KCZApTvFje=ufo+MxBMQ@mail.gmail.com> <1041557.1634931616@warthog.procyon.org.uk>
In-Reply-To: <1041557.1634931616@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 22 Oct 2021 09:58:12 -1000
X-Gmail-Original-Message-ID: <CAHk-=wg2LQtWC3e4Z4EGQzEmsLjmk6jm67Ga6UMLY1MH6iDcNQ@mail.gmail.com>
Message-ID: <CAHk-=wg2LQtWC3e4Z4EGQzEmsLjmk6jm67Ga6UMLY1MH6iDcNQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/53] fscache: Rewrite index API and management system
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        Marc Dionne <marc.dionne@auristor.com>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Dave Wysochanski <dwysocha@redhat.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        v9fs-developer@lists.sourceforge.net,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Jeff Layton <jlayton@kernel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        ceph-devel@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 9:40 AM David Howells <dhowells@redhat.com> wrote:
>
> What's the best way to do this?  Is it fine to disable caching in all the
> network filesystems and then directly remove the fscache and cachefiles
> drivers and replace them?

So the basic issue with this whole "total rewrite" is that there's no
way to bisect anything.

And there's no way for people to say "I don't trust the rewrite, I
want to keep using the old tested model".

Which makes this all painful and generally the wrong way to do
anything like this, and there's fundamentally no "best way".

The real best way would be if the conversion could be done truly
incrementally. Flag-days simply aren't good for development, because
even if the patch to enable the new code might be some trivial
one-liner, that doesn't _help_ anything. The switch-over switches from
one code-base to another, with no help from "this is where the problem
started".

So in order of preference:

 (a) actual incremental changes where the code keeps working all the
time, and no flag days

 (b) same interfaces, so at least you can do A/B testing and people
can choose one or the other

 (c) total rewrite

and if (c) is the thing that all the network filesystem people want,
then what the heck is the point in keeping dead code around? At that
point, all the rename crap is just extra work, extra noise, and only a
distraction. There's no upside that I can see.

                   Linus
