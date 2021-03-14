Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8AE33A851
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 22:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234236AbhCNVkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 17:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbhCNVkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 17:40:24 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE4DC061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 14:40:24 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id r20so13951016ljk.4
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 14:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HEgcOueF2VvHNJc5cHD9Ow6/3HbSqymVxf3NCXwy1mc=;
        b=fOTI5zrwO9nXlxVkLcyh1GiYxEjEgndp4h2U4c3pWzWYpcWJxqJBdVGMa9dVpkH65J
         vJYow2MyiWg7j7NkRcjQfmCiMJ4YLPhqNAlOcwnLlhTeJxdmhAXoGdKQnz4AH9h/ELl/
         ixiGb+QMWd1OAF+PhWCP0+UOHlI0uWLF3u+pA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HEgcOueF2VvHNJc5cHD9Ow6/3HbSqymVxf3NCXwy1mc=;
        b=OGrdQlahSOx0SsZVnTnJ6OPQr+dxbirzFhY6oykn4fD1Z+a/IEZLXc/9K21JSjz3rd
         5HBUYLZS4uqhSSg+XnSzzgcLaRo23LOo3R9EVfMyt7Uf96c0hmzCrLYWeRLccVIZ3Nvj
         znLDHWkas+BkDEjypgsimUKFDAGlA7dIC0Ykn/8yUeQe/70pR1Bt7zxE22Dw84NOIMCg
         F4ikweHkGbQzytMGfhSJC4Xuw13MoL8VxPIWEQx172pSYe99DVH14BwZ4aOS6aHlk0Aj
         gsAKdpimKxD9kn6we5u8meUKHLym6ksGf8kI23NAA4jyTTdkOW0aeam6aYGyEnR5W2MG
         y7FA==
X-Gm-Message-State: AOAM532mT351zDC4UJWXZ3H062uEeKTgAtuLfW143qopGuV7Oad0W99I
        c5a6WztoP6ch22toZ17r4yLC+Ot5zOP5Hg==
X-Google-Smtp-Source: ABdhPJxqdBjS5trDNV74PAMBcYKAMqpokgFGrncUJA8MvmT0VQwXNNOaaqzszfT8PM06ZmAIAHpIig==
X-Received: by 2002:a2e:b8c6:: with SMTP id s6mr8882720ljp.52.1615758022567;
        Sun, 14 Mar 2021 14:40:22 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id o16sm2453644lfo.166.2021.03.14.14.40.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Mar 2021 14:40:21 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id p21so53776839lfu.11
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 14:40:21 -0700 (PDT)
X-Received: by 2002:ac2:58fc:: with SMTP id v28mr5817321lfo.201.1615758020861;
 Sun, 14 Mar 2021 14:40:20 -0700 (PDT)
MIME-Version: 1.0
References: <YE53QiJuxsCUeoiu@localhost.localdomain>
In-Reply-To: <YE53QiJuxsCUeoiu@localhost.localdomain>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Sun, 14 Mar 2021 14:40:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgMm=PG3uxfpmYpkX-GaDAR09pej=t3nD6hHDNCYCyaRQ@mail.gmail.com>
Message-ID: <CAHk-=wgMm=PG3uxfpmYpkX-GaDAR09pej=t3nD6hHDNCYCyaRQ@mail.gmail.com>
Subject: Re: [PATCH] prctl: fix PR_SET_MM_AUXV kernel stack leak
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        gorcunov@openvz.org, Security Officers <security@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied directly, since I'm just about to tag rc3 and was just looking
that there were no last-minute pull requests.

Andrew, no need to pick it up into your queue.

Side note: I think we should return -EINVAL more aggressively: right
now we fill up potentially all of user_auxv[] and return success, but
we will have always cleared that last auxv pointer pair.

So we actually return "success" even when the user supplies us with
more data than we then really accept.

IOW, tightening that up might be worth it (maybe actually check that
they are valid user pointers at the same time).

That's a separate issue, and I can't find it in myself to care (and
nobody has ever complained), but I thought I'd mention it.

                 Linus
