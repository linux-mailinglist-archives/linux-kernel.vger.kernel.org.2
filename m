Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56F938C3C6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 11:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbhEUJtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 05:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233946AbhEUJtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 05:49:12 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3AFC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 02:47:48 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id v12so20409514wrq.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 02:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U9YtYqD1zOgwTQj4rwYUvRL9M+o9cBUdkDhNiVVCqT4=;
        b=BZ4SRa8E72pIovSE18ljTyIk2ivJUsYWo9ncs4s+AUTe7AfeOrjVSvSYJl1UbHRusi
         Ld35Jm+qOEjR20p/6AwlCZuhzuMgxtI2qlOl2r/Gl+5Fst3A7O/rAbr9Z38clmQauWx8
         7uuzUSSCfJd75Lzdf1+r/4C0KBhxubEkFbGiodGEPVCtFhOY7gIQZpVsCVdf3XhxeYWS
         PAzFgu+3Y7xUioY78vkJwf+Vkzfq/cE/kqh1cY3619P875D3p5UrB66wbXGghNxMenkr
         TLtAGTFCQAZEV0w5JcKiPvmG7Yp08KpI2Yyma1nyUXQ4ZJzOqf+V+e68JCXMPpb5tJrJ
         7Nlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U9YtYqD1zOgwTQj4rwYUvRL9M+o9cBUdkDhNiVVCqT4=;
        b=Ow5hZ0nKZ6Emiu+TOVP3RXHwTFyaVSrXt204AdIRm0oeFSsBUz2psqs/ox9Oiwq1hp
         s6M3UUAD28pJFFSaxJtzQifiCiNEARcC7GsZUPZELlF/psGX6lTo3L06WlorOInHPmjT
         bDJVsNccb4RrnRJjrfAbfzEpWSFvVQrOrn3M07n84Ki+MQLotfB7hNnAPr8o15G3dyif
         Bi9DqPgvDlMBRaukUfh4TooiOXtkiLXBjBJ0Z6YYozk0nIwgTn2NeU6ngUkeVT9LLg8v
         p7JIEjYDdWH/Xvi6KCrDTolHU4Ak2zyM3+K2gj8YkPkh/AB3WmHcYzXKpubKv5teQ/Ai
         mdDw==
X-Gm-Message-State: AOAM533elaachQoxZnopnR3MdN+YWBud3DC/+wpqtv5U22hArggCSH2y
        QVp4wnS+EPkAhD5e/ZfSvhnWRg==
X-Google-Smtp-Source: ABdhPJzAu9UcriKavTjt1us34Dgaviz7nsPsgGwSihi9yme6I9Rax5zBNoxlLILEiu19iO3Tq7OjWg==
X-Received: by 2002:adf:aad8:: with SMTP id i24mr8716047wrc.0.1621590467086;
        Fri, 21 May 2021 02:47:47 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:a932:cdd6:7230:17ba])
        by smtp.gmail.com with ESMTPSA id t7sm1429438wrs.87.2021.05.21.02.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 02:47:46 -0700 (PDT)
Date:   Fri, 21 May 2021 11:47:41 +0200
From:   Marco Elver <elver@google.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "glider@google.com" <glider@google.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        Mel Gorman <mgorman@suse.de>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] kfence: use TASK_IDLE when awaiting allocation
Message-ID: <YKeBvR0sZGTqX4fG@elver.google.com>
References: <20210521083209.3740269-1-elver@google.com>
 <bc14f4f1a3874e55bef033246768a775@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc14f4f1a3874e55bef033246768a775@AcuMS.aculab.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 09:39AM +0000, David Laight wrote:
> From: Marco Elver
> > Sent: 21 May 2021 09:32
> > 
> > Since wait_event() uses TASK_UNINTERRUPTIBLE by default, waiting for an
> > allocation counts towards load. However, for KFENCE, this does not make
> > any sense, since there is no busy work we're awaiting.
> > 
> > Instead, use TASK_IDLE via wait_event_idle() to not count towards load.
> 
> Doesn't that let the process be interruptible by a signal.
> Which is probably not desirable.
> 
> There really ought to be a way of sleeping with TASK_UNINTERRUPTIBLE
> without changing the load-average.

That's what TASK_IDLE is:

	include/linux/sched.h:#define TASK_IDLE                 (TASK_UNINTERRUPTIBLE | TASK_NOLOAD)

See https://lore.kernel.org/lkml/alpine.LFD.2.11.1505112154420.1749@ja.home.ssi.bg/T/

Thanks,
-- Marco

> IIRC the load-average is really intended to include processes
> that are waiting for disk - especially for swap.
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
