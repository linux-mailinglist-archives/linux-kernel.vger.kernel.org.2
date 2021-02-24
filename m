Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1D7D3238E4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 09:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbhBXIpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 03:45:21 -0500
Received: from mail-lj1-f169.google.com ([209.85.208.169]:45898 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234640AbhBXInI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 03:43:08 -0500
Received: by mail-lj1-f169.google.com with SMTP id c8so1432884ljd.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 00:42:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fzifr+DYnNfrijVNdr4UgzPg+PBqCooV3CbcyuDocMg=;
        b=NllDI8BGmcBJ3vGvAug+yrc3USsEhafXQr2u2F2wr2B7kzS7k5bhJBrCEhrdBNCdS3
         yRbjMX85/AohhYFhw0HUxpdGrJ3SDFoKsvkKBbj/Et6qghJAolK+UWrVFPlbsVGmbkbe
         z5k1MPcC4wlv3b5XJ14i7jMpqeiRRT1FtGyx2MsiHeMOmcXHh6cwbqZtwcBE6kiEfVUo
         psmJGCVw7Kkp/H3jjRFQeJItPgwF976vw8FIkzjF8AgwvBFuTITwFaw9As7lgRE2reKc
         OLuDYnzcvmZf6O+MbqVUrLWveDXLCKPMfj8/xyZS2E3nUOYus9n1L6LcFbYeQ4TcFAFv
         hp6g==
X-Gm-Message-State: AOAM532f9JBZIgHhXRup/0SndKhMPmZM6GsFpgYh4/PWu/tbYKREaDsS
        Xn/S9NkHnmGCb7LMteMJDVUYgoCKI0cvi0WyU+E=
X-Google-Smtp-Source: ABdhPJwtA4bfNO0CIxBnkNuPf+G0GQUQukSWpwxekey/CnoJXNlibmdfouJH5mSrdKyZSXBDX6DDNMFC0AimjSX7XGE=
X-Received: by 2002:a2e:9102:: with SMTP id m2mr11048866ljg.166.1614156146510;
 Wed, 24 Feb 2021 00:42:26 -0800 (PST)
MIME-Version: 1.0
References: <20210224081103.715233-1-namhyung@kernel.org>
In-Reply-To: <20210224081103.715233-1-namhyung@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 24 Feb 2021 17:42:15 +0900
Message-ID: <CAM9d7cgMkfZxe+XVoXCBY=t+erpvDjxyk+PYBKCryFDZidBu6w@mail.gmail.com>
Subject: Re: [PATCH 1/2] libperf: Add perf_evlist__reset_id_hash()
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 5:11 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Add the perf_evlist__reset_id_hash() function to libperf API so that
> it can be called to reset the hash table.  This is necessary for perf
> stat to run the workload multiple times.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
[SNIP]
> diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
> index 7be1af8a546c..285100143d89 100644
> --- a/tools/lib/perf/libperf.map
> +++ b/tools/lib/perf/libperf.map
> @@ -42,6 +42,7 @@ LIBPERF_0.0.1 {
>                 perf_evlist__munmap;
>                 perf_evlist__filter_pollfd;
>                 perf_evlist__next_mmap;
> +               perf_evlist__reset_id_hash;
>                 perf_mmap__consume;
>                 perf_mmap__read_init;
>                 perf_mmap__read_done;

I saw perf_evsel__free_fd and perf_evsel__free_id is called from
util/evlist.c without being listed here.  Do we need to add them?

Thanks,
Namhyung
