Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A295A43B402
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236484AbhJZOae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235530AbhJZOab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:30:31 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED219C061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:28:07 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id e200-20020a4a55d1000000b002b8bedf08cdso598934oob.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XSp/cI8B6tGIWQYSUxjLhFFTXMn9RrA+lvWtIcl5Xxo=;
        b=VYO509ItAWBV9C8cWr9QsGZXjZZ1SUxq7Ul9dgBGRQIEbu0sObO0EY5SEQcBqFdDHq
         1IHU3q6G2jr1ySt+MmB2RX4eKPZUskPSvFQuU4w/q5u7cNk/ITX+InvwPerXdOyubv1A
         kER892Q0xkbxBoLjtcINNPtlkC2YUueXigyFx7Dp45Cyb4C8pYOjFUpGmi3ruBI8T85X
         Bho7eEEgjsWbfzHoptT6sYLiSG7YrR22LOyHGPLa9pI7RGg7ZvWp0omgRnl5TdYpOeeF
         rEKQAcjJCBEKzcBi4j4UzbBHcezn1y2Nwyqn/ZJzK65yQjw7LBJMc8qyykromJwrIC1V
         oOTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XSp/cI8B6tGIWQYSUxjLhFFTXMn9RrA+lvWtIcl5Xxo=;
        b=Cywxhi01kdBxQDJAdtFx6qfwIPQxOjI9rDtVTFi/DlKKcIVWgfSlNUek10hdHZmeTM
         ZmJY0jrr/aU2QMa2fIidTm7YzYltN4IuWxKVxOoVsVuIZpH6QFHJrl+JExGgCZrxZm5P
         7FltuJ7GNP+yRZSOiqj67hqw3D9sozRRDra0TOYlvSpnjnC73ua6YadDhFfXvBGnDBc9
         SE4se5PC+FguPeHo5glMTCEamWRw6DilqTHjyMEK2SG+D1kHXODMVA8xMCLIJBeGInST
         9Z++ZUsajgakMprB/vpJGI30osT7ApQeqiiZ6Ke9OwojFvxwULO9s1pmisrAGNaD3zYJ
         xorQ==
X-Gm-Message-State: AOAM531MMEJAcUuxALHABbmjgDWYHIqzToLNpBacCbo/cIe5fF54CLLQ
        ql7xY0Ey5JL9b1VO5RoijeMSIZwC4dXtjpoOaFzP0Q==
X-Google-Smtp-Source: ABdhPJzkUK2imKD35Eplh4kMly+PxxxN0D1zt76yq2SpfTeEaegRQwBY0wSREOexzYsLLNnhWn9C4ckqY4B2PWcGuag=
X-Received: by 2002:a4a:ae0b:: with SMTP id z11mr17001006oom.25.1635258487022;
 Tue, 26 Oct 2021 07:28:07 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000009e7f6405c60dbe3b@google.com> <0000000000003548bc05cf4202f3@google.com>
In-Reply-To: <0000000000003548bc05cf4202f3@google.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 26 Oct 2021 16:27:55 +0200
Message-ID: <CANpmjNP+MhERRyixhHo55Fr99G0OggGwS6-KiUFx_99earQhqA@mail.gmail.com>
Subject: Re: [syzbot] upstream test error: BUG: sleeping function called from
 invalid context in stack_depot_save
To:     syzbot <syzbot+e45919db2eab5e837646@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, dan.carpenter@oracle.com,
        desmondcheongzx@gmail.com, dvyukov@google.com, hdanton@sina.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mgorman@techsingularity.net,
        syzkaller-bugs@googlegroups.com, tonymarislogistics@yandex.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz fix: mm/page_alloc: avoid page allocator recursion with pagesets.lock held

On Tue, 26 Oct 2021 at 16:08, syzbot
<syzbot+e45919db2eab5e837646@syzkaller.appspotmail.com> wrote:
>
> This bug is marked as fixed by commit:
> 187ad460b841 ("mm/page_alloc: avoid page allocator recursion with pagesets.lock held")

Looks like Dan's "#syz fix" made syzbot think that the title is the above.

The reason that the commit title only is preferred is that commits in
trees like -mm don't have stable hashes. Maybe if the hash is known to
persist the alternative format could be useful.
