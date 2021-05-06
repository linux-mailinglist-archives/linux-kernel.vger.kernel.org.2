Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4215337562D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 17:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235068AbhEFPD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 11:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235027AbhEFPD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 11:03:56 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68771C061761
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 08:02:57 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id z9so8208214lfu.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 08:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2eT0MKbpTIaqZ/oJJXKFKrCsA1epQVqWlKwWBElbZrI=;
        b=a7ldHXxoGJnYNifiZFiaxOjvVn6lCQYNc72X7fa0fLXdEMl6UAuoTYpXrDwmE9jBT7
         XKPbiZ/688M3/5xT/QfLV94WByJWGbYvysZ2LYMsn/X09wjxinSg1Rx0xbChxr2ZQFnO
         eiS4IjAHijBkkhUFl9IX6+9htSmuCaeTG9+dpkO51q2Kf3xj/UQc9RxzpENnqmtmVstH
         L6N5ldxYfeTXr76Xe+pNhBRdSae1aatUdJkIVx/LTHTApRT0m3BBY1X7PGlTKKTqKEpS
         jafv7TdJPCa2Mz0WqcPPbShcFei6f75ULekI9DJoiHzO7YMHsn2hwPWhLPnLQfiOnZpE
         y+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2eT0MKbpTIaqZ/oJJXKFKrCsA1epQVqWlKwWBElbZrI=;
        b=psfLq532A5jrURw0bsewrP/EkQC8zIE+OvcRy12/6pHc0pfRXzcy91MvVVj5xePB6u
         uXVpmarDwTpwcxjAyBpCBBuKjrEQqQMEIhgP1i+PKicMk3nKGr51evzXxVivbMGdkTaF
         fcW6X3jn3+tVRL55YgLQ/BKc9h7B+tO5rtGcEl90q151ut2VWVeKQ+g5ZtyrY+i35fBE
         NFv8Qx+s0sRZ4T+C5izTpbtRzPaLAvwIDXPoVLftEZxGkaq0UnpraOeSZsx10RLCKjue
         FvL4nUis2qKUWUKvM4nnLuAK18TRS68bGO6X3pjRHbWM40DcOsM3GGbmQvt2F4+C68tB
         K7Xg==
X-Gm-Message-State: AOAM531qB5uc+JgP5lIEf2rUs7DZWt7ZcQZkx5qcdnQuErxGMTt8dzta
        n/YjVMhoviaCkV5/UuBLHS78LmnDJpZ6Tkd4nUA=
X-Google-Smtp-Source: ABdhPJyASNQ9/T2R91F11z8YHDRJrGIKbU9c4ZwZBBBHaiXtAopq22bipsOaxZjbJjdaDktzDZJb0uD4dnwioBly040=
X-Received: by 2002:a05:6512:1190:: with SMTP id g16mr3486886lfr.342.1620313375599;
 Thu, 06 May 2021 08:02:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210506132827.3198497-1-elver@google.com>
In-Reply-To: <20210506132827.3198497-1-elver@google.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Thu, 6 May 2021 20:32:43 +0530
Message-ID: <CABJPP5D_azxBiKq08_m_WVmcEy8qbMCa0EsAgu57t2T+eDJA0A@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: warn about direct use of send_sig_info and force_sig_info
To:     Marco Elver <elver@google.com>
Cc:     "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 6, 2021 at 6:59 PM Marco Elver <elver@google.com> wrote:
>
> Setting up siginfo and using send_sig_info() and force_sig_info()
> directly is discouraged. Instead, new code wanting to generate signals
> should use the appropriate helper specific to the signal.
>
> Eric mentioned that he'd like to make these static at some point, but
> until that can happen, let's try to avoid introducing new users of them.
>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
> Eric,
>
> While siginfo doesn't need changing often, when it does, it's quite the
> adventure. We now have the various static asserts. The other thing is
> usage of {send,force}_sig_info.
>
> I think the best option right now is to teach checkpatch.pl about it
> until they become static.
>
> Fyi, I noticed one such new user here:
> https://lkml.kernel.org/r/20210421024826.13529-1-wangjunqiang@iscas.ac.cn
>
> Thanks,
> -- Marco
> ---
>  scripts/checkpatch.pl | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index ccb412a74725..3a86aafc3bcd 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -7153,6 +7153,12 @@ sub process {
>                              "Where possible, use lockdep_assert_held instead of assertions based on spin_is_locked\n" . $herecurr);
>                 }
>
> +# check for direct use of send_sig_info(), force_sig_info()
> +               if ($line =~ /\b((force|send)_sig_info)\(/) {

I think this might be a little better as:
if ($line =~ /\b((?:force|send)_sig_info)\(/) {

Otherwise it's good as it is.
Tested-by: Dwaipayan Ray <dwaipayanray1@gmail.com>

Thanks,
Dwaipayan.

> +                       WARN("USE_SIGINFO_HELPER",
> +                            "Where possible, avoid using '$1' directly and use a signal-specific helper setting required siginfo fields (see include/linux/sched/signal.h).\n" . $herecurr);
> +               }
> +
>  # check for deprecated apis
>                 if ($line =~ /\b($deprecated_apis_search)\b\s*\(/) {
>                         my $deprecated_api = $1;
> --
> 2.31.1.607.g51e8a6a459-goog
>
