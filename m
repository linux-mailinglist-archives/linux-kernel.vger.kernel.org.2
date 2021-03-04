Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57DE132D920
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 18:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbhCDR7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 12:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbhCDR6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 12:58:44 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6D8C061756
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 09:58:03 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id q25so24476327lfc.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 09:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lSqs9wkEbEk2a0S3R8mYygMHzF8HMXmInLPhb6U+SXg=;
        b=VEB/XXL0+AWnFaPuEUNRf/teQR+a76YuFn9Fk99/N91ZgOCFXDd5Pcq6NacZvKfz40
         Xrud7IbAtGsnwD+aJvwEiegsYP4UNWLIjU7nZSZds/Kn7VR2B7EviJ+N4QiSSn+OWZu6
         S3m29DTN7ZtRipXMh8+MOF4bZG8HyIsPM8Shc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lSqs9wkEbEk2a0S3R8mYygMHzF8HMXmInLPhb6U+SXg=;
        b=F4S5EILoQ4YPIL+bN6QFvUfqP4z0O0iIbWDzi7nOW10DS1R2Nyb3McPcs1NzhWHGHW
         vkMgzki34j2vp4G/utjGNn9PtN+hjpZSSMmjleXQXciRpnP80K5c5cLCRDt3t1iVcGsT
         p7p752y2pBVDJJCD/j+foSnm2juyJAppPsPO/7iqJDUOfDL59SIswbJtPcAXW/wdzE7e
         3FnJaxVXGxFv7rDAd4ZYHhS6NWRwjGX+RgltLqyCAbt4zv6yyO09oLvzXt6IQQNpZZJt
         LuVc1KzHrdxoxyqlAjaUgK+ksAsmJBzfDclJNgBRLoz6Fco9hTyeE6XS8yRMIyGawMqT
         G+IQ==
X-Gm-Message-State: AOAM531qyrvfvGuOeFfh8zU1Uv1wnGoQb+NFs2E1p5CZR/Z/XqUlDlY7
        Zi9LfwargFiW3PRuvu+24K5dYunCygd4rQ==
X-Google-Smtp-Source: ABdhPJzJ9Q6xZsRpxPxqy7xPvvmDCXYdr71npz2zGJB8Vg6xuUduK60jV6HcpfHn22SqZlFEtuUQjQ==
X-Received: by 2002:a19:6b13:: with SMTP id d19mr2899064lfa.291.1614880681910;
        Thu, 04 Mar 2021 09:58:01 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id h17sm8821lfc.289.2021.03.04.09.58.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Mar 2021 09:58:01 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id u18so20801195ljd.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 09:58:01 -0800 (PST)
X-Received: by 2002:a2e:864d:: with SMTP id i13mr2844609ljj.48.1614880680763;
 Thu, 04 Mar 2021 09:58:00 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjnzdLSP3oDxhf9eMTYo7GF-QjaNLBUH1Zk3c4A7X75YA@mail.gmail.com>
 <20210304124314.GA9979@duo.ucw.cz>
In-Reply-To: <20210304124314.GA9979@duo.ucw.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 4 Mar 2021 09:57:44 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgZjJ89jeH72TC3i6N+z9WEY=3ysp8zR9naRUcSqcAvTA@mail.gmail.com>
Message-ID: <CAHk-=wgZjJ89jeH72TC3i6N+z9WEY=3ysp8zR9naRUcSqcAvTA@mail.gmail.com>
Subject: Re: A note on the 5.12-rc1 tag
To:     Pavel Machek <pavel@ucw.cz>, Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 4, 2021 at 4:43 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> Would it make sense to do a -rc2, now, so new topic branches can be
> started on that one?

I was planning on doing an rc2 earlier, just not "this minute" early.
I was expecting to see a few more of the normal fixes pulls come in,
and perhaps do it Friday instead of the usual Sunday.

Because regardless of an accelerated rc2, I thought it was much more
important to rename rc1 and let people know to avoid it.

And yes, obviously it was inevitably too late for some people, but
doing an rc2 wouldn't have helped those people either. So the most
important part was making rc1 itself less reachable by doing that
"dontuse" rename.

(And I should probably have done that rename even earlier, but I was
waiting to see if I could get more confirmation that it really was
fixed. And in hindsight that was entirely pointless and stupid of me -
we knew there was some serious rc1 problem, and the renaming had
nothing to do with whether it was fixed or not. Oh well. Water under
the bridge).

But I also can heartily just recommend that people who already _did_
start on rc1 to rebase their current - hopefully not extensive - work.
I know I've ranted about rebasing for years, and it has huge
downsides, but the operation does exist because sometimes you just
need to fix serious errors. So _mindful_ rebasing, understanding why
it shouldn't be a normal thing, but doing it when something
exceptional happens - that's not wrong.

               Linus
