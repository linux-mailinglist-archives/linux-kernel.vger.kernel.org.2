Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3567438B4DA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 19:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbhETRC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 13:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbhETRCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 13:02:50 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D562AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 10:01:27 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id v18so8957100qvx.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 10:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9yFbYd6lD4ZPnFENsIfWwwwiFEi/ohkzO4vDy45CCOk=;
        b=NvLOFDgAzJXOyMHGHs+Da/MW4SxPo21FtnGNcFJpZ4sWg9ECLB/1Wb7ZJw8WPCteMj
         uZUSu4T42kzXUm/lRGQLz7okuc4MyZ2K0ZMIDNPUAuBb9siZQ8wPY1UF0nhWExK57lLI
         WoS8iwOEj3W9riAYt9glGUFFwlrqAyyfJ+W5VyCAPgLMwcW1Ghr1e4qxZNmw4IYaAFhZ
         Cqaa4xti5ER2szLt98vCYN5+kkLr9uK5PTqxSFNr2kp/0mQpXpXCHkI5vuQjE4YyWQ83
         KtmSYTSiKTEWusXlKF4SQwM2VmT2Jb+fGMRB9v662QxYMqQ+XqefDX0JD9R2Fo1cCeeW
         xUxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=9yFbYd6lD4ZPnFENsIfWwwwiFEi/ohkzO4vDy45CCOk=;
        b=Ij5/W29M/rbbYFgqaVWqVhsp0IZOFkPSN2OzPAv/M8EzlcHOWYWSxLrTDJsEe4xv7Q
         idHJbR44vZut4jLLOJMaCGlfs8rH78zpQWH7+pI324kd5A3zO0Da+Z0cqsJF4gZWYqt0
         m4uVMRUKKrkvrFiMwTkWKX1vjXT4dsRaWF67xuW6ZYibX8XH17bkfKvusniQ5OWVAws/
         W2/ws7qASP9EgWXzH7ohrL7vp8D9JO6m4jGfjH8oeyC+R9/uvhTnMDvwrb78oFjoP56I
         ygQJxIjMA3jQ/escHtTnZVyjbLvxTgN9PYL6waBGslf9p45gQDd9H1htXWS8Sd5kRDcU
         dN4g==
X-Gm-Message-State: AOAM531GvFLPXwyTlui8gqHektKgnI9JNj54DXEZ7hPCk9gfFZxAUY8k
        WEg6UnqUXoOeoJhmaUtiEcQ=
X-Google-Smtp-Source: ABdhPJzUQpT6oTjzq5Ewb1cYUWWwXGwrH718LjuIH09OTj+/dvM+2UMrI7qgrf8NCEyyz5qI5/gsfA==
X-Received: by 2002:a05:6214:8e:: with SMTP id n14mr6912432qvr.29.1621530086946;
        Thu, 20 May 2021 10:01:26 -0700 (PDT)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [199.96.183.179])
        by smtp.gmail.com with ESMTPSA id b4sm2378366qti.43.2021.05.20.10.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 10:01:26 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 20 May 2021 13:01:25 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Jason Andryuk <jandryuk@gmail.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: Calling queue_work() multiple times with the same work_struct
Message-ID: <YKaV5ej3WrUJQa7/@slm.duckdns.org>
References: <CAKf6xptjmd9BMuiKpRgj1YyyR97gGXKgYgj-4CKaTvBk4+FeoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKf6xptjmd9BMuiKpRgj1YyyR97gGXKgYgj-4CKaTvBk4+FeoA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Jason.

On Thu, May 20, 2021 at 08:39:56AM -0400, Jason Andryuk wrote:
> 1 & 2 look supported from workqueue.h.  Is the 3rd case true and
> guaranteed?  Is it okay to re-use the same work_struct in that case

Yes.

> while it's being executed?  A work_struct function can re-queue

Yes.

> itself, so I hope #3 is supported.

Yes.

> DECLARE_WORK(argo_work, argo_work_fn);
> static struct workqueue_struct *argo_wq = alloc_workqueue("argo_wq",
>                     WQ_UNBOUND | WQ_HIGHPRI | WQ_CPU_INTENSIVE | WQ_SYSFS, 1);

I don't know what the device is but does it need both HIGHPRI and
CPU_INTENSIVE?

> static void argo_work_fn(struct work_struct *work)
> {
>     argo_interrupt_rx();  /* iterates multiple "rings" */
>     argo_notify();
> }
> 
> static irqreturn_t argo_interrupt(int irq, void *dev_id)
> {
>     queue_work(argo_wq, &argo_work);
> 
>     return IRQ_HANDLED;
> }

Yeah, the above will guarantee that the work function would run at least
once since the last invocation of argo_interrupt().

Thanks.

-- 
tejun
