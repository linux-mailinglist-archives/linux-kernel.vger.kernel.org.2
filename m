Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A192B366071
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 21:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbhDTTzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 15:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbhDTTzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 15:55:21 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6DCC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 12:54:49 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id l4so60048802ejc.10
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 12:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uFNFpoRS03g7XkmkDpfCAdqtLSbNnkUok6vdGzxiXNM=;
        b=abR+4j0Hp863Nv20sJiBEsta4XfCdw4vdOQTbfb2O4gprLBCq7hkbRJOAabiMU+u5H
         kG6JAI6Q5ncIBm16UFa19SKi1QjS9sD2hxOqYG9MacxjhnHkcPIV41611MhHDxzVTFpo
         /FO8Y4r2vnqdWNAhL48FZ+5oJK7RsM0uMuEdHPa4fGeqM9rI2u7Um1vLdR7Fl88V4Edj
         ee1BVUL7VgUx8N6JY2jVAK6ODD0CfRoQa3ZbiW1PvQdPhOPAzOUWbQwJludZBmwznRqY
         J6ll4DAs/PqUY4t9IGhLoL7ATaabzCgTz0x39Ya0XDDjIGbPM6N8Q7xK/2Jsrz2kd5yW
         I2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uFNFpoRS03g7XkmkDpfCAdqtLSbNnkUok6vdGzxiXNM=;
        b=VfXxpQhJdplqzMiSpAVnEzHOhBGFtquvszAHWHAgD1vOBw0Ik92hDprDcrs30IZC79
         wah+GGYFxD36i1XrjqCH42tgVw9gGSQ1G7aO9e47DNEMvbzLowrXAlleMqShbrGh3oXJ
         jLEuJuYp0bxAH+tmt5VLZy78ScCUDtgcPN0m4sB9shBZ5zKKC3X9wtaHctUe7xpJBuTt
         sQLTtLsZSakHNFUirtcEXTI+KuOm2pn/IyHQQiwAEiJRqnpLnOvj1lFj+V/obnak/hOj
         biQa8VyXyr+Ne+18sxUyMP/GhH0OxlX/AwmsBV/EtXul82+EtfxZpLV0tuLXgtPli9JE
         9GIg==
X-Gm-Message-State: AOAM530wUBJnTxA2NG9OhGPha9m8CqsoAq0aEgV8L/q+K4gNBVEgT1td
        GTM+tLJP0vnDX9zrXdenZOaQTzErzs+KWW37lLAlDQ==
X-Google-Smtp-Source: ABdhPJztNnWNYRK9q/EzEExJZuM8ky1QrhKm1X9zuDVOap3RsJR8Bap8113BadT4fggOvhNGEPtea3fVYetyylzKgHI=
X-Received: by 2002:a17:907:7631:: with SMTP id jy17mr29286875ejc.418.1618948488004;
 Tue, 20 Apr 2021 12:54:48 -0700 (PDT)
MIME-Version: 1.0
References: <1299622684.20306.77.camel@gandalf.stny.rr.com>
 <877hc64klm.fsf@rustcorp.com.au> <20130813111442.632f3421@gandalf.local.home>
 <87siybk8yl.fsf@rustcorp.com.au> <20130814233228.778f25d0@gandalf.local.home>
 <77a6e40b57df092d1bd8967305906a210f286111.camel@intel.com>
 <20210419181111.5eb582e8@gandalf.local.home> <CAPcyv4gw7KoL8U66LLx_DVAE+5Jguz7tb3Rax-bdTz4BrpwhvQ@mail.gmail.com>
 <20210420085532.4062b15e@gandalf.local.home>
In-Reply-To: <20210420085532.4062b15e@gandalf.local.home>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 20 Apr 2021 12:54:39 -0700
Message-ID: <CAPcyv4gHHPdCYPzLeNzX0KMoNrOf8H0N5PBiWam0wF+WhV-Jpg@mail.gmail.com>
Subject: Re: [PATCH][RFC] tracing: Enable tracepoints via module parameters
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "fweisbec@gmail.com" <fweisbec@gmail.com>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@elte.hu" <mingo@elte.hu>,
        "chris@chris-wilson.co.uk" <chris@chris-wilson.co.uk>,
        "yuanhan.liu@linux.intel.com" <yuanhan.liu@linux.intel.com>,
        "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 5:55 AM Steven Rostedt <rostedt@goodmis.org> wrote:
[..]
> > > So yes, function tracing now allows setting a filter to trace only the
> > > functions for a given module, and if that module is not yet loaded, it
> > > stores the filter until it is.
> >
> > Ah, thanks for the pointer. So if I wanted to convert a kernel command like:
> >
> > libnvdimm.dyndbg
> >
> > ...it would be something like:
> >
> > ftrace=function ftrace_filter=:mod:libnvdimm
>
> Hmm, that may not work, but if it doesn't, it would be trivial to add it.
>
> >
> > ...and then "cat /sys/kernel/tracing/trace" instead of "dmesg" to
> > retrieve... assuming only "got here" style debug was being attempted.
> >
> > > To do something similar for tracepoints, I think we still need to add it as
> > > a module parameter.
> >
> > The dev_dbg() filter language is attractive, it's too bad
>
> Not sure what you mean by that. What filter language. Tracepoints do have a
> pretty good filtering too.

I'm trying to replicate dev_dbg() usability with tracing. So, when
people say "don't use dev_dbg() for that" that tracing can reliably
replace everything that dev_dbg() was offering. What I think that
looks like is the ability to turn on function tracing by a function
name glob in addition to any tracepoints in those same functions all
from the kernel boot command line, or a module parameter.

> > trace_printk() has such a high runtime cost as combining dynamic-debug
> > and tracing would seem to be a panacea.
>
> trace_printk() has a high runtime cost? Besides that it's not allowed on
> production code (see nasty banner), it is made to be extremely fast.
> Although, it does do sprintf() work.

I was referring to the banner. dev_dbg() does not have that production
code restriction.

> Would adding automatic module parameters be an issue? That is, you can add
> in the insmod command line a parameter that will enable tracepoints. We
> could have a way to even see them from the modinfo. I think I had that
> working once, and it wasn't really that hard to do.

Yeah, that's what you seemed to have working at the beginning of this thread:

https://lore.kernel.org/lkml/1299622684.20306.77.camel@gandalf.stny.rr.com/
