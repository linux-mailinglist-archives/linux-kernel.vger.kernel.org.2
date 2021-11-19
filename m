Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8E07457658
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 19:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbhKSS1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 13:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233721AbhKSS1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 13:27:53 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC9EC061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 10:24:50 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id z5so46317507edd.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 10:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=628q7p3vVd0CrFkuTgEua4myh/YWxoKJzbNr8Nt91Dc=;
        b=B1qBurZLaTfs+YDrS88+hpXrRqF+sRYb+RNluKjR4PQ/0ek0HiF8Mwa2OTZPwJrFzJ
         3xsMytEib1XmwgDyiEc66iSSMH2iFZPfJ292ZecypDC1DlrigRQlQvoITAgvimf4zdSM
         H0b8nyx8avpQNuFPS+eqZuEq6lZLQ8E+DT8Q8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=628q7p3vVd0CrFkuTgEua4myh/YWxoKJzbNr8Nt91Dc=;
        b=CDcwML9fRZ9cYnnYsf5NlwlcclNSWfPvsBjPlldbHRArocxbijSLHzzD5sezfGdQ/W
         JwiuJ99hr3V/Njxh+C5wGpqLsX89yHUaMm5wmVpX1R2D0WtUGOLHYzlglCEhmxj6dQBe
         VwWMreZ12InHYYuTtK5q0UM5IXRlkqKAbYhsCzZYjHk5mQV/GO4Uf9dqPzH83H3uuEqS
         tIiIDe2U2g/2eu0pP1E6cNekqgiFYEWE3D11W57yemdqjEovSIEhRVWx0muSE/R1oI70
         W1E6Xg58nFiUdqMRY+/W9pANxCldBDsesAMgWqjJBbRmrxUxX5OOBcluPAtw8NPIGllo
         KPIw==
X-Gm-Message-State: AOAM533HFTjaf4rbocBl8btjUBGngtiioErLZsxR2TDtmURuNW+UQpck
        6CdphvTWN1gbB3EAb9JgkXeDv3x2bJ0XDhT+
X-Google-Smtp-Source: ABdhPJxltCBmJ5B8bCO8w1GXzJt5X+1n7nJJRLRfpeOSMJxHIvrcwEo2MToCqGAqnIeZS8cAgGb89A==
X-Received: by 2002:a17:907:97d4:: with SMTP id js20mr10980222ejc.416.1637346289306;
        Fri, 19 Nov 2021 10:24:49 -0800 (PST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id y19sm325080edc.17.2021.11.19.10.24.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 10:24:49 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id 77-20020a1c0450000000b0033123de3425so11202647wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 10:24:49 -0800 (PST)
X-Received: by 2002:a05:600c:1d97:: with SMTP id p23mr2056537wms.144.1637345833034;
 Fri, 19 Nov 2021 10:17:13 -0800 (PST)
MIME-Version: 1.0
References: <20211117101657.463560063@linuxfoundation.org> <YZV02RCRVHIa144u@fedora64.linuxtx.org>
 <55c7b316-e03d-9e91-d74c-fea63c469b3b@applied-asynchrony.com>
 <CAHk-=wjHbKfck1Ws4Y0pUZ7bxdjU9eh2WK0EFsv65utfeVkT9Q@mail.gmail.com>
 <20211118080627.GH174703@worktop.programming.kicks-ass.net>
 <20211118081852.GM174730@worktop.programming.kicks-ass.net>
 <YZYfYOcqNqOyZ8Yo@hirez.programming.kicks-ass.net> <YZZC3Shc0XA/gHK9@hirez.programming.kicks-ass.net>
 <20211119020427.2y5esq2czquwmvwc@treble> <YZduix64h64cDa7R@hirez.programming.kicks-ass.net>
In-Reply-To: <YZduix64h64cDa7R@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 19 Nov 2021 10:16:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj9S-ETonTdvm+DWSBcvmNN50ccDBJ3DXBKYoGoNXBXUg@mail.gmail.com>
Message-ID: <CAHk-=wj9S-ETonTdvm+DWSBcvmNN50ccDBJ3DXBKYoGoNXBXUg@mail.gmail.com>
Subject: Re: [PATCH] x86: Pin task-stack in __get_wchan()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "Holger Hoffst??tte" <holger@applied-asynchrony.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Justin Forbes <jmforbes@linuxtx.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org, Pavel Machek <pavel@denx.de>,
        Jon Hunter <jonathanh@nvidia.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 1:30 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Anyway, below is the minimal fix for the situation at hand. I'm not
> going to be around much today, so if Linus wants to pick that up instead
> of mass revert things that's obviously fine too.

Applied.

I did have to add a number of "Link:" and "Reported-by:" etc lines
though. Please try to keep those kinds around as you make patches,
they get lost and forgotten too easily.

            Linus
