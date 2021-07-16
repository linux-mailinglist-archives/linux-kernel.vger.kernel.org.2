Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 793303CBBB4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 20:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbhGPSOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 14:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhGPSOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 14:14:53 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F6BC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 11:11:57 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id x25so17381736lfu.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 11:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QfMAALkWPughe4/LLQvt//KqLTsRhHD5Hg94xhkS5Hk=;
        b=Ddcp1we6t+dbvxYqCpKXta+OovrGZ1CkaGEmkIpNy3kLmvgNOFFaVZxHOdz8+SfncN
         bw9uifFIzvlG+GkAS+TTkIMWDioFWNCHPzFEgyISWz8cP7uE3CnnT2KOcAlkJ5+i+40q
         i6LYSi2CIl4EO7OG9s6IWqo6M+dfUXA0zV6NY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QfMAALkWPughe4/LLQvt//KqLTsRhHD5Hg94xhkS5Hk=;
        b=Ybmp7ur59Scrh8vgDLp0Rld5glhtrsLqz10nlpmdgestydF1UfX85ALOjg6vJyidTo
         G+lx9LhblHy1kbv4XeaxreZ1wlydTESyXl4FAIM0Jghc1+hSEzQ2HZ8BTi3PEv8u93d2
         oi/jKguErvRvZRs+U0WlE3ylSSIyTPpw/noKilgNRpzm1fC4AWZHd/07SuKaXje7IcY1
         pXow5IB+iVrc8ND9J+GHTyDPbUQRVMQR73G9YL9baaQSW2Zcgf+NmPQSBKzekVBdNHOC
         kelU1RTwxw3WDE0MP3phC6h6IhAKz8R/DZWTGTNjreGqtfHc+8V71PvF7lm87GKzvwsm
         wIcQ==
X-Gm-Message-State: AOAM532/6qPS1KdC2g8QW5kX2buFYIOhfoJ+LFHyujGAIj6JOUfD3QOr
        +i5OL/Z1zKbRVtNap8870hI0IM0BUoDgYFEg
X-Google-Smtp-Source: ABdhPJzmMss2nPG+MOrMlzUUu3/XXMlUN9QyJwerIRg/3BzEMDJOCvwG7awCeovi8SeLD4BA4fj33w==
X-Received: by 2002:ac2:59db:: with SMTP id x27mr8611783lfn.547.1626459115721;
        Fri, 16 Jul 2021 11:11:55 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id t9sm697980lfg.57.2021.07.16.11.11.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jul 2021 11:11:55 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id y42so17446144lfa.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 11:11:55 -0700 (PDT)
X-Received: by 2002:ac2:4475:: with SMTP id y21mr8495462lfl.487.1626459114803;
 Fri, 16 Jul 2021 11:11:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210715215753.4a314e97@rorschach.local.home>
In-Reply-To: <20210715215753.4a314e97@rorschach.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 16 Jul 2021 11:11:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiWdG6jqKhdU62b06-DtESVxHVK8MA23iV+6fB5hnGEAw@mail.gmail.com>
Message-ID: <CAHk-=wiWdG6jqKhdU62b06-DtESVxHVK8MA23iV+6fB5hnGEAw@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: histogram fix and take 2 on the
 __string_len() marcros
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 6:57 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> tracing: One fix in the histogram code and another take at the __string_len() macro

What part of "strncpy()" is garbage did I not make clear?

            Linus
