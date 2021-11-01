Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8485C44208A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 20:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbhKATNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 15:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhKATM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 15:12:58 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76390C061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 12:10:24 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id gh1so11869680qvb.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 12:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9Yh5KAej115BOsmnCnzIqo/9ygAgu2wASV/OBA3KQsg=;
        b=NqfKD7yCrDyqZTAqLkfFLKlHoQpuxs9uJpelMw1xnHrchWNzWIp/ea8Yze1viJ/TMn
         KcB+8uaaJPnsstlTcnAZvZsI51p8dFpj8C3mHYQUUGUy8+zNacN16D1Lc6yJuz2Y3xiy
         wj0qigu7U6IO0fnmq70SneI9wX2FqqDpJevU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9Yh5KAej115BOsmnCnzIqo/9ygAgu2wASV/OBA3KQsg=;
        b=XnLOblzDpQ1mSUoX18n9KUhnK1ST90W5iJzpf7N06qZ41RPojQ2nQcGKLfaUEld3XR
         q3vJIs2mMqfdHyWZaGpDK2ZuiqvLNeYPr3ADGkC0cxmaVEDmjf0LbybloSXTpXGx2D8R
         KJkd6ulTpz7hVZWIyrebg0SvDlplelGE2rOhgWrc74JOTerlpiTFDaPyrTdmxZd3ngRl
         BhA9IiNQmXl2FwZn8pWenYAIzw/x6kR/JmeDivlCTFNiv2W8CIt92ynBFsE7LEsvSHbw
         b3ozgzVfa1UVaPnIce2pLXauAqq5qTNPDhfnSXARa+6+hKqvwh6XKxKxNfDBmQ5ToOQd
         QriQ==
X-Gm-Message-State: AOAM533fyD33yg4wt8TLK6hufEU5+EKnHZn6jNAxn8c46Hjt/tcfGzDE
        6SA7n5LNJnDd4nggny6vRVbd6g==
X-Google-Smtp-Source: ABdhPJxpBnWPwguqPFlWIYe36uOS4iP9xRrY7Mw/91d7GMwtvxUCMEDoyWLmmNZNaH8/dQEDvUjhGw==
X-Received: by 2002:ad4:5b86:: with SMTP id 6mr11153060qvp.25.1635793823542;
        Mon, 01 Nov 2021 12:10:23 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-32-216-209-220-181.dsl.bell.ca. [216.209.220.181])
        by smtp.gmail.com with ESMTPSA id br17sm10815417qkb.10.2021.11.01.12.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 12:10:23 -0700 (PDT)
Date:   Mon, 1 Nov 2021 15:10:21 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rich Felker <dalias@libc.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Re: [PATCH 2/5 v3] sh: add git tree to MAINTAINERS
Message-ID: <20211101191021.h674kgeuqi4qyhdu@meerkat.local>
References: <20211005001914.28574-1-rdunlap@infradead.org>
 <20211005001914.28574-3-rdunlap@infradead.org>
 <20211027205431.GX7074@brightrain.aerifal.cx>
 <CAMuHMdWUQkhYxXfrG4MG-Ghi62P_XVxkCMb_6qijP-MMgn-JWg@mail.gmail.com>
 <20211028133049.GY7074@brightrain.aerifal.cx>
 <CAMuHMdUw=6RMF4gEhROMBwQALNmmKJgiKQLYymV4m75EZV+DJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMuHMdUw=6RMF4gEhROMBwQALNmmKJgiKQLYymV4m75EZV+DJQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 03:37:47PM +0200, Geert Uytterhoeven wrote:
> > > > I'm omitting this for now since (as noted on the cgit description)
> > > > this server is not provisioned adequately for cloning from scratch,
> > > > and should only be used for fetch into an already-populated mainline
> > > > repo clone. If that's a problem I can see about getting it moved
> > > > somewhere more appropriate.
> > >
> > > Perhaps you can move it to kernel.org?
> >
> > I would love to. This was my hope years ago, but I got bogged down in
> > the GPG key signing requirements and folks not following through with
> > signing my key. Has any of that been streamlined since?
> 
> I'll let Konstantin respond...

We still require a valid web of trust before we can issue an account, so
things haven't really changed in that regard. You have to get a PGP signature
from at least 2 other people who already have an account on kernel.org.

If you just need to host your git tree for hosting and sending pull requests,
then there's really no lack of options. Any large commercial git forge will
do just fine, including github, gitlab, gitea, sourcehut, etc. There's nothing
really special about kernel.org in this regard.

-K
