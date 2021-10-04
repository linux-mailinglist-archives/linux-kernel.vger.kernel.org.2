Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F8D421697
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 20:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238414AbhJDShQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 14:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhJDShP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 14:37:15 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B574BC061749
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 11:35:25 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id x27so75629607lfu.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 11:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q3rtjAMF0s155PLuGLifQ498nM8uqHQjjd2W39f9bKM=;
        b=dNO+T06bp6n0e4wCqt2yTEMB3F80fM9Vgzh5jpZIO6mwe3DQMRXOaOdLXC2M1lh9Dq
         mE8zj3N4kaJpFMlMmObQxrMYzYFijF3w/RodiCCzivMxJEkMGTHT9reE2Z2XmAQUHNUB
         qBSFXy+3wiqJxSgNsmPxHifuceiJzF4H8lZLVfvrvY1Xk8lF8SdxcV9M8EtOmN0tT0c6
         LSwA2ZHu9+qtrj9c/MDnNYT3a/aS6l3z3CvSBMjGEDRnzK9LjpdHqL57qmotS9zmJekZ
         zyiWkTFDoth+KvmXIYzXgu+DnWmUElPhq7/W47WaMfHA7Sj87eZwJEUkCSy+IPjbnlDL
         ud5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q3rtjAMF0s155PLuGLifQ498nM8uqHQjjd2W39f9bKM=;
        b=Wk77DFnRsvtHZzgk2Te3VNUtYrPH/peNNru7y3p4McWvjaqDC8waBucNqgnM4udVXE
         04F8DXk1YFjS/p8aK5syCsAPh4djOp63JTMHJma3z1RFsOrysPLrbZBkJaHSMu6/fAv+
         7HIYBAqkgUYWHZYH9fSGqG9NNlizUvTJ5I/1y0aDhjWy5FpEJfzlxNgJZtY1gteeDeEb
         BB9wdCrNTrL4nVD2gLaY9xM1jPiwCm47qBwPDgvo97k8Y8IM4g44beRjsP2Y/KBxj9lG
         EBMBPmWpjRDHWNrJSl4VU96wkPKDs9w6J5wDMp2lksjGzIAA6d6YsRWAM/bRLxkKBx61
         w5Eg==
X-Gm-Message-State: AOAM532QX+KcmGA4aoyZV++VWMx+8UtU/R0daBfjLANMy/tUOS89y/6d
        A/+uS87d8123ETiZj1MkSTUY+Edj4RZG4wxB6icevQ7CxLc4kA==
X-Google-Smtp-Source: ABdhPJzQoBkAHyXUeQ3KnJgIm3rCI51rSjZj0N5KHvvzay3sVbDvaiAdddgWewCFSNbRXzhME17MIseGyg8Li5GWMNk=
X-Received: by 2002:ac2:4157:: with SMTP id c23mr15601352lfi.184.1633372523869;
 Mon, 04 Oct 2021 11:35:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210929235936.2859271-1-shakeelb@google.com> <YVszNI97NAAYpHpm@slm.duckdns.org>
 <CALvZod5OKz=7pFpxCt1CONPyJO4wR5t+PH0nzdbFBT1SYpjrsg@mail.gmail.com>
 <YVs9eJnNJYwF/3f3@slm.duckdns.org> <CALvZod47r=9j_MhZz9ngWv_JE4oqF1CrXTOQ2GpSSNFftZAsVA@mail.gmail.com>
 <YVtGHoboSix3rexr@slm.duckdns.org>
In-Reply-To: <YVtGHoboSix3rexr@slm.duckdns.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 4 Oct 2021 11:35:12 -0700
Message-ID: <CALvZod6fwur--Q6Kh6GSPRR_16DQdrNDyuZgYjgncDpPUENWVg@mail.gmail.com>
Subject: Re: [PATCH] cgroup: rstat: optimize flush through speculative test
To:     Tejun Heo <tj@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 4, 2021 at 11:21 AM Tejun Heo <tj@kernel.org> wrote:
>
>
[...]
> What do you think about that approach? While the proposed patch looks fine,
> it kinda bothers me that it's a very partial optimization - ie. if flush
> frequency is high enough for this to matter, that for_each_possible_cpu()
> scanning loop really isn't appropriate.
>

Makes sense. I will take a stab at that.
