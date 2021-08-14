Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9D33EC3D6
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 18:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235888AbhHNQ2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 12:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234909AbhHNQ2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 12:28:10 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A33C0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 09:27:41 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id x27so25937004lfu.5
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 09:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ortWZphuXKFhjpOhthwIn3N+WyaFpzYFJ+AvGHbJUDQ=;
        b=cEB9iQ/ARK3yzJQnjgrabwC9VKujOH+Tl0AjsL2eQ9xl3auLSIojiuRRElQZkWEz+h
         xJF/IQcjKQScPAAJiScE6Bp+ElFvbyGy3MtPsTDCDzYwENHk2+Dj0lsoH/eHs7sjFMCt
         PIzqaqF6AqUQ2q1haG3pE3mnJ0pBbpJRJBKaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ortWZphuXKFhjpOhthwIn3N+WyaFpzYFJ+AvGHbJUDQ=;
        b=MfzW9ZJ4nkkWUMLovUJW2feJ6cQAn2sv/+Y17KgtB57EXRTVLKHp7z+JXiLLjOckej
         nVg2cbHVux6Moe95EMlsiid6BZlTYvC2TaTgrwhybrXZUm9u55WpcxS27oRRpqmj8Csd
         RQZpUFGne+nGv9MZz9EIO5ylKl796HX1o5UwI6+K20g/0ZtaY7BTUooCKegBNs1PfoiC
         vFnXWRyDAGQMA1uaSeuPn4wUQnUkFqc7+DJOBk5g78YXfO33cOZlM7w+NKzAItMHZjas
         tSyNfGXIy0DcxSNaXFG9O5QYV9qXr8NvEBwy2o8I7MA1qq2HWuhauTb1GRs0479HQYUm
         aapA==
X-Gm-Message-State: AOAM530IoM0lweDHvzu9oWOP8Ysc6k5hL+TicA9Ykjacv0H0+fkY6LjS
        /JYhzGWEajhFE7Bkt+juRorbXYZOPUzVYp+Qh9Q=
X-Google-Smtp-Source: ABdhPJzVNXzEmovK6otvaLyIw+nQhv0FU1JJpeOR86J4AhjxgScfV443L0aFbeN2ncw/ghsCe9wX8w==
X-Received: by 2002:a05:6512:3f28:: with SMTP id y40mr5876787lfa.345.1628958459208;
        Sat, 14 Aug 2021 09:27:39 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id z13sm543461ljk.39.2021.08.14.09.27.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Aug 2021 09:27:38 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id n6so20409710ljp.9
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 09:27:38 -0700 (PDT)
X-Received: by 2002:a2e:84c7:: with SMTP id q7mr5844285ljh.61.1628958458159;
 Sat, 14 Aug 2021 09:27:38 -0700 (PDT)
MIME-Version: 1.0
References: <YRdp2yz+4Oo2/zHy@infradead.org>
In-Reply-To: <YRdp2yz+4Oo2/zHy@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 14 Aug 2021 06:27:22 -1000
X-Gmail-Original-Message-ID: <CAHk-=whh8F-9Q=h=V=bKczqfRPbUN_A3h21aVfkk2HNhCWF+Pw@mail.gmail.com>
Message-ID: <CAHk-=whh8F-9Q=h=V=bKczqfRPbUN_A3h21aVfkk2HNhCWF+Pw@mail.gmail.com>
Subject: Re: [GIT PULL] configfs fix for Linux 5.14
To:     Christoph Hellwig <hch@infradead.org>,
        Bodo Stroesser <bostroesser@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joel Becker <jlbec@evilplan.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2021 at 9:00 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> configfs fix for Linux 5.14
>
>  - fix to revert to the historic write behavior (Bart Van Assche)

It would have been lovely to see what the problem was, but the commit
doesn't actually explain that.

I suspect it's this

    https://lkml.org/lkml/2021/7/26/581

but there might have been more.

            Linus
