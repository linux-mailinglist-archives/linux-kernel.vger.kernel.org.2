Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAD74542ED
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 09:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234608AbhKQIu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 03:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234576AbhKQIu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 03:50:56 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7F5C061764
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 00:47:58 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id bu18so5501585lfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 00:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9yJIKBkP/hglrN2GamqzYCPrI09C09Ls8U6CmGp4m+U=;
        b=moB0PXTl70rf/MyP3I0QeYk8t7ub0FlTGV1HzUVW4qwLq9Xj14xVXFtjVrLyw6BZHV
         PTmyfSC619Hw0rOzwl0Gk8aRJOCpTa0zxRrY6sqOBykhpNz3XTKB0B6Z+9CNxkXOfpnG
         TmJYkMRwdSN83eXS1M0KI1XKU441hSMu5dKP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9yJIKBkP/hglrN2GamqzYCPrI09C09Ls8U6CmGp4m+U=;
        b=feynWscU+AFI8Cha8+iqUVUWfZR/c1HyvblkIl4S2JklRvV3plbPlY5A2zgMNJxyG1
         JSHOSs+EYklmA1+cQwhyTC+D7DLeYlr0wlbO3NHFyTf88GkmPEuqzmV7BuGhBUAqVLav
         b0mF7y9TL5Kga6w042LgyEyWobuBHTfOJ2k/xwtlGNBDnRjl9HQo6EjBjwEZ4OgA8j80
         kJGNDnqdSnlg2sV18AnjhItzrQyG29NPMV3+jx612Hd9jjbfcECM7M+Cn9UY+nxL8Tuw
         VYRBEJ/FfFIWy/dLlTdq9YJCPCKFqFPu3aFC73XmvInMMuSWTHv6JRTUrtZLOWjV8ibn
         13wQ==
X-Gm-Message-State: AOAM530I1Uoxn2XYoB75lu+M7lYU0Y8qmSydfs4cwionRnvzutagYAsF
        NXxHEjsYsDF8AaUCL9GNQ/LlzgDCoRMtTbY8q3L45Q==
X-Google-Smtp-Source: ABdhPJyup6wdQP7lq2iQ9eWNfwCJm2OJVL9q/glWYOp3IJ6/yAujHKV3SscAIeCa4bAYjVrQ+AV3riR5SoORtlHBpM4=
X-Received: by 2002:a05:6512:31d:: with SMTP id t29mr13381740lfp.331.1637138876438;
 Wed, 17 Nov 2021 00:47:56 -0800 (PST)
MIME-Version: 1.0
References: <20211111161452.86864-1-lmb@cloudflare.com> <CAADnVQKWk5VNT9Z_Cy6COO9NMjkUg1p9gYTsPPzH-fi1qCrDiw@mail.gmail.com>
In-Reply-To: <CAADnVQKWk5VNT9Z_Cy6COO9NMjkUg1p9gYTsPPzH-fi1qCrDiw@mail.gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Wed, 17 Nov 2021 08:47:45 +0000
Message-ID: <CACAyw99EhJ8k4f3zeQMf3pRC+L=hQhK=Rb3UwSz19wt9gnMPrA@mail.gmail.com>
Subject: Re: [PATCH bpf] selftests: bpf: check map in map pruning
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Nov 2021 at 01:27, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> Not sure how you've tested it, but it doesn't work in unpriv:
> $ test_verifier 789
> #789/u map in map state pruning FAIL
> processed 26 insns (limit 1000000) max_states_per_insn 0 total_states
> 2 peak_states 2 mark_read 1
> #789/p map in map state pruning OK

Strange, I have a script that I use for bisecting which uses a minimal
.config + virtue to run a vm, plus I was debugging in gdb at the same
time. I might have missed this, apologies.

I guess vmtest.sh is the canonical way to run tests now?

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
