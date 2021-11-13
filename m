Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B1B44F488
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 19:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235860AbhKMS3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 13:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbhKMS3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 13:29:41 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B24C061766
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 10:26:48 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id b15so51611689edd.7
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 10:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+iv0OQbFYyKn6Oq3sJi4AovIopSuy5o8Cd1ez7+IGL8=;
        b=StmJ/g2eAHkje1MsnWNu1hzkTzVVd6w8pfM85DhccQm0TA/xPpyrzvEAE2nU5FXxk8
         uCe4/Xo9SMV4aeAS4zhDny2popqxjbNe5THah9IjHYqdkdTiPZxal6tW/lBN+atwWh3n
         xmNYcArXm9XPhe40JQ65vpLL5gvfxI8BR4u9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+iv0OQbFYyKn6Oq3sJi4AovIopSuy5o8Cd1ez7+IGL8=;
        b=tCBG8+lTZioGsE3JfWtOqDjKp9AoiQCowh4koWJP+OcLYNSvgLLpl8JlFmYJ8W0HRY
         lg/xTd1xgVgS68C9IoGS9vKiOfg7yFvXgCwefmp3/+PsRrFeB1OLWa0TU1R9XS+66dZ2
         5Pv8gxfWLzrM/bZtzJkLkhwkHefrQSR8JKs8E9AKACaaFTfyoOr2T/YRMTsYXyYesa8H
         +eOzMXQdkVRrnjhvjB2rHfV0GZ44FYsXj2XBN+swCmYEYITYmvbgBCY2x5kDVKjiNv3T
         R+PzuqpeCCx5QtIsjSizcT5TzDRFotXJ6iPJ1JlEmNZbjJUQZBNNQe8qWBdcLJ/ndL08
         xhGA==
X-Gm-Message-State: AOAM533lORF6w1T5inFeVJrxuQcEbQTvXkzS2Kv8o6Wouu6wSOxx2WvO
        9KxAS/1mIyEfWK6rXE/ozMMYaJe56hZxTLmdVPM=
X-Google-Smtp-Source: ABdhPJzOoFyZncaLSttJfQaegD/GiPBWFLm1GBI5wDfenvedDciA7FlmdphOjTFKZ9uLu75VIaUKLQ==
X-Received: by 2002:a17:907:c0c:: with SMTP id ga12mr34161080ejc.417.1636828006369;
        Sat, 13 Nov 2021 10:26:46 -0800 (PST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id r13sm1458221edo.71.2021.11.13.10.26.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Nov 2021 10:26:45 -0800 (PST)
Received: by mail-wm1-f54.google.com with SMTP id f7-20020a1c1f07000000b0032ee11917ceso9219269wmf.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 10:26:45 -0800 (PST)
X-Received: by 2002:a1c:7405:: with SMTP id p5mr43460095wmc.152.1636828005213;
 Sat, 13 Nov 2021 10:26:45 -0800 (PST)
MIME-Version: 1.0
References: <20211113083520.26ec84ee@rorschach.local.home>
In-Reply-To: <20211113083520.26ec84ee@rorschach.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 13 Nov 2021 10:26:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjREUihCGrtRBwfX47y_KrLCGjiq3t6QtoNJpmVrAEb1w@mail.gmail.com>
Message-ID: <CAHk-=wjREUihCGrtRBwfX47y_KrLCGjiq3t6QtoNJpmVrAEb1w@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Three small fixes for 5.16
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 13, 2021 at 5:35 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
>  - Copy just actual size of histogram strings

I have pulled this, but I think it's wrong. Or at least it looks
_very_ suspicious.

> -                       strscpy(str, val_str, STR_VAR_LEN_MAX);
> +                       strscpy(str, val_str, val->size);

So now it doesn't overrun the source string any more, but I don't see
what protects it from not overrunning the destination - which is
indeed STR_VAR_LEN_MAX.

Maybe 'val->size' is guaranteed to be sufficiently limited, but that
sure as hell isn't obvious at least lkocally.

So if I read this all right, if you ever have a FILTER_STATIC_STRING
or a FILTER_PTR_STRING that has a field->size that is larger than
STR_VAR_LEN_MAX, you're now screwed.

Maybe that is unrealistic, and never happens. And yes, STR_VAR_LEN_MAX
is fairly big, but I would personally be happier if these kinds of
things checked BOTH the source limits and the destination limits.

And no, we don't have that kind of string helper. I've talked about
this before: people tend to always think that string copies are about
"either source limit or destination limit", but the fact is, both can
exist.

             Linus
