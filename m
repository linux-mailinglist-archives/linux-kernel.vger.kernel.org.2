Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABFC131358A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 15:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbhBHOry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 09:47:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbhBHOep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 09:34:45 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81894C061788
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 06:34:01 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a9so25058305ejr.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 06:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Cw2bJezjxJXzUVOhX7h38EvcUGtOt4m/8Z18cKh11zE=;
        b=CKSXjVv/xg64+uJ7vm8UgYFjbhKvsVTlGpTEy/kGeHqhEKekoJAyrdvUPb4S64ptCK
         tSpe5V/OPUHp12qv9T/uAB6qTOvqLDauQaENBkKz32rXhUrxi+HZp0eXCneU5BPr/91I
         JMH4/DKkc3uevcoH+j6f6YjwNB8pRUjNAFdX/CkbH6HcM5uVLrR23VUeL3+/DUQPCS9z
         u2KJTQv78CxCPqteRjBqyR7vibJdL5tHanvaz6Cwq6c3d7NpdvBArMgm/vQu5Dy4/f1x
         8bhmdWKRFR4VXFv7hOfWlafFilu6Bx32ENuDlGITq5rtNR7T43Zy2dDrfbaMZxk4zl2R
         ljLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Cw2bJezjxJXzUVOhX7h38EvcUGtOt4m/8Z18cKh11zE=;
        b=tGIKOy3G8wzRZ8i6YWPKQd3TCAqHUWb4lz9RjdhQakeg72kUcnfe0MiXoJOt51UJ6t
         ba85a32Hj1lnY8+yjbfbqe/4cdgZy1swjuq2y+7BkDYYxYF578KRZBW1oR6x2UmJafpD
         tlxF4PvnRr9Q7Q5GOtXMkOaeHbodBzUCu/Ov8OEUFjtVEu4OcRaXVJ0o2bWfLo9SqaG2
         aD4ZkJRqBDwrjVupsudAD7I9L3FDLgusaqpgunee1XutoY/JyghxhhrBJ/KRDzsmJlSy
         R2RWkDTNMFtUJ7AXS1TS/bP3oE3D3dNSRaLpxGOTyFpcdQ6EpFBwlVyu2/gMan80OSw9
         F8xA==
X-Gm-Message-State: AOAM531FdtGQBp/udhlX8X6NbGkrKKa4LI51Vk7LbJQ34J779TfvCO2X
        LNjh6QIai0nj+gmfg1eX4A==
X-Google-Smtp-Source: ABdhPJxYyHeWrwacfNGlS4E7cJrhjaIngAiadK1mA+3UYCAcNjd/2WLpXPsbPPb6n0UtwqffzjtSOg==
X-Received: by 2002:a17:907:9702:: with SMTP id jg2mr17461438ejc.48.1612794840348;
        Mon, 08 Feb 2021 06:34:00 -0800 (PST)
Received: from localhost.localdomain ([46.53.253.245])
        by smtp.gmail.com with ESMTPSA id o11sm9520679eds.19.2021.02.08.06.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 06:33:59 -0800 (PST)
Date:   Mon, 8 Feb 2021 17:33:58 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] sched: make struct task_struct::state 32-bit
Message-ID: <20210208143358.GB10066@localhost.localdomain>
References: <20210206151832.GA487103@localhost.localdomain>
 <YCEU3SSoYneIh5t1@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YCEU3SSoYneIh5t1@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 11:39:25AM +0100, Peter Zijlstra wrote:
> On Sat, Feb 06, 2021 at 06:18:32PM +0300, Alexey Dobriyan wrote:
> > 32-bit accesses are shorter than 64-bit accesses on x86_64.
> > Nothing uses 64-bitness of struct task_struct::state.
> > 
> > Propagate 32-bitness to other variables and functions.
> 
> You're saving a handful of bytes, why?

Eeh? To save handful of bytes.

> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -655,7 +655,7 @@ struct task_struct {
> >  	struct thread_info		thread_info;
> >  #endif
> >  	/* -1 unrunnable, 0 runnable, >0 stopped: */
> > -	volatile long			state;
> > +	volatile int			state;
> 
> A much larger, but probably more useful cleanup would be to get rid of
> that volatile.

volatile is separate patch. It is independent of ->state type.
I didn't think about this specific volatile at all.
