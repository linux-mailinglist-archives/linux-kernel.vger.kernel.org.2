Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 352D840BD78
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 03:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbhIOB7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 21:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbhIOB7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 21:59:12 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C0AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 18:57:54 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id k4so2664831lfj.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 18:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rJlZqUnq05iJIzEBlrGrw/a1VC/WyblwcDwPRrzG8+s=;
        b=D9WudYt6WVVp/tcN7gHFkmiiaEW43rvvqowvnIKM9qBE3EO0QYWgLUsxIMElUa1OJx
         rOBgMPWXc/Rozox71pKWzkBLgUcrmGqdU18HA76b5LSAjuM2rajb0ex2RkKbS1DhiCkH
         0r6bnQynmV3maQKnjVhP5JEXVQ5T91Xxig1uY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rJlZqUnq05iJIzEBlrGrw/a1VC/WyblwcDwPRrzG8+s=;
        b=nW3Q8qzJXwG11A/7cdnIq7zbud7ZRWrlxjAWcTjJXdUyp/ySp8ChZPQ+0I5M/g/J0P
         R4MPvy0v4yCdMcccVvmoUg2btyfP6t9Sn8lzXZG6CX9fUIE4rtd8n7qJRKwFpZT9ld4R
         NIkgFBwsFhcKUelTaAh+bElI4wV6EqYIMNUt2HKNsvF3R6Fd6B9rP7q6VFQlcR/QUjJR
         BDQVMoTjkBDMSFmBsSFkv5UZ8B6ybNj5p7anChu94M6NvD24IiW7LbTlIy0x1aysIeBX
         NJdjAJzudv8GMrsdfWZJ683J4MdhVT4RJQIRnUG1GkAv51NYYGDoOGOoq6+UCByR9dbc
         2PHw==
X-Gm-Message-State: AOAM532iZKmuxzzfxW5iaohvkn6UODqdIUlYWSMIbpkuqZzc7pxdWm2x
        kNHNBroJRcEZiiNQWssubwjDkLefvD/eEIhjc0I=
X-Google-Smtp-Source: ABdhPJzqG+d1F9/uZQ4mgiOsQ+yei5nMAcU5QwlLIcLN7mSLhuD6vVAjqM1RzoLXYEYkyS2hMFjwCg==
X-Received: by 2002:a19:6a16:: with SMTP id u22mr878848lfu.513.1631671072122;
        Tue, 14 Sep 2021 18:57:52 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id h7sm1257666lfv.95.2021.09.14.18.57.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 18:57:51 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id g14so2343169ljk.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 18:57:50 -0700 (PDT)
X-Received: by 2002:a2e:7f1c:: with SMTP id a28mr872480ljd.56.1631671070565;
 Tue, 14 Sep 2021 18:57:50 -0700 (PDT)
MIME-Version: 1.0
References: <163166717752.510331.12843735095061762373.stgit@devnote2>
 <163166721835.510331.4931010992364519157.stgit@devnote2> <CAHk-=whsAk7u0arWz37YbCyQPZgKfKOhrM1oKp+0B9uJk6J9OQ@mail.gmail.com>
 <20210915104718.135cb7393fb63bd8140105a2@kernel.org>
In-Reply-To: <20210915104718.135cb7393fb63bd8140105a2@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Sep 2021 18:57:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg3bPXCmV3k6Znffnx=zZPFh+jcANujf8DZx6MsHLxS3g@mail.gmail.com>
Message-ID: <CAHk-=wg3bPXCmV3k6Znffnx=zZPFh+jcANujf8DZx6MsHLxS3g@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] tools/bootconfig: Define memblock_free_ptr() to
 fix build error
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 6:47 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Hmm, OK. Let me copy lib/bootconfig.c itself into tools/bootconfig
> as a user-space code.

Well, or we need to have some really good way to mark these shared files.

Normally I don't think we share any *.c files with tooling, and
tooling copies over the *.h files it needs. Is this the only one?

So yes, copying the *.c file in this case would match what we do for
the header files, but particularly if there are others, maybe we could
have something like the "uapi" directory that allows people to
explicialy share files with the tools.

But it would need to be very explicit in the pathname, so that people
would have that big warning sign of "hey, now you're editing a file
that is shared with tooling".

That has worked at least _somewhat_ with include/uapi/ and arch/*/include/uapi/.

         Linus
