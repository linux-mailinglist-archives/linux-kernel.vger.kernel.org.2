Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4E93935F0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 21:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhE0THb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 15:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbhE0TH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 15:07:26 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF751C061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 12:05:51 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id w28so797469uae.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 12:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Way17n7ZyrobKAlrVmYM0oRFANifhT7XMXjjCjQMaRA=;
        b=RBGLbBuy5/Qm2Iw0Pk9nvQ4apG6VjVA1O07H6XzXdTToN0h/KDn/n1CMNmdY/po3eR
         r9fXGY4j9s9zBDYYC6jPDfewwIuTk3+XQ3UhW62zi6m/Cr2Xhu8guYXywQD8vpYZNnvG
         C9GnsEa2BsfHFkQCil5VtGiTB7pw3f5CTU9zg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Way17n7ZyrobKAlrVmYM0oRFANifhT7XMXjjCjQMaRA=;
        b=RDMZSOgFc5xaE8lGOGXv82enONkmS5mS5FsnnK3cn8zwI0O+1PbAF0te8mWgeNAKe+
         gEKS6Lu8mkd9C0EO1GUPbSo355or8XMw9vWkofbcC73WnOaIXVab+O7k0PAVEw9ew2Tt
         sSBMs/ZrfEF10XXB2KkNYSpMpDwVsbU15fezhKhTNctzJfIg2m7Oym/4gJ3VWDzTZg3u
         s3OWEfTDwKOkFC6vsMhbQOe45cJl3c+U3eOiy3Yr7v5UvZSY1y1XU+wjZ3xBEpEGCHj8
         6i7THgGC7/rGE1qPxYtkZrbhzFHBgJxPUr7XM8K0Y99L6T8XAvxY93TXCqHmzKQbBBsW
         ZgpQ==
X-Gm-Message-State: AOAM532q8poAQmDgYI3IaShQWlgAyAESvPUfgEwwjK6kI1f1Ez73mH7l
        yuXbxSOgsS2wXwNXGahFzNkLYPi3rnCLqk1tVTOjJVYHF8Y=
X-Google-Smtp-Source: ABdhPJzlejB0l0Fw7ZeyyKkKkFMR1rmdYmah4x6ESVTl4yDCBLbd/uB8S64stjHgRxO7KQADquRBduPKc6l2ztoOHPs=
X-Received: by 2002:ab0:3811:: with SMTP id x17mr4382768uav.69.1622142350389;
 Thu, 27 May 2021 12:05:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210527033018.3731126-1-keescook@chromium.org>
In-Reply-To: <20210527033018.3731126-1-keescook@chromium.org>
From:   Will Drewry <wad@chromium.org>
Date:   Thu, 27 May 2021 14:05:38 -0500
Message-ID: <CAAFS_9GA8UFoN4YYN0cJGXft74op-YaL9H9KvF-FyacLX_qPzg@mail.gmail.com>
Subject: Re: [PATCH] selftests/seccomp: Flush benchmark output regularly
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 10:30 PM Kees Cook <keescook@chromium.org> wrote:
>
> When running the seccomp benchmark under a test runner, it wouldn't
> provide any feedback on progress. Force IO flushes during the test.

Would it make sense to just setbuf(stdout, NULL); in main?

> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  tools/testing/selftests/seccomp/seccomp_benchmark.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/tools/testing/selftests/seccomp/seccomp_benchmark.c b/tools/testing/selftests/seccomp/seccomp_benchmark.c
> index fcc806585266..7be1e2131f79 100644
> --- a/tools/testing/selftests/seccomp/seccomp_benchmark.c
> +++ b/tools/testing/selftests/seccomp/seccomp_benchmark.c
> @@ -42,6 +42,7 @@ unsigned long long timing(clockid_t clk_id, unsigned long long samples)
>                 finish.tv_sec, finish.tv_nsec,
>                 start.tv_sec, start.tv_nsec,
>                 i, (double)i / 1000000000.0);
> +       fflush(NULL);
>
>         return i;
>  }
> @@ -54,6 +55,7 @@ unsigned long long calibrate(void)
>         int seconds = 15;
>
>         printf("Calibrating sample size for %d seconds worth of syscalls ...\n", seconds);
> +       fflush(NULL);
>
>         samples = 0;
>         pid = getpid();
> @@ -157,6 +159,7 @@ int main(int argc, char *argv[])
>         /* Native call */
>         native = timing(CLOCK_PROCESS_CPUTIME_ID, samples) / samples;
>         printf("getpid native: %llu ns\n", native);
> +       fflush(NULL);
>
>         ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
>         assert(ret == 0);
> @@ -167,6 +170,7 @@ int main(int argc, char *argv[])
>
>         bitmap1 = timing(CLOCK_PROCESS_CPUTIME_ID, samples) / samples;
>         printf("getpid RET_ALLOW 1 filter (bitmap): %llu ns\n", bitmap1);
> +       fflush(NULL);
>
>         /* Second filter resulting in a bitmap */
>         ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &bitmap_prog);
> @@ -174,6 +178,7 @@ int main(int argc, char *argv[])
>
>         bitmap2 = timing(CLOCK_PROCESS_CPUTIME_ID, samples) / samples;
>         printf("getpid RET_ALLOW 2 filters (bitmap): %llu ns\n", bitmap2);
> +       fflush(NULL);
>
>         /* Third filter, can no longer be converted to bitmap */
>         ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &prog);
> @@ -181,6 +186,7 @@ int main(int argc, char *argv[])
>
>         filter1 = timing(CLOCK_PROCESS_CPUTIME_ID, samples) / samples;
>         printf("getpid RET_ALLOW 3 filters (full): %llu ns\n", filter1);
> +       fflush(NULL);
>
>         /* Fourth filter, can not be converted to bitmap because of filter 3 */
>         ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &bitmap_prog);
> @@ -188,6 +194,7 @@ int main(int argc, char *argv[])
>
>         filter2 = timing(CLOCK_PROCESS_CPUTIME_ID, samples) / samples;
>         printf("getpid RET_ALLOW 4 filters (full): %llu ns\n", filter2);
> +       fflush(NULL);
>
>         /* Estimations */
>  #define ESTIMATE(fmt, var, what)       do {                    \
> --
> 2.25.1
>
