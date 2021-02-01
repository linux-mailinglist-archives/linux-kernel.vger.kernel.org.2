Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C590330A0E4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 05:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbhBAEjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 23:39:16 -0500
Received: from mail-lj1-f177.google.com ([209.85.208.177]:36441 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbhBAEf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 23:35:57 -0500
Received: by mail-lj1-f177.google.com with SMTP id l12so17901621ljc.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 20:35:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vfPJ7EgIotj08sAqymwjuZ/KxuHRGj6SOIBCfnMfRJk=;
        b=QpHK7hVCuDFwtqYwPMCq+/pXMHPgKT8NgGDDgGT3pEnY1I9Dx9OPsY8NShpnLrQe9z
         rv9p0za9H1QYH9OUFcj3GDJw80DfGCQdBMqaKTgfFU8QMa5Ny54MHj2hehsZUOqyGEYg
         SoHA8XkIT3Ak7+sP+O69Nwo3OTPJths5VOHihGpAdZVdyaFOZ8yM7OGIftWPup02eMb+
         tpDsYQYzBW5ITko1mqAen8D7/Wy5vZuaxsqX5SVFmwS7nzOVxxX3BB4XHigHp/SVw77o
         BIlgGHhurIB0nq/Czj7sAbCwW0DikF+1F4z9t4I9oRhqxo6dC2/EYUujSw4RhK8eK/XI
         uudQ==
X-Gm-Message-State: AOAM532M5zzk/LIUTadmgr81kn2tUGzWtB7wF8JJMZbdqRGPN8yro6Uk
        NlRzCO/cHlGUraKRg2hjb/B/kGiU1z0ueIfSE94=
X-Google-Smtp-Source: ABdhPJysR3mOTdJaIMHqflQI5PlBQ5MMra3b9CPMfza3lMdkwAkVP8gD5uXRgku6r9Ii9uWfWDjIL3LZqAaU8wvQ/Sk=
X-Received: by 2002:a05:651c:282:: with SMTP id b2mr9260942ljo.52.1612154115250;
 Sun, 31 Jan 2021 20:35:15 -0800 (PST)
MIME-Version: 1.0
References: <20210129054901.1705483-1-namhyung@kernel.org> <YBcwrQJATmToLua2@krava>
In-Reply-To: <YBcwrQJATmToLua2@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 1 Feb 2021 13:35:04 +0900
Message-ID: <CAM9d7cjaUsDM13BsLBaQJyvXOGN-6B2VcKNpZJ+L8DD75jA3Wg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] perf tools: Minor improvements in event synthesis
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Mon, Feb 1, 2021 at 7:35 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Fri, Jan 29, 2021 at 02:48:58PM +0900, Namhyung Kim wrote:
> > Hello,
> >
> > This is to optimize the event synthesis during perf record.
> >
> > The first patch is to reduce memory usage when many threads are used.
> > The second is to avoid unncessary syscalls for kernel threads.  And
> > the last one is to reduce the number of threads to iterate when new
> > threads are being created at the same time.
> >
> > Unfortunately there's no dramatic improvement here but I can see ~5%
> > gain in the 'perf bench internals synthesize' on a big machine.
> > (The numbers are not stable though)
> >
> >
> > Before:
> >   # perf bench internals synthesize --mt -M1 -I 100
> >   # Running 'internals/synthesize' benchmark:
> >   Computing performance of multi threaded perf event synthesis by
> >   synthesizing events on CPU 0:
> >     Number of synthesis threads: 1
> >       Average synthesis took: 68831.480 usec (+- 101.450 usec)
> >       Average num. events: 9982.000 (+- 0.000)
> >       Average time per event 6.896 usec
> >
> >
> > After:
> >   # perf bench internals synthesize --mt -M1 -I 100
> >   # Running 'internals/synthesize' benchmark:
> >   Computing performance of multi threaded perf event synthesis by
> >   synthesizing events on CPU 0:
> >     Number of synthesis threads: 1
> >       Average synthesis took: 65036.370 usec (+- 158.121 usec)
> >       Average num. events: 9982.000 (+- 0.000)
> >       Average time per event 6.515 usec
> >
> >
> > Thanks,
> > Namhyung
> >
> >
> > Namhyung Kim (3):
> >   perf tools: Use /proc/<PID>/task/<TID>/status for synthesis
> >   perf tools: Skip MMAP record synthesis for kernel threads
> >   perf tools: Use scandir() to iterate threads
>
> heya,
> is there any change to previous version?

No, it's just a rebase version.

Thanks,
Namhyung
