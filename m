Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A56414CF9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 17:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236402AbhIVP2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 11:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbhIVP2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 11:28:20 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F020C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 08:26:50 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id m3so13465719lfu.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 08:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sVblMwcY20Jt1iJwJZzOQQzmXaPjWYdpKIFg44drlAI=;
        b=Iv8Fu1IRNg70EMHGzFeMTd8j/ThtaiAem9UrK07EGRyvDmdYcny/SyCehISsXmkqpx
         l92lTNBSyBbDXYg1Yhc6RFGTAV9NS5ml7ZmwcQJaPFjWpMPUte3T+pogP3++9F+/Z1A/
         kzeL2ruJbqjYn3yHBIgPlbAR8WOp/hvzXBCGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sVblMwcY20Jt1iJwJZzOQQzmXaPjWYdpKIFg44drlAI=;
        b=W/PSyDFDWz4k07JlGz4bKAzH5ILQ6PI7ELESMovvxFiwJDr8nEKymu+5paTFv7dCVQ
         FDiVMOpyrt/4ujs0hJlSUDVMJlU/h/0aH1Ti4EhStFKymeLms0p2iubjl3mctjJtPBED
         Qtx+/4i+o7seWhxYemVMPu5B1kT17vQCoGW2Rbq2T3ZdQFLD+jMqZ1VI4DQJlurRPm3z
         /l8si0Hu+wnpJVTXRH5bpGSPRF2MZGRwM7l0PLT5ATe7lMrvbs+1axw1iNZ+ttOh9Qaj
         2U7NMCKlAlXq8sHaa2JoCNV/i8uhs6JOlFPeZdBIS725LJ6wzD4RKMHqIIt1ZhD0Ii5V
         JFiA==
X-Gm-Message-State: AOAM530K2QWVh9/Sc6870BGmPTL/cdcNRAseoFhL8sM63H24yhMKt0Fc
        kahtFByvR+8QpFVQLoCl2T7sLVojoPCLhWqdMAY=
X-Google-Smtp-Source: ABdhPJy6t72nDcA3hhFnGO09RsRc0NcYnba863lm4Cwv5JTXpJhWxh8rGh618/H2q0DdleFAUk/pSw==
X-Received: by 2002:a05:651c:a12:: with SMTP id k18mr118578ljq.207.1632324303566;
        Wed, 22 Sep 2021 08:25:03 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id 5sm282995ljj.13.2021.09.22.08.25.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Sep 2021 08:25:03 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id e15so13164614lfr.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 08:25:03 -0700 (PDT)
X-Received: by 2002:a2e:5815:: with SMTP id m21mr126446ljb.95.1632324177022;
 Wed, 22 Sep 2021 08:22:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210903160302.yh42vpkuob45dbpb@gilmour> <CADVatmMqT1yq3YHBzt4-VsL8uVHUULmy2gpaH27rAqimao2i_A@mail.gmail.com>
 <20210904091050.g5axxctgelciihjn@gilmour> <CADVatmN+9euG5Fegor1+kaSPewbW8vRwBgnxmr5SsK3mOE6FEg@mail.gmail.com>
 <20210920144730.d7oabqfbx7pmyyfb@gilmour> <20210920154333.vunyxeshdb7jt5ka@gilmour>
 <20210920155350.h6624mt65vwg72p2@gilmour> <CADVatmNi+jN+EwiWuoDoocZFyErDVNt1ND0BxtjuKiV63aNuJg@mail.gmail.com>
 <20210920171042.oq3ndp3ox4xv5odh@gilmour> <CADVatmOs7Cc1EdCZXMyXcWM-3-J4bU_3zF1thkOohVUL-G6ZrQ@mail.gmail.com>
 <20210922095725.dk4vk42zb3kh7y6s@gilmour> <CADVatmOMV5gMhCuoP65O9mbW639x5=0+bGh92WVL8FFX2Mvu3w@mail.gmail.com>
In-Reply-To: <CADVatmOMV5gMhCuoP65O9mbW639x5=0+bGh92WVL8FFX2Mvu3w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Sep 2021 08:22:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi=8Wp31FSyOH5A8KY+7f3dSuP62zUpvTtyvENm1Hh7xA@mail.gmail.com>
Message-ID: <CAHk-=wi=8Wp31FSyOH5A8KY+7f3dSuP62zUpvTtyvENm1Hh7xA@mail.gmail.com>
Subject: Re: Regression with mainline kernel on rpi4
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Maxime Ripard <maxime@cerno.tech>, Emma Anholt <emma@anholt.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 3:11 AM Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
>
> That test script is triggering the openqa job, but its running only
> after lava is able to login. The trace is appearing before the login
> prompt even, so test_mainline.sh should not matter here.

Side note: the traces might be more legible if you have debug info in
the kernel, and run the dmesg through the script in

  scripts/decode_stacktrace.sh

which should give line numbers and inlining information.

That often makes it much easier to see which access it is that hits a
NULL pointer dereference.

On x86-64, generally just decode the instruction stream, and look at
the instruction patterns and try to figure out where an oops is coming
from, but that's much less useful on arm64 (partly because I'm not as
used to it, but because the arm64 oopses don't print out much of the
instructions so there's often little to go by).

         Linus
