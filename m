Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 254D33FE120
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 19:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344582AbhIARaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 13:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbhIARaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 13:30:17 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789E7C061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 10:29:20 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id m4so293856ljq.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 10:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qLyGBukcS+nnjy1FKTF0pgn11BpStgCPxN3KcpXKwZI=;
        b=RJ9SDvHHQdSbswYw2P2+6h4uecGgZ3MklCwZmG9vM/czpJDFQuD5hmVQoKBnwJIo6T
         jdvtHHBA7TjXI+RjRG9+7QOKV8BVZG4xDhrnqqzhQS0bh6+KbO/k84s0tX2QNTrpP/Ir
         +v/NghMPOz47JdAOyeYw0Mfn33mdwEYnE9o9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qLyGBukcS+nnjy1FKTF0pgn11BpStgCPxN3KcpXKwZI=;
        b=nw57P5tQq1pKBqYWia8ZQ4fKU4Oi5RFNSNfYZEQqd0JJ1YdgOFDRVhc1W0HFDv7ygP
         kTW+KaRx9l3WtdXKIlPccMsEmXJyja9t5pq9DfpQ3NpYozMMotZtBKJAYBJOnFlahT+E
         0KFZvGWhFRtVoezQ9t1Dcke5kzVQmc0ryeL02YRMqI83pywY2QUuSOAGIs582hZNWQpM
         aKM7xTxaiszphcqWSIZArmJlcgErdgqGYBv1CzC/Tgf76kmvjNWg12frO015p7zm+uw/
         /0uwAR6Gb2s50Yd3Le4pJZp6Ylrxs7b8pDlMl7DnJbwyUPUBw6Cigm1JZOU7yn3hnMK3
         yplg==
X-Gm-Message-State: AOAM5302LJ6qNX50bSgrG669oXb0BjS82y7JLmTg3co6I3Qw1VXQZFQC
        xuLXzuFLelniQUQJzeFEv232djFHnmx5sBgf
X-Google-Smtp-Source: ABdhPJwydFikaNkEuUMphC8LsO5/ZLXuKf5aDdiYCp34pG63bOiRH8GNTcSRaPKooH8AGzreCjI9WQ==
X-Received: by 2002:a2e:bc26:: with SMTP id b38mr638264ljf.497.1630517358437;
        Wed, 01 Sep 2021 10:29:18 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id bt42sm11434lfb.118.2021.09.01.10.29.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 10:29:17 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id m28so536353lfj.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 10:29:17 -0700 (PDT)
X-Received: by 2002:a05:6512:681:: with SMTP id t1mr380737lfe.487.1630517357502;
 Wed, 01 Sep 2021 10:29:17 -0700 (PDT)
MIME-Version: 1.0
References: <a2f423cf-9413-6bc8-e4d8-92374fc0449e@amperemail.onmicrosoft.com>
 <YS8HpUz9FUcFWt0V@zeniv-ca.linux.org.uk> <CAHk-=wiwAC8L7UsRsd-sHNS8ZETbrTB0EELvYV1qMOUo86R7kg@mail.gmail.com>
In-Reply-To: <CAHk-=wiwAC8L7UsRsd-sHNS8ZETbrTB0EELvYV1qMOUo86R7kg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Sep 2021 10:29:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjAPEs3HRGswJ-AE1R048j2MBsBtMfg3GOsaFykHoeKsg@mail.gmail.com>
Message-ID: <CAHk-=wjAPEs3HRGswJ-AE1R048j2MBsBtMfg3GOsaFykHoeKsg@mail.gmail.com>
Subject: Re: Is it possible to implement the per-node page cache for programs/libraries?
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Shijie Huang <shijie@amperemail.onmicrosoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frank Wang <zwang@amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 1, 2021 at 10:24 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But what you could do, if  you wanted to, would be to catch the
> situation where you have lots of expensive NUMA accesses either using
> our VM infrastructure or performance counters, and when the mapping is
> a MAP_PRIVATE you just do a COW fault on them.
>
> Sounds entirely doable, and has absolutely nothing to do with the page
> cache. It would literally just be an "over-eager COW fault triggered
> by NUMA access counters".

Note how it would work perfectly fine for anonymous mappings too. Just
to reinforce the point that this has nothing to do with any page cache
issues.

Of course, if you want to actually then *share* pages within a node
(rather than replicate them for each process), that gets more
exciting.

But I suspect that this is mainly only useful for long-running big
processes (not least due to that node binding thing), so I question
the need for that kind of excitement.

                Linus
