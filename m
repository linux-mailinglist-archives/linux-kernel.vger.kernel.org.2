Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5293BA413
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 20:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbhGBSwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 14:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhGBSwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 14:52:36 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54C6C061762
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 11:50:03 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id r26so2301763lfp.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 11:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=71nuSMvaqgHrgpwAtP1N6KiE3ICrLSTcXVzeIPBvQ4o=;
        b=M7diCQUwMpzKQ1GXJoVPs9ZHH6w/FGKZMDIDOCrHx9bDTbOzzu8tbcnHNGtiUjvfRe
         7nD4xqc8ZKvmjMItQppsaUWB7+CxM4/HXNOlQPoFXIptkAOTbwmoM8RuNSbTOSK9Qk6c
         MNnPD0+78LLKPaN9r+5vwqH2uhsVbhc4Az2RY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=71nuSMvaqgHrgpwAtP1N6KiE3ICrLSTcXVzeIPBvQ4o=;
        b=ElC6VBJ/YCB6CE21XV7hzH0A9Vs9yZgYIecz23c2998JQEeuVhm0+UOeA44Ln7fv2o
         H3rh+4I7aRTHbCs3nE5C72oSRJWSDP0Ne0TEGwfkSFVZVlitc/3gvetAPmqqWyPr2PDj
         XvliRBRQbe1ZLWBckN8t8quG2w4c/2E9bchB1LF2haKDKlanqKt2Lhlzh8aOktznAz80
         d2Ae27gMATdI7sU+DG0XGfPZ3C8hLsl5IuVpFuwW8CcAOVXM25FsCuoh4YqF1cjq0b3E
         73Vg1VkzyWYc4187WOl15bbu7r+k2xUHb/MZ9lCdY48a6LHgIs/ekVSxoA+cs7dNOAh1
         hpsA==
X-Gm-Message-State: AOAM5327BrYd8epWE4A2I2B4HRomD8C31NiqApN7HYVmoT7XUxeU+GEG
        z9wqdE4v6RWszyi1uACQtDtb8i6mXk6IX+DA
X-Google-Smtp-Source: ABdhPJyi6aYOEFZ7fnnc7j6uTFmlGfCCWxvcRYxxs2WxYlGMGdNeBvSNQ3OVPzX/wgD7ByVbi+xFHA==
X-Received: by 2002:ac2:5236:: with SMTP id i22mr731523lfl.637.1625251801273;
        Fri, 02 Jul 2021 11:50:01 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id h25sm346682lfe.284.2021.07.02.11.49.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jul 2021 11:50:00 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id t17so19878748lfq.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 11:49:59 -0700 (PDT)
X-Received: by 2002:a05:6512:3f82:: with SMTP id x2mr716901lfa.421.1625251799639;
 Fri, 02 Jul 2021 11:49:59 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYuBvh-H8Vqp58j-coXUD8p1A6h2it_aZdRiYcN2soGNdg@mail.gmail.com>
In-Reply-To: <CA+G9fYuBvh-H8Vqp58j-coXUD8p1A6h2it_aZdRiYcN2soGNdg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 2 Jul 2021 11:49:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgJJtZ9TD_zDefSnaLzLAcjVKXPJoK2o=K-QWkhLGxyuQ@mail.gmail.com>
Message-ID: <CAHk-=wgJJtZ9TD_zDefSnaLzLAcjVKXPJoK2o=K-QWkhLGxyuQ@mail.gmail.com>
Subject: Re: [mainline] [arm64] Internal error: Oops - percpu_counter_add_batch
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        regressions@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Theodore Tso <tytso@mit.edu>, lkft-triage@lists.linaro.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jens Axboe <axboe@kernel.dk>, Zhang Yi <yi.zhang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 2, 2021 at 1:24 AM Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> The git log short summary between good and bad.

Ity would have been really good to have a full bisect.

But from another report:

    https://lore.kernel.org/lkml/87ade24e-08f2-5fb1-7616-e6032af399a3@nvidia.com/

 it seems to be commit 4ba3fcdde7e3 ("jbd2,ext4: add a shrinker to
release checkpointed buffers"):

Ted, when there is a fix for this, it would be interesting to see what
made this all work fine on x86-64 but fail elsewhere...

         Linus
