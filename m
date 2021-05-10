Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E74378D83
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 15:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348814AbhEJMr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 08:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238567AbhEJLSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 07:18:06 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B779BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 04:17:01 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id t21so8974388plo.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 04:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xm+XYqfWRu4ZHIHc10/OIsTGE2salXwYppbXnujxvCI=;
        b=VlHYn2TWlqhF19uo0fToa8AxcsNyfkg2YXKiRhUCktMzb6qLgu6IRoWJBtTdR2txYm
         b6CkGAvm/r8JbAcF2ZGjO+zbfzJZv3Rb4kjtenP/wLAk7Nllb1aG28cylBfTFUjl8qIq
         M0+8SoNHHODbp3iFDnxWRctq3PqaMb8dYXF3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xm+XYqfWRu4ZHIHc10/OIsTGE2salXwYppbXnujxvCI=;
        b=HsZIh5u8Q6uuPw6jZkqfqV95CdYD+QsEsMwXOCL4PiNyYgMZmptKxPqz+oP1842rqo
         8wfv9+LkZFTbiOLevOZcvc2cKh/4NsFV3Mt7eCRHRlJmZexqBQZTllaSHk6DosSKJXR0
         ed5sa7nsahVVjdkzPRivdTp4P+NY8BbbFhcEWCPZ75yRohckU16BKkx5UJDFzgKhhjXo
         27iHjVbWLYfUA9bUAJRY+zL5+ZmV2t0RtYUthgmUwjvFXioR9uUdqJ9FHpFZbSpOazX9
         wo75EEpP+buiHq2o8GiWL6WsGo8POwc26v6x7eKKCuczrIKPBd9XDPpmV5zqW2MRAnDf
         XMGQ==
X-Gm-Message-State: AOAM530AjmGEAXO+fgJx5qSiPG+Xm1uSbN12E8GQP9owLbOV8DKibKEw
        QSGWDbXRGdKuA5oAvyMsy3xtGQ==
X-Google-Smtp-Source: ABdhPJw16paoQ7z1gvdL6lnJZo9bKETOe2uY73tywQXG+r7aqgxsmjxR0XhBFWbTRmQlr5SpUC1bwQ==
X-Received: by 2002:a17:902:d2c3:b029:ed:764e:d1f4 with SMTP id n3-20020a170902d2c3b02900ed764ed1f4mr24033202plc.84.1620645421193;
        Mon, 10 May 2021 04:17:01 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:b1d:8aee:8284:2f76])
        by smtp.gmail.com with ESMTPSA id f1sm18302018pjt.50.2021.05.10.04.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 04:17:00 -0700 (PDT)
Date:   Mon, 10 May 2021 20:16:55 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Luo Jiaxing <luojiaxing@huawei.com>,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        bobo.shaobowang@huawei.com
Subject: Re: [PATCH] printk: stop spining waiter when console resume to flush
 prb
Message-ID: <YJkWJ7OCzFM7m4OU@google.com>
References: <1620288026-5373-1-git-send-email-luojiaxing@huawei.com>
 <YJPxj83F1sBjHHAE@alley>
 <YJP4F1UIt/eRZ96s@google.com>
 <YJP5MnkJ8pJevXM6@google.com>
 <YJVsgPc66lhaAUN0@alley>
 <YJjuRV57eO3Pp/bp@google.com>
 <YJkIK9cyHr46UAFP@alley>
 <871raeop5q.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871raeop5q.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/05/10 12:32), John Ogness wrote:
> On 2021-05-10, Petr Mladek <pmladek@suse.com> wrote:
> > The current plan is to move console work to kthreads (separate
> > preemptive context). Using IRQ is a complete opposite way.
> >
> > There is always the fight between getting the messages out as soon
> > as possible and the risk of breaking the system (softlockups,
> > deadlocks).
> >
> > The kthread approach reduces the risk of system breakage to a bare
> > minimum. The price is that some messages might never reach console.
> > There is finally a consensus to give it a try. If it fails, we might
> > start looking for alternatives again.
> 
> +1
> 
> I think it is clear that any such fixups will disappear once
> atomic-consoles and console printing kthreads arrive.

Yes, hopefully.

> That doesn't mean we should ignore the fixups.

Well, that also doesn't mean that we should not discuss the fixups.
And there seems to be some sort of taboo on discussions.

> We just need to decide if it is a real problem that needs our
> immediate attention, thus warranting a fixup in the current implementation.

That's a good point.

> I can see the suspend/resume issue might be a real problem. If this
> should be addressed now, I would support Petr's patch, forcing the
> backlog to be printed in the preemptible resuming context. But let's
> just keep it a suspend/resume fixup. I do not think we want to start
> playing with how console_unlock() behaves.

And yes again. If console suspend/resume is a problem then something
superficially about suspend/resume can be done. System wide API that
makes printk behave either like "old" or like "new" one depending on
some flags is slightly opposite to "keep printk simple" intention. IMHO
