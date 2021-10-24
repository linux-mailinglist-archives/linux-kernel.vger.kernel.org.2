Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06074438C2A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 23:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbhJXVrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 17:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhJXVrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 17:47:05 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50494C061745
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 14:44:44 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id x27so4853716lfu.5
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 14:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ryZxhawk/h0qs5tZCgKZdBuPuqyJ9WVtt/N+HNRxYbA=;
        b=PF+HxDOj4jRbUbIGGsXBJZMvVI+QzbTEkrtSOQMPI0iSaDkNYRRxzaRa4FWHkKCyNF
         rCSHzX0BxdnvWjWd4/u+8txDSnF5F1QFS4qkLxQQalw5oUjDghgF33VXUMIVxqIBNMlC
         EYOtYfn61QIaTQ5PiEeaacaBh24Zg1OJ4G/4gR2X2mwB/GfOd4LvJEaXkZ654T0kaydL
         2sc2upn6JN8Hw6zm4l/vnMl/rCXDM1PvVwswL7lK4C5HVmdExpUq1swPKmITRYLDSYcj
         JyFNuLF//kSYlTHMH4wHRCCltwCDxWrk5rQWIcVKMFP3WJwEftwD18DzxKGIIXPj7smi
         5tKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ryZxhawk/h0qs5tZCgKZdBuPuqyJ9WVtt/N+HNRxYbA=;
        b=N0/PQuVsB70dppIbXr7DhHiq+mfzdlPxbSAVWMUwQkkKhpWVbHdUC8oH1WVdrwGhDH
         fXR5Q3LLzCvxx12W5v8jfwR2lgLeoDRCOM2AsVRkuucXTRQaNPZLWi6KELn0VYwQUhNy
         8NUGxtrRtEK2s+HrPQbWF1TT1rTE/gKdUoswQs4z1ehXKRKwhBLQZ6ydOl7lvdOVS9q5
         PUa/1CSU+su9revzd5uQTcF3Rt8MlN28llgTMCr9nOI29RFdAM1V/e3cDyrtSN50KwjL
         qfOCVagfbgkOhq/yLV0OLeLq3kEaHR6mD6pvfUldd2Dx/dcuKBFw8PrfumXtCZMyTil7
         7vfg==
X-Gm-Message-State: AOAM533L5Tjxg2Y3MpuPBO5EaT6wSbK2Z70gtxFltY66yJhOUdzXDGe6
        4BjZukBeCdimlme0zpomsJqM7kYe0bx2RjZWGacGp1F525Q=
X-Google-Smtp-Source: ABdhPJzxS/Jx9/bwtKL8TjRwj8l7pISvcOLBGz+ZDFrS64NPPcx8Vfbl3oixbwjKI0eBCKqnUC8ehozS0FsuUlPdGH4=
X-Received: by 2002:ac2:430d:: with SMTP id l13mr6615116lfh.656.1635111882492;
 Sun, 24 Oct 2021 14:44:42 -0700 (PDT)
MIME-Version: 1.0
References: <20211020054942.1608637-1-quanyang.wang@windriver.com>
In-Reply-To: <20211020054942.1608637-1-quanyang.wang@windriver.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 24 Oct 2021 23:44:31 +0200
Message-ID: <CACRpkdYxMDp4FRGP=EOt8oTMxs_YuskbvMx5wXBDjUWz6hD=gQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: add BUILD_BUG_ON to check if fixmap range spans
 multiple pmds
To:     quanyang.wang@windriver.com
Cc:     Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 7:50 AM <quanyang.wang@windriver.com> wrote:

> From: Quanyang Wang <quanyang.wang@windriver.com>
>
> Not only the early fixmap range, but also the fixmap range should be
> checked if it spans multiple pmds. When enabling CONFIG_DEBUG_HIGHMEM,
> some systems which contain up to 16 CPUs will crash.
>
> Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>

Looks reasonable to me.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Please submit this patch into Russell's patch tracker.

Yours,
Linus Walleij
