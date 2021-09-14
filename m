Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBA140B979
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 22:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbhINUt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 16:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234710AbhINUtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 16:49:53 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF3CC061762
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 13:48:35 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id p15so1109058ljn.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 13:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0tzy5HhmdLCwbO3fFudYbI0KSBkL7KVwEu0UdmJ0Ygw=;
        b=XII/PyFYNJd9fcTfzjp8XzgGS94O/8zoi8sxLS1Q42YB1xBdgzGXT06zapqTx5n1Xo
         GONaGnMkVnx+vbpHjtcyEdqfbjQH0TUU+xVzULZKM7V4WuNyidewwKWl3iVik5363uMg
         7qLMGQvrTMnNivZs1x2bRWqbcPWDPl9pcnslQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0tzy5HhmdLCwbO3fFudYbI0KSBkL7KVwEu0UdmJ0Ygw=;
        b=P8/sRdNkfIp/V8anAKDHCSm9txn/2dkPniVOfht3S6ASJOoMStLl6jfvcNN66kImi6
         KhkkPminTViDv1lMYC3Sxi58HBkmIA7yItY1f9OqVWWsNCnWx9zrfR5kqC+qVwojhfQK
         UuDZxN7oE3yIAi+KxOpp1wBQvMU2nvbp6s0CZ9KRFZsqFscU3iBPt9uirwulhpLP3xRk
         jU9SiCzb0ToCx5HTyrVUbT3qsk7IxwQ7HFwUhQHptWArVxuNKgtefIWece/s1iN3sIvI
         sut89Hw7bclCGfmRqM8468GH7d04LQxeB9cSj2WCthGUdjBdVt/aYJi+VWdmk29pkA1U
         +wKA==
X-Gm-Message-State: AOAM532l2yUYWHfmHI5VrXqQEH0Tz2ip/yLh7CJfeo8v51kGFwBd/QDH
        ZVax/pwero4PXb0jGQ1XfMpon87od4qR0QB1Dik=
X-Google-Smtp-Source: ABdhPJxxY2NFP88fH2RMYcmrablfXfUeQcIpZ9m6VimldOlrqw09qzLZ7mruuMjQfUkwHqibWQO+Gw==
X-Received: by 2002:a2e:4a19:: with SMTP id x25mr17062675lja.235.1631652513026;
        Tue, 14 Sep 2021 13:48:33 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id q189sm1410170ljb.68.2021.09.14.13.48.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 13:48:32 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id r3so1106912ljc.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 13:48:32 -0700 (PDT)
X-Received: by 2002:a2e:1542:: with SMTP id 2mr17497299ljv.249.1631652511805;
 Tue, 14 Sep 2021 13:48:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210914105620.677b90e5@oasis.local.home> <CAHk-=wj9k4LZTz+svCxLYs5Y1=+yKrbAUArH1+ghyG3OLd8VVg@mail.gmail.com>
 <20210914145953.189f15dc@oasis.local.home> <CAHk-=whfA=k0CP_cYzCn3Wt7De-OJQbJbOKsvowuYnxKCAavSg@mail.gmail.com>
 <CAHk-=wg5tJ_+sKKnkzc6nxpfEvvbUG2Yg3zF-vVfUfZD=PFy7Q@mail.gmail.com> <CAHk-=whBd5Sgg4if7HB4o0Zrj3eNprKv9U02uEUB1QhQvrsQZw@mail.gmail.com>
In-Reply-To: <CAHk-=whBd5Sgg4if7HB4o0Zrj3eNprKv9U02uEUB1QhQvrsQZw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Sep 2021 13:48:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wipBkq-OeUBsgv-_hvTfg=nveTpiZonWeY1dBMofkjEuw@mail.gmail.com>
Message-ID: <CAHk-=wipBkq-OeUBsgv-_hvTfg=nveTpiZonWeY1dBMofkjEuw@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Fixes to bootconfig memory management
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 12:38 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So I'll do a minimal conversion that adds "memblock_free_ptr()" and
> hope that people start using that. And then we can later try to move
> "memblock_free()" to a name that isn't so misleading.

Commit 77e02cf57b6c ("memblock: introduce saner 'memblock_free_ptr()'
interface") should hopefully fix that panic that Vlastimil saw, and
the kernel test robot report as well.

And it should make it easy to cleanly fix that 'copy' leak too.

            Linus
