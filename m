Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E97A36EF25
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 19:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241050AbhD2Rv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 13:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbhD2Rv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 13:51:57 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC35BC06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 10:51:10 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id z13so25143266lft.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 10:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6As9QWB6Bh2AmK0gqxTfBNY3/GVKKNOfvjuvOCjRnsY=;
        b=CMBlR2cONsJRSVTzvsEhjwLrLl8X3/1UbmXgxMCZsoJVtJgmnPSAXsraEDcY8C0qhJ
         dF+0hqGhEuxcsoVcg63yfRv8tKMj+gxh5WAt8Ebm+NroA4rNJ0HxHMlPloS2ve88C9xH
         godFDieuF8yt8hRTWJ7DH02vPp+8OcauXV558=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6As9QWB6Bh2AmK0gqxTfBNY3/GVKKNOfvjuvOCjRnsY=;
        b=OCcKkwIPQ+kLUnUHpO26ZDVpzAUxlA1J/bjo5misgyMVPjLZ6gWzujxiAehZ624SXu
         J1PREkFm3qwCZsYbjPW100Dpd/Kvdi+8M6suSkoeGHeM0KZCBTrlIEty+RyUTkHTimvh
         XGFoyieWXWx45aVnSnaZCh7e1NJ3tVAoYfzN+4zX6gowwV5NsrXeSz/pGiOlWr8rIvoG
         AgnMzuzN6kpD2qDwZqxDpnkBkRLVZ3LuFHAuUTtq9ZPWWkd/8HksGVqXXTbRDTk5hRCc
         41GrRXkCsrTntMCu9Uyhbab2wHzZ0f6G92WNBCtIGf3mJSZTyolDJgWnaaRwROyIVI0r
         T0jw==
X-Gm-Message-State: AOAM530c58HeSf0n3uSgVGyBZHSJLxdGL4+JDLhql1iUNDHAONwFDcux
        cHGdZPUQCKwhmPuZn625rNIEKSZAp4+s0VwO
X-Google-Smtp-Source: ABdhPJxGIK4wADrzHtzE/m1ECQhdZ2sbK6G/ByfayUyMw4kf8Yrh1czYySX7M7wt7E8rGzPsM3X2NA==
X-Received: by 2002:ac2:57c8:: with SMTP id k8mr466416lfo.659.1619718668979;
        Thu, 29 Apr 2021 10:51:08 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id i15sm40906lfg.232.2021.04.29.10.51.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Apr 2021 10:51:07 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id 12so105827097lfq.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 10:51:07 -0700 (PDT)
X-Received: by 2002:ac2:5f92:: with SMTP id r18mr484354lfe.253.1619718667143;
 Thu, 29 Apr 2021 10:51:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210429170619.GM3122264@magnolia>
In-Reply-To: <20210429170619.GM3122264@magnolia>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Apr 2021 10:50:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgpn570yfA+EM5yZ0T-m0c5jnLcx3WGSu3xR8E4DGvCFg@mail.gmail.com>
Message-ID: <CAHk-=wgpn570yfA+EM5yZ0T-m0c5jnLcx3WGSu3xR8E4DGvCFg@mail.gmail.com>
Subject: Re: [GIT PULL] xfs: new code for 5.13
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 10:06 AM Darrick J. Wong <djwong@kernel.org> wrote:
>
> Unfortunately, some of our refactoring work collided with Miklos'
> patchset that refactors FS_IOC_[GS]ETFLAGS and FS_IOC_FS[GS]ETXATTR.

Ok, the resolution looked reasonably straightforward to me, and I
ended up with what looks like the same end result you did.

But I only did a visual inspection of our --cc diffs (you seem to use
--patience, which made my initial diff look different) and obviously
verified that it all builds cleanly, I didn't do any actual testing.

So please double-check that everything still looks good,

                 Linus
