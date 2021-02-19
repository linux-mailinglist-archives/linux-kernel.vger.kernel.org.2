Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA2731F518
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 07:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbhBSGaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 01:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhBSGaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 01:30:16 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A333C061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 22:29:36 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id g3so2164850qvl.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 22:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8QbOeYSHoSBYRxmS8POCx9jwvefT3QjgtdlEKLIWRhs=;
        b=hOGE2ImC/+HsdcBOo8ZcsyMxmHF+KAh4wWz2br/79rUxvlQrPDr85SdB4FUleX+rE2
         BcZBtaCnpsTeI2kL/HGdzfJDiauWi+l2v7U0HcgqokBkcFyH5csNxpBaNIUqoVQX5TA4
         TgasZtrqe//wW7O2Jp0E8D9AdpACA6lBwEttDaik9XBfgmCCacKBSuCALc/Yq4ISoHNt
         9p1M2A9fHTprp3SKBOuQMw0Cr0IPkU8jgQRoYXYxhdZmL6BqF4loV4xOYs/6szIvFz2c
         yeeObXtJBzpWtevCDK6H4zhrgiI8TocPW6VSahNfOWDZ7DQoxiH62MWQ0KCk/YTbaPwy
         ew4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8QbOeYSHoSBYRxmS8POCx9jwvefT3QjgtdlEKLIWRhs=;
        b=YpPjQq07NTHkvkoI73oUI/2LvTKhqNZTp0c9aRCFt+QeEl714cUkzeUmtEn6Y4Zik1
         sz9DmH+DgGwGpa21V+WQPf5a8n868t8RxbDUKB9cZ7Wm2M27S84r/ura6ysgIIll2CzJ
         Df50vOi4xTTspzQrNDL0ppitg7Lc0OI+LeuIxmhFjH8ottI+SHrrrkigKrNiSe+CkqKo
         c3EdbX5o6ivoZu5a1q1yzx3CwFrSROxxzw0KY42zd8s2XJSJoZlqs2VaaOT2BbwKgxR4
         PiSmfowkaPyPU1ih7HKfJtJCmWMkM/z1d3QbmlfEmDBsDa8ve+aLvg1Vkh5mrIIHoqkA
         bE6g==
X-Gm-Message-State: AOAM532V9iW1P+8Dh0k+eqecSSYK0sFE9MQ4yN7/+tObMbNiGOMN4F+h
        HzI53qvzmKqui7unztBes/1CgzFeCe2j+xbYYQQcGA==
X-Google-Smtp-Source: ABdhPJwOntCz7gq+5LgnwvQI04RShCe63RIEhKJRAFPqvLgZE7jBdojjaXo9zKTXiRNLGleD2sNST3aT750CIxCVYvk=
X-Received: by 2002:a0c:e80d:: with SMTP id y13mr7811702qvn.2.1613716175541;
 Thu, 18 Feb 2021 22:29:35 -0800 (PST)
MIME-Version: 1.0
References: <20210214000611.2169820-1-zzyiwei@android.com> <20210216091128.GA3973504@infradead.org>
 <CAKB3++aXuCS3WRf1mfrM2oZ0KiJ4xP4ib-ZbJXr8cXVEkU-sXw@mail.gmail.com> <YCz6nz4i136z1+H1@alley>
In-Reply-To: <YCz6nz4i136z1+H1@alley>
From:   =?UTF-8?B?WWl3ZWkgWmhhbmfigI4=?= <zzyiwei@android.com>
Date:   Thu, 18 Feb 2021 22:29:24 -0800
Message-ID: <CAKB3++b+n=VWuXZqZqyZJvAf1+Wqogvi07L21GqdRwThSRdf2w@mail.gmail.com>
Subject: Re: [PATCH] kthread: add kthread_mod_pending_delayed_work api
To:     Petr Mladek <pmladek@suse.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jens Axboe <axboe@kernel.dk>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Ilias Stamatis <stamatis.iliass@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Liang Chen <cl@rock-chips.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 2. User triggered clean up races with the clean up triggered by
>   timeout. You try to handle this scenario by this patch.
Yes, exactly.

> 3. User does clean up after the clean up has already been done
>   by the timeout.
This case is well handled. So only (2) has a potential race.

Let me clarify a bit more here. The "clean up" is not the clean up
when a process tears down, but it's actually a "post-work" to cancel
out an early "pre-work". The "pre-work" enqueues the delayed "post
work" for the timeout purpose. That pair of operations can repeatedly
happen.

The racing is currently worked around by refcounting the delayed_work
container, and the later "post-work" will take care of the work
deallocation.

I mainly want to reach out to see if we agree that this is a valid API
to be supported by kthread. Or we extend the existing
kthread_mod_delayed_work api to take another option to not re-queue if
the cancel failed.

Best,
Yiwei
