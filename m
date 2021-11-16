Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C842452F03
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 11:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234035AbhKPK2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 05:28:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbhKPK2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 05:28:03 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946CFC061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 02:25:06 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id w199so8206350oiw.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 02:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AE7HgW227d3FdwOtIFG+aJYGgutZ6b/rT9QN4eEs5N8=;
        b=a21VVbjqsV0UskRnqP/aeQUudY8zSSM0WQosyfZhe4TWoP0zACcnivi01gpnY5PbHB
         bjZL9Q+amgiVfysAYd9TjQhEi55dQdo7Xtb7N9DhAoD3JYbpsXczU7qGfBjBEfpkIWHb
         mb1smJQwjVZny2dneDVEf47a11S35t1R5S1PwCOh8NRXF56jLGUV0MPnfkxd+hPtMqpi
         6vLwfG9qDOefWgYZQ9o6oFG8T0BmgM9KMnyKeokEiynx5GclKjxbVd2w9K4xzxRaLdZh
         ISQMEGfhBqHU6IiEPEuUw9Kr0VJdmshATmgRv+dUnHDxLx0X93tZ1SKn2mS/9pR1yps9
         RX2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AE7HgW227d3FdwOtIFG+aJYGgutZ6b/rT9QN4eEs5N8=;
        b=SvWmfaIhX4NER/f7VdwUNPUMBP80ba418snsq1O6nteI3cp/yuO3PTtRAcNQ3QJM1M
         swiZvLrHvk7ZfvS6Ia4m1zRGjtfT7Evh+/PyAb0O8VA7POmwD9d9ppwXa/JP1lKuDrDh
         kDSedhZ1J5XMuHTdjtQQJhbgizIRZpThXKoRRxM+Bglpub6psQlHAO87bs7AHiylrOq4
         TLOWOwAOhNghNhEoOYMD40oeAcp3AC48MXez7XqFCGTvqYbzkP6Y1mkUKONehf1B6pTf
         auw6vMxcBkjk4YTq3KkqKQaax3jwl6VL1T33B0OkASsxlutP6IS4ZB7hJ5wn4X9SZsOJ
         cUpA==
X-Gm-Message-State: AOAM5327o03+YyG9Z77dMJgs1g8wEinGjCnW6zCkqbA0iXNi01Dcj13k
        m6Xy3g79t/hV0Qr1kMf23ltBN+DyGBaF+RYaTb5f2g==
X-Google-Smtp-Source: ABdhPJzRReEeMkpRTpi/VLSErRT8E/aEwisQSmzKMnxdrbIw64qFNE6+78ozyXRWo06BavBfOfy8VR34jLbJy9zkN6g=
X-Received: by 2002:a05:6808:1903:: with SMTP id bf3mr40931675oib.7.1637058305811;
 Tue, 16 Nov 2021 02:25:05 -0800 (PST)
MIME-Version: 1.0
References: <0000000000003efce905d0b135e6@google.com> <10635720.r0gBeNIlcX@localhost.localdomain>
In-Reply-To: <10635720.r0gBeNIlcX@localhost.localdomain>
From:   Marco Elver <elver@google.com>
Date:   Tue, 16 Nov 2021 11:24:54 +0100
Message-ID: <CANpmjNMNC=3FiBB0aVVP9LXA9-03ug-sE4CqgJu2-sjdxA14TQ@mail.gmail.com>
Subject: Re: [syzbot] BUG: sleeping function called from invalid context in __might_resched
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2021 at 08:57, Fabio M. De Francesco
<fmdefrancesco@gmail.com> wrote:
[...]
> I think that this is more readable and comprehensible.
>
> Therefore, if I'm not wrong, Marco's "!preemptible()", that is "if (!
> (preempt_count() == 0 && !irqs_disabled())", might be rewritten to an easier
> to understand "if (preempt_count() || irqs_disabled())".
>
> Am I wrong? Let's test it...

It's right, but why not use preemptible()? The definition of
preemptible() might change and then you'd have to fix the code again.

I actually find (preempt_count() || irqs_disabled()) tells me less of
what your intent here is vs. just writing !preemptible().
