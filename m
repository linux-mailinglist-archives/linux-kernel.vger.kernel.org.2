Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE4841AB61
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 11:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239860AbhI1JEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 05:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239815AbhI1JEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 05:04:24 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA6BC061769
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 02:02:45 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id x27so4873906lfa.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 02:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7U3IsLEhAc3NNtaNLa10p/PtnKwn/xh1zEIhY+LzfEA=;
        b=dNzmP4NyMAfWxCGEhizylDiPzAIzCTmhqiShkiKXJgrZ3q/H9iTJ0/pUBKJqL0YT6d
         N0HcZorSfa/mJNVynggLRO3SUvx2NavkpNErN1bGatyNjKkYOKrfeQu32iMcntTR46C2
         FCZBWQRKLAIh9iuigapYqphe6M2atqm14pKrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7U3IsLEhAc3NNtaNLa10p/PtnKwn/xh1zEIhY+LzfEA=;
        b=xr4/8Dmih5j89R0AEIWQsJjiO4HVoJizv4NUTKXEsvOkWBQ5POVcSCVl7KQgwQwyMt
         +OCAZp8mgub4mpHJGUaayTpXlUHj0B3tt4bASo77yfQR/JUy6vIXF10SwTU1GDqpk0Wd
         PrAzs9fbfPQ3cJpgFaaZ/Om9wacaWnFt2qBfpMLa6ylLFeXHGUXg/abj9C0DWe0alrHR
         sFDq3OQjyED30owoalFqrQDshFENbDKKR+FIgPBKJHS8GDGg00nRJ9UY4AUc6cuhAjYX
         PIjDIIxYSkRmJMdWYsljGOymjQf8aXui//dr9n8GHgrEoDHMM/PwmkbIbWjKPJIqF9zG
         7HJA==
X-Gm-Message-State: AOAM530KT0HM8b78bYeGROjsY7T5vd5P+dZkOaTIm3B4Uy/7kd/uLzcL
        yV4nNjaj/3wGwSXyJFbWXs3/ZMUJlXWAHvHvhVWxfA==
X-Google-Smtp-Source: ABdhPJx5RkqJDOvtlGGV9JWMT/j9vLa1fIA/m1rWaiEYqhbYBlW0S9sKbPqrl63MfTYo9lSubHtmPfGT0idO7fjqsGo=
X-Received: by 2002:a05:6512:76:: with SMTP id i22mr4455442lfo.39.1632819763475;
 Tue, 28 Sep 2021 02:02:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210924095542.33697-1-lmb@cloudflare.com> <20210924095542.33697-5-lmb@cloudflare.com>
 <a076398b-f1da-c939-3c71-ac157ad96939@iogearbox.net> <871r5aglsh.fsf@cloudflare.com>
In-Reply-To: <871r5aglsh.fsf@cloudflare.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Tue, 28 Sep 2021 10:02:32 +0100
Message-ID: <CACAyw99LePDKKaL4wqYdU7tqj0S5VSGyR_iiu++MhcX3CuQynw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/4] bpf: export bpf_jit_current
To:     Jakub Sitnicki <jakub@cloudflare.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Sept 2021 at 15:01, Jakub Sitnicki <jakub@cloudflare.com> wrote:
>
> I find exposing stats via system configuration variables a bit
> unexpected. Not sure if there is any example today that we're following.
>
> Maybe an entry under /sys/kernel/debug would be a better fit?
>
> That way we don't have to commit to a sysctl that might go away if we
> start charging JIT allocs against memory cgroup quota.

I had a look around, there are no other obvious places in debugfs or
proc where we already have bpf info exposed. It currently all goes via
sysctl.

There are examples of readonly sysctls:
$ sudo find /proc/sys -perm 0444 | wc -l
90

There are no examples of sysctls with mode 0400 however:
$ sudo find /proc/sys -perm 0400 | wc -l
0

I find it kind of weird that the bpf sysctls are so tightly locked
down (CAP_SYS_ADMIN && root) even for reading. Maybe something I can
change?

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
