Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB0D438309
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 12:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhJWKJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 06:09:34 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:34567 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbhJWKJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 06:09:33 -0400
Received: by mail-wr1-f48.google.com with SMTP id d10so801267wrb.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Oct 2021 03:07:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent:organization;
        bh=BtvKTNRM1ufVMrUKQuKY7C9ijfBOccvsGcReMZF+Wqc=;
        b=0gQcEKqq3tILYj98sdw9ffQ9hMOvH19EoLAlTHHa2OM1XLli73511Fmic8ke9O9nqq
         tkj8kHUSOY+utz4zvzAibPb5X0OwwVJk1RObWSj+H9uH28macr3HLBfBMeXVTdeanLIz
         px3osR6ucdzMcClcDbOZM0nEAxorrOpsC33tB1rnXCeTdrGu2sReqNfFG1cqbHuYRH5D
         L9TeOrIamTYUH7I8rTH4outup1HRzFQcqf/EF79bs0dvH2y7KS8KB0LYnm4EYMK9/JFd
         hx1gynuA1qQAAX7ZphUh4GrSqGKDzjHVy/1uJHUr18RdNgOuzqGIBK+KoWWWuO4T6SF6
         0xtw==
X-Gm-Message-State: AOAM533UMbNKcrSeY8euq6D3kJOznA2ulsiGq0+PaF3dqunfL2xLYN+K
        usazSgmHYJT/lscCr7+tKTxxew==
X-Google-Smtp-Source: ABdhPJyGqNsk7PRdRlSckaaEopi/r4nsBQ2jKv3kUR9YOCrA0oZTHpRug6WXqqg3P9LervEAg7y6hQ==
X-Received: by 2002:a5d:4ac4:: with SMTP id y4mr6909523wrs.190.1634983633322;
        Sat, 23 Oct 2021 03:07:13 -0700 (PDT)
Received: from fedora.tometzki.de (p200300e68f0105009e5bc999bd8eb7e0.dip0.t-ipconnect.de. [2003:e6:8f01:500:9e5b:c999:bd8e:b7e0])
        by smtp.gmail.com with ESMTPSA id q1sm3158695wmj.20.2021.10.23.03.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Oct 2021 03:07:12 -0700 (PDT)
Date:   Sat, 23 Oct 2021 12:07:10 +0200
From:   Damian Tometzki <dtometzki@fedoraproject.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     gregkh@linuxfoundation.org, tglx@linutronix.de, clm@fb.com,
        corbet@lwn.net, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, longman@redhat.com,
        miguel.ojeda.sandonis@gmail.com, wedsonaf@google.com,
        boqun.feng@gmail.com, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: "Using Rust for kernel development": Memory model
Message-ID: <YXPezv907nRp62OD@fedora.tometzki.de>
Reply-To: Damian Tometzki <linux@tometzki.de>
Mail-Followup-To: "Paul E. McKenney" <paulmck@kernel.org>,
        gregkh@linuxfoundation.org, tglx@linutronix.de, clm@fb.com,
        corbet@lwn.net, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, longman@redhat.com,
        miguel.ojeda.sandonis@gmail.com, wedsonaf@google.com,
        boqun.feng@gmail.com, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
References: <20211022210315.GA2582977@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211022210315.GA2582977@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt
Organization: Linux hacker
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Paul,

many thanks for the great article and your time. 

Damian

On Fri, 22. Oct 14:03, Paul E. McKenney wrote:
> Hello!
> 
> This email is in response to the Rust memory-model discussion at
> Maintainers Summit (https://lwn.net/Articles/870555/).
> 
> My blog series entitled "So You Want to Rust the Linux Kernel?" [1] is now
> feature complete, and a big "thank you" for all the great feedback that
> this series received.  I have recommendations at "TL;DR: Memory-Model
> Recommendations for Rusting the Linux Kernel" [2], and this email is
> therefore TL;DR(TL;DR).
> 
> Given the Rust-for-Linux's focus on device drivers, the Linux-kernel
> features requiring special Linux-kernel-memory-model features can be
> avoided within Rust code.  For example, code using RCU, sequence locking,
> or control dependencies can remain written in C, and higher-level APIs
> based on that code can be exported to Rust in manner consistent with
> Rust's current ownership models.
> 
> This approach reasonably straightforwardly accommodates the more likely
> short-term choices for the Rust memory model, which would presumably be
> the C/C++ memory model or some stronger subset thereof, for example, one
> that excludes consume and relaxed accesses.  If the Rust community chooses
> a less mainstream memory model, the code that makes C-code functionality
> available to Rust code would need to take up any slack.  For example,
> memory barriers might need to be inserted into this wrapper code.
> 
> Longer term, I hope that the core Rust community will become interested
> in supporting modern techniques, and to that end I have suggested some
> longer-term goals in the TL;DR post.
> 
> There is already plenty of interest in modern techniques within the
> greater Rust community, and number of people produced prototype wrappers
> for various sequence-locking and RCU use cases.  I am grateful to all
> who took on this challenge.
> 
> However, arriving at good wrappers requires a sufficient understanding
> of Rust to be combined with sufficient knowledge of the Linux kernel's
> wide variety of sequence-locking and RCU use cases, and unfortunately
> this combining seems to be some ways off [3].  It therefore makes sense to
> defer the need for such wrappers in order to allow time for this diffusion
> of knowledge to take place.  So, in the near term, if a Rust-code project
> were to request direct access to RCU APIs, I would instead ask them to
> create higher-level APIs so that the RCU APIs would remain within C code.
> I am also working to better document the wide range of RCU use cases
> that are present in the Linux kernel, which I hope will speed up the
> process of working out what a Rust-language RCU API should look like.
> 
> Of course, the corresponding choices for sequence locking are in the
> capable hands of the relevant maintainers, who are CCed.
> 
> Thoughts?
> 
> 						Thanx, Paul
> 
> [1] https://paulmck.livejournal.com/62436.html
> 
> [2] https://paulmck.livejournal.com/65341.html
> 
> [3] This process took four years in the C/C++ standards committees,
>     but perhaps things will go faster with the Rust community.
