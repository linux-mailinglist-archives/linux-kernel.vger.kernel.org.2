Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2188F3D16B5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 20:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbhGUSPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 14:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbhGUSPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 14:15:34 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB62C061757
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 11:56:09 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id f30so4663929lfv.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 11:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aJkW/Rt80/ziMvbn4832hKqXFcNOrBwlbkHciUUuUEQ=;
        b=h3o4hzJQWX+TGJxM1Jtx5rcowiFdFpFGP1bJrbF2mhXZ6Iahjbd/JUD501V9ekEXeH
         AKH+TPFtDIlarocczD/aWA1pu8wLGBLaRHpy4i/siBaSki9h5jCAgNQpFt/qJnD1htBB
         mATXWGOEBa84HmjBZUdJpk8shmsNjxHoAmmV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aJkW/Rt80/ziMvbn4832hKqXFcNOrBwlbkHciUUuUEQ=;
        b=DtAZrtQATGBHDoFWEKp5GUUSCZfKtX3BUbZUIUZZ8myiLiDHPosaUx1dPSL77ZkegN
         whs5EtEaeqFQ8Tp4q5zIDn4pC4M9hfNRJqzLV//lrQGjqGcPeeTXPSrrJeAHJohvWCHa
         TV1vADaF/6sRGXct49gjDq2pgJOHOwJ06ttxUgOY0Is9KcYtw5cVe9EMvR7zmBW19+My
         0T0AeXaR15j2vJSMDrKM4nzDZW6nqLEwMU1tA1zIrYhoQaA/aAJny4j6RAwo5k+C2Kii
         B4TxCIMi2DKySKLiq9UUW0mljrn9I3PiEQsc/TOk8cU17sI4Avk7NVsQKMbrsEselcF3
         Ytyw==
X-Gm-Message-State: AOAM530hGA6zsrfrqkJpNpVwhOLnO3VAA0wSv++bTub8EAtor+7m/Gle
        6gLkzn1972ZV81FlGLX9rcU9u5CiyitD8xrI
X-Google-Smtp-Source: ABdhPJyOZJ7qEpYoUPgBAuObSTWXt3uTzLiBsXrCN/gCmpS3ej8V59hsAuuUCdeluQYvcGOMUjapPQ==
X-Received: by 2002:a19:771c:: with SMTP id s28mr25948903lfc.358.1626893767646;
        Wed, 21 Jul 2021 11:56:07 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id c5sm2892977ljj.17.2021.07.21.11.56.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jul 2021 11:56:07 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id u13so4653038lfs.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 11:56:06 -0700 (PDT)
X-Received: by 2002:a05:6512:404:: with SMTP id u4mr25898153lfk.40.1626893766677;
 Wed, 21 Jul 2021 11:56:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210721135926.602840-1-nborisov@suse.com> <CAHk-=whqJKKc9wUacLEkvTzXYfYOUDt=kHKX6Fa8Kb4kQftbbQ@mail.gmail.com>
 <b24b5a9d-69a0-43b9-2ceb-8e4ee3bf2f17@suse.com> <CAHk-=wgMyXh3gGuSzj_Dgw=Gn_XPxGSTPq6Pz7dEyx6JNuAh9g@mail.gmail.com>
In-Reply-To: <CAHk-=wgMyXh3gGuSzj_Dgw=Gn_XPxGSTPq6Pz7dEyx6JNuAh9g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 21 Jul 2021 11:55:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=whhThPq-ETzyepM0OteV480FcVExxPMoU0ntaH-mX_BrQ@mail.gmail.com>
Message-ID: <CAHk-=whhThPq-ETzyepM0OteV480FcVExxPMoU0ntaH-mX_BrQ@mail.gmail.com>
Subject: Re: [PATCH] lib/string: Bring optimized memcmp from glibc
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 11:45 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>  - the code generation is actually quite good with both gcc and clang.

Side note: I only looked at whether the code looked good, I didn't
check whether it looked *correct*.

So caveat emptor.  It looks trivially correct both on the source and
assembly level, but it's entirely untested, which probably means that
it has some stupid bug.

               Linus
