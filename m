Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3C5376D83
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 01:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhEGX4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 19:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbhEGX4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 19:56:12 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6575C061761
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 16:55:11 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id t11so14977164lfl.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 16:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RDWJpUYmPPrkWqh/DpQreXEAXgVxI78KHgUhVmuROJY=;
        b=bAm5Ql5fOqSQmXEpAgHiRH580ICA55MB2VHmk9uSnuKh6sX3gBT0sxUiLe9tugQXHV
         xPuYrutsGdw9bMxPVweU6xAja+iWUIg18TiZQ9aNH2cXIRNK5mUdJFglXjh+B+seedSf
         Av/0nlLTEWl9quCHTc+aDXWuD10MgloAMF+aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RDWJpUYmPPrkWqh/DpQreXEAXgVxI78KHgUhVmuROJY=;
        b=p1/qfR/u4fAO3sd7ep8kBbJ+LiClNkHKsbMEVM9YTlO4kaoM1cNzem51MgDWl75XBe
         BkC4sxVPZHeP4y99enClO6sUe4SR/1wqIZTZxKnLZ/vxHVB6SYg0DAU5lzS7uGTNDpvx
         b8qIsdW4/40nTNpjB39g4XuTBueQCrQVSRDNbPE1sr29OxB7qM5jM5x/dnATzHhTlabb
         uvipNF336DCzrb6W/OBl2JgZS0OmlhPnh1G4C2tqFBvKWDdvzfQ4nJJoddtqWXTec6up
         J5ml9IAC1CUWjpkumk99ZVyNtE/QD7QmDwlIxUONeaZAXxMlWTlGqCxg6kKFKYG1mdze
         upzA==
X-Gm-Message-State: AOAM533kl1JPXUJqUt7cHwIHJ+bbbx9XD+B5qLJV4Oepu/Pbd9tc3yrS
        qSlrVMnFAJQ5rGGsXkl6S+6liYzq02DHeOXjBzA=
X-Google-Smtp-Source: ABdhPJxU6Zn9XBmFSURTCQQrExulzWCoakgg9cusUaUrr7gaK3flLsaIN+NrE0+87bjkrNVFegDCIw==
X-Received: by 2002:a05:6512:1318:: with SMTP id x24mr7852743lfu.376.1620431709877;
        Fri, 07 May 2021 16:55:09 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id v6sm1490432lft.167.2021.05.07.16.55.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 May 2021 16:55:09 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id n138so15043097lfa.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 16:55:09 -0700 (PDT)
X-Received: by 2002:ac2:5e6e:: with SMTP id a14mr7887858lfr.201.1620431708918;
 Fri, 07 May 2021 16:55:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210507220813.365382-1-arnd@kernel.org> <20210507220813.365382-13-arnd@kernel.org>
In-Reply-To: <20210507220813.365382-13-arnd@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 7 May 2021 16:54:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiqLPZbiWFZ3rDNCY0fm=dFR3SSDONvrVNVbkOQmQS1vw@mail.gmail.com>
Message-ID: <CAHk-=wiqLPZbiWFZ3rDNCY0fm=dFR3SSDONvrVNVbkOQmQS1vw@mail.gmail.com>
Subject: Re: [RFC 12/12] asm-generic: simplify asm/unaligned.h
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 7, 2021 at 3:12 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The get_unaligned()/put_unaligned() implementations are much more complex
> than necessary, now that all architectures use the same code.

Thanks for doing this, it looks good to me.

I suspect it's still slightly unnecessarily complicated - why is that
get_unaligned() not just

  #define get_unaligned(ptr) \
        __get_unaligned_t(typeof(*__ptr), __ptr)

Because I'm not seeing the reason for doing that "__auto_type __ptr"
thing - the argument to a "typeof()" isn't actually evaluated.

Maybe I'm just nit-picking, this certainly is a huge improvement regardless.

             Linus
