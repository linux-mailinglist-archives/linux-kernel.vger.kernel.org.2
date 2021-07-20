Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0E713CF356
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 06:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241852AbhGTDuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 23:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242192AbhGTDuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 23:50:25 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0A4C061768
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 21:30:52 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id 109so7649457uar.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 21:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MNkK6dRLcnq07OlRkiuGoaq/j3YT8TX30B8mHnfH7IU=;
        b=kgyhBzJkSeA6bOB0iA3Gq3xBZRnmfJW4OdCrRLOtu1mQHXjIUUwAk3m0/2ZjDpyzT1
         Utt9+el96WcGbdle505BVX3JHO0Yj6U22WHHRSgTPz98n6KLaO0qdsAQbS+ZNhFttzo0
         GbTBB2jyBm2HM41UK7+pdBYwV/F5k6RA7CaL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MNkK6dRLcnq07OlRkiuGoaq/j3YT8TX30B8mHnfH7IU=;
        b=ISSKctebJVcbGXew4JAE55qU7hG5KcOEgg/9xwpn2rYOIV4tt8VB95mfLqR2dat88I
         9xGYw9kyUnuoIM3zcjS8jq7CAOP/ufT1n3u9r3EO3zfLtUPyQiS3k0r0F5F/3zENbzE/
         u98XixNqx+9C1sZ0+pBpW1SidHHtba6QbE3MJmYX3fQaHErSF9ZEPWcxLxXCodhjWKX4
         ycP/5aU1AY1GJk02swqoPAq1d/AUhFc2/RE7c+MuGEWHx+BjnpnY8ngFFUsmE/YcDvLF
         gH465k0SYKDBGCh5TLSdF7BEji9wd8a+2i9ktVbkRPHBHnmbvjVFxlTpWcTdXABZa8eF
         k4Og==
X-Gm-Message-State: AOAM533ukTs+w4Mrb0yz4Se3691FDHAwjvpGxzZqn+Zdnazi5DLewGmO
        rcGazjSEPx+vuXut8HZyciBcqG7IZCq35GP4PZJHePCVBAo3xw==
X-Google-Smtp-Source: ABdhPJx8ZPLMRe3p1Y6wZoF01TMyFtxC9BT9V1MeKGxozlthoHSXxFtIuVpI4A115CKyPuX052vtv2n4LJyOpp+2M9o=
X-Received: by 2002:ab0:2690:: with SMTP id t16mr29157373uao.9.1626755451926;
 Mon, 19 Jul 2021 21:30:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210720090415.279cbb19@canb.auug.org.au>
In-Reply-To: <20210720090415.279cbb19@canb.auug.org.au>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 20 Jul 2021 06:30:41 +0200
Message-ID: <CAJfpegsD9DNE0z_VHekjhhpECKM_tZcFKSLJSBKij1ZSbQeRNg@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commits in the overlayfs tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jul 2021 at 01:04, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Commits
>
>   3132b5adad49 ("ovl: pass ovl_fs to ovl_check_setxattr()")
>   d1e717e0032c ("fs: add generic helper for filling statx attribute flags")
>
> are missing a Signed-off-by from their committer.

Thanks, fixed.

Miklos
