Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A81377E26
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 10:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbhEJI17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 04:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbhEJI14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 04:27:56 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71586C061573
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 01:26:51 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id b14-20020a17090a6e0eb0290155c7f6a356so7867008pjk.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 01:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/rg41zCxK5ufgrvrfH/DIqgz2oAqQCyoIrvoteBUQDo=;
        b=Tw+gGshZVURsIad/I+sle6Nc1D0+esrDiUFwI/SLLjbgaZ2TP2YHChmuOXLY2LffTP
         qbXbS06GbTCfaiUXj+6BF3+MX42nI4tKBZz+yCUZu+EjkxJpU/iRif1jsj+vkkzYfc6l
         lyuoMn9eZH9dnUo0DRatDgh6U7WL0+cVKXnrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/rg41zCxK5ufgrvrfH/DIqgz2oAqQCyoIrvoteBUQDo=;
        b=YcJmFLbsIm0KuLINiZFmLBBvTTeEBFzf8pWmaWl6EYqACVcUr0rf8pk2xi7XHYSvM/
         JZMLRRf/3d5W4FnPuM9LHsZ7XnrvTSrwbioE3CweA6UH2xY53kMtEJrDPGG1gX8e7LAj
         93j7jZtZTGDgCB9aiKqv4fLqNlinPBiTuNOzewsKZq4mlM6CufZ5uN2wBedRIv27TNGn
         CYmneRgUvPtkI08DtEKiVCKPZ7GgYXWSzN+Hr+mi/5NYdwTH79YzUE57oI+WjLy/pmmf
         U4mg7v169Q0BNDbHy81zWpcfCec8lwDfaZINmLTJ9ZqTfqG/jpd+a47yBOGEY1KMWZSs
         mT6g==
X-Gm-Message-State: AOAM531OOMRJ3HXT4Kd9dV0Jt8ENwN2JRVHKgjzSFnWMuuOSro0nwWpY
        LJviby61iVp/uflPGEu0+pWeBw==
X-Google-Smtp-Source: ABdhPJwgHbJadzYFgxn0SJq0BUKEMphCRYHQn+iFoxOA1DgjiNSMzxy+QEScnyqo9Rq0e9/LGI8oWA==
X-Received: by 2002:a17:903:4091:b029:ec:fbd2:3192 with SMTP id z17-20020a1709034091b02900ecfbd23192mr23163672plc.21.1620635210962;
        Mon, 10 May 2021 01:26:50 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:f055:559a:ad7f:e975])
        by smtp.gmail.com with ESMTPSA id a7sm19704904pjm.0.2021.05.10.01.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 01:26:50 -0700 (PDT)
Date:   Mon, 10 May 2021 17:26:45 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Luo Jiaxing <luojiaxing@huawei.com>,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        john.ogness@linutronix.de, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, bobo.shaobowang@huawei.com
Subject: Re: [PATCH] printk: stop spining waiter when console resume to flush
 prb
Message-ID: <YJjuRV57eO3Pp/bp@google.com>
References: <1620288026-5373-1-git-send-email-luojiaxing@huawei.com>
 <YJPxj83F1sBjHHAE@alley>
 <YJP4F1UIt/eRZ96s@google.com>
 <YJP5MnkJ8pJevXM6@google.com>
 <YJVsgPc66lhaAUN0@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJVsgPc66lhaAUN0@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/05/07 18:36), Petr Mladek wrote:
> > console_unlock()
> > {
> > 	...
> > 
> > 	if (printed_messages > limit && !console_lock_spinning_disable_and_check()) {
> > 		printk_safe_exit_irqrestore(flags);
> > 
> > 		console_locked = 0;
> > 		up_console_sem();
> > 
> > 		defer_console_output();
> > 		return;
> > 	}
> > 
> > 	...
> > }
> 
> No, please, no.
> 

Well, the alternative patch set just gives everyone an API that selectively
downgrades printk() to pre-console_sem_owner age: when console_unlock()
would never handover the printing duty. It'll take no time until this
function will pop up somewhere where we don't want it to be used.

E.g.

	rcu_read_lock();
	...
	console_unlock_preemptible();
	...
	rcu_read_unlock();

lockdep_assert_preemption_enabled() is not entirely reliable - it
depends on __lockdep_enabled, provided that system in question has
CONFIG_PROVE_LOCKING set.

> Not to say, that defer_console_output() would trigger IRQ on the same
> CPU again and again.

You mean only on archs that have arch_irq_work_raise()?

It queues the work IF we have pending messages AND there are NO active
console_sem waiters spinning on consolse_sem waiting for us to handover
the printing duty. And IRQ shall write to consoles only N messages out
of possibly M pending messages (M > N). N, obviously, should be small,
e.g. 42 lines: if after 42 printed lines we didn't handover printing
to another context then - queue another IRQ work and iret. But it keeps
the console_owner mechanism enabled.
