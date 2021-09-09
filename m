Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21ED6404221
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 02:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344085AbhIIAPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 20:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241998AbhIIAPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 20:15:01 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14196C061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 17:13:53 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id n24so41681ion.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 17:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u/oNyUzVDcvaYcpDh9wmrylwNICdOwMu/2YDLPmGpIY=;
        b=qz63LbSJJsuJtmyjrkE3D/8rI6hdOS0JHCJTfxLDv2cZ14JotrnFgqbZVAohleOrHi
         ghmHQvT3IonWSlFIYxTkyBE+87CmPJhh0oKL6I1k5NV5/M5Wth7QILaf73R4PWL8SVFt
         sVCfrMADxbAqwi+PDZZCWKr0qDPhRbG0sK+mdffoPjnhE6W+QchY+da8kmHrJRuSY+Tg
         sluIhYjJJ4Ke7O3OkBPyb4Yw/DM4DiRd7wFsBT8AmFzHcUzcvQLNN53GDuyoz+z5uoOn
         XgkcA8O7XnNbGIMctBOo/BKLGCr+pAUBDQWUTdVXeMkI5V3j0R7fWJJK5Hc6ZInj/om/
         uGDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u/oNyUzVDcvaYcpDh9wmrylwNICdOwMu/2YDLPmGpIY=;
        b=UZ8uTbntSI9dHUaQQJfh+q/wqUDKvYweqJh2mARlAsUTFMUJ98FWAZpMKjfdyKqmrX
         zkd2MZ/V53axTGBa3yqhl7arSgQnEQxtWX2OIxfILlwjQSYxqJYojoPVPEcElgnV6YU1
         eGG3tchku3oJzHka1qGajTfTIMQkyMD2kkCM8gmN3S6omGRYTJfMUDPiclRvRQ2aoGVr
         gmdUlQd0KS+TefuihzYy67o1R4rHE4rggu7tyXFDh8he/EvydI5/b7gDZ+NMjXllu9hk
         Ae6yU/X3OCPEtRUfRf4nXMhxQUjmJIgwHPZ1+KD7T4+OUL+IkdCV+8ynrU2Ww4a0GUch
         jPlQ==
X-Gm-Message-State: AOAM533NeCXZaBkD+AcB7bPDMsY+8C0Q2hrIH9Zc9ky6ASvuQKvB3PFL
        DE5+iTPH+DyaSo8olp/xMhYFVmZ/Yx7G0n44QSGLaPtNuIU=
X-Google-Smtp-Source: ABdhPJxXnIrbyiyXQS2l6IB2elzke3/RP7HKSNs3rsH+0XGKvDYLboosLPBvZQbKIL/fLEtmVhBWhOxmf/dkoRm4rHE=
X-Received: by 2002:a05:6638:4122:: with SMTP id ay34mr191161jab.131.1631146432540;
 Wed, 08 Sep 2021 17:13:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210908234751.GA8052@kernel.org> <20210909000141.3136241-1-ndesaulniers@google.com>
In-Reply-To: <20210909000141.3136241-1-ndesaulniers@google.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 9 Sep 2021 02:13:41 +0200
Message-ID: <CANiq72nwzPt2zx-m8Cbi8-GAztknEefVDVM4VGhOFyUvagcukQ@mail.gmail.com>
Subject: Re: [GIT PULL] Compiler Attributes for v5.15-rc1
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>, Marco Elver <elver@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On Thu, Sep 9, 2021 at 2:01 AM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> What about
> https://lore.kernel.org/lkml/20210802202326.1817503-1-ndesaulniers@google.com/
> (modified to mention clang-14 rather than clang-13)?

I would like to have that one in -next for a couple days before making
the PR. Since we are in the merge window too, I decided to send the
one I had in the queue first.

Cheers,
Miguel
