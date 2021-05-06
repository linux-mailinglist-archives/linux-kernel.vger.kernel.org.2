Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 040A13758BF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 18:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236150AbhEFQxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 12:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236123AbhEFQxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 12:53:45 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14F0C061763
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 09:52:45 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 124so8768863lff.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 09:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RWUyBsKmAFKnzuyTle8X+IqQwBw635MonpJL6f0XlXs=;
        b=Toi2dF2JP14eu4kDfyv/A1fcV9pf6T+Oy+B/5i1euIBOSEjCs0r1EEBYOP0PvA837S
         F3eZH0yldWBxMDKkApRB8/r4ihrk53nSarJ8P+bAJKHUUjAZxB6tuMnMXudJJCPPXAdJ
         ANsg5C6zlsR30xcTNcPKU1hbbeizg3CKUy4gI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RWUyBsKmAFKnzuyTle8X+IqQwBw635MonpJL6f0XlXs=;
        b=EbX+Apuq/nXxQNCqcIlapyb8sN0RGHJ7CC6QePOsxpqg2BaufQkmR5jC1owgEZsPgQ
         hfNEaiyps3kCpkSxV6koJDPXm/A7F0xK3Bw2bJak1xsFFv8JXucMiclsUs6BPH3lRsSw
         pJIshLYWP8+vXt8HY9+Uy0eVXsqRsajTVYtFGjau/kW+ROpdKqxvQabuZ7pf2fDneaiV
         BQ45W+gfXqipBCdAQrjuQH4WVMsa+qwjvrVZchBTze/MsdI4GwgCPocBxnkELU36RO7O
         A9sPG5mXo5eFBC7C+yfx98BzzPpFGWugIHDkhzURTv1rxZeRwmqsqvylNkjcLdRJMKOi
         vn3A==
X-Gm-Message-State: AOAM53213XlQxn50BQEvBLNDlIF4N+q1E3YP4CQl0XAGxZwSvhKlKQac
        qpywwDx816P4sY+gxeMO6RSzPB1LrbxGj+zRNS0=
X-Google-Smtp-Source: ABdhPJwV+KMzyyqkNAB4vqHmjI4n9qNzMkySywePgTV503k7CqkOn4Lv+7nlLHZMy/o33OeCVJ0vLw==
X-Received: by 2002:ac2:4c4b:: with SMTP id o11mr3595444lfk.173.1620319964089;
        Thu, 06 May 2021 09:52:44 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id m11sm1073825ljp.36.2021.05.06.09.52.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 May 2021 09:52:43 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id x20so8769999lfu.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 09:52:42 -0700 (PDT)
X-Received: by 2002:a05:6512:1095:: with SMTP id j21mr3512256lfg.40.1620319962710;
 Thu, 06 May 2021 09:52:42 -0700 (PDT)
MIME-Version: 1.0
References: <a81e116ba3d64aab8d379703bedcf032@codeaurora.org>
 <CAHk-=wgU-ERpeM0CJnN8JTVVUsBRtgpvU33sKke67V6pZj6A=g@mail.gmail.com> <81ecc015b1bd773f583cc86490e392a0@codeaurora.org>
In-Reply-To: <81ecc015b1bd773f583cc86490e392a0@codeaurora.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 6 May 2021 09:52:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiOp-Q0sFhmzGy2R=uMNV7Q26yqjeKNnwCnXgffnuDc9Q@mail.gmail.com>
Message-ID: <CAHk-=wiOp-Q0sFhmzGy2R=uMNV7Q26yqjeKNnwCnXgffnuDc9Q@mail.gmail.com>
Subject: Re: [GIT PULL] hexagon changes for v5.13
To:     Brian Cain <bcain@codeaurora.org>
Cc:     linux-hexagon <linux-hexagon@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        sidneym@codeaurora.org,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 6, 2021 at 9:17 AM <bcain@codeaurora.org> wrote:
>
> I apologize -- in my initial account setup I'd done the key creation
> without a signing feature/capability.  So in order to sign the tag I
> realized I needed a new subkey for signing.  I tried broadcasting the
> new key but perhaps I did not send it correctly.  I'll try it again
> today.
>
> http://keyserver.ubuntu.com/pks/lookup?search=bcain&fingerprint=on&op=index

Ok, that ubuntu keyserver worked for me now, and I can verify the tag. Thanks.

         Linus
