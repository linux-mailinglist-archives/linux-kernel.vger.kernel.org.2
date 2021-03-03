Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFE932C2DA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353938AbhCDAGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 19:06:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbhCCU6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 15:58:12 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757F9C061763
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 12:57:11 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id y12so17597789ljj.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 12:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jRuDUUKixXJZDP0HjES33qad4zVN4t6lxUgDAY1T79Q=;
        b=QNwL/lnQ6xUnUJftFOjYj8S9SK2GrudH3yjL3FFeYEI36t+HVCk0ahbgAXK7QMT1q/
         d7s7AYb2jVr536dyDslgA1cJdUs4S/uosw+QeGO4MUiZh8yb3HqGGqPuVwKJQLGPWteM
         NqzmXkjI8rx2WgJHgIn7NY19N0J8VPem+YCDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jRuDUUKixXJZDP0HjES33qad4zVN4t6lxUgDAY1T79Q=;
        b=aBp5WAmIgedha86Dqb7P+kQMdawnarEpPWIBgzYWRwwyTeLKFqV/ttwmJWkYYSBMaz
         T3RnImUBSs9VCevYHI7NQrjCBTDZP4ZmaqtsS3XxA6HakEq2uCIn+HG8IjWIFT+OyuRH
         l4+r5nPZZCxyqnmK5poPKOJGJjHZNCMUuUCBHdK6nuYku6BEytuiCTcyaGRG1GvWfiS7
         UuRpvK6kkrnLD9UxTERzUcGYN6n6MtkIXXrkCmXXAYv2o3GPdzrKhb8EPsbpQMIpye0r
         NhmsWyY24804OBAlz5e/UIv21m9xaeuFlZ5xHronf8zXGb7vdx41ssQTh9s0mHlVdPXD
         BdYQ==
X-Gm-Message-State: AOAM531yaXCYiFYfnYBQYYyKaG1WNiE0nvlvyIyeTtEDGkBA9XK3v8Ry
        5NHCg1SaoNcOYIUfqh3jPdaE3qREb7P9ig==
X-Google-Smtp-Source: ABdhPJyTNx7zhXGcYYyD6XCy7Cy6lTeNkI1yrjVH+acKNQdSWRFSf0R1G+l8whQ31W+c0+HSkqbmHQ==
X-Received: by 2002:a2e:9d13:: with SMTP id t19mr412213lji.119.1614805029663;
        Wed, 03 Mar 2021 12:57:09 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id w28sm1951184lfk.185.2021.03.03.12.57.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Mar 2021 12:57:09 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id p21so39350460lfu.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 12:57:08 -0800 (PST)
X-Received: by 2002:ac2:58fc:: with SMTP id v28mr305345lfo.201.1614805028665;
 Wed, 03 Mar 2021 12:57:08 -0800 (PST)
MIME-Version: 1.0
References: <efe6b039a544da8215d5e54aa7c4b6d1986fc2b0.1611607264.git.jpoimboe@redhat.com>
 <20210302232649.y2tutffhxsblwqlb@treble> <CAK7LNAReuB5zUq_7S8ZG25+tdQowECDOK1rApYvkPCpHhPjK5w@mail.gmail.com>
 <20210303191516.6ksxmng4pis7ue4p@treble> <CAHk-=wjR0CyaKU=6mXW9W+65L8h8DQuBdA2ZY2CfrPe6qurz3A@mail.gmail.com>
 <20210303193806.oovupl4ubtkkyiih@treble> <CAHk-=whA6zru0BaNm4uu5KyZe+aQpRScOnmc9hdOpO3W+xN9Xw@mail.gmail.com>
 <20210303202406.bxgdx5a25j6wc43b@treble>
In-Reply-To: <20210303202406.bxgdx5a25j6wc43b@treble>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 3 Mar 2021 12:56:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi9J3mM8y+aH9e=HRo95giK4BRyyasayAimB0gdvbvDsQ@mail.gmail.com>
Message-ID: <CAHk-=wi9J3mM8y+aH9e=HRo95giK4BRyyasayAimB0gdvbvDsQ@mail.gmail.com>
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

On Wed, Mar 3, 2021 at 12:24 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> Your nack is for a different reason: GCC plugins are second-class
> citizens.  Fair enough...

MNo, I didn't NAK it. Quite the reverser.

I am ABSOLUTELY against rebuilding normal object files just because
gcc versions change. A compiler version change makes zero difference
for any normal object file.

But the gcc plugins are different. They very much _are_ tied to a
particular gcc version.

Now, they are tied to a particular gcc version because they are
horribly badly done, and bad technology, and I went off on a bit of a
rant about just how bad they are, but the point is that gcc plugins
depend on the exact gcc version in ways that normal object files do
_not_.

               Linus
