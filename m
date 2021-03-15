Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3F933C9DA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 00:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbhCOXWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 19:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbhCOXWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 19:22:45 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2ACC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 16:22:44 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id a1so18285302ljp.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 16:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bxbgsbwCtesrXY+YKKY37TUZeQyapKV2GgIjlyayPRg=;
        b=K0AcqFivrA/zOa8g2gpETpk+xHa2hDLhn+NP/PxTtZS0B27p90k2mZkAHsyLfYOzLB
         Um/GXw5prAT97Wy1mYI3t0OcvyfDydcuDZyjRLu8lTETdaGe5R+NoUYhQsrivd4x551b
         lJ/ENjgEkSG7B05JsZkZWSMHw9CVsj+3e9cHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bxbgsbwCtesrXY+YKKY37TUZeQyapKV2GgIjlyayPRg=;
        b=nswRsYBDW+/i5/6A5dw7sbJfwwwm82niDLbygcWP/9sRoy5agB2VCApQi90VJoI1ZY
         zpWzLEesntlHcGcIZXoq+Xwq+aNqPUv2mAnXFRsKnJvFwIB6KONZ5oAcM4arm3jfTFH3
         zpYM1iRIkldeRs6Q7kisQxQkaEEy58PEtJTB4xp4/nh3ELpXdqkagqDHXOyAjxEe7a8k
         HdcXHwKumclXQfmR5KVIIJn1Dt6FRJHKCbjSZyCy0cQBd1P9utkD6HOnaEdBT9YOrhtd
         SrlR1vd0JC26WUWq4ejqcDBlXLnLrLJhXkE1kQ4MPu9Y3BKEmgpAGQrR/gMzOoVZDbHE
         dfEg==
X-Gm-Message-State: AOAM533NGa2pPwr5DQRooAfH/vUXGQG95thXQHp+OzE7I0ZKq+imP53P
        HyOhIKxpN1CmiskXIjFGHXXfWT5YfCUEjg==
X-Google-Smtp-Source: ABdhPJyE+SSoKi21SOEyVvecg63sVwHT6qTlpl8qrVAuxpriPfb9Zmjx0ARg4FayUp8PUYS9ILGPww==
X-Received: by 2002:a2e:9a86:: with SMTP id p6mr793454lji.359.1615850562644;
        Mon, 15 Mar 2021 16:22:42 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id h129sm264740lfd.245.2021.03.15.16.22.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Mar 2021 16:22:41 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id u4so59568285lfs.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 16:22:41 -0700 (PDT)
X-Received: by 2002:a05:6512:a8c:: with SMTP id m12mr9398477lfu.253.1615850561143;
 Mon, 15 Mar 2021 16:22:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210311130328.2859337-1-oberpar@linux.ibm.com>
 <202103120329.VU4uJ0yZ-lkp@intel.com> <CAHk-=whmwEJ-4tGamqOCw4BDJ-yjYrLRYxaFq5YurVc-XXO+hg@mail.gmail.com>
 <db88186a-d6af-33c9-f1fb-10b673b8fdd6@intel.com> <CAHk-=wji=we4HQ2m6Z=fnUSM4UW8+X0eTnb9YPGYdcTqpVAL2Q@mail.gmail.com>
 <09373c3d-73e8-933a-24ad-5c4ba4fdc615@intel.com> <CAHk-=wg0DY=cE-6Tjp_Dt32UC6XtMZBa0Rr2GqkK=Sh9HE=5kQ@mail.gmail.com>
 <YE/ERLHBdjJ19TYT@audible.transient.net> <CAHk-=wj6OiV_sSZbqz-ZPnL7=NboN-3VQYM6brVCfq2px0EAqg@mail.gmail.com>
 <20210315230951.GA17229@gondor.apana.org.au>
In-Reply-To: <20210315230951.GA17229@gondor.apana.org.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 15 Mar 2021 16:22:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj8kZ4LdbejRzBbWwGdqewPuV=1U8sEY1KzW3ubQ4AB+w@mail.gmail.com>
Message-ID: <CAHk-=wj8kZ4LdbejRzBbWwGdqewPuV=1U8sEY1KzW3ubQ4AB+w@mail.gmail.com>
Subject: Re: [kbuild-all] Re: [PATCH] gcov: fail build on gcov_info size mismatch
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Rong Chen <rong.a.chen@intel.com>,
        kernel test robot <lkp@intel.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 4:10 PM Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> The quoting on "!" doesn't help I'm afraid.  Even though [ is a
> built-in it is not allowed to look at the quoting because it's
> supposed to behave in the same way whether you get the builtin [
> or the one from /usr/bin.
>
> So when it gets the expression the quoting on the "!" has already
> been removed.

Oh Gods, that's truly disgusting.

But I guess from a historical perspective, it actually makes a nasty
kind of horrible sense.

What a crock. Oh well. We had the workaround already, so it's not like
this causes any heartache aside from "shell is even worse than most
people can imagine".

             Linus
