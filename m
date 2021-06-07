Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48C8C39E941
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 00:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbhFGWEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 18:04:13 -0400
Received: from mail-lj1-f178.google.com ([209.85.208.178]:37518 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbhFGWEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 18:04:12 -0400
Received: by mail-lj1-f178.google.com with SMTP id e2so24271402ljk.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 15:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=txXYmOupJbYB1C7rh8a5WZGYrF5P61AgRLYJOTkAc4w=;
        b=WOEKIfOY+a2tx1fOyB+1DJ2V0dv3wdWvUNlmvbzKS01EFyJvhhqT34KzbsEA084j5h
         4sUk5X4jWSFsI1/FccKpcjKJNMW9UCWLjOzJ7I02RPD4rIIHKKs0WPVHffH94EsJ0rDc
         7ndLZHqpRDKNO98VfyE7Zqk4G8JHe0bPTOLJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=txXYmOupJbYB1C7rh8a5WZGYrF5P61AgRLYJOTkAc4w=;
        b=QsbUAYNJgojQcpK7AlQU6e1tbVkezXM3Kox9p7T1heapcYcnZKtHciSi8Hy8hG16WR
         cSo5vkLGTrPXi4Z5aq9lHKhu8cnYYS8gqq8lIeOhWujaJPH7gCCRBVwCnTirfwZjHz5x
         42GHbe/pEqkJbcL0HFTlcIQojkxGv5YvgfBJAebaSDuT1AwNZMVvmY1QxgsTcbVpqmGt
         JCQVW/e6bAURNdH+bLcH5L5FMQq9X8CWfD8U//IK5uPkdpz9yfCUSxytTg3utOVZtkqR
         Ep29KFVhxNR+YtiXpw102MUAHBYLiLXyaKYt7fVIQhEaJscE2LGW1DAG8zP3ppLv1jGe
         Fr/A==
X-Gm-Message-State: AOAM532TCQjVe8yZxJpfjgzTZyISoIN2zSsv7ObxVzaJ+ABVeZnKOai4
        zNrV8IMZzIfjyKvElG05UQAOU1iBmwqYCfMK3rQ=
X-Google-Smtp-Source: ABdhPJxYJH9JQ+1VU88hkJTdY/enWsLrTPK+qECbOhBQ+g6rXebnZoBICQW3NTf8TIEwaL6bWaWFvg==
X-Received: by 2002:a2e:b4b4:: with SMTP id q20mr9964385ljm.27.1623103279095;
        Mon, 07 Jun 2021 15:01:19 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id w10sm833568lfn.187.2021.06.07.15.01.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 15:01:18 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id z22so8298033ljh.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 15:01:18 -0700 (PDT)
X-Received: by 2002:a2e:a443:: with SMTP id v3mr15723931ljn.251.1623103277694;
 Mon, 07 Jun 2021 15:01:17 -0700 (PDT)
MIME-Version: 1.0
References: <YL0dCEVEiVL+NwG6@zeniv-ca.linux.org.uk> <CAHk-=wj6ZiTgqbeCPtzP+5tgHjur6Amag66YWub_2DkGpP9h-Q@mail.gmail.com>
 <CAHk-=wiYPhhieXHBtBku4kZWHfLUTU7VZN9_zg0LTxcYH+0VRQ@mail.gmail.com>
 <YL3mxdEc7uw4rhjn@infradead.org> <YL4wnMbSmy3507fk@zeniv-ca.linux.org.uk>
 <YL5CTiR94f5DYPFK@infradead.org> <YL6KdoHzYiBOsu5t@zeniv-ca.linux.org.uk>
In-Reply-To: <YL6KdoHzYiBOsu5t@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 7 Jun 2021 15:01:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgr3o6cKTNpU9wg7fj_+OUh5kFwrD29Lg0n2=-1nhvoZA@mail.gmail.com>
Message-ID: <CAHk-=wgr3o6cKTNpU9wg7fj_+OUh5kFwrD29Lg0n2=-1nhvoZA@mail.gmail.com>
Subject: Re: [RFC][PATCHSET] iov_iter work
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 7, 2021 at 2:07 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Anyway, what I'm going to do is
>
>         if (WARN_ON(uaccess_kernel())) {
>                 // shouldn't be any such callers left...
>                 iov_iter_kvec(i, direction, (const struct kvec *)iov,
>                               nr_segs, count);
>                 return;
>         }

Yeah, this looks better to me simply because it makes it obvious how
that kvec case is a legacy special case.

But make that a WARN_ON_ONCE() - if it ever triggers, we don't want it
to spam the logs.

I guess 32-bit arm is still CONFIG_SET_FS, so we should get some
fairly timely testing of this on the various arm farms.

I wonder if it's even worth trying to make any such cases work any
more. In addition to the warning, maybe we might as well just not fill
in the kvec at all, and we should just do

        iov_iter_kvec(i, direction, NULL, 0, 0);

for that case too.

Having looked around quickly, I think

 (a) none of the actual set_fs(KERNEL_DS) users seem to do anything
remotely related to iovecs

 (b) on all the common non-SET_FS architectures, kernel threads using
iov_iter_init() wouldn't work anyway, because on those architectures
it would always fill the thing in with an iov, not a kvec.

So I'm starting to agree with Christoph that this case can't actually
happen. It would have to be some architecture-specific kernel thread
that does this, and I don't think we _have_ any architecture-specific
ones.

My first thought was that we probably still had some odd core-dumping
code or other that might still use that set_fs() model, but that seems
to have all gotten cleaned up. Wonder of wonders.

So I'd _almost_ just remove this all right now, and if not removing it
I think making it an empty kvec might be preferable to that cast from
an iovec to a kvec.

But no hugely strong opinions. I'm ok with your version too, modulo
that WARN_ON_ONCE comment.

              Linus
