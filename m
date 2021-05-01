Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 144923707CF
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 18:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbhEAQGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 12:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbhEAQGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 12:06:06 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9577C06174A
        for <linux-kernel@vger.kernel.org>; Sat,  1 May 2021 09:05:15 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id j4so1719694lfp.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 May 2021 09:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7nlYoQExVbXQhvC/EaGOIk1M5S2Uav+x5xdbORmDf5o=;
        b=XEwq9R1H0HQHrvXfOtBwmFEP/4cLHs/4p+ksTho0zU/9blcwQfdwK5hL9D2Fzcq8az
         EOQw+j65UGDc/TZyaKkUq96pjaSLUS/g+SStreW1U+h9AEsuMlL1Vq6MLI/+dFDlwqm5
         GJvv7frzqQ0MYxZDAzcJOI+MbEF2787l/ezlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7nlYoQExVbXQhvC/EaGOIk1M5S2Uav+x5xdbORmDf5o=;
        b=HxXWpJDCikZ4SMn3kWP8C4FivMJO2MAkFsaEHC9iNNvArYn09aFeMKq7/7YGw818hV
         MRU1Eaq9IfEWboDZfR0oixdBXse6SXY9LHLLHpvv8AsHw0OKUOZuARivtepD0uTbDa+M
         dqjql8InuPsvcLqGcxV/NC6Aig8YNFt4ak/ML0xkQk+udimoEtwNc7zy5OF+t7VJCNI+
         knJSDn/4pp1IuPmMjr/+OyGdO2whDPtOJKA2btrzPILKj+UTOy/dYejyvT+OLlN1avzP
         RptvMrtUmmN6cdVEbQSDGzdlixBMDjXWrbC3WWSltGvy2prAWWFlGCvsmenIjrUhFAdy
         OMCg==
X-Gm-Message-State: AOAM5321gc132p1AogQHj2dV1r8eI3RgmQlKMKkDQQpDicUoO6q+n4Us
        yREoJPsOdyDBRIq0hpFTXJhBT6wEarpYFhQT
X-Google-Smtp-Source: ABdhPJyC/jsEiPEdGx+rNROl6d6713mEMnLq89XZyVjVqkf9kxR8n2VP5hkQUGecFmNGYiNqxoUy8w==
X-Received: by 2002:a19:614c:: with SMTP id m12mr6999031lfk.606.1619885113079;
        Sat, 01 May 2021 09:05:13 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id w26sm605455lfn.82.2021.05.01.09.05.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 May 2021 09:05:10 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id c11so1657499lfi.9
        for <linux-kernel@vger.kernel.org>; Sat, 01 May 2021 09:05:09 -0700 (PDT)
X-Received: by 2002:ac2:5f97:: with SMTP id r23mr6990675lfe.377.1619885109537;
 Sat, 01 May 2021 09:05:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210428230528.189146-1-pbonzini@redhat.com> <61aa0633-d69c-f1b6-dc9f-6ca9442fbbab@redhat.com>
In-Reply-To: <61aa0633-d69c-f1b6-dc9f-6ca9442fbbab@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 1 May 2021 09:04:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjhLXDRdxfhzHS8bPOxtNQuQLVpepsytCzN=LPxJuejTg@mail.gmail.com>
Message-ID: <CAHk-=wjhLXDRdxfhzHS8bPOxtNQuQLVpepsytCzN=LPxJuejTg@mail.gmail.com>
Subject: Re: [GIT PULL] KVM, AMD PSP and ARM CoreSight changes for 5.13 merge window
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 1, 2021 at 1:00 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> is there anything wrong with this pull request?

No, it's still in my pending queue, and in fact I'll get around to it
today. It's just that I've always had something else I wanted to look
at, and this was always "I'll get to it when my queue is emptier"".
And the queue never emptied (but today is the first time I don't have
a lot of new pull requests pending overnight, yay!)

             Linus
