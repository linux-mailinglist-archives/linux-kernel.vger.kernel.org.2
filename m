Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45E333A4979
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 21:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbhFKTgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 15:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbhFKTgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 15:36:45 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15D9C061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 12:34:46 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 131so11146687ljj.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 12:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tUREJcjYiuBpO07752RlqO1e4KYkKB+aItYVhjDXKKU=;
        b=iF4sdKjoMB7UZrrRxeufPi9ePYSwDXXPzglnmrtaVzPpoegEkYXxnnkcfOCzD20gTl
         F23sUxrMmCCzdHs914CK6w9ifdgQQ1hY3RECdsEJMebwbc908ZvoQf2YqRRSj0Vq0RFU
         2+nY1hrCpSKAO7gRs+5W6FPiK1KtloKXlClbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tUREJcjYiuBpO07752RlqO1e4KYkKB+aItYVhjDXKKU=;
        b=HZ7UyuvCOaSR7lGK8oOk4w2JXI5XBEJ02H5dqjq+bqoUDdSQHSaytlPhUQmVkbcxDv
         1Z2OMfpwa3jtNMlmcy+EQZIrtzR/MO8QQNpW7hNoPmD74IUGFuW1EkkYNjv3A+OcfLbw
         LbVq70888zuxvtZrPK1niQHqvaJdc+xsw6ANE1gQ2ClVZYasNdRmOH6m/MTqBAF3Z0Ir
         CDePW9K6qTdFiQ2+xbIt5qrQO6t3az3NedRFbM2KwCcHiSb7enNo3q21wcYLhO04VegI
         hgiF1Hd4MRVY1yaj1jd/THgN6MJmOi5fe7m950nk9DwhjFQ5xIOK0nmmAkb1x4Q29PZH
         bcPQ==
X-Gm-Message-State: AOAM531iWXm/mHqV1tWvmjYnB3FrDGhJw0EEjHQ1vQyr5d25d5Ag4aR+
        QABiAYEX7yxk7eGq0Kg5McQysJqs/sylY0zvexI=
X-Google-Smtp-Source: ABdhPJxYvtfPSY3mTZARnAHX3fRMWVF2dJIlEq9Q5UFtX00w97cb1+dw/PB/Xq95v/1hLO6hQrwQWw==
X-Received: by 2002:a2e:9a05:: with SMTP id o5mr4137147lji.249.1623440085116;
        Fri, 11 Jun 2021 12:34:45 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id x32sm669792lfu.235.2021.06.11.12.34.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 12:34:44 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id j2so10127434lfg.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 12:34:43 -0700 (PDT)
X-Received: by 2002:ac2:55b7:: with SMTP id y23mr3451884lfg.40.1623440083600;
 Fri, 11 Jun 2021 12:34:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tyyyQ-0QkKquLX4q=7=pjGeRxhhP=z7rfLjEbX7mSrh5A@mail.gmail.com>
 <CAHk-=wgT1ZXOGRjBHbvw+GqY=qUv4oHv8BZ6FpSay6z_0FxkPg@mail.gmail.com>
In-Reply-To: <CAHk-=wgT1ZXOGRjBHbvw+GqY=qUv4oHv8BZ6FpSay6z_0FxkPg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 11 Jun 2021 12:34:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiv-MFjHYDH4wCi401fomZHKRLSeaWJBYxRe8vq7tujQA@mail.gmail.com>
Message-ID: <CAHk-=wiv-MFjHYDH4wCi401fomZHKRLSeaWJBYxRe8vq7tujQA@mail.gmail.com>
Subject: Re: [git pull] drm fixes for 5.13-rc6
To:     Dave Airlie <airlied@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 10:07 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I think anongit.freedesktop.org is sick. Can you ask somebody to give
> it some tender loving? It's just disconnecting immediately..

Either somebody gave the site a hug, or it decided to just get better
on its own. It's working now,

              Linus
