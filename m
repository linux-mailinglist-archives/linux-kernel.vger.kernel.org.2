Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5408E38AF8F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 15:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240609AbhETNFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 09:05:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28805 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243215AbhETNE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 09:04:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621515816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=inyMr/7N0a6qL+glX2SQHV2O99zSuBvxKfCBioYVTWI=;
        b=GnmmCy93c/3FrGEuUKxF0+8djSSiCy6ewtLD5dbRib/ZelxghFDYweuNjcszfj6YZmRVNM
        iKfYrPyDs7yhGyhyRUC9EJ1CVEvDv1DqVWwTKG+WOvobAvBl42fMfqlM1Bxj/CHVZHBSnC
        Du+YzBErSsti2Jn0TSupgJ5seFEaFrs=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-_4k0KrEGNhCllP8pXeRgYA-1; Thu, 20 May 2021 09:03:34 -0400
X-MC-Unique: _4k0KrEGNhCllP8pXeRgYA-1
Received: by mail-io1-f71.google.com with SMTP id h7-20020a5d9e070000b029041a1f6bccc8so12146949ioh.18
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 06:03:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=inyMr/7N0a6qL+glX2SQHV2O99zSuBvxKfCBioYVTWI=;
        b=F7Brgt/XSmMQ7bKHVbeHIdlT1HJkiq6z5P/l6a/ND55DBTVs4PjjxVDPcRE/0P8UX+
         M4VIdx4yQCy2OyvvS9XqpDRfzlUL2rSYcjdBa4aEzEvtb0KcSlvgO8X1YMKHCDm33m4i
         cPaXuWOGln0ZObpc9d7KOTtg3ysllnrYftfKKza5Q4M7EUTz9AdQ3OHFQNhm12v4OCYs
         GWDxcnoKiiDEVByQOSD9F58aFjlkSsTXLcZNUEDnRVN6GedR/WjWkvykt0dL2fbXciD6
         4plLQcx2Dyj663M2uA+UZ+J+GVr0iT43GHxYTGQBcwjvA7okAlKoSv40npy077aaASBW
         kJ5Q==
X-Gm-Message-State: AOAM531pe6isIF2DWJAmqTY2DLNhAiUIHu7f80hepLWJDT3soOx0wuQU
        vWLJE2o5EnyNcxfXJB7Z5lkPVZ/XUKyYGuL83QD17z5eKuAvPLh6PlPT6jAOHYP08qFuP4Z1ELH
        WaYigYen1TR86ia+d/vSAV+vO
X-Received: by 2002:a05:6e02:671:: with SMTP id l17mr5189030ilt.267.1621515813422;
        Thu, 20 May 2021 06:03:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwbmnP7iW1CxCSD3eUfEoyspmFnsoN7DBtSxkyW2qnLHaP9wYRgTq6CEALgAs9mUozSpv17rA==
X-Received: by 2002:a05:6e02:671:: with SMTP id l17mr5189001ilt.267.1621515813153;
        Thu, 20 May 2021 06:03:33 -0700 (PDT)
Received: from halaneylaptop (068-184-200-203.res.spectrum.com. [68.184.200.203])
        by smtp.gmail.com with ESMTPSA id d2sm3047190ile.18.2021.05.20.06.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 06:03:32 -0700 (PDT)
Date:   Thu, 20 May 2021 08:03:30 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] init/main.c: silence some -Wunused-parameter warnings
Message-ID: <20210520130330.hqejx2xw6kbdibil@halaneylaptop>
References: <20210519162341.1275452-1-ahalaney@redhat.com>
 <20210519213731.fd8699098bf79bfd23c73090@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519213731.fd8699098bf79bfd23c73090@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 09:37:31PM -0700, Andrew Morton wrote:
> On Wed, 19 May 2021 11:23:41 -0500 Andrew Halaney <ahalaney@redhat.com> wrote:
> 
> > There's a bunch of callbacks with unused arguments, go ahead and silence
> > those so "make KCFLAGS=-W init/main.o" is a little quieter.
> > Here's a little sample:
> 
> Do we care about -Wunused-parameter?  I suppose we do, as it might
> point us at small code optimizations.
> 
> How voluminous is the warning output from -Wunused-parameter?  Small
> enough to be useful or large enough to be useless?
> 

That's something I was wondering too. The output from compiling with -W
is _very_ loud, to the point where it is almost pointless to do it. Even
with this patch applied I get 1679 warnings generated when doing a
recompile of init/main.o - all but one of them from headers included.

The motivation was brought up because item 20 in [1] says:

    20) Newly-added code has been compiled with ``gcc -W`` (use
        ``make KCFLAGS=-W``).  This will generate lots of noise, but is good
        for finding bugs like "warning: comparison between signed and unsigned".

and while none of this is newly added code, I found it pretty hard to
discern in a prior patch here if I was causing extra noise or not.
Thought I'd chip away at the noise.

If we decide we don't care about such warnings then feel free to ignore
this patch, but since I was playing around here anyways I thought I'd
clean it up a little. My preference would be to care, but the output is
so loud it is easy to make the argument that it is too late to start
caring.

Thanks,
Andrew

[1] https://www.kernel.org/doc/html/latest/process/submit-checklist.html#submitchecklist

