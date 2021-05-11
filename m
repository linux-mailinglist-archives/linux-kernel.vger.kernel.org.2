Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3EDC37B17B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 00:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbhEKWQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 18:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbhEKWQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 18:16:42 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA67FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 15:15:35 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id h1so6864219uar.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 15:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pernos.co; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9APnGG9XDlJhvDOfUIsq0WVU3gMNJ2g3qgJEUxydNUg=;
        b=I3q6I778Ko853XpTutbwmhvj2DKUu5ahO1ZPdz/ndvEFPNrXNJXKgpsDjpzdSwS3nR
         ruVb+G6BDMDvMnC5REh4QVHaVDV/X2cEvZ/p7Q+wSh6jB48ZKgm+dsaDTDBbDvo219+F
         QDVjRFr2vafsSx2o7fVZH0F4kYuSSVnK3e6uI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9APnGG9XDlJhvDOfUIsq0WVU3gMNJ2g3qgJEUxydNUg=;
        b=VFbo4fOfEg/u+lwMi7KzZNWRb+fFaSE0kss1wGM9hbDyPmfigS06Dug1rSWmlxRwjV
         4zp7Fj3LGfJRlJCSrGJMryN+NIrgROx+J1BQl3fjgCtuE5kysE5ptE4EB6UPbY9q9w5W
         HTLizFdyLk/tBqvUQiOBUH31D3mK+lb810sZoz/RypAiHLsxSsqFJkqP8Y+dBcEkV4FC
         KzZBYjDxewdyUp9rsGcW6d5QXYSg1DN+pUpF4g4nqtieE8S10Xj8QUZDWRqGh3AeQyeS
         d9SvhA0L9ylxL3du8jx7ODKSGE093U3yk+j+RVjuMxU9xcDyKxkjnC+PkYFcEUhL5dtn
         hO0w==
X-Gm-Message-State: AOAM531ofzP+YItndmRa/YcNFtASaSGxVPVdV2V+yXbZEpoxHbF6vTTS
        8WZj1+9q1VMG6Tv6bhx5m2uwUDEShWRZIAvu
X-Google-Smtp-Source: ABdhPJxtrehLzYqnQH4E8kpuLVYpP1Qg28iEllVh8gOiXEKMBtvwjtN0uljPQGBkHjwz+xJeR1tz5A==
X-Received: by 2002:ab0:2a83:: with SMTP id h3mr5526425uar.18.1620771334569;
        Tue, 11 May 2021 15:15:34 -0700 (PDT)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com. [209.85.221.178])
        by smtp.gmail.com with ESMTPSA id u140sm2410295vku.46.2021.05.11.15.15.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 15:15:33 -0700 (PDT)
Received: by mail-vk1-f178.google.com with SMTP id b21so4375733vkb.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 15:15:32 -0700 (PDT)
X-Received: by 2002:a1f:fe0b:: with SMTP id l11mr5646538vki.24.1620771332590;
 Tue, 11 May 2021 15:15:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAOp6jLZ8GR8DKCZLQJKPS7oeP1CX4L3ijBFDBePGX4q6z-DQhg@mail.gmail.com>
 <CAJHvVci_q5rxuo-N+EH_CNxX_M3oxWcLyitvbdySa_PMH3e_Dg@mail.gmail.com>
In-Reply-To: <CAJHvVci_q5rxuo-N+EH_CNxX_M3oxWcLyitvbdySa_PMH3e_Dg@mail.gmail.com>
From:   "Robert O'Callahan" <roc@pernos.co>
Date:   Wed, 12 May 2021 10:15:21 +1200
X-Gmail-Original-Message-ID: <CAOp6jLaSLC4O0ZayFz1BiO6UqC7pK_umFUb29bgXDu6U5dUQgg@mail.gmail.com>
Message-ID: <CAOp6jLaSLC4O0ZayFz1BiO6UqC7pK_umFUb29bgXDu6U5dUQgg@mail.gmail.com>
Subject: Re: Userspace notifications for observing userfaultfd faults
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Peter Xu <peterx@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, Kyle Huey <khuey@pernos.co>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 6:12 AM Axel Rasmussen <axelrasmussen@google.com> wrote:
> Is some combination of bpf and kprobes a possible solution? There are
> some seemingly relevant examples here:
> https://github.com/iovisor/bpftrace/blob/master/docs/tutorial_one_liners.md
>
> I haven't tried it, but it seems like attaching to handle_userfault()
> would give similar information to perf_count_sw_page_faults, but for
> userfaults.

That would probably work in some cases, but as Kyle said that requires
privileges and currently rr can run unprivileged (if you set
perf_event_paranoid to 1 or less) and usually does. Also, AFAIK,
kprobing handle_userfault would not be a stable ABI.

Rob
