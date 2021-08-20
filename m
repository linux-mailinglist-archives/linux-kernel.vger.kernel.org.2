Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F49D3F2B7B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 13:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239788AbhHTLm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 07:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239665AbhHTLm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 07:42:58 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA159C061756
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 04:42:20 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id y6so16852888lje.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 04:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BwSYnZ0fXeyF3ucmVYtCymM5MkqPY89pcO9lgHDkScc=;
        b=RQV3qkbRPB4wYn5rj55IDWMO5Wywf4L6wyjACr5IMbV/zKC36Ab6BeVA76WHo2bs4j
         nyrb7DMkVIXnh0n7r4Pk+OInxYOfLVae9K0ZAQMO+QgJXveyqceQ8lzHCCXFR/9ArfE4
         ZBWCImoPry5Ydl+fvYVRdPdNvVPDC6LXtVpU4uIGo0VjrDaZsYylBJLnI5aSZO3IWar0
         N+IXPS8HSukU8TtqsNWym+9YmCdj9Ed6Luk46mBRNxBJWMaInC8usKVRyomOt5I8HpnZ
         kdez1wm7WCrnD4B9891D85TmVqzs6WU7Ex+eeEozWvPTowdFcxszIdbxiplestG2EdjQ
         zDXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BwSYnZ0fXeyF3ucmVYtCymM5MkqPY89pcO9lgHDkScc=;
        b=Ck5Viy1+mm3a5MTZsvLrapOL+Y7Mv5LwYUDFaYAga1KMcBfgyqGnwj9XXUEd02KZRv
         dwoKW2QAXJTr9b/pyFYFT0nLJYuptH+qdaWuMzUrVx73WKGhXrskApC1LWQi8K+Nngtt
         tfTW+EfagyDzlPus/TsCSZ75I3HblOFyOoY/6ZSuzZ5Yn7JFGmwjMhUF/QkeAn7PCIkb
         G30aMZqZIwsk886jhMpj+WMBXEQQIJ2hZ0zx20t2cU3wf+heozCsLBXUWRBQeeA1w0ff
         rKUG2EObcG/pdWXHmzZC7cdxlZUzcK7Gwyp0FDDlHeE+FoVsbLx1s0SfCXdff8lFCeNq
         U7Tw==
X-Gm-Message-State: AOAM530vjoijeKaRCggI3rA8cjYJ/GnVBe23CzMmI/ZWdIfWRUpFWBn/
        OmErLZ+2421NKod2CY303L69rzJD5fap5QHIwisj3g==
X-Google-Smtp-Source: ABdhPJzdXSMf7HClGrUsh7vy9ZlHbcJeSNEIBy+APf+XJPeJIP1M8RavCEv4mkMq21DlHjqlbmlf4vOcBxrETaa+aTY=
X-Received: by 2002:a05:651c:1248:: with SMTP id h8mr13374370ljh.160.1629459738919;
 Fri, 20 Aug 2021 04:42:18 -0700 (PDT)
MIME-Version: 1.0
References: <1629417219-74853-1-git-send-email-wang.yong12@zte.com.cn>
In-Reply-To: <1629417219-74853-1-git-send-email-wang.yong12@zte.com.cn>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 20 Aug 2021 04:42:07 -0700
Message-ID: <CALvZod5usW9OEsJSbeGYBnSGVDNLLKqMoGAx-JQrX6s62r-XiA@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Add configuration to control whether vmpressure
 notifier is enabled
To:     yongw.pur@gmail.com
Cc:     Tejun Heo <tj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Roman Gushchin <guro@fb.com>, alexs@kernel.org,
        Wei Yang <richard.weiyang@gmail.com>, Hui Su <sh_def@163.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        wang.yong12@zte.com.cn, Cgroups <cgroups@vger.kernel.org>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, yang.yang29@zte.com.cn,
        wangyong <wang.yong@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 4:54 PM <yongw.pur@gmail.com> wrote:
>
> From: wangyong <wang.yong@zte.com.cn>
>
> Inspired by PSI features, vmpressure inotifier function should
> also be configured to decide whether it is used, because it is an
> independent feature which notifies the user of memory pressure.
>

It is also used by the networking stack to check memory pressure. See
mem_cgroup_under_socket_pressure().
