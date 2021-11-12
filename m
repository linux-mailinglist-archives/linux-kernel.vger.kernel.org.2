Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D280244EB58
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 17:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235409AbhKLQav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 11:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235209AbhKLQat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 11:30:49 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B99C061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 08:27:58 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so7172166wme.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 08:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7Mx4sv0Z+OWpo3XmiwYh9pL2bDl0W/f/UPkiyBp2OOg=;
        b=WfEalKoBAal21mFSWEpFNBuOdRf45QxEJGWc0OilwKzYc8rkxAnyaVnSKH1QZKFCHr
         SUep8at0JddUBSfJ5j3yF5iDbCDqpb0/A7pGH6Z0PzgeyaduioKYMESJr+FfzKFFcmc4
         ftRHJ9C8fOcUoKLURdOt6TmIt5uV2JoOjYFGbg6LCE1NkhJb6MVnmhuDMCAgQU8XhpxQ
         iL+EdGAid1FxMiYpK8i34JE4l+zQhJ8LJps6bQVNRJ5yP0jbJLwQTnSCsOncfcQdd48D
         PYlVRJCqhzjdkIu0Jen9AG5sDgmY/b5ptdi9sgrhnv4k9Ow4v96pimlzNLw69FWI0+C7
         9tOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7Mx4sv0Z+OWpo3XmiwYh9pL2bDl0W/f/UPkiyBp2OOg=;
        b=4zquSGD7xVNK5sRIolHOIqi7MMj3izkp6H/p4L8day1wjLxEys+6lfsS6/m+5zKmfI
         cWD9itup35MU840yjQYqLd+sSxLKek7fME2rXjqf8MbAkq2QfCG5E28Y/xdY7mmmvcJG
         QHKRR2zKCCylcKGaw/SggOr3ZjCnwIg9PjViNNq6mFCXmTjqvdebwPQJXQE4memZw+0a
         08uQ1kHq8GmVzXooN99YarKcsj+aXfktzDRuhnJoMaq2oESpI/8KfS6rZwJ9GUmQ56Pu
         ThzxbnxypI4PpogLS7B0r1fJT/Z96R1Ney62Ks5ssLN2BVxnEd5V2uEj0GnhW8ugIk+x
         eLqA==
X-Gm-Message-State: AOAM532Jm19IFV3q4AzLBvfA9ig6HOkYX7rVB4gUe+wj5bmTki6GIWBL
        36gqiOGEhBCo2RzyZIyAlEoQGQ==
X-Google-Smtp-Source: ABdhPJzITXLqVqTECGFrukJvOociEBLc+zZ1miTlMveQUTq79kO1KuzaqumRsBPszoCVtd3C/mQMBQ==
X-Received: by 2002:a05:600c:354f:: with SMTP id i15mr18259567wmq.59.1636734476982;
        Fri, 12 Nov 2021 08:27:56 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:6278:97ae:80fe:4b98])
        by smtp.gmail.com with ESMTPSA id j11sm6198417wrt.3.2021.11.12.08.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 08:27:56 -0800 (PST)
Date:   Fri, 12 Nov 2021 17:27:51 +0100
From:   Marco Elver <elver@google.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com>
Subject: Re: [syzbot] BUG: sleeping function called from invalid context in
 __might_resched
Message-ID: <YY6WB9wMx/0VaqDx@elver.google.com>
References: <000000000000f43bb905d06c8b7f@google.com>
 <8755565.Ff9ToCiNAG@localhost.localdomain>
 <CANpmjNMg62oXEQpuSccZdv-cx9txy2TH_4FQphaLEpSQTqZ1cQ@mail.gmail.com>
 <1805242.PYQNYDVmnG@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1805242.PYQNYDVmnG@localhost.localdomain>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 05:05PM +0100, Fabio M. De Francesco wrote:
> On Friday, November 12, 2021 2:58:14 PM CET Marco Elver wrote:
> > On Fri, 12 Nov 2021 at 13:22, Fabio M. De Francesco
> > <fmdefrancesco@gmail.com> wrote:
> > [...]
> > > I think that this "BUG" is a false positive.
> > >
> > > In do_con_write(), Just before the call of console_lock() there is an
> > > in_interrupt() check that, if it evaluates to true, makes this function to
> > > return "count" and prevents the SAC bug.
> > 
> > It's not complaining about being in an interrupt, but rather
> > interrupts disabled, i.e. still an atomic context.
> 
> Yes, still in an atomic context. 
> 
> Actually, I've never talked about being "in an interrupt", but I've just said 
> that the in_interrupt() macro prevents to fall into the code that might 
> sleep. 
> 
> Now I suppose that this is the place for in_atomic(). Isn't it?

in_atomic() probably won't do:

	/*
	 * Are we running in atomic context?  WARNING: this macro cannot
	 * always detect atomic context; in particular, it cannot know about
	 * held spinlocks in non-preemptible kernels.  Thus it should not be
	 * used in the general case to determine whether sleeping is possible.
	 * Do not use in_atomic() in driver code.
	 */
	#define in_atomic()	(preempt_count() != 0)

In particular, it doesn't detect if interrupts are disabled.

My guess is that in this case '!preemptible()' could work:

	#define preemptible()	(preempt_count() == 0 && !irqs_disabled())

But still am not entirely sure.

Thanks,
-- Marco
