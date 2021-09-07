Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79EE4402BB6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 17:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345205AbhIGPZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 11:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344974AbhIGPZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 11:25:48 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD11C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 08:24:42 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id q70so20512569ybg.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 08:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q6hnF4rzaEcB3k0gEcqVjL/tjWG83NoIEoW0T87h7bg=;
        b=RLHio3+/t+nypb0HbIW6zWvs8ZtOTjm0TuTqXNa8GaBqgbOvRBLlRNcA1M6EO4bf1s
         9TkSzAZTxc3PdBRwhEoN6uSP1DIEpeYsNP0M/Lrntg5hfCoAeuM7FBFbIf5rA7N6RZOw
         36RQawSpxo/FCMBg9m7jfaQo1bnF5saStoD/Z3IjS5UQ04RDDkbLmqdkKUq12aANfadl
         +7YEdPHkPUvDLwhtt03iFtMMGpPyM0mxSX5/JMEUvkTDwOEqI6e+4ytXRej09tFCR/Kg
         pvIrjjgtLiD3o/DoXg9uD8nQ4AXSqRBhmSFFWqM2jOo+OkBKfHcRAIrozBvTmChpMhJy
         vaDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q6hnF4rzaEcB3k0gEcqVjL/tjWG83NoIEoW0T87h7bg=;
        b=MoO7p7e1QX5pmOZ+pwqZA2pxQN1Us+z12+VxBaqaWbp4+icfc1GLVbmPcXDfdc244f
         yvI//qefuYXoe5HOG4YKJWnzoYQ2SnETNK53nvlyRmoKf7Tl9Wjkfy98eFd8do43kyf+
         CO25rPpJWS14gHvUu6pcI5w520O8OEWKHnqHEw8awSUeQl7BAkDlzmu+z6FNCPC4MD3d
         oY0VzZ0dDIEVbFENsp4y3spWl1tZpL2awYx9XC7zoGCR25e0qYFTeQybPxCIOmnHFvDt
         wd+nlryYM5GtuyZwAFbUkiIF/Hh/eqBNGPt6nP4DPUmyZ9LqXfgyERFAIsM+CEutgMGR
         B0Jg==
X-Gm-Message-State: AOAM532m4CEebVFCDvpmD53NFFKWAnZNSmqMUrWi0uhdlCbDbdwr1iFK
        0jJ9AY11hJH1GpvTTDz+SQt1BeDd7ZW+m9mYneu6eQ==
X-Google-Smtp-Source: ABdhPJywzMw7mWtKMQ4GK0ewd2Iz5tKKfqXK6YjsFj7kQ+VuzhQifI6vmPx12dXKIJ6B/yMG0a3FlC+1CRf7kjIrdl8=
X-Received: by 2002:a25:40b:: with SMTP id 11mr24851385ybe.398.1631028281091;
 Tue, 07 Sep 2021 08:24:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210904064044.125549-1-yan2228598786@gmail.com> <20210907111201.783d5ea2@gandalf.local.home>
In-Reply-To: <20210907111201.783d5ea2@gandalf.local.home>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 7 Sep 2021 08:24:29 -0700
Message-ID: <CANn89iJVc3kNU+4biyHRQtUQVYQpN5sPDTW5sfpyCo8uV-uSpg@mail.gmail.com>
Subject: Re: [PATCH] net: tcp_drop adds `reason` and SNMP parameters for
 tracing v4
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Zhongya Yan <yan2228598786@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        David Miller <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>, hengqi.chen@gmail.com,
        Yonghong Song <yhs@fb.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>, 2228598786@qq.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 7, 2021 at 8:12 AM Steven Rostedt <rostedt@goodmis.org> wrote:

> Just curious. Is "Tcp" the normal way to write "TCP" in the kernel? I see
> it in snmp_seq_show_tcp_udp() in net/ipv4/proc.c, but no where else
> (besides doing CamelCase words). Should these be written using "TCP"
> instead of "Tcp". It just looks awkward to me.
>

Yes, we prefer tcp or TCP, although SNMP counters have Tcp in them,
for some reason
( grep Tcp /proc/net/netstat /proc/net/snmp ), that can not be changed.
