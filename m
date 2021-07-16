Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A603CBAEE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 19:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbhGPRIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 13:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbhGPRIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 13:08:12 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E36FC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 10:05:16 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id g8so7608199qtj.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 10:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W6SIeoBg1DkcyvgcoeydZ8AAdyJegtyOitc9kq3PmT0=;
        b=CaXBg+yk3wFm1JTg0C9WRIG2RdSEML5UqjjEAikj3TkPl2AatwXckVhLnhWruM/VZ5
         WgL98ZT8bFugKwk6WN4JUWcHd21m1sq1xfvbRyp/Qt7xA9y1Qf2TGrfqCEBqQI/xXBQe
         XSavzr5uObBuRqwFH2OaXdpZSZiv95tyxPSGOL1reOmRbZdUi3umHt/SnpCw5FutLOj6
         506fiqLIw/l//jmdCy0dsXGeL8V0XAyrppmInW3Atv6izgyhrqkWxTKeU/5+bPOTPAJY
         mAqblM8G60tnOpFZqUtiEfB2AgvKCYSD1w/eF2lu2M7bZYZU2UvwuVryOm8c/fZfza4D
         /OLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W6SIeoBg1DkcyvgcoeydZ8AAdyJegtyOitc9kq3PmT0=;
        b=VLkAkrttnIoBcaopxcoIj1rbChLsD9L/6H607dgmFpGptSVGk2V2mFRJUxcgQYQyMr
         pTLNErgDKVLLU9xpGBTRgimVLDBxuMEy4s3zK8OelxfdT4QlR7xD7Vdrhsw966Tw93EM
         +piEb0XHpHuNSBVUhjsMtkrawHvRy2YU4lw0HTFX11H5spl0uMObaaLJx2jmeHos9q5W
         kw0nrOGvaETeElIx8SseQsjrV75/vtLNB2b6hSLHmALqa3c74SIfBSJIMIahAKOHapem
         VrPvhaxupphsBJ83YK6vSsiD/rGFBYJcAkKStTn1GCqzsqh2HqvTSLXCSMR4jPanlnwo
         JrtQ==
X-Gm-Message-State: AOAM530SPbUfO3nutYIoxQpKmvDKPlgRmizQC4wCfO7P4I/s41t2xPzA
        O2yHH6yQJ+w27uAkeL7j3qw=
X-Google-Smtp-Source: ABdhPJwkRKtyIqmIS3oubkpiLCGicN/r2iSdVyY2utlk1Z/F96zhbEreIksU3R0coTvnF4fnDlOjJQ==
X-Received: by 2002:a05:622a:2d1:: with SMTP id a17mr2833375qtx.338.1626455115410;
        Fri, 16 Jul 2021 10:05:15 -0700 (PDT)
Received: from localhost ([207.98.216.60])
        by smtp.gmail.com with ESMTPSA id s3sm3381657qtn.4.2021.07.16.10.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 10:05:15 -0700 (PDT)
Date:   Fri, 16 Jul 2021 10:05:13 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2/2] bitmap: introduce for_each_set_bitrange
Message-ID: <YPG8SdsbQ+sxjk0w@yury-ThinkPad>
References: <20210709034519.2859777-1-yury.norov@gmail.com>
 <20210709034519.2859777-3-yury.norov@gmail.com>
 <20210709095950.6a451ccb@oasis.local.home>
 <YPBZPbCgJPjV2qPW@yury-ThinkPad>
 <YPGNw4nRXsdaTHi4@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPGNw4nRXsdaTHi4@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 16, 2021 at 03:46:43PM +0200, Petr Mladek wrote:
> On Thu 2021-07-15 08:50:21, Yury Norov wrote:
> > On Fri, Jul 09, 2021 at 09:59:50AM -0400, Steven Rostedt wrote:
> > > On Thu,  8 Jul 2021 20:45:19 -0700
> > > Yury Norov <yury.norov@gmail.com> wrote:
> > > 
> > > > bitmap_list_string() is very ineffective when printing bitmaps with long
> > > > ranges of set bits because it calls find_next_bit for each bit. We can do
> > > > better by detecting ranges of set bits.
> > > > diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> > > > index 87acf66f0e4c..1ee54dace71e 100644
> > > > --- a/lib/vsprintf.c
> > > > +++ b/lib/vsprintf.c
> > > >  
> > > > -			buf = number(buf, end, rtop, default_dec_spec);
> > > > -		}
> > > > +	if (buf > start)
> > > > +		buf--;
> > > 
> > > If the above is to undo the last comma, please put back the first logic.
> > 
> > You're asking me to move part of the logic inside the loop which generally
> > should be avoided. Is there any particular reason to do this?
> 
> vsprintf() should write what is needed and keep the rest of the given
> buffer intact. There is even a test for this in the test_printf module.
> 
> I think that test_printf does not complain here because only a single
> character is used and it is later replaced by the trailing '\0'.
> 
> By other words, undoing the last comma does not cause visible problems
> in the end. But from vsprintf() point of view, it is a hack that does
> not trigger the warning only by chance. And it is better to avoid it.
> 
> Best Regards,
> Petr

Ah, OK. Thanks Petr.
