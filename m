Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B63D332439A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 19:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234565AbhBXSL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 13:11:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234502AbhBXSL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 13:11:28 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D25C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 10:10:48 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id j19so4390111lfr.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 10:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T18j6faUKgGfUyzDSnahU+MQ0EeCWnejsT6SUVEgYQM=;
        b=XnL74fIb2y442Lkvpqj1K22yiFeODco8tGcnKRQwBtCwyFvHqcQZBuSInsFfIUNBdv
         654ZiYf4Qc/OEcDKemaLNntKLquuUcAUskAlErz/90JFJaP2Wx+RGhtZEVCDWBCpsn4T
         cBodHyKHJGLsfEtTnra1Lp+quNIHnRQmXiXjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T18j6faUKgGfUyzDSnahU+MQ0EeCWnejsT6SUVEgYQM=;
        b=LO7lnZx6kqSfp+FMyUvK3IzhMLYRkKiwhGmGLkkGmS0Id9sMlUfVD1XZuzWqHwTa1X
         RHOi9H1mrb5lRKu3aXUbZ0pf5kGbBuW17Smur6FcK8U4mfG46YlUe/odLk8qeys6acmK
         6FbOaVXrnymP+WKZi4SZuLsq1A5xfmJYk22avqlWxc1AbtIKC/d3TWQ30/7rPmxV9p1Y
         zcuKe3OMwh7mYBK3NjFDHhoFzHeH8/ezqoKhk99k/ZDWKJHAQNfCjw0R8mIhZ5dIbUjC
         HAEJDqMOhGvB/LfHwU0RumLXim4TBzIMTURmL9qbeaGFn8mZ4ANkhBlldytk9OFT5C2T
         4oLA==
X-Gm-Message-State: AOAM5322JaoRle8+EIl9c+xWOMqOHWgknstvB1DJB83bEynGVaRDpOjY
        uDuWsR/gEnLqU8qIyqMtSKoazDxB9eYjZA==
X-Google-Smtp-Source: ABdhPJw3shVcaMwZN8338K2tRpgEjfFvffvrXbXWc7rwGs6WAZJsV2ZS7do0h0Y2f4NxamiCD4M7Og==
X-Received: by 2002:a19:4c08:: with SMTP id z8mr2064098lfa.157.1614190246646;
        Wed, 24 Feb 2021 10:10:46 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id n8sm626636lfe.276.2021.02.24.10.10.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Feb 2021 10:10:45 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id p21so4405373lfu.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 10:10:45 -0800 (PST)
X-Received: by 2002:a05:6512:2287:: with SMTP id f7mr19230530lfu.40.1614190245360;
 Wed, 24 Feb 2021 10:10:45 -0800 (PST)
MIME-Version: 1.0
References: <cover.1614090658.git.dsterba@suse.com> <CAHk-=wijdojzo56FzYqE5TOYw2Vws7ik3LEMGj9SPQaJJ+Z73Q@mail.gmail.com>
 <20210223192506.GY3014244@iweiny-DESK2.sc.intel.com> <20210224123049.GX1993@twin.jikos.cz>
 <20210224175912.GA3014244@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20210224175912.GA3014244@iweiny-DESK2.sc.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 24 Feb 2021 10:10:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiJ9KnCn14TXQdxS6OjxqX_ZoGuezNLrTDYCE0ACQb2Fw@mail.gmail.com>
Message-ID: <CAHk-=wiJ9KnCn14TXQdxS6OjxqX_ZoGuezNLrTDYCE0ACQb2Fw@mail.gmail.com>
Subject: Re: [GIT PULL] Kmap conversions for 5.12
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     David Sterba <dsterba@suse.cz>, David Sterba <dsterba@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 9:59 AM Ira Weiny <ira.weiny@intel.com> wrote:
>
> To be clear I'd like to just drop the 2 patches which use zero_user() for this
> merge window.
>
> Is ok to just drop them and merge the rest of this series in 5.12?

Ack, that sounds like the best way forward.

          Linus
