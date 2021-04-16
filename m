Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 729CB362A5D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 23:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344426AbhDPVeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 17:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344421AbhDPVeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 17:34:05 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D43C061756
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 14:33:40 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id t17so1923113qkg.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 14:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7eH2Lv11SZ0QBm3f11PM1lGjnhy8yPppQrMbgJ4vk1A=;
        b=CjG3ocYg4/RhZbq+qnSzPhtDOmM6lnB2H5LmOYWVYyV4v+5chxBLzcyjQyNzNABrac
         K9RjzvaXZuaLdblD+tEGfTwMp7aqoEvVgv5WuR3WcHBBnzDRCKb9hRq9H5jX5zQpc7I8
         BwggiJGbF9JOAnp8dlpLOWwQYfpSJD3+uOZxh7CnwZ71y5bARvVwWoALxzS1WrbUSeR7
         vjEQa9eG7N2E1/AKNv2bgKS6WYuJM2UXXRicS5BujvF4iOG6kaEHk+eUiWH+hLF5oCHY
         JypL9smg65qPHQQbHo+JDapbrWoYHANZ/oG+87k9TYSrLWaeBgpJcXKoFuZU4iPPs0L6
         CfHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7eH2Lv11SZ0QBm3f11PM1lGjnhy8yPppQrMbgJ4vk1A=;
        b=jzXY4ZMslh/bZHwnEfKeP9AHtpJNyAfDEd+KUHIx5v/f9vViaHyi/dllMQiBkbKcgX
         vx4Ce4gJ+atuunpD1hJPwkDbUrEtH+/gpkL3+sGHlv9o+JbGk8XOqlDb41FB1/xIlXiP
         wgItgfRs+JaOSrlofcYwOR77ZpBho6OtnLoWx5ZR8A5jjhpgRntJyQj08WKWSwfkUpey
         jio9IxcyiJD0kU79PpCTTSWIaFd0FHja1X4L3R+Vzvrm0IvJeKUiQI5eCb829f9MwrIH
         iHC9gJQki12IxyWRVYMdZeKQOxONOLPfnCffV6DtzBUaVO/CoVoD5uigZBFg1Mu6cs4s
         AvFw==
X-Gm-Message-State: AOAM5324HU4JCfQWGzeDNeqmnXoje8AEedNZcK55/BjbcrHojkkSgubg
        osudo7V/79Pg1ApaGvYDhpbuLaJUWj542QmCnfkq6Q==
X-Google-Smtp-Source: ABdhPJxbMSKARCZNdKn5pHyebLlyAwpT4vc/GvCWbXhP052KTAGt0UbyHBni48pbhubDGSq38b8E4Qr2i6r4+C3XHWI=
X-Received: by 2002:a37:a7c7:: with SMTP id q190mr1308734qke.146.1618608819213;
 Fri, 16 Apr 2021 14:33:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210323035706.572953-1-joshdon@google.com> <20210324112739.GO15768@suse.de>
 <CABk29Nv7qwWcn4nUe_cxH-pJnppUVjHan+f-iHc8hEyPJ37jxA@mail.gmail.com>
 <CABk29NsQ21F3A6EPmCf+pJG7ojDFog9zD-ri8LO8OVW6sXeusQ@mail.gmail.com> <YHmnbngrDGJkduFD@hirez.programming.kicks-ass.net>
In-Reply-To: <YHmnbngrDGJkduFD@hirez.programming.kicks-ass.net>
From:   Josh Don <joshdon@google.com>
Date:   Fri, 16 Apr 2021 14:33:27 -0700
Message-ID: <CABk29Nvkx6wyDfUWsv5oUCR9GKW3qU=HTLdMKpwL+_HcymVFJA@mail.gmail.com>
Subject: Re: [PATCH v2] sched: Warn on long periods of pending need_resched
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        David Rientjes <rientjes@google.com>,
        Oleg Rombakh <olegrom@google.com>, linux-doc@vger.kernel.org,
        Paul Turner <pjt@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 8:05 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Mar 30, 2021 at 03:44:12PM -0700, Josh Don wrote:
> > Peter,
> >
> > Since you've already pulled the need_resched warning patch into your
> > tree, I'm including just the diff based on that patch (in response to
> > Mel's comments) below. This should be squashed into the original
> > patch.
> >
>
> Sorry, I seem to have missed this. The patch is completely whitespace
> mangled through.
>
> I've attached my latest copy of the patch and held it back for now,
> please resubmit.

Yikes, sorry about that. I've squashed the fixup and sent the updated
patch (with trimmed cc list): https://lkml.org/lkml/2021/4/16/1125

Thanks,
Josh
