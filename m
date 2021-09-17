Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9E3040FDC4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 18:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234774AbhIQQVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 12:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbhIQQVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 12:21:31 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B82CC061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 09:20:08 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id z24so8919550lfu.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 09:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S+26Vsol/pLE3N2ZCeBR7S3rv3GmRM47x0Lj5a/+Z+4=;
        b=ZOrBVNAXGkcl3SRetFlgOpBW8k57TEz1htELHRMsY3cQ4RgsIlPi57MdJP4t8Bpliw
         qOFJAjljj8r3mmZf0xIyJ3eXTd8lf6Kkp5SQrpaKeABXfjdaX3xwJvEGmeTJdXVedy6A
         9RjIw/HW+4xZ2xVsHaC7TnLhx9T3X3VhIgKmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S+26Vsol/pLE3N2ZCeBR7S3rv3GmRM47x0Lj5a/+Z+4=;
        b=eW/7UG0+YRIGn8VeAa0tqXaVmLi0ayauoYODQm4k8k4R/GoxqkywUBmJpW4OVFFOC0
         ufeVcp4JwX7rz0/vX0n0nijELh8AWqJXILt96/4EGMeMb9o87FAiBHB+LmM2EXxu8+xd
         T8nFtOYMw7tSVDBNOtSP5iCYxLwJnGmG9YmxyDAd0KnOkQK5EbJJGBAihsvgG3f5pRYQ
         hxZIOCSNp0Tg7tP3lhXXgJIEmquqWSv2EHNMh6UkHrFf428fakB8r5lja2JoVSoMKa5o
         2bZd+pyRrUolmwj4+6Buy8B8klRoAbehj11XFENKvzmEq3OzAazlGCpOCunhbpAHUjpM
         TZWA==
X-Gm-Message-State: AOAM531gaVzAEZvGvzGZLtP/6GcULWNHCJslHPlFeIDlGm2X53v6Dr0n
        dM0haJdz0rlCnm4bY5B4Ko3KJ3/a2CgfYu78meY=
X-Google-Smtp-Source: ABdhPJzksARGz4LRgr4ivNqUz5YwgJ6wzEpVrwfhfgvgH+5XaE4XSEhNgXPAn901swFqS/N3tInGtg==
X-Received: by 2002:a2e:b88a:: with SMTP id r10mr10098447ljp.362.1631895600030;
        Fri, 17 Sep 2021 09:20:00 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id v10sm564070lfr.82.2021.09.17.09.19.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Sep 2021 09:19:59 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id i4so35387037lfv.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 09:19:59 -0700 (PDT)
X-Received: by 2002:a2e:8185:: with SMTP id e5mr10019984ljg.31.1631895599183;
 Fri, 17 Sep 2021 09:19:59 -0700 (PDT)
MIME-Version: 1.0
References: <YUR6gpm+mTWqdil6@infradead.org>
In-Reply-To: <YUR6gpm+mTWqdil6@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Sep 2021 09:19:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wihcFU1mq1ksH9k2pTTziopDWm16nra0Ofw7aORGphJaA@mail.gmail.com>
Message-ID: <CAHk-=wihcFU1mq1ksH9k2pTTziopDWm16nra0Ofw7aORGphJaA@mail.gmail.com>
Subject: Re: [GIT PULL] dma-mapping fixes for Linux 5.15
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 4:23 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> nvme fixes for Linux 5.15

This presumably went to the wrong person for the same reason the
subject line was bogus.

I got these fixes through Jens, if you had an _actual_ dma-mapping
branch you wanted me to pull, you did the wrong pull request.

Please send that proper one instead.

Or, if it was just this nvme thing, it's all sorted out already.

          Linus
