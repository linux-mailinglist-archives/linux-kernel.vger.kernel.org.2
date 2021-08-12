Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE953EA628
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 16:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237812AbhHLOFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 10:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235893AbhHLOFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 10:05:03 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45235C061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 07:04:38 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id n1-20020a9d1e810000b0290514da4485e4so5083068otn.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 07:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bvOIAvHT/Lw36eIDHwbsiEEXIRoETITJHslQj5KEmLc=;
        b=kDoK2sQdm8oPn8jph/Zcj+Eg2ChbwYjfa4vuLLDbXb/gz1jEZuY/DjCDZ6c0vdIDS4
         vi5WRkncaSkvvFgm4/Y5EUDZtEfkJqjfN68Lt4cYbtcNB4i4SBp1w8meYFwZru2MbU8T
         P5nCHIBNDsBONv++52Z6TJZk8oHOZGjYeSeHfWSIQAjdWd0/BPNxRt/V4rbRAHCsIFVx
         sashmc8hcMYRHoXU+ybN+YRJtLbyXJ9OBdp5WWmk8HTBv2gvt6k4Qa+acDP2aV0LmccF
         iFCwza8wFNhT6BPa33yFr5q+hDhybjDDm8JLxQUBNJV0gClnHf4Knf4dI/k3e1hGw349
         nErg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bvOIAvHT/Lw36eIDHwbsiEEXIRoETITJHslQj5KEmLc=;
        b=gSFY4wjRCr6ieZoLzPh3vcFZC+RBRhAyW70Y9+lEpjxvwiNUcdwvGpbYoM0PN66Br0
         ypVqeFEgSZp6JxS/dC5G52QSSr01XNbXKGbi3HJefJ8SlihtjuCvitAbt9BSUgw/bwfD
         8/JCMNk3Px6n1+hJCxjwXfiOjW4EPZAv2SZr8BQ9QoOBwnvvPwGUGxZ1I0YfZ5P0h2pt
         TZKHv/dJHOCRk8z0nEjndaIw0UMlNONMGrTTlQgBAqM5tEvQZVvDfWTSK4YM6s5n3PY2
         0+yVvFpsjCMah9G1dMv+HG8ky71br1N5QvApmmMir10I/3EH6cL/V5oeYdUJTQ2TW125
         gDUw==
X-Gm-Message-State: AOAM531Py/tV7XBqsuW4AX0IxaJIX8HlortmslbithK/a3CNcOfkYg1a
        xaBxErUxMjdKqjscHczBwIkfvO7791pwQGOWFAuYWg==
X-Google-Smtp-Source: ABdhPJyrAiMLL38/2/8rWitXvAiAWxhRViM0OOLTm9cXU+/yOu6n8WBSItFKsFepBIuytaX2YmKOyF/al8Krz8Lj34w=
X-Received: by 2002:a9d:6f99:: with SMTP id h25mr3589241otq.17.1628777077440;
 Thu, 12 Aug 2021 07:04:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200604145635.21565-1-elver@google.com> <20200604152537.GD3976@hirez.programming.kicks-ass.net>
In-Reply-To: <20200604152537.GD3976@hirez.programming.kicks-ass.net>
From:   Marco Elver <elver@google.com>
Date:   Thu, 12 Aug 2021 16:04:25 +0200
Message-ID: <CANpmjNMAZiW-Er=2QDgGP+_3hg1LOvPYcbfGSPMv=aR6MVTB-g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kcov, objtool: Make runtime functions noinstr-compatible
To:     Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[-Cc most]
[+Cc Mark]

On Thu, 4 Jun 2020 at 17:25, Peter Zijlstra <peterz@infradead.org> wrote:
[...]
> I would feel very much better with those actually in noinstr, because
> without it, there is nothing stopping us from adding a kprobe/hw-
> breakpoint or other funny to the function.
>
> Even if they almost instra-return, having a kprobe on the function entry
> or condition check is enough to utterly wreck things.
>
> So something like:
>
> void noinstr __sanitizer_cov_trace_*(...)
> {
>         if (within_noinstr_section(ip))
>                 return;
>
>         instrumentation_begin();
>         write_comp_data(...);
>         instrumentation_end();
> }

Apologies for resurrecting this. :-)

It seems I'll need to use this approach soon for upcoming KCSAN
instrumentation for memory barriers. I'm able to use the same objtool
feature that erases __sanitizer_cov* calls on x86 to erase memory
barrier instrumentation, but arm64 will still be a problem because of
lack of objtool support.

Mark, on arm64, is the approach above that Peter proposed ~1y ago
acceptable in general to make instrumentation noinstr-safe?

Thanks,
-- Marco
