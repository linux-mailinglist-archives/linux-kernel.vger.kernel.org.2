Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD41378DC1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 15:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233798AbhEJMwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 08:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343497AbhEJMNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 08:13:45 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353E5C0611AC
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 05:06:15 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id q15so8890773pgg.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 05:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PTR4dBkNFBCJ7q1RjCjO2bl1wxVL8tAhBVKYkSFF/gk=;
        b=O3jcwqfmGMEjWuO+My7tQegTIjW5LTammV9l2g6BXHdojoV+bbCdqpSQF5K8Fp/DLU
         9mRkNI59Tqysx8YyihQJdMURooh8i1jB0p/oihyAllVHu4uolRbHlkysHf3R+/okOG1J
         ey+W603teOFrvkM9YS/Y6H/rC22KNHVK1hQ5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PTR4dBkNFBCJ7q1RjCjO2bl1wxVL8tAhBVKYkSFF/gk=;
        b=h/tuWE30ZeFFMOkWN0R84b6qPal1OTe+KqRj9kQaXIQrlJ5MC6z4RpbVeI7dlYi+UQ
         QK1G6015s2YUTk9V/KifSVUyi7GxfnoGOdyRqsNIplrQ2xf7b0lKRhXfnystLxoMIJdK
         KBN0g196vmuXcxKZhWrDhJGopuGy53agqtvCwxt+VlQpcWqJNZr01Qyc8MMaY5twF/0U
         fj99qI2kYcvvlNhg6bykrUS/1siBNU37QnLwsy64T0nH8wcjTWH61QbPnX4wZ+SPF5HN
         0zokzFuXgc4dRZlEGnTzkEiL8OHuC3CXt2unFHK6DY+h1cngniB3cLda/uh5LbUDBrRR
         /vpQ==
X-Gm-Message-State: AOAM5300QTmZ3q0Bsqf3AeGYanc1wGCbHZN9mfxvwhQurRRGQ0xhLcuH
        fXALhY76zzdQu20oGEzIYUji/w==
X-Google-Smtp-Source: ABdhPJw1nvyccaShmLkqHXdOxQNzynoJPzOIgrVgI+jk8306PThKT5gWkzc1c82RfmlvUN8F1xMAcw==
X-Received: by 2002:a63:aa48:: with SMTP id x8mr1238179pgo.359.1620648375232;
        Mon, 10 May 2021 05:06:15 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:b1d:8aee:8284:2f76])
        by smtp.gmail.com with ESMTPSA id d16sm11392910pgk.34.2021.05.10.05.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 05:06:14 -0700 (PDT)
Date:   Mon, 10 May 2021 21:06:09 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     luojiaxing <luojiaxing@huawei.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        john.ogness@linutronix.de, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, bobo.shaobowang@huawei.com
Subject: Re: [PATCH] printk: stop spining waiter when console resume to flush
 prb
Message-ID: <YJkhsb7h5Ptn+oFO@google.com>
References: <1620288026-5373-1-git-send-email-luojiaxing@huawei.com>
 <YJPxj83F1sBjHHAE@alley>
 <YJP4F1UIt/eRZ96s@google.com>
 <YJVnNQ7RGvx9JKxV@alley>
 <46df3838-e1a6-ee95-b398-bef0896d2b03@huawei.com>
 <YJkB6SedDHe3FlGI@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJkB6SedDHe3FlGI@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/05/10 11:50), Petr Mladek wrote:
[..]
> The only problem is that it becomes the console_owner too late.
> It spends long time by flushing the accumulated messages. But
> they are its own messages after all.
> 
> The only real solution is to pass the console work to a separate
> kthread and do not block any printk() caller.

Yeah, but even that thing is getting complex fairly quickly.
wake_up_process() queues kthread on the same CPU, so if the
printk() (ab)-user is in atomic context then printing kthread
won't get scheduled.
