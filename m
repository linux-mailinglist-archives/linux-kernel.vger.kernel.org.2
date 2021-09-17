Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF2B41002B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 22:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244130AbhIQUEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 16:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236102AbhIQUEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 16:04:39 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D5BC061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 13:03:16 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id x27so37526120lfu.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 13:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=zaej+MRlr60eW5/SILG2YvxNdgVG8sMyUG0fQtuBD0w=;
        b=O9eyELD1LGYc6R4OPdc03PelcHYokHZZo62kKPEKJSkEtWb1Z+/iz6vcSRFzenKNCd
         e9GLjYeGuxkfbHjj2v8NntVguhVQ6mwVycy77PXCLMK/lflrn43yAl/X0avQ4hqKU04R
         aCIbHuRVlNsGvenSl5q9IhNlpr/M6iKZ9eJGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=zaej+MRlr60eW5/SILG2YvxNdgVG8sMyUG0fQtuBD0w=;
        b=AXwkqWclPo6DBGUaONbVMQ2Td5rdztpMiwittrc6y3p3GdHi02esp22p+83JBP+V6Q
         hUUUHCSRecME/52/WGOGRfVDijND2XzlVHNSM/s8q2l6ySS8LhLtBs05DQwIFrGuvVd4
         ID9n5H9gff99u8dvGRdx3RbEry39qu6pWq+txUIczS15B1XsFF8xk+tTIQkbND+3a053
         9A+EBNYw4BtDVVFucnPs7nzy/m7lUxmlO6KNZMk6u1mjFeVheycHDJXrW76grpR+BR7M
         7z3y4KnvUntSWA8dC+c00Rt6strim5TVSsAZRpDXsesMzTS8dOd1U77JtCClPOvzIr8J
         Vtyw==
X-Gm-Message-State: AOAM5336VEydgVphaZV767XEiBQ4Gv0FsAX39TpL/4MGI4pf8JrRdkMI
        AJVnhKphtzZmlHoK2o63KeydAhk0IGtLXeEU7+8=
X-Google-Smtp-Source: ABdhPJx+YjfL/UGite6ZWIy6PiI9BXpVak88TY/tgMTIySNPQOjuoQEzPFO8/nnFR27aaxxc+9K60w==
X-Received: by 2002:a2e:884e:: with SMTP id z14mr11046848ljj.365.1631908994587;
        Fri, 17 Sep 2021 13:03:14 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id u2sm596250lff.238.2021.09.17.13.03.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Sep 2021 13:03:14 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id g1so37973411lfj.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 13:03:14 -0700 (PDT)
X-Received: by 2002:a05:6512:114c:: with SMTP id m12mr9769083lfg.150.1631908993830;
 Fri, 17 Sep 2021 13:03:13 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Sep 2021 13:02:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=whOsdfVrXHRJir0gu4Y3-K+nDkk7jAAWg15xu0jfQ9hpg@mail.gmail.com>
Message-ID: <CAHk-=whOsdfVrXHRJir0gu4Y3-K+nDkk7jAAWg15xu0jfQ9hpg@mail.gmail.com>
Subject: 30 years since the Linux 0.01 release
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is just a random note to let people know that today is actually
one of the core 30-year anniversary dates: 0.01 was uploaded Sept 17,
1991.

Now, that 0.01 release was never publicly announced, and I only
emailed a handful of people in private about the upload (and I don't
have old emails from those days), so there's no real record of that.
The only record of the date is in the Linux-0.01 tar-file itself, I
suspect.

Alas, the dates in that tar-file are for the last modification dates,
not the actual creation of the tar-file, but it does seem to have
happened around 7:30pm (Finnish time), so the exact anniversary was
technically a couple of hours ago.

Just thought I'd mention it, since while unannounced, in many ways
this is the true 30th anniversary date of the actual code.

                Linus
