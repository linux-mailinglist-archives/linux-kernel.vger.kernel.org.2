Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C376C30979A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 19:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbhA3Sp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 13:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhA3Sp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 13:45:26 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EE9C061573
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 10:44:45 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id v24so17158117lfr.7
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 10:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=89SdszQOEMr4HUN0UTxJxsMmAIYG9ucrs0ELQI8XVrk=;
        b=MptePmMJoBrEaKxom97tw/OO+Bnzv8iV/Ds3P010RVLy81iRtVxmpKXvsO4bKDFrqu
         Xk6uHhbukwFxQrxCat6b8MZ01rWyCyGT4/bBEI3Knjwa0TLln9ZUrZogAhDqxlQlgawR
         ciSDL7wDPtvGzSCWvl/LvwSvl7BPZyVr+M7DA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=89SdszQOEMr4HUN0UTxJxsMmAIYG9ucrs0ELQI8XVrk=;
        b=a59+kwVRYVsZpD4YvsZ2wsKPvuRUCmjz9pZE6Q5frWyOdfJAYjXFj8ixSfAaKi5b8O
         u0OQmeqHWLQ75GTMjtjDn/nH3C0EH+W7YMn1GbWk/fR+T3u9MG9l3g63NBBUlyAcMtmv
         Me0ozPcCg3TZ5IvV4zGJno6e83xpN3fpi2vU1BGX9biFTnC0IkcFDUQoVkTKUua8tKv/
         Fg5oK9i/ratqC/BKZWdCQ8V9yhqGdbNX8bEFCS56M4LyE3urPxNLuSzQtUXlntRhOssz
         QnUOmw/UCUblLWqepq5LH/tYpNcrxhn/k1U/EQaWNeqOeNuYVBJ80j+PNQwgtBoc8JQA
         AINA==
X-Gm-Message-State: AOAM532rHyqzXYo/CdpVxxxQuemdTkoquH4JRIG6qIg0tBGzA2c0+ara
        mdnNHvZoxI+p1cjKuKGrRa+jctiH8uJtiA==
X-Google-Smtp-Source: ABdhPJxlZ1uH1+ySDxTq7oorPFnRuG2tS+w1XWJP7J/GKkKTf2CYgIPa0SznbA+ALQ7Tq2ixOxtOHA==
X-Received: by 2002:a19:40d4:: with SMTP id n203mr5078843lfa.350.1612032282533;
        Sat, 30 Jan 2021 10:44:42 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id z11sm259721lfd.98.2021.01.30.10.44.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Jan 2021 10:44:41 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id v24so17158038lfr.7
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 10:44:41 -0800 (PST)
X-Received: by 2002:a05:6512:2287:: with SMTP id f7mr4728000lfu.40.1612032280785;
 Sat, 30 Jan 2021 10:44:40 -0800 (PST)
MIME-Version: 1.0
References: <YBNcv8jLEDE8C/IW@kernel.org> <CAHk-=wjk7zEOFEjGWZmGF8_dcitBQ_dPUMSkr-g7B7cYcXGvSQ@mail.gmail.com>
 <YBWUHkbNt6OLoeUq@kernel.org>
In-Reply-To: <YBWUHkbNt6OLoeUq@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 30 Jan 2021 10:44:24 -0800
X-Gmail-Original-Message-ID: <CAHk-=whCPotCrco-Q4hUfgoG3+6uNn_CprxbuV1mQtxJHm0gfg@mail.gmail.com>
Message-ID: <CAHk-=whCPotCrco-Q4hUfgoG3+6uNn_CprxbuV1mQtxJHm0gfg@mail.gmail.com>
Subject: Re: [GIT PULL] tpmdd updates for v5.12-rc1
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        James Morris James Morris <jmorris@namei.org>,
        David Howells <dhowells@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 30, 2021 at 9:15 AM Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> This was meant for 5.12 but the timing was *way* too early. I'll take this
> one back. Just to unambiguity reasons I'll use tpmdd-next-v5.12-rc1-v2 tag
> for my final v5.12 PR, once I send it.
>
> I considered a bit, and I really think that it would make a lot of sense
> to do a late 5.11 just containing the two commits from James

Ok. I'll ignore this pull request, and will expect the "real" ones later.

Thanks,

             Linus
