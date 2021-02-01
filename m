Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8F6530A0FB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 05:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbhBAEzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 23:55:52 -0500
Received: from mail-qt1-f182.google.com ([209.85.160.182]:34851 "EHLO
        mail-qt1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbhBAEzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 23:55:24 -0500
Received: by mail-qt1-f182.google.com with SMTP id t17so11426272qtq.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 20:55:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iA3Zs5UzX6vl2UD67Nk9UWm/a0kKpmd7I2sX0emJaK0=;
        b=tFNQyyMNuXCRozzf6e4ujUp2aPJBqmv4/HBqhsTVojZCvdiUdkixNgzmxl/i47y0D6
         2E5PHkOSoInEaTokJePwmW2SywRZuzyE/jMOnUqevYBIruYiX1jqt2J2Jywf0nQ5DYjq
         oeuHSp6o7dfe02LCEnfsirRsfwCAf2zNEUUbZ27YsB8M1xAsU/tTCAsEklZJUbdn8c2N
         ftVd1O/vDptk2sqGu+FyEd7dTJb3nXqkZP3WIQBllFSiec87RWM9mCwh36XNBgtUi2YY
         45V55uMd4hQvuy5aKbhLoWlW9aXdKOI/aG+rhV5rEOFEwcYDeBZpZWyFbYmvd3XNozRl
         6Z/A==
X-Gm-Message-State: AOAM5323RSLVzb9SjdHO0qIlaoGXZSGw2OYl3cCME3NGh00gLAdJbBt8
        vb7PxOfXXnSMvK7tmefqC3eDu0uMoqIZ95APAp7KiEYR
X-Google-Smtp-Source: ABdhPJwO8+/EPS3P3j9uEYZ+8jMy59K1GHBo8chbgRVQRkjdXvBlbJ72QL20EN5Ny4Xio8Ij1lPJ1HtbNA/yK797Fd4=
X-Received: by 2002:ac8:4e8b:: with SMTP id 11mr13870919qtp.292.1612155283805;
 Sun, 31 Jan 2021 20:54:43 -0800 (PST)
MIME-Version: 1.0
References: <20210129054901.1705483-1-namhyung@kernel.org> <20210129054901.1705483-3-namhyung@kernel.org>
 <YBczqtjXRvnMRYjD@krava>
In-Reply-To: <YBczqtjXRvnMRYjD@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 1 Feb 2021 13:54:32 +0900
Message-ID: <CAM9d7cj7E1u73ExFstFgQ9JMOFGM2KSrZs0zyUKte-C4VdBOjg@mail.gmail.com>
Subject: Re: [PATCH 2/3] perf tools: Skip MMAP record synthesis for kernel threads
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

On Mon, Feb 1, 2021 at 7:48 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Fri, Jan 29, 2021 at 02:49:00PM +0900, Namhyung Kim wrote:
> > To synthesize information to resolve sample IPs, it needs to scan task
> > and mmap info from the /proc filesystem.  For each process, it
> > opens (and reads) status and maps file respectively.  But as kernel
> > threads don't have memory maps so we can skip the maps file.
> >
> > To find kernel threads, check "VmPeak:" line in /proc/<PID>/status
> > file.  It's about the peak virtual memory usage so only user-level
> > tasks have that.  Also check "Threads:" line (which follows the VmPeak
> > line whether or not it exists) to be sure it's read enough data - just
> > in case of deeply nested pid namespaces or large number of
> > supplementary groups are involved.
>
> I don't understand this Threads: check, could you please
> show example where it's useful for the check?

Sure!

I think there's a chance that the status file actually has the VmPeak line,
but it didn't read to the line for some reason.  In that case, we should
not assume the task is a kernel thread.

So it needs to make sure whether there's no such line in the file
or it just didn't read enough data.  To check the latter case, it
searches the "Threads" line which follows the VmPeak always.

Did I make it clear?

Thanks,
Namhyung
