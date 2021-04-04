Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9F635380B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 14:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbhDDMJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 08:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbhDDMJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 08:09:45 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B715C061756
        for <linux-kernel@vger.kernel.org>; Sun,  4 Apr 2021 05:09:39 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id h10so9858346edt.13
        for <linux-kernel@vger.kernel.org>; Sun, 04 Apr 2021 05:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OaMFsbeZljHFsoFceRfAAsq8fgsEN4iEOOo7+En5IZw=;
        b=IWljy0fft69im/Ah1nmA66ZFRzB0kByVqMsethL6i35h022kg5iRlEVYkTUSzslxr2
         1ylGmYNZMiXv8LomNlazGz8Ohgh6B9+o0U593Fr6qRDtMBiOhRAk7W8VnFlvO2X6akBi
         lEEW5wBmnV78OzFeLumUYq0/UYS2TM0UvQ1u41TyXGUI6A/3erwS07Hn/EKjfmy6AGs3
         OQCHyNy6/dIjn/pWd5lNYkW6z5eAuSSAdMKM9LJ2YGi9AdfyMQNXO9619FnSAKN5YGkC
         dDwZ5K+UOU5XowqnhKHRaY2cfmWUEMlN4V7gP01DKocoNbOi7zdMaVhUNAHIYdWKTfmH
         wpQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OaMFsbeZljHFsoFceRfAAsq8fgsEN4iEOOo7+En5IZw=;
        b=HfEZjQeU+naHkZ3pa9YEGoHwdIMX05EEvSi7ai2aK+u/rY7vz2Z4Ev8bsLashFSjOl
         PnboHRI4Xp1Sjqb0VMYYq/uAEK1IlVqRKBt43VbtVkkscaormJtaHj25zeDoJ+S/Gj2w
         rax3frQ/XJA9h7mx5eB2MHyzjiU+undx3XiMKlrPwLm0TqnxEEe2SuxvQostDaRRRdso
         Pt/9+neK5R95OCNp9iOgo9vTHXj+NJ9vD4lTQXI0e3wgLt5wGJN4PJW8Ow66rL2fizqk
         JIX1ivO8UPQZB/Qfu40U8uf6PAC6OFyyVDwlqdZEztd27352OZa5Rx9M82zwZHX0LkGi
         yUhA==
X-Gm-Message-State: AOAM530LlC04Om67SmIji1Fe4d3F+uxzIYe91TkH8E69IMmQ1xTc+sBo
        s0lyycNvuQJqfQVr8fSH1UyuLgHIEKmO6TNZXgQ=
X-Google-Smtp-Source: ABdhPJz+P0N0ZRbkc9ejsvZK/JouNLhl438CcVRM4YSO5hbmGTILuEx6oH+u3MM04oWH5soC7dsykqqVK2knfbyPqQo=
X-Received: by 2002:aa7:c312:: with SMTP id l18mr12025131edq.190.1617538178310;
 Sun, 04 Apr 2021 05:09:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210403051325.683071-1-pcc@google.com> <CANpmjNOzaOJY5K+Sq78AF5N1_6=1kv3rXZ6w+XPuEf9G+cd8iA@mail.gmail.com>
 <CAMn1gO5mQ2WPs9B9jN91T90Qxf3k6eK-GeBUhs=YqmkZu4NKFg@mail.gmail.com>
 <CANpmjNM__Dk_MVd-9fPT=TbPw=a1giicUcFS+RwCfQ7yue8Xdw@mail.gmail.com> <CA+fCnZd4BaejuyyWuT4xeiEyY1J0-6RWiyP3_u+w-xdOrALd9w@mail.gmail.com>
In-Reply-To: <CA+fCnZd4BaejuyyWuT4xeiEyY1J0-6RWiyP3_u+w-xdOrALd9w@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Sun, 4 Apr 2021 14:09:27 +0200
Message-ID: <CA+fCnZeYpBx5KwjBTr7H_kU=kSYhxiFdG9r=Wn0dBJ-fiV_9oA@mail.gmail.com>
Subject: Re: [PATCH] kfence: unpoison pool region before use
To:     Marco Elver <elver@google.com>,
        Peter Collingbourne <pcc@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 4, 2021 at 1:52 AM Andrey Konovalov <andreyknvl@gmail.com> wrote:
>
> On Sun, Apr 4, 2021 at 12:31 AM Marco Elver <elver@google.com> wrote:
> >
> > However, given the above, I think we need to explain this in the
> > commit message (which also makes the dependency between these 2
> > patches clear) and add a comment above the new kasan_unpoison_range().
> > That is, if we still think this is the right fix -- I'm not entirely
> > sure it is.
> >
> > Because what I gather from "kasan: initialize shadow to TAG_INVALID
> > for SW_TAGS", is the requirement that "0xFF pointer tag is a match-all
> > tag, it doesn't matter what tag the accessed memory has".
> >
> > While KFENCE memory is accessible through the slab API, and in this
> > case ksize() calling kasan_check_byte() leading to a failure, the
> > kasan_check_byte() call is part of the public KASAN API. Which means
> > that if some subsystem decides to memblock_alloc() some memory, and
> > wishes to use kasan_check_byte() on that memory but with an untagged
> > pointer, will get the same problem as KFENCE: with generic and HW_TAGS
> > mode everything is fine, but with SW_TAGS mode things break.
>
> It makes sense to allow this function to operate on any kind of
> memory, including memory that hasn't been previously marked by KASAN.
>
> > To me this indicates the fix is not with KFENCE, but should be in
> > mm/kasan/sw_tags.c:kasan_byte_accessible(), which should not load the
> > shadow when the pointer is untagged.
>
> The problem isn't in accessing shadow per se. Looking at
> kasan_byte_accessible() (in both sw_tags.c and kasan.h), the return
> statement there seems just wrong and redundant.

(Technically, it's not wrong. But it was written under the assumption
that no accesses to KASAN_TAG_INVALID memory are valid. It's not the
case with KFENCE (without built-in KASAN annotations). And there might
be other places where this isn't the case as well, though we haven't
encountered any yet.)
