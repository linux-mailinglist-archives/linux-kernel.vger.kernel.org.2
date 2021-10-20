Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B47434F65
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 17:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhJTP5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 11:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhJTP5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 11:57:49 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC498C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 08:55:34 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id e5-20020a17090a804500b001a116ad95caso2775976pjw.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 08:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8/kHF6YsBF0VnFXO19L7hIupe8qJPMdaf854o+HCwfY=;
        b=n3Sfk7DBuCbUQBAVU+XdZOeEDfYz0+/5PejRxjeF5kgf5dC2r5cMA+EjmkJK66yLPf
         Ohe+vhlvv8njUtj+4NTNp3b4O8rDqAJv0TNkOJOToWwmLLNvMrG3D8B0GF4KfsAay1M8
         SVYw7YiBso2iMLaEYVb94B3+5O2eFZGC38pYqxN/vPBwzYdy7FS9NEXizjLh+zrsV6ns
         nU1oORRslCtBD+6Cz/Vi68/DPUpJFRUZw4fBJLVgruoDPvkkGM5mixxsNGicoqcx5M7D
         sxmyJnFtkbsWlTJAkn2rLQlnlOhlKdCyqBBwQGpBW7MOziZh7vRo0qAmCGcWrjhRM3aX
         XFpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8/kHF6YsBF0VnFXO19L7hIupe8qJPMdaf854o+HCwfY=;
        b=kSSD1Hn6LGyhpIO/l4Y7AT5SDA/HB15d1IJGk/Otsw6jIV5WYhgY5w/lUDmOKQvWPx
         xjQ4A92CXQJlYvSx8uAqgE/iJWAHPv7yVv1XyrCV9DrNbvhBHwN3VFNddK5+zFInIBlh
         99ZITjynUqCgPRxT/62imLNYR9fMeRQa26go58zq39TjOl4+8Gte5gX8rsswAJNk3xJJ
         09dMZcvxBUNE6yCUIHJzuFXt2TKolb+SqwSZuOQ0OiKKeulWo2nw+yYfX7x67ZW14pRr
         gbiuaKohZvd6vaeLvaeN5eHHfws/f+JmQzJ9k6XcGXIjCgIjz6dUUUdPNfYU3P0KZiGK
         dhQA==
X-Gm-Message-State: AOAM5331qkPg3AJjxz7WEolIZe4CrqyfXZ9argx4apzljy7ldHAI4FGK
        nKhx4R1KM6ibq8mCjZsxjyevbYZzuZzUAmISoqLWoA==
X-Google-Smtp-Source: ABdhPJzeAuq3bsrp4zGPtvJDaThlVFfE7hzvsZDkBB7AVCKsDdiOlQZSBJZzZpYrOV5jzm0t9MHyGJR16lYvshygQvw=
X-Received: by 2002:a17:90b:4a81:: with SMTP id lp1mr841396pjb.124.1634745333907;
 Wed, 20 Oct 2021 08:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <20211020013153.4106001-1-kaleshsingh@google.com>
 <20211020013153.4106001-2-kaleshsingh@google.com> <20211020113234.45657902@gandalf.local.home>
In-Reply-To: <20211020113234.45657902@gandalf.local.home>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Wed, 20 Oct 2021 08:55:23 -0700
Message-ID: <CAC_TJvdOx_=CY8u02hWzxkEpipPQTk2bvb1oOtN7uoURPffsDg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] tracing: Add support for creating hist trigger
 variables from literal
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 8:32 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 19 Oct 2021 18:31:38 -0700
> Kalesh Singh <kaleshsingh@google.com> wrote:
>
> > @@ -89,6 +91,8 @@ typedef u64 (*hist_field_fn_t) (struct hist_field *field,
> >  #define HIST_FIELD_OPERANDS_MAX      2
> >  #define HIST_FIELDS_MAX              (TRACING_MAP_FIELDS_MAX + TRACING_MAP_VARS_MAX)
> >  #define HIST_ACTIONS_MAX     8
> > +#define HIST_CONST_MAX               4
>
> BTW, why is there a limit to the number of constants?

The motivation was to limit the number of hist_fields that can be
created for constants. These are also indirectly limited by the max
number of subexpressions (3) and the max number of vars/keys that can
be defined, so I don't feel strongly about keeping it.

Thanks,
Kalesh

>
> -- Steve
>
> > +#define HIST_CONST_DIGITS_MAX        21
> >
