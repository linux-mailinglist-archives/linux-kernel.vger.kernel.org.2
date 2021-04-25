Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8FD36A86B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 18:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbhDYQkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 12:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbhDYQks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 12:40:48 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8FCC061574
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 09:40:07 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id b38so20102224ljf.5
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 09:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vu4WIwE43RfHTLIJEqOqqEQDOseMSmGOQorvONsz2Xc=;
        b=HxbgDpXLxRvpJCTdn7bMuTAoxL+ja5PRYmVoF4Q9sxDBcWlVsMLzdHzMDr03e16sS7
         7Yst7B++2onkamUYfWqiS7ERiB8qKpS/9w5EktcPC13zki0Oxb3V0QT1QIGb4LE0MFls
         dbf215yPBe1PY4u+kX/7B+/g4Gk6yywx+TQ5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vu4WIwE43RfHTLIJEqOqqEQDOseMSmGOQorvONsz2Xc=;
        b=W7paYRezRQYhjiSnMfs2kYIWAa8foTuOCW/OGix9t1xVTLgue5mKxA46phqgicaoy8
         +qWpP4otX4TJXyJ4fqExm1YtSEeL58MdzQhnkGNiEZgwKX+rdQZW3Rw5YkZQLTYkAYHZ
         0kLQ/m/mcDLbBTYqDY4jGQdQpDN9xWBhW/JCUk1LaTyjfyVEoSNT8aPhXEwPsTvoQeqi
         PjwSuEdXN8aZeqV2mfFTyIxA0g9Y8fvBLEYkbaoo6WnwOs79QcegwmArDHu1xLskjAno
         mi6U4Uyb+Kg66WYOaChsJ/Ax6XiKJYtBZNARGTxSCx+uMFDBHHbA/RpfhEtPXe3LFDn7
         LOCw==
X-Gm-Message-State: AOAM533olNGiE2pWoqj8kgPAIR83+KHkHMrfv+iCblZ7/zfG7T6UEsJs
        8iCyZovjFbrt6YZMyLEcDpSh+jw08Ro8vU7c
X-Google-Smtp-Source: ABdhPJwZ8h+XQTJfsDBCblv3HcJQkXQOVRmriLbyuj370qgJqMotIizqUBIUs89Ivxf/6WHi/JI7Yg==
X-Received: by 2002:a2e:9606:: with SMTP id v6mr9623321ljh.79.1619368806307;
        Sun, 25 Apr 2021 09:40:06 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id j5sm1145397lfu.268.2021.04.25.09.40.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Apr 2021 09:40:05 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id u25so22925569ljg.7
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 09:40:05 -0700 (PDT)
X-Received: by 2002:a05:651c:1117:: with SMTP id d23mr10306013ljo.220.1619368805084;
 Sun, 25 Apr 2021 09:40:05 -0700 (PDT)
MIME-Version: 1.0
References: <YIU4005K55S20FU1@zn.tnic> <CAHk-=whhCWi_aOvY9AfAz4fRMU53hO7n+w9hU6Wuk4RuHpK31Q@mail.gmail.com>
In-Reply-To: <CAHk-=whhCWi_aOvY9AfAz4fRMU53hO7n+w9hU6Wuk4RuHpK31Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 25 Apr 2021 09:39:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi2NEfJmgZbqHL43a2rsWuc7Oyb5kfiz9x8z+S-juL7-w@mail.gmail.com>
Message-ID: <CAHk-=wi2NEfJmgZbqHL43a2rsWuc7Oyb5kfiz9x8z+S-juL7-w@mail.gmail.com>
Subject: Re: [GIT PULL] locking/urgent for v5.12
To:     Borislav Petkov <bp@suse.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ali Saidi <alisaidi@amazon.com>,
        Steve Capper <steve.capper@arm.com>,
        Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, and replying to myself only because I spazzed out and pressed
"send" before I had filled out the full participants line.

Sorry for the duplicate message quoted in full below.

                 Linus

On Sun, Apr 25, 2021 at 9:37 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> [ Side note: this is cc'd to x86-ml, even though x86 is the _one_
> architecture that was guaranteed to be not at all affected by the
> actual locking bug, since a locked op is always ordered on x86. ]
>
> On Sun, Apr 25, 2021 at 2:39 AM Borislav Petkov <bp@suse.de> wrote:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/locking_urgent_for_v5.12
> >
> > - Fix ordering in the queued writer lock's slowpath.
>
> So I'm looking at that change, because the code is confusing.
>
> Why did it add that "cnts" variable? We know it must have the value
> _QW_WAITING, since that's what the atomic_cond_read_relaxed() waits
> for.
>
> I'm assuming it's because of the switch to try_cmpxchg by PeterZ?
>
> HOWEVER.
>
> That actually just makes the code even MORE unreadable.
>
> That code was odd and hard to read even before, but now it's
> positively confusing.
>
> New confusion:
>  - Why is the truly non-critical cmpxchg using "try_cmpxhg()", when
>    the _first_ cmpxchg - above the loop - is not?
>
> Pre-existing confusion:
>  - Why is the code using "atomic_add()" to set a bit?
>
> Yeah, yeah, neither of these are *bugs*, but Christ is that code hard
> to read. The "use add to set a bit" is valid because of the spinlock
> serialization (ie only one add can ever happen), and the
> cmpxchg-vs-try_cmpxchg confusion isn't buggy, it's just really really
> confusing that that same function is using two different - but
> equivalent - cmpxchg things on the same variable literally a couple of
> lines apart.
>
> I've pulled this, but can we please
>
>  - make *both* of the cmpxchg's use "try_cmpxchg()" (and thus that
>    "cnts" variable)?
>
>  - add a comment about _why_ it's doing "atomic_add()" instead of the
>    much more logical "atomic_or()", and about how the spinlock serializes
>    it
>
> I'm assuming the "atomic_add()" is simply because many more
> architectures have that as an actual intrinsic atomic. I understand.
> But it's really really not obvious from the code.
>
>                 Linus
