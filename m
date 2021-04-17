Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBB7363212
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 21:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236994AbhDQTwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 15:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236718AbhDQTwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 15:52:07 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B96C061574
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 12:51:39 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id y4so9772525lfl.10
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 12:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V9GAEUssANBfKD15rSozAJHNG7J93nIDtHCydhPvEyg=;
        b=Bg7f0TZ9VMkODVodUxo6nOYaLPNAtK3zo+8R5f4drYQz4zXcV5xMh95M/iaSrGrgUl
         ZQoW0aZRgSG/dI0D896jjYc5BzE9mebQvnUfvzEIIjN66tZ7KMqZeyvGYfU/aoSkEzHj
         Kw2aAnXTdbTXACWkyPkvRbmvBcrIzVsjGat5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V9GAEUssANBfKD15rSozAJHNG7J93nIDtHCydhPvEyg=;
        b=a18MOlWvdKwS4PNeMOoRXx1qG4/+E+iTaGOeC1YjeQo5jBvzzZ1W7QZVQS43yo3Xv1
         Ph3TwLcXg8z1W2BzC0tW0c3xjlkC2yOrcJVacLSUqdEeTDvhWTR8wy/DTzHBS+rVZr0+
         B3oflNi+suf+I3EV1PM08rX7gNE7H7VlAZ9q2xuAl4vmuApR5+xTexkwbEmp6HFw3p7u
         joh5jS5LpvnLlsX2/j2G47fDdnXXaBJFrzTjg0FIya5YFBP1p0scCvpVgXRaisNiWu0b
         dYQ5zz1o5bNsYTymH2p+vq0Dwkdp0xUi+zAPPlJzt3nyEWrQyq4Mrk1Q7ce9qyHCdjTY
         jMGw==
X-Gm-Message-State: AOAM532C83GcLz/XkQd6PH9WGbyxOP/gW+VFi0ZrCpF5rSdgUEvKPoQy
        njgHmydsgYSIWaaMvjLA0xJOHNMfP87+ls99
X-Google-Smtp-Source: ABdhPJxlnDQsGdwxwqRpDJKVMUjn/P43Y9JTH6WFEJkaY8WDTL8p4gWoHBbcfYicrxP1MtLeoLC4BQ==
X-Received: by 2002:a19:e20a:: with SMTP id z10mr6974192lfg.391.1618689097573;
        Sat, 17 Apr 2021 12:51:37 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id c2sm1358588lfi.143.2021.04.17.12.51.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Apr 2021 12:51:37 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id l22so27477508ljc.9
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 12:51:37 -0700 (PDT)
X-Received: by 2002:a05:651c:3c1:: with SMTP id f1mr6240560ljp.507.1618689096862;
 Sat, 17 Apr 2021 12:51:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210416192413.1514419-1-eric.dumazet@gmail.com>
 <CAHk-=wjbvzCAhAtvG0d81W5o0-KT5PPTHhfJ5ieDFq+bGtgOYg@mail.gmail.com> <CANn89iK0Win0m5ggB-EjFvVwmpkyg_nG9FW9uzREmrpoeTF_aw@mail.gmail.com>
In-Reply-To: <CANn89iK0Win0m5ggB-EjFvVwmpkyg_nG9FW9uzREmrpoeTF_aw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 17 Apr 2021 12:51:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wijrfU0BN7L5Go1PDZ1NQRgDGnW57EeMXw_qqowMGJZAA@mail.gmail.com>
Message-ID: <CAHk-=wijrfU0BN7L5Go1PDZ1NQRgDGnW57EeMXw_qqowMGJZAA@mail.gmail.com>
Subject: Re: [PATCH] x86/uaccess: small optimization in unsafe_copy_to_user()
To:     Eric Dumazet <edumazet@google.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2021 at 12:44 PM Eric Dumazet <edumazet@google.com> wrote:
>
> I thought put_cmsg() callers were from the kernel, with no possibility
> for user to abuse this interface trying to push GB of data.

My point is that "I thought" is not good enough for the unsafe interfaces.

It needs to be "I can see that the arguments are properly verified".

That is literally why they are called "unsafe". You need to make the
uses obviously safe. Because the functions themselves don't do that.

            Linus
