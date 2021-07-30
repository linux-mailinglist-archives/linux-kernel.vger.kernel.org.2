Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B533DC152
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 00:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbhG3Wzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 18:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbhG3Wzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 18:55:42 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FABCC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 15:55:36 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id u20so14604150ljo.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 15:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iC0yGwN0SCauoQARO5oAMRQDO1xQvSEhxunAqW4uFOo=;
        b=dBMt/cMy8XeMSlGs5RO6FOrRhZr1+6w9kDPZSpDyA4nXFaBjwAn63KjHF8hSt6FVaF
         riRMMcqQiV8IyXbvmfORSkDmzdad2cUxnA1jCf7ZuNYcXkIwWBYvrVXf78zlVwVKObfA
         7WLKWGjsgOqmsS0d3JIYGk1kxKcOJPKRexb/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iC0yGwN0SCauoQARO5oAMRQDO1xQvSEhxunAqW4uFOo=;
        b=DRp9jM4mxh8Pafj0MaYnyoWt31GkZTd4x7XCo0g6+GujzSsdzdzdOoFOZIF6sqqrOc
         ZFeZIbV/5K55mPHdtdgHaKjHEB4pdIQgT572LncaFMq8aEtaloTKCm8z8R7YZdlCijMl
         UUjBjLGKATC3Erz6isBBOXWdjIS6lwrz1pu06cNgiEbCtqrUcIIDzzBUrnN8/4I5QAMK
         Cpih8napPoW8bOVIJr7eyLXPHF0URHSU/5lUyrMvWHB68ano54lSr4W6Xg3MGV4n4EuV
         lE9spAgrFuK8GuzjJ7S8mmVhq0kQgSPjPFZGi2JvvUjY1ByuQ7ejQ+pzeqWkC3KZgRJI
         evwg==
X-Gm-Message-State: AOAM53114c2nurowhinRjnq4g4JzW5FRM1Ic5veYlsFwjlUot3lbUaY2
        8tzDy6iG3ay3PXlsayEbWN7nUCV/S+lC2XVER3o=
X-Google-Smtp-Source: ABdhPJxrQgRg9QxSV1YU/UqhTxzb1QgeXZB3u1M9JGV/KYwutjxiSawg6XJyyZc7rarwg7jE25wwWw==
X-Received: by 2002:a2e:7612:: with SMTP id r18mr3277328ljc.76.1627685734648;
        Fri, 30 Jul 2021 15:55:34 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id o8sm254141lfu.25.2021.07.30.15.55.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jul 2021 15:55:34 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id b21so14500194ljo.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 15:55:33 -0700 (PDT)
X-Received: by 2002:a2e:81c4:: with SMTP id s4mr3225543ljg.251.1627685733761;
 Fri, 30 Jul 2021 15:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210729222635.2937453-1-sspatil@android.com> <20210729222635.2937453-2-sspatil@android.com>
 <CAHk-=wh-DWvsFykwAy6uwyv24nasJ39d7SHT+15x+xEXBtSm_Q@mail.gmail.com>
 <cee514d6-8551-8838-6d61-098d04e226ca@android.com> <CAHk-=wjStQurUzSAPVajL6Rj=CaPuSSgwaMO=0FJzFvSD66ACw@mail.gmail.com>
 <CAHk-=wjrfasYJUaZ-rJmYt9xa=DqmJ5-sVRG7cJ2X8nNcSXp9g@mail.gmail.com>
In-Reply-To: <CAHk-=wjrfasYJUaZ-rJmYt9xa=DqmJ5-sVRG7cJ2X8nNcSXp9g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 30 Jul 2021 15:55:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgw7hh5+E6P2YYpHH51YNnkpro5tzSdXEmL9Xpk5Bh9Dg@mail.gmail.com>
Message-ID: <CAHk-=wgw7hh5+E6P2YYpHH51YNnkpro5tzSdXEmL9Xpk5Bh9Dg@mail.gmail.com>
Subject: Re: [PATCH 1/1] fs: pipe: wakeup readers everytime new data written
 is to pipe
To:     Sandeep Patil <sspatil@android.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable <stable@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 3:53 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I've pushed it out as commit 3a34b13a88ca ("pipe: make pipe writes
> always wake up readers"). Holler if you notice anything odd remaining.

.. and as I wrote that, I realized that I had forgotten to mark it for
stable even though that was the intent.

So stable team, please consider this the "that commit should probably
be added to your queue" notification,

             Linus
