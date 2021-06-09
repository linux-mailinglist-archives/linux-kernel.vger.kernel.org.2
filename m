Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5732B3A1C90
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 20:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhFISOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 14:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhFISOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 14:14:19 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB42C061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 11:12:24 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id j12so20226329pgh.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 11:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gks6qbv9Lr+imHtC7AaeB4+/G8WI7NzfclheXnHYu0Y=;
        b=UdhbgzZUkddxIZ5rHW9r5JA7w1k60HSJek2eW6w9ZJzw/vlksEFnZgQ/MSRRILhjpU
         CPn+IdzCaDhGEx3viK0Uc7ioDMPVeCvbzlAGFDRk1d1hXyIMvW5HjV/CoTM+nXEbpc1A
         kescIHMYfbgdVwjWFpCwWbXDK+316/NOYRRc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gks6qbv9Lr+imHtC7AaeB4+/G8WI7NzfclheXnHYu0Y=;
        b=IcNtx7yQZUfyMwTExoX3N0vliRGGJUKSAwCSTI7va6RNhZQCUAH1K30Uha7/3xAl1j
         f0srlmLk47glEAvA5BzF4UYv+MI2sBLbscCMmHYTkxaqMG79ITZbjgyfSq3lkXOdSjJZ
         3+1kZHL9CpSkcJEAZiZy137oZB45WhDlyoZ8mpyyUDoVbs238XJeOUU1l2IS6oFns2B/
         9JMMMgUaFzRa40wc0qY/NLGLz78Tl58scA5dZ1ftbBbqbhJVSSMrTgGMd5amdAQpsq8M
         gBLDwPe1VhNzZYvzYCiRJEs7VLvXuYXpOcMFo1dQGrusrtIpzA3OAHdzYlm4DKXP3P6S
         k/dA==
X-Gm-Message-State: AOAM532aXxYSNEki/l6jk8Q3kleEegETY79KeKa1fIjI2GQ8B6hKyY26
        E1aQiQSOqJgr9x9kmoJdU/91fKYs1nlW7A==
X-Google-Smtp-Source: ABdhPJz2NS8YTClpY3QzVpJIjA5NuhRW9njVzmhpgF8VNv7ILKzJkp6maVlZgUrsgcXmluyEqRW9EA==
X-Received: by 2002:a63:1d09:: with SMTP id d9mr941895pgd.302.1623262343701;
        Wed, 09 Jun 2021 11:12:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d66sm246332pfa.32.2021.06.09.11.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 11:12:23 -0700 (PDT)
Date:   Wed, 9 Jun 2021 11:12:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Zhengyejian (Zetta)" <zhengyejian1@huawei.com>,
        rostedt@goodmis.org, ccross@android.com,
        linux-kernel@vger.kernel.org, Zhangjinhao <zhangjinhao2@huawei.com>
Subject: Re: [BUG] I found a bug when try to enable record_ftrace
Message-ID: <202106091110.F13B8B6@keescook>
References: <01472d0f-55c1-15ea-9beb-5d64b322bb44@huawei.com>
 <202106021042.8527F3AB30@keescook>
 <YL/CHEbw5L2Selfm@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YL/CHEbw5L2Selfm@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 03:16:44PM -0400, Joel Fernandes wrote:
> On Wed, Jun 02, 2021 at 10:43:29AM -0700, Kees Cook wrote:
> > 
> > On Wed, Jun 02, 2021 at 03:42:23PM +0800, Zhengyejian (Zetta) wrote:
> > > Hello,
> > > 
> > > There may be a deadlock caused by ftrace recursion when try to enable
> > > record_ftrace.
> > 
> > Hi,
> > 
> > Thanks for the report. Joel, is this something you can take a look at?
> 
> Kees,
> 
> Sorry for late reply. Right now I am dealing with a production-stop bug and
> would not likely get time. Plus I feel a bit less motivated, because the
> ftrace in pstore the way it stands now is unusable due to perf issues anyway
> (I wonder if anyone uses it at all now). I would rather someone who has time
> to work on this try to revive: https://lkml.org/lkml/2020/9/2/1075 . Should
> we just delete pstore function tracing till then?

If no one is using it, then yes, let's rip it out. Zetta, are you using
pstore ftrace?

-Kees

-- 
Kees Cook
