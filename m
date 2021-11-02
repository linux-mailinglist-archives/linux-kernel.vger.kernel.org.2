Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72BAB442661
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 05:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbhKBEZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 00:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbhKBEZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 00:25:47 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA157C061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 21:23:12 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id h11so32800696ljk.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 21:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hOI6QRrV5zRFm8op/6Gd1rEX3NwOtN92NhH17jVxu8Q=;
        b=h2hpRrDEtL2p/0jKnOT1ONm13DydLtzTwK16ZAknZGkNhW/tlObp6XIQd0rp6I341A
         udIAa9pOsmlDUrXTMYgQUcl7ZnA8e0LTW5Af4pzSEIriRhrOdTUbOSj46aJLK2hVIQJz
         gI+p6bpFk2SL46CZy+5Qhjmn1YVMC8AVmA9+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hOI6QRrV5zRFm8op/6Gd1rEX3NwOtN92NhH17jVxu8Q=;
        b=mJ2NbcT3Mq3DijxMv14UXkojmP4hVINDMtngtlRGe5IYwtAmvkJW2BT/i/hDss14D2
         3v1QGRWuJA6225tx/KO9DkQbSAV5BUBxWhVQJ45+K96SUVX1bsntSsQwuL7pi5UWwZRN
         ra5J9Hk3wQMAwGCRs2D0/fZB2fGIK7qlTCmZ5Q+n14e3y7B3Td7g2lkORJrQE5qw1g8x
         d6mzy7hNf4li4EHLSZkel4h8P4KiNegeY8uSKf7pwZkazrTYs12K+j3u3qgFA+m6No0a
         YgS5rs31fbg5m/w1tOn7flecYjpl8XgY0BUONRfGtcm2Ps54D0wBCBQlmHm5iZWFeKu3
         9/SA==
X-Gm-Message-State: AOAM530QkS64IGUfljEum9Ti9GleAijt10ceBZKzqfs6gDnmgv/SezdK
        tjS0L96RmS+xVroEluAQJXUAMN7FdeqmvfPi
X-Google-Smtp-Source: ABdhPJx93Hbpe98UvAVEhA1ycNJHMTPPreZ0AcDRIQQx0YrmrDNtvHily3MyB+sT6ILZRNUcgF+imw==
X-Received: by 2002:a2e:810c:: with SMTP id d12mr18978608ljg.398.1635826990381;
        Mon, 01 Nov 2021 21:23:10 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id v14sm145952lfr.176.2021.11.01.21.23.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 21:23:10 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id l13so40381562lfg.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 21:23:09 -0700 (PDT)
X-Received: by 2002:a05:6512:10c3:: with SMTP id k3mr32858764lfg.150.1635826989429;
 Mon, 01 Nov 2021 21:23:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhRJ=fHzMHM6tt8JqkZa4bf0h72CAytSX9YrEs14Oaj8SA@mail.gmail.com>
 <CAHk-=wj2LqbZ3xSLKfnR42y7ZEgqw8K42-mE+nsHwsoFiNNpKw@mail.gmail.com>
 <CAHC9VhS3LfGvuVyXW5ePTQNtQ0KeQ7vz3wLinoZrbGVjU6GuoQ@mail.gmail.com> <CAHk-=whvZRaJSXirjcWKn75H-2H1tc54cru8p-vXE_2UyuvGNQ@mail.gmail.com>
In-Reply-To: <CAHk-=whvZRaJSXirjcWKn75H-2H1tc54cru8p-vXE_2UyuvGNQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 1 Nov 2021 21:22:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj0fNVO9tfEmWTcW7i+HoN4K4PejZ44sQYCEfL1S3UPWA@mail.gmail.com>
Message-ID: <CAHk-=wj0fNVO9tfEmWTcW7i+HoN4K4PejZ44sQYCEfL1S3UPWA@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux patches for v5.16
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 1, 2021 at 8:55 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> This follow-up was sufficient. In fact, the original should have been
> sufficient for me.

... and as you saw from the pr-tracker-bot, it's all merged now.

Sorry for missing that part of your original pull request.

            Linus
