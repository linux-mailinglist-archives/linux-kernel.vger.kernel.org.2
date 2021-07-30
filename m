Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B373E3DB14F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 04:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236127AbhG3Cqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 22:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbhG3Cqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 22:46:36 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB57C061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 19:46:32 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id pf12-20020a17090b1d8cb0290175c085e7a5so18665760pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 19:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/jHaRzrwnTkxPzzhIATQChLO4eAJDANBxVXBTRmfZAk=;
        b=fZlZQgziymRz1laziR3iwWKBzmjbHYQ8liIi0u84sJ48v2MNxxDmryQtfDukedle+2
         qW/J7DMJRzRyH9gr6v4UtpVrmBkJxToUANPCUPi8DDjMUFYlEyz58wQrLwIvuvcanJ0y
         XJR7g5UdDDskSy46lOChLTjmmNoTQqPzMRXyJCnYqdg59Y83fSn3D9yxEZUgOCKXGC99
         46JjKgn6MlCQV6pbGfMwNr1XcDo9rjJaCcCa342yX4zuqVblyYbtzWfo4HB5p40mP6OE
         8eYCmeUNC+U7elM7zTdOKwt95x+avFctu+m9n8/S8pCa0FS1e1ZXSQLYE1a/Xn0LjpWz
         C/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/jHaRzrwnTkxPzzhIATQChLO4eAJDANBxVXBTRmfZAk=;
        b=Y+55Hav2YTuZqTBq09/n/t5JetiTJTuID72Eqm+deVQ2BciqWwIbAhP3clLOB6XOYD
         /5a/NCtQYO6au32qvkD66EwFCm0Cqb7j+hDGtPbde5aiNnugTGjP/XVoImiy/QcxtNOQ
         fxphf+bS7Dk0a+psORjMzq9QSPkHMexkqMRxfOROTBBvWOppu/pGWJZZCuWUWBilk7r4
         JkyWEdxN6EIvBHjKFqC2oWFeD5/y10E6XfhNlR3HmjQCZ6/Ldpz7t3OdvZEdmArdOMjK
         MYlSxo5/+VSkqhrkoO/DMW1g9xXNEsensFmsgcIxVx1rtJoI7u2C+mYdPBmxfuTvU0He
         9RwA==
X-Gm-Message-State: AOAM5333z/yIYWjm70ZKT9FvGatFI4WBC2ttpa4ipmNeAdziqmBBo/Rz
        w1UMly0fnt3NVZ/dUu9DEqQ0HcL0CZ5OsIOlLdfYNg==
X-Google-Smtp-Source: ABdhPJzn37CezuT/IcB54RiqyDYSXciG7d8blI3sEMoNDk7ag9zYF4JK9IpSWEhADYoftegpT4o7cnrTMDl3DcMlQIw=
X-Received: by 2002:a05:6a00:d6f:b029:398:74ba:4cdc with SMTP id
 n47-20020a056a000d6fb029039874ba4cdcmr614697pfv.49.1627613192067; Thu, 29 Jul
 2021 19:46:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210729092831.38106-1-ligang.bdlg@bytedance.com>
In-Reply-To: <20210729092831.38106-1-ligang.bdlg@bytedance.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 30 Jul 2021 10:45:51 +0800
Message-ID: <CAMZfGtXC0o0bWepzPqPFa9NMYsn5A=Xo=jS02SrYjG4UhhkOZQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm: mmap_lock: remove redundant "\n" in TP_printk
To:     Gang Li <ligang.bdlg@bytedance.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Axel Rasmussen <axelrasmussen@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2021 at 5:28 PM Gang Li <ligang.bdlg@bytedance.com> wrote:
>
> Ftrace core will add "\n" automatically on print. "\n" in TP_printk
> will create blank line, so remove it.
>
> Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>
