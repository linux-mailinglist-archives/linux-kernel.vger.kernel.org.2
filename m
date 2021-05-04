Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A54EB372D66
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 17:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbhEDPz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 11:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbhEDPzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 11:55:55 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058F3C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 08:55:00 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id c3so9968636lfs.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 08:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g+unjtHm/rBLwTMZM4tl4Q30PDymo74btwmzKLoZ/sA=;
        b=ZLT2JvpPvPUPbbcIHgI3bQtXWtU/Hm0/A4U+RLt0R5BiQfq1zpGbnBh63E42n5wnzu
         Lot16wxaeNXbReHlLIOQ13aRZYx4FLwegzuNmmjLYrN9nBkeQiNfyVrUT3Mc2X5fBf9d
         oDLqzodlQKQUHRQBoeBp80DzxHmbsEMZ6wifw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g+unjtHm/rBLwTMZM4tl4Q30PDymo74btwmzKLoZ/sA=;
        b=gk0dPUZFfHMygBuRMPunLHSUMAvDlE+iPf/qx4q3DbBETQv912JJxd+aM4xhhDJ8ni
         66FC5Y+iR13rjdZorvc1xNpULgQmG5pD4DpTSWQHd+v1hfIIdrISPStILlSyh4WETiQ+
         Ima7J54FiPEArZ37FBDzB+8eP1MFc3Qf2Nk1AsLCg/Pj5YknQpJm8Q/Ovk9SLK1CthcD
         7rs1/BESgVIjdQsTHT433oS4uXHhC5S7Jlvxes08vi2jUgDVLTQXbQXnPssVF0UGqDcJ
         +ITu4X8B6LLaKncisD5/Y411BD8AM46OQRecSyeNj+ZWFGxK2YiOXYF+YCpGCqSLZ0NT
         QG8g==
X-Gm-Message-State: AOAM532Izmgpl0zNo8Qg38BWR5ECi32JJMNzdYYX0ReRelfqAa2lz2vj
        BUeTQeUfx0q3kXZ4MZp/n+YhSgNj9+L556HD
X-Google-Smtp-Source: ABdhPJxbC+NooIsRbptrmDjojeMCUXwt2QMD8v85CSZy2wUvtWJpjNGwIrdvLTR4o1dqgd44XcAMlA==
X-Received: by 2002:a05:6512:139e:: with SMTP id p30mr17375801lfa.489.1620143698313;
        Tue, 04 May 2021 08:54:58 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id h11sm1708639ljc.118.2021.05.04.08.54.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 May 2021 08:54:57 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id h4so6396725lfv.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 08:54:57 -0700 (PDT)
X-Received: by 2002:a19:7504:: with SMTP id y4mr16748492lfe.41.1620143697568;
 Tue, 04 May 2021 08:54:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210502220519.GA24775@duo.ucw.cz> <CAHk-=wg0Cvmxk58f0waakTKo8G5wPWarVw5b2=11f35vBAOYUw@mail.gmail.com>
 <YJFro4ue80SIboQd@mobian>
In-Reply-To: <YJFro4ue80SIboQd@mobian>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 4 May 2021 08:54:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjuAbLtGY6UcV+_KTEXLxeKnQU+0AyxV75-FHovSB15Jg@mail.gmail.com>
Message-ID: <CAHk-=wjuAbLtGY6UcV+_KTEXLxeKnQU+0AyxV75-FHovSB15Jg@mail.gmail.com>
Subject: Re: [GIT PULL] LEDs changes for v5.13-rc1
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 4, 2021 at 8:43 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> Oops, sounds like I should have test-merged it and dropped the
> change. Thanks for solving it for me.

Oh, it was fine this way too.

In fact, I prefer to see a (trivial) merge conflict over having people
change their branch just to avoid it. So I think this all went down
exactly how it should have been done.

Thanks,
           Linus
