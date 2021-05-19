Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20977388924
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 10:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236881AbhESIL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 04:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbhESIL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 04:11:27 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C49C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 01:10:08 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id t10-20020a05683022eab0290304ed8bc759so11024168otc.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 01:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U1m3QthGxvv1NLoiTwxWzLfeaQCVyf+o0wvQq3RcR54=;
        b=hsTBydpAapiadFEy6CpfWBakbdASo/ru8fhbFEL/Nn9kSehD1hRtMF4apOQG5CXTCu
         xmYsWl1TtOtYBBT5vwPoxk55V2B2VUA16vPQrGAdQdTXmD4TN4Y6sw9GbUwDqO6qu1H5
         zPKBsViHk3jWg8iGx4XwDVGTQsssAXRBoi9kOs/X8ig0SMMiinRWtYbw2WOnAAyUASw+
         7Z3ZT+AZ0gOMRrslS6XUAX40fRfxl8ijzxNv+iNAieMocBdDi8g64GQLpr07/iDwIkiT
         0xodlDRlZIYr4wm7S5xNa22DogX44x6FLpZ6DB9sn2QD3M9UXUSrkIRsO2j8uyS9i5y6
         EtUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U1m3QthGxvv1NLoiTwxWzLfeaQCVyf+o0wvQq3RcR54=;
        b=h5zPQ6HXPy3Kz8RBULvj5f7xrH4cR+LriZd8ahmWsTjLuDY5KoZvsvojNKNdbeSgeK
         II3GTrOW/saWZtdY7anumqgwVLU8jrckegJq4GmXCS0fzxul+TDsnZXzrM8gmuBlMWoH
         wAGYaYqQ7IC2gqhdLNeRwDKc5WR84p415I1ponunA6TbsI2CMp/6uTafLRoTRNwo7nwr
         KMAoBGhTbcOhC0wYvZkIShbVL2mnfkyeuUJLBrEfoLE/7ZNfkPJFoXbuCDZo3KjH01IU
         DiEK09j+PVVM+ZIGllbUlIQbfNQWdOU6wDHzrsjHUsshBsQBILmwt9KPxENA5z7Q6cnc
         KKiw==
X-Gm-Message-State: AOAM531D4osRhBOSc3mvO+xTWCZhn/AB+BMCu4jHJbkMWBTT/0Q1jJUw
        UIu63drN252pNOko0JCuWJ/pCEbBlIQ1T9QOYZ/uPQ==
X-Google-Smtp-Source: ABdhPJy54EQQo9o67kQK9Yxj2gbY7ifgW7x2AkE7sZKK79bEhi0ZHQtBi14ub8phAjOTHpGnGMHduXKVR7vs9fpChr8=
X-Received: by 2002:a05:6830:349b:: with SMTP id c27mr8184955otu.251.1621411807615;
 Wed, 19 May 2021 01:10:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210514140015.2944744-1-arnd@kernel.org> <0ad11966-b286-395e-e9ca-e278de6ef872@kernel.org>
 <20210514193657.GM975577@paulmck-ThinkPad-P17-Gen-1> <534d9b03-6fb2-627a-399d-36e7127e19ff@kernel.org>
 <20210514201808.GO975577@paulmck-ThinkPad-P17-Gen-1> <CAK8P3a3O=DPgsXZpBxz+cPEHAzGaW+64GBDM4BMzAZQ+5w6Dow@mail.gmail.com>
 <YJ8BS9fs5qrtQIzg@elver.google.com> <20210515005550.GQ975577@paulmck-ThinkPad-P17-Gen-1>
 <20210518232012.GA2976391@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20210518232012.GA2976391@paulmck-ThinkPad-P17-Gen-1>
From:   Marco Elver <elver@google.com>
Date:   Wed, 19 May 2021 10:09:56 +0200
Message-ID: <CANpmjNNqonF82pzkmHnNmhPtoZfOihAooanVkt0WUFRaNdEkMg@mail.gmail.com>
Subject: Re: [PATCH] kcsan: fix debugfs initcall return type
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 May 2021 at 01:20, Paul E. McKenney <paulmck@kernel.org> wrote:
[...]
> > If I have not sent the pull request for Arnd's fix by Wednesday, please
> > remind me.
>
> Except that I was slow getting Miguel Ojeda's Reviewed-by applied.
> I need to wait for -next to incorporate this change (hopefully by
> tomorrow, Pacific Time), and then test this.  With luck, I will send
> this Thursday, Pacific Time.

Thank you! If I don't see anything by end of this week, I'll do the
reminder then.

Thanks,
-- Marco
