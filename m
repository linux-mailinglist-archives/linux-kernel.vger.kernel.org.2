Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA74D41DB55
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 15:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351760AbhI3Noq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 09:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350042AbhI3Noo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 09:44:44 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D942C06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 06:43:02 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id g62-20020a9d2dc4000000b0054752cfbc59so7325248otb.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 06:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z+mDLaCEoD4xcfTBzaSvcO3VRIj8xtvNVb0uc+dFdB8=;
        b=F9NCaeaTNyVMgwTGU9IRiAIP3KmnXEJengmaehgEb4aZZfJKD12ACx94EfatQcifmo
         zAbRd5lx+SKQ7Oou04Fl0vGmTeeH5phGgndSixB6cxYsnGmrJLFHVcJ7Kyk+u6WaQkbx
         1/2lOjZ6KqA675rOaCio7AFbN/TlFdO2iRo0hzHXuHH69vzDlLZ1FKdwiaU4YsqD+n7B
         gb71tLfUxFPtTU5OVU3mXbKr9pb0w7zxJQY93thfrCFO2e/GhL5mf6z6KjiUp95sHN6d
         wpqd7iwscjD4TQTcxj0KFAY7tzhlbYXwiUhwZ5j74Aym5PX6msqPrSVc/16vETUfwMwj
         d44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=z+mDLaCEoD4xcfTBzaSvcO3VRIj8xtvNVb0uc+dFdB8=;
        b=P5Ig1iSIYaWe7HnjDRQ04y7tsD3rTkUmsUPtyDfpzxaihnLhn9Y9YrwlQJaoGlEC6E
         TrSAVMrQsAsJrNxAB4eCD5CVOAjHlrMva/sJlCuv6zlM/eTL3pYtzTLfhkytjURc3NXx
         i/ucBXDXrJwxXwER9f25COHujteYloAAS5nBa7RRuod9MJsd0QlueXUrikvo76HSZG47
         YBtHXlRUpzNtmXtpoykv60nnCtyTYU6TfVXfuLkrGcOTkWVjKUflpYtMf7Eq5IcbMYmH
         qpmAxAiuHOk2gKJtgGw7+8KbAXAdN0Tp7ADUdrRa47mOZr90JYD+a1ruh/iJl4LJ/Qim
         jyvg==
X-Gm-Message-State: AOAM532Jq6Q0aTyJm4uiNBzI4dp1KqVrOOfnOMlYltVIPBLKYfcGBAK7
        f/AVO7Rg9D4LANOBibdBi9U=
X-Google-Smtp-Source: ABdhPJwhSFQRrbb1AjWRmbzQ6+H6Awgkljp+IWBtQ2mzAW/R8xGPuu0ntPL9H2YTpm8KnJWkIz0M7w==
X-Received: by 2002:a9d:3e4a:: with SMTP id h10mr5165304otg.171.1633009381443;
        Thu, 30 Sep 2021 06:43:01 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u17sm572856ots.22.2021.09.30.06.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 06:43:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 30 Sep 2021 06:42:59 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.15-rc3
Message-ID: <20210930134259.GA521118@roeck-us.net>
References: <CAHk-=wgoE8XBPVA6Mu4CygxX9TE0FgWaAsVUJOe8KQH-CzEcAA@mail.gmail.com>
 <20210927110548.GA771805@roeck-us.net>
 <CAHk-=wiuGKOBvgje56X-EdOp4mnoz4C2nM1ML6DqRFfsptai3w@mail.gmail.com>
 <20210927200932.GA8510@alpha.franken.de>
 <CAHk-=wgdZgiLoHoQS+C2CP8x5PGn6b=GBkY6K9T3QhDoaeV9mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgdZgiLoHoQS+C2CP8x5PGn6b=GBkY6K9T3QhDoaeV9mg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 01:46:42PM -0700, Linus Torvalds wrote:
> On Mon, Sep 27, 2021 at 1:35 PM Thomas Bogendoerfer
> <tsbogend@alpha.franken.de> wrote:
> >
> > if it was a fix in the mips tree I would have sent it already, but it's
> > watchdog driver fix, which was meant to be picked up by Wim.
> 
> Oh, my bad. Regardless, it's fixed in my tree now, and all of
> Guenter's build failures should be fixed.
> 

Sorry for not getting back earlier; I have limited internet access
right now.

I _am_ watchdog co-maintainer, so I guess it is partially my fault.
Wim normally handles pull requests. I had asked him to send a pull
request with this patch, but unfortunately he didn't reply.

> Of course, other random configs and compilers are still an issue, but
> it's nice to see that most (all?) architectures can at least do a
> clean "allmodconfig" build for some random set of tools. I don't think
> we've ever been there before.

Not all of them, but that is nothing news and unrelated to -Werror.
Many 'minor' architectures do not and never did successfully build
allmodconfig, and others (nds32) need a specific gcc/binutils version
to build it. I submitted a set of patches for csky to enable it to build
allmodconfig with upstream gcc, so maybe we'll get that in 5.16. For
others it may be a lost cause. I can create a list with build errors
if there is interest.

Guenter
