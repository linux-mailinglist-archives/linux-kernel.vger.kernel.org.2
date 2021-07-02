Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3163B9A0C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 02:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234481AbhGBA2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 20:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234469AbhGBA2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 20:28:50 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFAEDC061764
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 17:26:18 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id k8so10945748lja.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 17:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4ojivLqIxhJFrg2mkQVdvq8a38GP5yVcK9noWQjWXjQ=;
        b=Gop1h/wC4k56lKH6v1PD4hX8fLfZIhG0emVypz0FX1ztp1MRpep9OiBfP/xoy8jwSL
         lMtYD7BdrUyrOBX7z2ZKXQRrJbheI/TgmVnT3A6NBpVzDnAYUMEC2D/UE+ySyLKwbIuw
         I7HKssIjEStPfibkfy0Zr8vq1CNcrB3092+I4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ojivLqIxhJFrg2mkQVdvq8a38GP5yVcK9noWQjWXjQ=;
        b=BZLwwAgyGOGXGCUT8UDB8HaBDp0PXTCqcLWE217nX/2/nOS5rLiHjRNmGx/Wc/I7Dk
         i5DSSdo5HF37jeW6BwmbKQNZ3XZcpWXZyg4lyTRf0uYkbwawbU5H8KcwLb3oNaRlcSpN
         I7YMh504W+k6ZeCBQQRpew3F/453nAkKUMjD/0Ma3iJ2lHPfo/ABoq9fHnkaP6t78nap
         MmZQ2GZ+WTi6zQFBj7PcLND9PWFfEKmZggQi7I8AAXf9s1oMJ8iLGxSG5PLtuC+sA5aX
         dWeC5JHocNyYm9NHZeor+dXahUk1BFBx50dbZ2UsfVHFAU8TwibsW4x6LgrVcR8y/Tf2
         Vi1w==
X-Gm-Message-State: AOAM530DAcRV6hiJFClQcAE3HzH8LGJbuPzwQmW4zlub+8Pk5ExQs1yf
        DuTbzwVtqs+TdVoXumRYiGaFWnYWei6iKAxpUy8=
X-Google-Smtp-Source: ABdhPJxcjsxR5g/4TxyCdTH0u+/x0hJiyARa7f7D4BT1krrrQVDs8CO9F3yAB9EDhizSbx1Iy7TkPA==
X-Received: by 2002:a05:651c:b0d:: with SMTP id b13mr1621137ljr.481.1625185576815;
        Thu, 01 Jul 2021 17:26:16 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id i5sm171843ljm.120.2021.07.01.17.26.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jul 2021 17:26:16 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id u20so10890812ljo.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 17:26:16 -0700 (PDT)
X-Received: by 2002:a2e:b553:: with SMTP id a19mr1574210ljn.507.1625185575823;
 Thu, 01 Jul 2021 17:26:15 -0700 (PDT)
MIME-Version: 1.0
References: <YN4rzCdUR+/2LgaP@mtj.duckdns.org>
In-Reply-To: <YN4rzCdUR+/2LgaP@mtj.duckdns.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 1 Jul 2021 17:25:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgcyjLGcoRho5iw7b3Yx+R05rXwyJmP_LhOqsHgjiZugQ@mail.gmail.com>
Message-ID: <CAHk-=wgcyjLGcoRho5iw7b3Yx+R05rXwyJmP_LhOqsHgjiZugQ@mail.gmail.com>
Subject: Re: [GIT PULL] cgroup changes for v5.14-rc1
To:     Tejun Heo <tj@kernel.org>
Cc:     Cgroups <cgroups@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 1, 2021 at 1:55 PM Tejun Heo <tj@kernel.org> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.14

I've pulled it, but let me vent about this history a bit.

Look at commit c2a11971549b ("Merge branch 'for-5.13-fixes' into for-5.14").

Now tell me how that commit explains why it exists.

Merge commits need commit messages too.

In particular, they need commit messages that *explain* why they exist
in the first place, not just a one-liner that says what it does (and
does so badly at that).

                    Linus
