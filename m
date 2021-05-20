Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB2F38B53F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 19:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234466AbhETRcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 13:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbhETRch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 13:32:37 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E505C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 10:31:14 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id c15so20746806ljr.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 10:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IWyd5vQ0tdTZhv+oPIYSkEnp7t4QKuqrE25ohxsctR8=;
        b=Ic/e82cajUiahyEuvPpiuLgc1inY2ttwkJiuCriPNyfS7F1zg8M5p3SHsWKqmo7+hI
         Bh5GnJnts19VUixtKCeEeTGBFWzRrZ+QazY7jcIe2HgQ71mGUTvr5Gx03S4BWaAZAszH
         Nx8QfU6s15Bv2B16k5Gp/+OZghbeLRkGtG74lLVjVE8bTpTfUhvhWlhZbjqLGFHbU+Sg
         oQpoBqntbRmCELVga+htuuHac9aAoeEd/l7A2AjFMtjkw5kon/R+xV5GxBM+hgf3c0gX
         iOS75GMWQhVN9TH+YVC25jyrQwbStPzPgRyWhsuIfwjR5LZxAISG6IF/qbnRW5XOBlcO
         mvSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IWyd5vQ0tdTZhv+oPIYSkEnp7t4QKuqrE25ohxsctR8=;
        b=AI4BnKIahF3bTduLmIlz0WmwqIc/jpVTC3Rq6zSL4nZMnAdmdmckHzpGrLE/s67H3y
         7oOYxbqAhk1yGmPW4BsXEdRq6H8SxW/Mb6igRMc40+sUjNHVYoDmF88UHC1PgMH5YPNq
         /uAAL/7+pFu1Gf2icKbxlLoxRaQqhsa5grHEefBLX1j8unBtB6jPZ/CTinIm293ZP+ux
         yHxLAM9sKxGemz9DAipxwDpEwadF98LKCYKjuHijnwrtfWQ5yGIt6gHu63ZH86KbnSod
         lNqhYOMAU6yqqxWCqfNFfvURNeORCb62Q8h9xXmqKZDl4Q7X64AhBH40RiJyQvpzwQyQ
         Bv2w==
X-Gm-Message-State: AOAM533wKp7juJGwXMmrZt1Gkw9yDNdk6bqQp4ZLrHd/5nSXpWMUHhSm
        B5tJyCXNS3RZGhcWP8WBPWDNjJyQYZaCOKmcimg=
X-Google-Smtp-Source: ABdhPJyaYBqT/6DNE5iA0xZlel1YEWkCY46LIKC5808FFImJi1+4D/Jc9UR2WyX1N+m3M8yvcTQfO0aA/7TxS5ipIvw=
X-Received: by 2002:a2e:bc23:: with SMTP id b35mr3855706ljf.378.1621531872910;
 Thu, 20 May 2021 10:31:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAKf6xptjmd9BMuiKpRgj1YyyR97gGXKgYgj-4CKaTvBk4+FeoA@mail.gmail.com>
 <YKaV5ej3WrUJQa7/@slm.duckdns.org>
In-Reply-To: <YKaV5ej3WrUJQa7/@slm.duckdns.org>
From:   Jason Andryuk <jandryuk@gmail.com>
Date:   Thu, 20 May 2021 13:31:01 -0400
Message-ID: <CAKf6xpsv-v0kMXnuOVmkjOXYV+R=HPnKWL9cufZaNEa6+3jvMw@mail.gmail.com>
Subject: Re: Calling queue_work() multiple times with the same work_struct
To:     Tejun Heo <tj@kernel.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Tejun.

On Thu, May 20, 2021 at 1:01 PM Tejun Heo <tj@kernel.org> wrote:
>
> Hello, Jason.
>
> On Thu, May 20, 2021 at 08:39:56AM -0400, Jason Andryuk wrote:
> > 1 & 2 look supported from workqueue.h.  Is the 3rd case true and
> > guaranteed?  Is it okay to re-use the same work_struct in that case
>
> Yes.
>
> > while it's being executed?  A work_struct function can re-queue
>
> Yes.
>
> > itself, so I hope #3 is supported.
>
> Yes.
>
> > DECLARE_WORK(argo_work, argo_work_fn);
> > static struct workqueue_struct *argo_wq = alloc_workqueue("argo_wq",
> >                     WQ_UNBOUND | WQ_HIGHPRI | WQ_CPU_INTENSIVE | WQ_SYSFS, 1);
>
> I don't know what the device is but does it need both HIGHPRI and
> CPU_INTENSIVE?

argo is a Xen inter-vm communication mechanism, so networking-ish.  I
wanted HIGHPRI to ensure it is run promptly.  I wasn't sure about
CPU_INTENSIVE, but high data rates could potentially copy a fair
amount of data.  HIGHPRI alone may be sufficient.

> > static void argo_work_fn(struct work_struct *work)
> > {
> >     argo_interrupt_rx();  /* iterates multiple "rings" */
> >     argo_notify();
> > }
> >
> > static irqreturn_t argo_interrupt(int irq, void *dev_id)
> > {
> >     queue_work(argo_wq, &argo_work);
> >
> >     return IRQ_HANDLED;
> > }
>
> Yeah, the above will guarantee that the work function would run at least
> once since the last invocation of argo_interrupt().

Awesome.  Thank you, Tejun.

Regards,
Jason
