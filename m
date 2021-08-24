Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29DAA3F69F5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 21:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234870AbhHXTkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 15:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234152AbhHXTj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 15:39:58 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C48BC061764
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 12:39:14 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id m4so4760914ljq.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 12:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sg2PeXygntpvBqIKJYVWHWj4D3JPXoTat1Hdlqkmh7U=;
        b=fVGpm4zytOEgKYCiYTv8HiBsEBqkpXonVy0t2eG8CE8JNNbpbZjbUdBL08kDjWv7W+
         Rt6w3znYPC91yDwSJc3FQliDhEAwKpijLzmNopf/row0wktjFdarFGHVG1e0YELcJco5
         +Gw4ptbu76uHIyyI+9wE+qNhCkKyOOB+qGkHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sg2PeXygntpvBqIKJYVWHWj4D3JPXoTat1Hdlqkmh7U=;
        b=ZAoBX8eCVic3U6ozImpKqhL4Tdp4uqyOFKg3guQgZCU/sRsvOgs6zLcLcGzTDfaYFL
         AXXFfVXzt8bXyDoxta1aln+LM35tZkVBUM/mcTBv2PUqiviVKq5aY1rgCHCypgoT4/jm
         fcTyp0wCl24uE+dNyyXVap/DZKIA7V7MyUO77baDFYdhBjfhKPgYRv1c72GW0QGELFCY
         NuC5vXTFMNw6Uz6SU+h2fdxS/XpTU9mmyajHMO2QAAP9ay1J+ksvy6t/jmS/GqcXRC9w
         yGUhLICC6QiPgQ/gn305g98MuDyQB+4Bcmu2IV+qipFt4gapfylDmjAkXjlH4CWpo64w
         +Isg==
X-Gm-Message-State: AOAM5314smxiNj31xg7UiXRXokDgEaNYPXxmmbEjy2TisJ2KV8RFAF/Y
        lhJH6PTceXn9kTeigIyTc7lckskTY/3aQ0IG
X-Google-Smtp-Source: ABdhPJzZS4JYABc+ZZWvg1u8xAghy9/q44IeLTVRrTLKgn41P4KgSkGbhm1SCbDj4AMsbHzAUF7mQQ==
X-Received: by 2002:a05:651c:1409:: with SMTP id u9mr32811480lje.429.1629833952535;
        Tue, 24 Aug 2021 12:39:12 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id w2sm479368lfp.231.2021.08.24.12.39.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 12:39:12 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id l18so32003551lji.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 12:39:11 -0700 (PDT)
X-Received: by 2002:a2e:7d0e:: with SMTP id y14mr32977454ljc.251.1629833951436;
 Tue, 24 Aug 2021 12:39:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjD8i2zJVQ9SfF2t=_0Fkgy-i5Z=mQjCw36AHvbBTGXyg@mail.gmail.com>
 <YSPwmNNuuQhXNToQ@casper.infradead.org> <YSQSkSOWtJCE4g8p@cmpxchg.org>
 <1957060.1629820467@warthog.procyon.org.uk> <YSUy2WwO9cuokkW0@casper.infradead.org>
 <CAHk-=wip=366HxkJvTfABuPUxwjGsFK4YYMgXNY9VSkJNp=-XA@mail.gmail.com>
 <CAHk-=wgRdqtpsbHkKeqpRWUsuJwsfewCL4SZN2udXVgExFZOWw@mail.gmail.com>
 <1966106.1629832273@warthog.procyon.org.uk> <CAHk-=wiZ=wwa4oAA0y=Kztafgp0n+BDTEV6ybLoH2nvLBeJBLA@mail.gmail.com>
In-Reply-To: <CAHk-=wiZ=wwa4oAA0y=Kztafgp0n+BDTEV6ybLoH2nvLBeJBLA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Aug 2021 12:38:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=whd8ugrzMS-3bupkPQz9VS+dWHPpsVssrDfuFgfff+n5A@mail.gmail.com>
Message-ID: <CAHk-=whd8ugrzMS-3bupkPQz9VS+dWHPpsVssrDfuFgfff+n5A@mail.gmail.com>
Subject: Re: [GIT PULL] Memory folios for v5.15
To:     David Howells <dhowells@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 12:25 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Something like "page_group" or "pageset" sound reasonable to me as type names.

"pageset" is such a great name that we already use it, so I guess that
doesn't work.

            Linus
