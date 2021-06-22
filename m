Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A33423AFC87
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 07:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbhFVFRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 01:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbhFVFRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 01:17:15 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114C4C061756
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 22:14:59 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id n35-20020a05600c3ba3b02901cdecb6bda8so838056wms.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 22:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=igBGOSIDZ6LxhaMTJqFN/2gXteF3yCVxKqpvV2Tb7pY=;
        b=vD7dwf/4rkdpgtOXKkGYx767Gxcjk6eeTkyEDZUnB4GqZNVnyUBIsj7SK+9C+8EZiO
         KalzugQBEFZpBmiHcrXPBAJEUXPlMYIE4+8337qG+T3wc/WK47QJW5+emCp3992hH88Q
         tIFMOpd3MqKkY/hdDhbaL93Rr3UBgKeRMRUyQFZV7uPfBDFLLMHy5BRN6dw5hX9akDDv
         ostfer+4D9LbBnrEsSen9fvQyXzlfO1feevZmx+VQYoUiLkbBAJbFenLeMQzsQuleiK8
         tfKgaJeRQKdBrftkc350XmtFnco2aBSVhdyiiVfMrY/KGXE7dZrYPaHrb6q82ejan5ck
         mF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=igBGOSIDZ6LxhaMTJqFN/2gXteF3yCVxKqpvV2Tb7pY=;
        b=GLtUPwWBm0avTYXmG9zpg0C50trkeXmKpLtFEvO1DXPIDY+Yv0eOUucdipKn+DzWj/
         Lw4J+nVSWVDKglqkhFx+6MZkSV3veTIlikMqNBu7UVVkL8mTA8QQqly/G1fR43spaseh
         gWr34wGRVk6pF526vFTHb8jcNHDaAINVhCH0gNABXgpvUS03wiZhjG0RiFFzsEnICGb9
         PD4/xlpJiPy6tZtcDty0woAe3ESFCCfRGk8PwQQa/5uXeb191icSmYDZ1umk3m7ay5Js
         rBHJ+cu303jHZSEekz/V1x1DELXKvmLIMokEuXOYvjWZeua+WhCLnZM3wPDqGGYN4YEd
         RpCQ==
X-Gm-Message-State: AOAM532qRLDYXQD6guSWbcRKDT1FBeI4NnQ1C7rSbhPhklTLMb7p4FhS
        lFwvoUBcdewGsqKpZq8KBOZbGVoouRrcf0FNzOPshw==
X-Google-Smtp-Source: ABdhPJxj+feurhsVkQiK/14lZiavLlEBqqrgJ0pC0rPrD79zp8cVFXFjinFHqzYYF2xyQMO5E8wD5MO8Gak5cqLAWtU=
X-Received: by 2002:a05:600c:4105:: with SMTP id j5mr2316395wmi.58.1624338897557;
 Mon, 21 Jun 2021 22:14:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210621234317.235545-1-rickyman7@gmail.com> <20210621234317.235545-3-rickyman7@gmail.com>
In-Reply-To: <20210621234317.235545-3-rickyman7@gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 21 Jun 2021 22:14:46 -0700
Message-ID: <CAP-5=fUGRdj=G6=srwoATWMimK5tB4X2Sxa64tTVk_JRwMJdWg@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf script: delete evlist when deleting session
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2021 at 4:44 PM Riccardo Mancini <rickyman7@gmail.com> wrote:
>
> ASan reports a memory leak related to session->evlist never being deleted.
> The evlist member is not deleted in perf_session__delete, so it should be
> deleted separately.
> This patch adds the missing deletion in perf-script.
>
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> ---
>  tools/perf/builtin-script.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 1280cbfad4db..635a1d9cfc88 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -3991,7 +3991,7 @@ int cmd_script(int argc, const char **argv)
>                 zfree(&script.ptime_range);
>         }
>
> -       evlist__free_stats(session->evlist);

Should this be removed?

> +       evlist__delete(session->evlist);

If the perf session "owns" the evlist, would it be cleaner to add this
to perf_session__delete?

Thanks,
Ian

>         perf_session__delete(session);
>
>         if (script_started)
> --
> 2.31.1
>
