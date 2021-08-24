Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E893F6915
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 20:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbhHXSa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 14:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbhHXSa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 14:30:57 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD78C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 11:30:12 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id l18so31694147lji.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 11:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RuBQdJhQ1k1gyx9+QD8pp0eKOEgTf/y6j0rnTy6eEF0=;
        b=iLUaCmCvcaQsgZ/dKvg6RUX7lHV/WT8/1PxEeDqy/vAPcYeCS7r+Pr6tK4IxraU2dl
         krfcqA8CKRp5ubWmjHoOcohuAYQRT9oOzzmTLAopWy8EXo3vZFoYz8OnEyo0zNHdXRhy
         x/q58ZSBblv/6UFk2LlKRLHs3UAIWUxkdGgqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RuBQdJhQ1k1gyx9+QD8pp0eKOEgTf/y6j0rnTy6eEF0=;
        b=O8hv/ekdwul6ZFj0et+R3TSfri0gs5T9DOg4cKZMOEk0r5bpNS+QmJ/WF3Uo2c96Ct
         KyKY4+i6m5VFfYcObmWnecxL77xKbSmTlLqq9aCl0CYMbZxJXeqojQ/hQhaGN/vk1OON
         34cKS/Qf05iWxfzW7jTfJVIK+Rk2KAaxBpB38zivi6w/brsowNHOnVaGd7gdY7HpCwro
         JRXqPclUqQcnGb1dwlVR22m4dr0DvzhEqrC/dG34VJ+KT/n+I2wEjjP8cyO5oS7kyBMV
         ZVtIOY765ugkEY3mCLyxxwsWJnlYmcK8O2Jgu+kmdAc5GkfLk5OaORR8L9NwHqaAdp8w
         nWEQ==
X-Gm-Message-State: AOAM531C4kKpX/COLLm41EdtPndMNVTv5xe/SC8SDcFDtfVwGT97dfDs
        T7b8Yy0k3y8gSiiaLfiWRgtZ7dsULzaxufQO
X-Google-Smtp-Source: ABdhPJxcLbOfvZaeedN9KzX521O3PtoPXLitVoVU94HEk1ZxQW4LqI4BLFAUpB941ofDg2uY9ArqKQ==
X-Received: by 2002:a2e:bd09:: with SMTP id n9mr33324580ljq.76.1629829810597;
        Tue, 24 Aug 2021 11:30:10 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id bq10sm1818814lfb.25.2021.08.24.11.30.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 11:30:10 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id l18so31694071lji.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 11:30:09 -0700 (PDT)
X-Received: by 2002:a2e:3004:: with SMTP id w4mr30557535ljw.465.1629829809573;
 Tue, 24 Aug 2021 11:30:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjD8i2zJVQ9SfF2t=_0Fkgy-i5Z=mQjCw36AHvbBTGXyg@mail.gmail.com>
 <YSPwmNNuuQhXNToQ@casper.infradead.org> <YSQSkSOWtJCE4g8p@cmpxchg.org>
 <1957060.1629820467@warthog.procyon.org.uk> <YSUy2WwO9cuokkW0@casper.infradead.org>
 <CAHk-=wip=366HxkJvTfABuPUxwjGsFK4YYMgXNY9VSkJNp=-XA@mail.gmail.com>
In-Reply-To: <CAHk-=wip=366HxkJvTfABuPUxwjGsFK4YYMgXNY9VSkJNp=-XA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Aug 2021 11:29:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgRdqtpsbHkKeqpRWUsuJwsfewCL4SZN2udXVgExFZOWw@mail.gmail.com>
Message-ID: <CAHk-=wgRdqtpsbHkKeqpRWUsuJwsfewCL4SZN2udXVgExFZOWw@mail.gmail.com>
Subject: Re: [GIT PULL] Memory folios for v5.15
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 11:26 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> If anything, I'd make things more explicit. Stupid and
> straightforward. Maybe just "struct head_page" or something like that.
> Name it by what it *is*, not by analogies.

Btw, just to clarify: I don't love "struct head_page" either. It looks
clunky. But at least something like that would be a _straightforward_
clunky name.

Something like just "struct pages" would be less clunky, would still
get the message across, but gets a bit too visually similar.

Naming is hard.

             Linus
