Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00EAF32C269
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376660AbhCCTnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 14:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240680AbhCCT0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 14:26:50 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD8CC061761
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 11:25:54 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id u4so38983614lfs.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 11:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P3A2O71ftuJfSYcOjzG8n0G0DSSbzV3fpd6bic7USUM=;
        b=fJlv4zH8GTkwLsBd+qX8OFR+earNuJHiLEuvYOwl3rNwh0Qticl4+a/PHzSKaRifKR
         wtUSTXlWKZe11OR4eXmAUXXnA4krJ07dpa0WsRUD7tFxvIxX3tWiNeIGVgjRkH9/OaAs
         dURJsQj/RGcwMDzmA+QLnZtjhPWSZpnRxGwpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P3A2O71ftuJfSYcOjzG8n0G0DSSbzV3fpd6bic7USUM=;
        b=dzDUkar6cnIDrEHLV/vldC1RK7J71uO+fpm31VxrU6cBQHR1lQRWoIf5jOiM1sc1io
         TJCgQyV7YD59qMtZ27aHZgvkZ9HZnCuW1pIZdDGPpsILh85LLqqogPnkXqjEaj3KevdR
         fWGQC40dWK4sqEZ5eQo/LFsD1yZmTXFLX6dZuVu5N1TjQSAJIPzeUMf4YN4YvCVAtdtN
         nq2VUjXYD3eX8PjoUb253QO0qkGIXir10A3yo5ofytp8pOd2jwQzlYf13Ig5E7yO3hK3
         4ownX+ECjz9SL95E79BVc7dSa9j0MrzGRvdjrSH+HLO0CfRHUoBy4R0EY/TzzS6nBxyW
         n7og==
X-Gm-Message-State: AOAM531qwAEbxVBM9nfnwWHlMQS4CKjuCpc1H0KrbX3fO6g0KwvPfmun
        GoCAsGz3yYVVktBSJLHAXOXR66M2CaemQw==
X-Google-Smtp-Source: ABdhPJza4aY0kF5W+5FhyjsRHJgN5r5lgesXiFozQUDUKQMJ4RszzYqrofoER33BnR1IfvcjqpbgHQ==
X-Received: by 2002:ac2:46f0:: with SMTP id q16mr71809lfo.589.1614799552878;
        Wed, 03 Mar 2021 11:25:52 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id g24sm3342869ljl.122.2021.03.03.11.25.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Mar 2021 11:25:51 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id e7so39007020lft.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 11:25:51 -0800 (PST)
X-Received: by 2002:a19:ed03:: with SMTP id y3mr121436lfy.377.1614799550613;
 Wed, 03 Mar 2021 11:25:50 -0800 (PST)
MIME-Version: 1.0
References: <efe6b039a544da8215d5e54aa7c4b6d1986fc2b0.1611607264.git.jpoimboe@redhat.com>
 <20210302232649.y2tutffhxsblwqlb@treble> <CAK7LNAReuB5zUq_7S8ZG25+tdQowECDOK1rApYvkPCpHhPjK5w@mail.gmail.com>
 <20210303191516.6ksxmng4pis7ue4p@treble>
In-Reply-To: <20210303191516.6ksxmng4pis7ue4p@treble>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 3 Mar 2021 11:25:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjR0CyaKU=6mXW9W+65L8h8DQuBdA2ZY2CfrPe6qurz3A@mail.gmail.com>
Message-ID: <CAHk-=wjR0CyaKU=6mXW9W+65L8h8DQuBdA2ZY2CfrPe6qurz3A@mail.gmail.com>
Subject: Re: [PATCH RFC] gcc-plugins: Handle GCC version mismatch for OOT modules
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-hardening@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Justin Forbes <jforbes@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Frank Eigler <fche@redhat.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 3, 2021 at 11:15 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> Adding Linus, who indicated in another thread that we shouldn't force
> exact GCC versions because there's no technical reason to do so.

I do not believe we should recompile everything just because the gcc
version changes.

But gcc _plugins_ certainly should depend on the kernel version.

Very few people should be enabling the gcc plugins in the first place.
Honestly, most of them are bad, and the people who really care about
those things have already moved to clang which does the important
parts natively without the need for a plugin. I'm personally waiting
for the day when we can just say "let's remove them". But in the
meantime, making the plugins depend on the gcc version some way is
certainly better than not doing so.

                  Linus
