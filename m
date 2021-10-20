Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B94434F95
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 18:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbhJTQFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 12:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhJTQE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 12:04:57 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04802C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 09:02:43 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id y26so15998749lfa.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 09:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eG3bUu5SIJmKxKQp2DNznEXHCaWQks+FETb1kl7uqiE=;
        b=bQ+2m/CFkc8KcTe0fPRcwqHly1KPXKijiAy3rnFSrpdKXys9wqap05TJLJ0NgmPsLY
         d8PsvECpM2pweejvt+aeISLt/drefksFM/ld1aDUMJzytisD3J8nN+PYW0bOGO5cpMbM
         0pKA3gTke/qVfL7+icIR9dxHYt1XqnOjcD7Eo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eG3bUu5SIJmKxKQp2DNznEXHCaWQks+FETb1kl7uqiE=;
        b=y7t2C/a7wu71Qe5d+K4Cqq60N/OMi0/D4Ba9ruWfAV/axO3ZO9ImzUmAN7J699ohxx
         P+KXPRVZt+9GAl1dCCLqDVBvFb+tTagYfhq4iWcasneX7/+543eTtgqaeGFoY1S6j9KX
         tVPEvD2wKVouwiQOuOmFkYrkBzZ1zjQ6RlP4z6Hs6tb4KUvtRFjYGdJMPHt3jXtx7TGk
         iuTIhzFPVLwO8YGNkEKbWVQoElvN6ktefuQFygBMIfclM2zwbDIck3DeFByVDQPsliqW
         I+dNCXGbFeAwQ0y3fcx+IAboD0mQLv1zHdY5pl8ZB6pHD0/s+Jbf6CuJypK/FyVpRQ7u
         2v1Q==
X-Gm-Message-State: AOAM5304JyaDLeaV+LYFHpyuzPR2IN7aXunlhUItMFLsFc9gIK0KxCVv
        HbGEDcMSkDXbhvZ99cxrZBZ69O+e8lOWdg==
X-Google-Smtp-Source: ABdhPJxbZwUuReiPu77T33KGrRIvW1YtGoRtM47A/hcCiWfvDKV99/N8265r8PGg6Gq8vKs1esAaww==
X-Received: by 2002:a05:6512:3055:: with SMTP id b21mr164635lfb.316.1634745760874;
        Wed, 20 Oct 2021 09:02:40 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id p23sm221150lfd.127.2021.10.20.09.02.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 09:02:39 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id y26so15998549lfa.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 09:02:39 -0700 (PDT)
X-Received: by 2002:a05:6512:13a5:: with SMTP id p37mr150809lfa.474.1634745759327;
 Wed, 20 Oct 2021 09:02:39 -0700 (PDT)
MIME-Version: 1.0
References: <20211018195945.2462739-1-dinguyen@kernel.org>
In-Reply-To: <20211018195945.2462739-1-dinguyen@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 20 Oct 2021 06:02:23 -1000
X-Gmail-Original-Message-ID: <CAHk-=wj=eUah6C8Zj4z2OzbFGn0Oxtg9cqvYs1kD-=qPj0dYBw@mail.gmail.com>
Message-ID: <CAHk-=wj=eUah6C8Zj4z2OzbFGn0Oxtg9cqvYs1kD-=qPj0dYBw@mail.gmail.com>
Subject: Re: [GIT PULL] NIOS2: fix for v5.15, part 2
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 9:59 AM Dinh Nguyen <dinguyen@kernel.org> wrote:
>
> - Renamed CTL_STATUS to CTL_FSTATUS to fix a redefined warning

Hmm. That's still some very generic names exposed in a arch header
file that seems to get included (indirectly) almost everywhere.

I've pulled this, but I would suggest you name those flags not "CTL"
but something that is more exclusive to nios2.

Btw, the same goes for some of the other macros in there that are
currently unique - like "RDCTL". That's a name that I can see a driver
using internally, and with nios2 being so unusual, it would take
potentially a longish time before anybody even noticed.

            Linus
