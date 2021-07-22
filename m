Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F433D2B11
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 19:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbhGVQpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 12:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhGVQpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 12:45:32 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A85BC061757
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 10:26:06 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id t20so8332468ljd.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 10:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fuOs6XPM+Q3/Q5FSz5nCr0Y7zobhha2fUoijl6Bu2BA=;
        b=KFfv4h+yMAYsYLHv2rATQrjCbiBMCJfoJq06Mxs5adn4YXCUe5Em+QXV2L39tUNSrB
         U347JBxT1yLJyFZ42neWsvHQuPeAHuKxSytJ0HXTxmSrn4JEyYp7NMI2Qe8Div/6cou3
         HeWdJgKNMLJ+OM2KBu7XYNy40nFYwWFlqVmPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fuOs6XPM+Q3/Q5FSz5nCr0Y7zobhha2fUoijl6Bu2BA=;
        b=OXA6bOfxG4/bktdtuTPI+0lGWyohVYRol3tlypka/0I+jymzdxv0iF9x0fu8imADHQ
         R3JYxzSlyQih8nWtHuAVinnpH4enpAkS3FSgZmsjr6HXTb1bk183oVEOoJaZYu5P1x6M
         tDIIp5y3qV2E6fQh+ZWH1C9c3hZcOe3zcI5hn60ppgBx2V+xAViS0tOR/FmtRgjW8/Wa
         b6eI0jrigsVLKF/2VNV2OBmvJ7KewX0ttRTJUDFfqHUL+wJOFG9juCjZf6v1Esu6aAlI
         1m1/mYy+bqYpYdYN7CLtkJmnbaDJx4oXu3I50EayR/G6hycMnqS7LraWCOsIA9IVZt3W
         drRA==
X-Gm-Message-State: AOAM531MuwdxFKEyNRnEMzBSPt4cYWYa9OvjrI/z0ar2o3yaWRBVZqvV
        bsGhib4pQxpAuYQ1vFi8lhOgprxWG/ic41+DMWA=
X-Google-Smtp-Source: ABdhPJw1NtJNOqrVb1j7HgR/GAP8hmsGsLuolH+6CY+yfsMXJ9mPhYXmWKlk3b100o2XfxEBdEyIMA==
X-Received: by 2002:a2e:a164:: with SMTP id u4mr703036ljl.121.1626974763010;
        Thu, 22 Jul 2021 10:26:03 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id bp40sm1978236lfb.221.2021.07.22.10.26.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jul 2021 10:26:02 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id a12so9653696lfb.7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 10:26:02 -0700 (PDT)
X-Received: by 2002:a05:6512:2388:: with SMTP id c8mr330523lfv.201.1626974761892;
 Thu, 22 Jul 2021 10:26:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210722140949.3knhduxozzaido2r@liuwe-devbox-debian-v2>
In-Reply-To: <20210722140949.3knhduxozzaido2r@liuwe-devbox-debian-v2>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 22 Jul 2021 10:25:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wirFvNqAvaNaABHc2mi7FKL4n6TEAwQ3WTyTJueJcHCvA@mail.gmail.com>
Message-ID: <CAHk-=wirFvNqAvaNaABHc2mi7FKL4n6TEAwQ3WTyTJueJcHCvA@mail.gmail.com>
Subject: Re: [GIT PULL] Hyper-V fixes for 5.14-rc3
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        kys@microsoft.com, Stephen Hemminger <sthemmin@microsoft.com>,
        haiyangz@microsoft.com, decui@microsoft.com,
        Michael Kelley <mikelley@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2021 at 7:09 AM Wei Liu <wei.liu@kernel.org> wrote:
>
>   - Reversion of a bogus patch that went into 5.14-rc1

When doing a revert, please explain it.

Yes, they are simple in the sense that they just undo something, but
at the same time, that "something" was done for a reason, and the
reason why that original change was wrong, and how it was noticed (ie
what the symptoms of the reverted patch were) is important.

I've pulled this, so it's too late now, but please please please
explain reverts in the future, not just a "This reverts commit XYZ".

                     Linus
