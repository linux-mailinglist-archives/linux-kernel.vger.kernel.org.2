Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0AF9379B9C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 02:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbhEKAjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 20:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbhEKAjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 20:39:11 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FC5C061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 17:38:05 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id u188so1863685vsu.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 17:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pernos.co; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=09JM7Ox7xZYPPFB9C47KgCoGB3BmJhJc+28H+wSrtLo=;
        b=E2Tks3il867yf5r40wJV4wl1jydz/BQ/jSXsJlEj+A3xBfxLoGfye8yNOpDoRQqY4j
         ljgkaXABcgrtDZ/OUzvG3H99tTrgsm2ZgpFgHBaNMCPlHgSLxQVf2/4B/MQvyf2CNiNa
         EyNZQnt2DDbL/XNCmvSmgCKcatkvqH4SYWJb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=09JM7Ox7xZYPPFB9C47KgCoGB3BmJhJc+28H+wSrtLo=;
        b=kOOl6HFE5Y1EOPHoNzc1/8wFv1adDXwiIzPFYW03Go6+b8P8T1H0UoNONkjCy7p2Pi
         Y8MAFo52TxQh9RrH7Y6a1LXo8Jorfcl4a/DgqnyU9wQR2LhNMeSRvyij1M9TOqqc5pc4
         afLZex59yzP+9BNSLJoRP2YLtOfZAF42hJ+IMvBuULX2LcTYi6WA1jJS2ivF5JJsN64r
         R/pPa5ZblXq4000L6PA5FEBXDX/MKJ0Jo+sc2p/ix8nvrILAsMJ7PNhBJUfkTqyN2brB
         Us95eWVeMUawh7d69maGvI4/pl9zvowj1FY/V8pSWkoSJSl94pxZffxzx4pu4buf3056
         Vlpw==
X-Gm-Message-State: AOAM532lSOvYNLpLLzPwk2VibEZPqTnvxPzlP1zvrHBMOoEodCo6c485
        DQob5UGkX52tCt41n+uia8gcQc+s2LhWfIz4
X-Google-Smtp-Source: ABdhPJxvjX/da7XpQfbKx/wRIuhvOObhFiXpnE+3iuh3E/aCvOhGqt90VL72WCYIeUZ5PB5h3RDQuA==
X-Received: by 2002:a67:f2c7:: with SMTP id a7mr22519966vsn.4.1620693484299;
        Mon, 10 May 2021 17:38:04 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id f6sm2051585vsh.31.2021.05.10.17.38.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 May 2021 17:38:03 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id u188so1863661vsu.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 17:38:03 -0700 (PDT)
X-Received: by 2002:a67:f815:: with SMTP id l21mr5306470vso.34.1620693482885;
 Mon, 10 May 2021 17:38:02 -0700 (PDT)
MIME-Version: 1.0
From:   "Robert O'Callahan" <roc@pernos.co>
Date:   Tue, 11 May 2021 12:37:51 +1200
X-Gmail-Original-Message-ID: <CAOp6jLZ8GR8DKCZLQJKPS7oeP1CX4L3ijBFDBePGX4q6z-DQhg@mail.gmail.com>
Message-ID: <CAOp6jLZ8GR8DKCZLQJKPS7oeP1CX4L3ijBFDBePGX4q6z-DQhg@mail.gmail.com>
Subject: Userspace notifications for observing userfaultfd faults
To:     Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Peter Xu <peterx@redhat.com>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Kyle Huey <khuey@pernos.co>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For rr (https://rr-project.org) to support recording and replaying
applications that use userfaultfd, we need to observe that a task we
are controlling has blocked on a userfault. Currently this is very
difficult to do, especially if a task blocks on a userfault on a page
where some other task has already triggered a userfault, so no new
userfaultfd event is generated. We also need to observe which page has
been faulted on so we can determine when the fault has been serviced
and the task is ready to run again.

I've tried to find workarounds with existing APIs and it doesn't seem
tractable. See https://github.com/rr-debugger/rr/issues/2852#issuecomment-837514946
for some thoughts about that.

It seems to me that a sufficient API for us would be a new software
perf event, e.g. PERF_COUNT_SW_USERFAULTS, with an associated
PERF_SAMPLE_ADDR that would give us the address of the page. Does that
sounds like a reasonable thing to add?

Robert O'Callahan
