Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0AE240EB1B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 21:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234980AbhIPTvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 15:51:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59811 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233659AbhIPTvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 15:51:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631821781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sDj5QquE5wN5sDynUMGxIuSMd5cPh1XI9LhK8+3NFac=;
        b=SvRPDXSfyyw3YkAJxpKab/Ao4qdMlbudhtwz7F6qjNaBlRs9LKIhQFJ3MP1hltVTQcKnlF
        Zgrm/CQXTgj4KaOMR8fyt/Sn93oLRZ1bbLbAy7j+oBSjTGTYTkEqhXugzpYl4Ehn2oFeUc
        W0ZveLFCXih25P6NyQoNbCtynvihv6k=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-CDEg18dnP_yqK5gMxfb7ng-1; Thu, 16 Sep 2021 15:49:40 -0400
X-MC-Unique: CDEg18dnP_yqK5gMxfb7ng-1
Received: by mail-wr1-f71.google.com with SMTP id m18-20020adfe952000000b0015b0aa32fd6so2839635wrn.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 12:49:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sDj5QquE5wN5sDynUMGxIuSMd5cPh1XI9LhK8+3NFac=;
        b=nz5YiS5Y7nkvYQMiFDv8e2jDQlqMMfmb2WxMqBZin1uRp9eHR00/hznCQqwzjqdoA+
         1c5GIIhpUpuZB/c7LFp49oVdccRkkylb9gvCFcdiOIAaiOcfbN60xoNS8//NtxYoEnYk
         ipGCuqTD6oheFyoVC+0dTmq0Q15oBdApzbDsK9SsY7sPm5QIwZMPBb4JsFZOgPy3tjBM
         kvQwY24L8EkmVDuI5G/6/twEzXF4TFvJ78u7YXIHKkVMzNf0/W+EViYFnVvVFGe7r+vU
         qZkigkcooE5g8Xr5qogpcDYklrsOND+li+LSkNf6nMxtaeF8q8dFZoSqvneAEReoFN5Y
         Lu4Q==
X-Gm-Message-State: AOAM532cO/6N5JkQzL7sKXxHlEXeDUZHGnSorxZZrPfNsU1pQEcCpN+j
        SnjbnqS200hCe+GeOmO79TWrrfCoCGHN8e/OkxHcvQeQ9AFMnd7lDVQfha4DzJUkbXPB6CJ3x+P
        O3r6zfMWU1jk5WBcdkQooRDQy
X-Received: by 2002:a7b:c005:: with SMTP id c5mr6900964wmb.59.1631821779044;
        Thu, 16 Sep 2021 12:49:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzowIpQj7MDRnL7vkKs4yBql1LnXPD8G4Fs8z9x1Jol32Zpd/wojf6+iRyz0CfsHKVvoiJdyQ==
X-Received: by 2002:a7b:c005:: with SMTP id c5mr6900949wmb.59.1631821778833;
        Thu, 16 Sep 2021 12:49:38 -0700 (PDT)
Received: from krava ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id n186sm8475826wme.31.2021.09.16.12.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 12:49:38 -0700 (PDT)
Date:   Thu, 16 Sep 2021 21:49:37 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH 7/8] ftrace: Add multi direct modify interface
Message-ID: <YUOf0Wt3+2r9HH6A@krava>
References: <20210831095017.412311-1-jolsa@kernel.org>
 <20210831095017.412311-8-jolsa@kernel.org>
 <20210914174134.1d8fd944@oasis.local.home>
 <20210915174718.77acaf8b@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915174718.77acaf8b@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 05:47:18PM -0400, Steven Rostedt wrote:
> On Tue, 14 Sep 2021 17:41:34 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > A better solution, that prevents having to do this, is to first change
> > the function fentry's to call the ftrace list loop function, that calls
> > the ftrace_ops list, and will call the direct call via the ops in the
> > loop. Have the ops->func call the new direct function (all will be
> > immediately affected). Update the entries, and then switch from the
> > loop back to the direct caller.
> 
> An easy way to force the loop function to be called instead of the direct
> trampoline, is to register a stub ftrace_ops to each of the functions that
> the direct function attaches to. You can even share the hash in doing so.
> 
> Having the ftrace_ops attached in the same locations as the direct
> trampoline, will force the loop function to be called (to call the stub
> ftrace_ops as well as the direct trampoline ftrace_ops helper).
> 
> Then change the direct trampoline address, which will have the ftrace_ops
> helper use that direct trampoline immediately*. Then when you remove the
> ftrace_ops stub, it will update all the call sites to call the new direct
> trampoline directly.

ok, that's the way the current direct modify interface is using, right?
I thought it'd be not so easy to adopt for multiple functions, I'll check
on that again and come for help ;-)

> 
> (*) not quite immediately, as there's no read memory barrier with the
> direct helper, so it may still be calling the old trampoline. But this
> shouldn't be an issue. If it is, then you would need to include some memory
> barrier synchronization.
> 
> I'm curious to what the use case is for the multi direct modify interface
> is?

when the trampoline is re-generated by adding or removing program,
we have same functions to trace and new trampoline to attach

thanks,
jirka

> 
> -- Steve
> 

