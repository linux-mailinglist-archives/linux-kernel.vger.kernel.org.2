Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0F6A3EBD34
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 22:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbhHMURu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 16:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234198AbhHMURr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 16:17:47 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57902C061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 13:17:20 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id c24so21935593lfi.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 13:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GFV5lmVN+JD08JpsLHuW/g9a9aLzMuIjyvYEJ1TJkEE=;
        b=j7uHAAwVagEhjIQfAEgVKt4UKiNyCnssnj/SNuUT329+DGFnIt6yCSq8ozr8erC0rS
         4GyRceTxDH8qO8sNYeKT+WZV+SE+m4X2UCzI9l/m0/F4FBhTOxsznVi86ovhBa1OMDRn
         jHRLq7nJl/LAFDXvqlxic0IdHd+hd1Mj/5Af6Sv9ce9eeH+O5WhuuVB8wA8JvF8lwogB
         xLowwuoNchcoQshChqWwr9aZ5bA1/0EJ29oE/TKdsWaU2nShSp/tfIDNUhIZ32TZ30HR
         0icMnstEpn3IVzgT8SnhPYHOTEQYR4abF2ZLW5zUi1zPyFUBFqtx0qG25EAIc080eYv8
         Am3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GFV5lmVN+JD08JpsLHuW/g9a9aLzMuIjyvYEJ1TJkEE=;
        b=juOzv/BBT6qZgTdAJCuSzk9Pf+SP0uSdah77AXxOrD976eg+wLARDFW7PDTnFS+hL+
         /delHooJReMPt8MPHA0ijhEO55d7WQIDakglbGt1uXAN3o2z10h20x6zSfHQtCJZbEOG
         cSPWhIEvqdz8xdtvnJEoub8i/3Etv/8Nz1ZPtgsd+u5SfC+CvuVygbIfE5Ut1y7P9kBf
         XldhfCxpsNUu+pgUaBECsZk4F3VLNZNHiVgV5HpSHkkVQVZmqgEbvh3eggtNabhrerll
         SSkwehxPn812DqSQNdk1lpTRbdPsly4TvVLjdAZqanlvQ9b2bM4Gwqk5UZxD3KO7pwNF
         uBdQ==
X-Gm-Message-State: AOAM530TdY+f81ljp/qP6l2//qg4uLEnj/LOLGOoNkz5997PRDZ+SvDi
        Y7U77wFsfVBEuy9t5wVh+pCe5UKo3POcM7mZfajVEw==
X-Google-Smtp-Source: ABdhPJwwvdMMPK6x8sK+8U8N0u9tL75R5rFPakH+Z3Gp5EZkBrwGd31/IG7GW0Fv4b5+BeSGUSiJFZI+NiHA4xhaV8s=
X-Received: by 2002:a19:e00a:: with SMTP id x10mr2996893lfg.536.1628885838324;
 Fri, 13 Aug 2021 13:17:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAP-5=fUV-Tbo+X-myLZ2z8hpjBbHUrgLN6wq9z_wsykyXgxp+g@mail.gmail.com>
 <CAA4y5iAnwnubx1hSxrfopPajqNnyH+UWWUvMZJqsiyy=L3sx-w@mail.gmail.com> <CAGq6xJ4oo2WM2j58vkMayp_FikLEEJ7pK+oMcp=85aPGdEaFGg@mail.gmail.com>
In-Reply-To: <CAGq6xJ4oo2WM2j58vkMayp_FikLEEJ7pK+oMcp=85aPGdEaFGg@mail.gmail.com>
From:   Namhyung Kim <namhyung@google.com>
Date:   Fri, 13 Aug 2021 13:17:06 -0700
Message-ID: <CAA4y5iARtvPfLEQ+UcrNMQwpwxXr56Of6U7ApiOqffHf8OCYWw@mail.gmail.com>
Subject: Re: perf report sort
To:     Arnaldo Melo <acme@redhat.com>
Cc:     Ian Rogers <irogers@google.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ LKML and linux-perf-users

On Thu, Aug 12, 2021 at 5:20 PM Arnaldo Melo <acme@redhat.com> wrote:
>
> On Thu, Aug 12, 2021 at 4:15 PM Namhyung Kim <namhyung@google.com> wrote:
>>
>> Hi Ian,
>>
>> On Wed, Aug 11, 2021 at 12:01 AM Ian Rogers <irogers@google.com> wrote:
>> > My suspicion is that page_fault and _dl_relocate_object have identical
>> > numbers of samples (5.56%) but sorting by the symbol (in sort_order)
>> > should solve this. I suspect providing a sort order in the test will
>> > make it robust, but I'm confused looking at the builtin-report code as
>> > it reads that this should already happen. I wondered if you had any
>> > suggestions?
>>
>> So actually the sort key doesn't sort the output. :(
>> It should be called 'group-by' rather than sort.
>
>
> I think there is value in changing this behaviour to match what Ian expected, don't you think?
>
> And also I think we should start doing this not via command line options, but via .perfconfig settings.
>
> And perhaps we can mark these kinds of settings as .perfconfig-only ones.
>
> This way we can have a 'perf config' mode that extracts these settings to share with others, or keep
> per-organization defaults.
>
> The range of preferences is huge, it is really difficult to find sane defaults that please everybody, so we probably should try to help facilitate per-community defaults.
>
> wdyt?

I agree that it's confusing especially with -F/--fields option.
If users want to change the behavior to be a real sort key
they probably need to use -F too.

Not sure what's the best way to handle it.  But by providing
the config option, I guess users should be aware of the
change and use appropriate options.

>
> - Arnaldo
>
> P.S.: This discussion should really have happened in the open, please consider replying to this CCing linux-perf-users & linux-kernel while keeping as-is this response :-)

Yep, Cc-ed.

Thanks,
Namhyung


>
>>
>> The output is sorted by the overhead (= period) by default.
>>
>> There is -F/--fields option to control which fields are displayed.
>> When it's used, the -s option will behave as (real) sort keys.
>> In fact, 'perf report' (using the default sort key) is same as
>>
>>   perf report -F overhead,comm,dso,sym -s overhead
>>
>> If you want to sort the output by symbol name,
>>
>>   perf report -F overhead,comm,dso,sym -s sym
>>
>> Maybe we need to change the test like above.
>>
>> Thanks,
>> Namhyung
>>
