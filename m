Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04A9343AC5C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 08:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbhJZGnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 02:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233421AbhJZGnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 02:43:18 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5B8C061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 23:40:54 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id s1so9272896edd.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 23:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4+4312Y8RYCvG+aqk+Oz2BFx93b9JFXqnmkPMxsmX28=;
        b=eW1aqfetNYAw3aGppYWzB2qv57l+LyJPhRtULwIBOmb60vnQ8YmppeblyOV6P/WxdO
         ug6c76OrpySj6t5qxW3S9KyrKJDuedw4t5kuaIaxtHgPJHli2Fln23mNODSXhbAZA14J
         i9g0UkE4406jQN9K4aUuadVuUUAeJRTN4CMLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4+4312Y8RYCvG+aqk+Oz2BFx93b9JFXqnmkPMxsmX28=;
        b=34jSnpqrhx5vaZQ7KZF0opL5LqX+OGuXlxnkrAQnRnBVZbTYvBUTTkPkST/g9ts3JF
         JpH8Rsi4TP4ElzWWg3Y95KjEznOb8TWNfRtrCXXdoSHZST4p0+/+1Xj4KOh2a0RlJJWY
         dgAFw1Vv0oD5AVzlq5KUVrrLkcHki7YYjXQQu+/T5aBDnx95LwUn167ST5ss9eSmGCnM
         DjuOekxtI6vaHkoA7CTZoDBQKjr73WIqhVPb8Yv8XChhKZzMw4ZidO403guRibBP55sf
         4xwmPNj2Bi08HxD+JqDf1E/cP6fYj7m8p3aDimZe/3g/piS8SqwtAzbLH0d/vGFjMci1
         g3HQ==
X-Gm-Message-State: AOAM530j/DO66cUBMs9AJdvJFtj44muuTWOjkmfr761qF/4LxWxfSeG6
        KmJ49rEQZ5V6KMCp7/ndqjhPlwKNQ0TOsByxiZJh/Q==
X-Google-Smtp-Source: ABdhPJy8gAmFFt/J34kfpujCbyizohWn0M5MYZT7yusL/QRNY9JkQcR19jOM+ramSraj1SMwLdVx/mvuHdJgdyeKFQs=
X-Received: by 2002:a17:906:7c58:: with SMTP id g24mr28094153ejp.351.1635230450982;
 Mon, 25 Oct 2021 23:40:50 -0700 (PDT)
MIME-Version: 1.0
References: <CA+9S74g77kMvkB7X44bipuN0WfMpHJO6Dgors4HhvLPiDhq5NA@mail.gmail.com>
 <20211004192635.nk7opq7bs7yosjtp@offworld>
In-Reply-To: <20211004192635.nk7opq7bs7yosjtp@offworld>
From:   Igor Raits <igor@gooddata.com>
Date:   Tue, 26 Oct 2021 08:40:40 +0200
Message-ID: <CA+9S74gx3uTMvTXA+W_p4fEKtiSp9z=oO0YxDtaVwY=p_v5Y1Q@mail.gmail.com>
Subject: Re: rq->tmp_alone_branch != &rq->leaf_cfs_rq_list + RIP: 0010:enqueue_task_fair+0x268/0x6a0
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Davidlohr,

Given that we did not see this crash anymore after upgrading, there is
a big chance that it fixed it.

Thanks for pointing it out btw!

On Mon, Oct 4, 2021 at 9:26 PM Davidlohr Bueso <dave@stgolabs.net> wrote:
>
> On Mon, 20 Sep 2021, Igor Raits wrote:
>
> >------------[ cut here ]------------
> >rq->tmp_alone_branch != &rq->leaf_cfs_rq_list
> >WARNING: CPU: 5 PID: 1832 at kernel/sched/fair.c:379
> >enqueue_task_fair+0x268/0x6a0
>
> Does this help?
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2630cde26711dab0d0b56a8be1616475be646d13
>
> Thanks,
> Davidlohr
