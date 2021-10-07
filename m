Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACA11425514
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 16:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241916AbhJGOPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 10:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241679AbhJGOPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 10:15:19 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078CBC061570
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 07:13:26 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id r1so13692134ybo.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 07:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HP9WwW0M8z63LJaQOqy54ea9C1/sxc+Be/x1C/DqpK4=;
        b=NZYZ1mud9N8mnzCVbKcM/zTNtIbQCtFGdEgdrsK+dxhZyNB4fl9VgBHhk3dDmem4nX
         WrNb6mkG4l1GQm+LlDfRq+ACp56o79aoWvfz9SM7dBriaV8EzqQAYktCguL5jHnl/h7V
         pRGmb6ADAKWs+0pLPn8DM+DmhE+WwDf1crbJaWV88nrcZ8yCzIvBMw/JC+16SIINjQzH
         +P2ch08ERLqbIB1HQ3dqEG95k46d+r9C/SRT2u/yYPN4+oN4hMUeZUJ8P+C/+GOWDyNd
         SLCgSFDcVQpoQGkx9+zKeehk2qhwXtKKrMj3SrgCEoml/cMN4zL+jhLeJMbXCJYRWZuw
         b2HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HP9WwW0M8z63LJaQOqy54ea9C1/sxc+Be/x1C/DqpK4=;
        b=cEbCHaes4xCJTdTI16/6tzOxmUUrb+3Kvc4EqgA21XYIKOeFBA3VrtkhBCZ8tFWg5+
         qVR4aWJWFox741wcIpIvDXsRZFGjWUQoM8uCrf26uMR4san415UgNmbK+TfswO9w38FE
         ibOLTomVCbAEufyjU8OTlNSV0BGy5zko9NtYcoI0lNzykGRvQ3C/6a7lCfJ6vqhIkuvl
         4IRVojMQH4gjQ8u6IyPYCQD93EanbOxq2Hpndp784mamknTCPGJ4JZnxW/YiHuuJZZeI
         Aq3/IXn3j28df6b4coRrYd4XLkBAV6emuorWb8nEgWCSO8l9RJlrqniL+0GhW3J5yfZm
         zLvw==
X-Gm-Message-State: AOAM532zqdO59XdM0jVivoAkYYl0OuWO8LMkYlCLbUYUBD3rh/H6Bs5J
        t+On15/ZWwI5fBGSN847HjkWPQiOT1z0wlTByZvA58kqCuo=
X-Google-Smtp-Source: ABdhPJzYAaiq5xNFPWbuV8AQfo8HBhGhNQpV/uNAIAVZNJf+h0DF43eUJhXc/5CyWE/zlNC7SVt33t5wNK4GZuWGePg=
X-Received: by 2002:a25:e652:: with SMTP id d79mr4975895ybh.291.1633616004937;
 Thu, 07 Oct 2021 07:13:24 -0700 (PDT)
MIME-Version: 1.0
References: <20211007031756.345269-1-eric.dumazet@gmail.com>
 <20211007072917.GN174703@worktop.programming.kicks-ass.net>
 <CANn89iKOa+tqerm80vHvHEurc2UxTq_heQuOUE0KnVuJht8AKA@mail.gmail.com> <YV7+/0+Q1n67wCF8@hirez.programming.kicks-ass.net>
In-Reply-To: <YV7+/0+Q1n67wCF8@hirez.programming.kicks-ass.net>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 7 Oct 2021 07:13:13 -0700
Message-ID: <CANn89iLEz5POFii_=wU=2J0A9CE3H5JPq3sQFUQ8E400YumUpw@mail.gmail.com>
Subject: Re: [PATCH] x86/apic: reduce cache line misses in __x2apic_send_IPI_mask()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 7, 2021 at 7:07 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Oct 07, 2021 at 07:04:09AM -0700, Eric Dumazet wrote:
> > Good idea, I will try this.
> > Hopefully nr_cpu_ids is populated there ?
>
> Lets hope :-), I'm always terminally lost in early bringup. I figure it
> should be painfully obvious if it goes wrong.

The answer seems to be yes on hosts I tested.
