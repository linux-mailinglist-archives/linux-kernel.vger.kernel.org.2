Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93FF93D184B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 22:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbhGUUGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 16:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhGUUFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 16:05:52 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4EEC061575
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 13:46:28 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id b26so5164523lfo.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 13:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wHmWOsRJBltjYo7lCFhKzzQm+gRr0aziJWNnsm+aX04=;
        b=AKrRqb6ZSHyas0lTpEb/OJQ4sS90yqcnp66+16rXaoYcS9JZ1Ft4L/FV31nBUbXqRd
         ZQVTk8nuT1MLONhdGXvRXJ1/SOVPhaYqRU4JWvyDLFp4E9MvKBl2qDDX/cMEYMIktlX+
         4w9O+vfJH3cBANYWYhDUgZS5akjmCFNy7wctk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wHmWOsRJBltjYo7lCFhKzzQm+gRr0aziJWNnsm+aX04=;
        b=oHtIROqFHhCSYFcRg9K4OiK/G7UZHndyF2qxqAgPIJ1BLvo51pQEVHSp8Z3csv5e8n
         jIuFm2Ex5nwop9amyt8NB5DF6BxNUL2EpawLc9PX1zDCNi5iYXGW9rbphmAcQtZVEVh9
         GFXd8Y/MqIp8ZRGmwx0KnehAxxSHKQxw3inG8pZD5T825GUTHONLr40J4wizgjH7rQHc
         5sGh7xqUlqNwf061LEyb7jgceCLkAu//9TzFOtlPtbwW2tPt9EohokaCHJGeBzNE4t31
         y+xB339qK1BCSN1TYoKMKWQO+wIdsdksvKMzznnuKMLCV1BSRdssxNMxMXWrepkn8TTA
         vCLg==
X-Gm-Message-State: AOAM531QSQjlXT+hzsr7tSvg06WX+V9J0xEcFC/wN8CG6Ks3twXs69b0
        uE1DHoAb7CBAIuCjhISW7KunQBIg2W/EwmKQ
X-Google-Smtp-Source: ABdhPJzsdcXWYKov3G5N5yDGfrOsYAvWuQ8dbhpL7O/AtKs0mAslDJoHNe7d8kyt0C0Xa9Om2Nh2iw==
X-Received: by 2002:a05:6512:3697:: with SMTP id d23mr27344232lfs.552.1626900386416;
        Wed, 21 Jul 2021 13:46:26 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id k21sm2822879lji.107.2021.07.21.13.46.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jul 2021 13:46:26 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id h9so4670407ljm.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 13:46:25 -0700 (PDT)
X-Received: by 2002:a2e:90cd:: with SMTP id o13mr16148707ljg.465.1626900385724;
 Wed, 21 Jul 2021 13:46:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210721184131.2264356-1-willy@infradead.org>
In-Reply-To: <20210721184131.2264356-1-willy@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 21 Jul 2021 13:46:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjOZQ1yvG+FvP-sDgGaDzmXoxC7KjDMUerw_Z2QYyAHmA@mail.gmail.com>
Message-ID: <CAHk-=wjOZQ1yvG+FvP-sDgGaDzmXoxC7KjDMUerw_Z2QYyAHmA@mail.gmail.com>
Subject: Re: [PATCH] mm: Make kvmalloc refuse to allocate more than 2GB
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Qualys Security Advisory <qsa@qualys.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 11:42 AM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> It's generally dangerous to allocate such large quantities of memory
> within the kernel owing to our propensity to use 'int' to represent
> a length.  If somebody really needs it, we can add a kvmalloc_large()
> later, but let's default to "You can't allocate that much memory".

I really think that without the WARN_ON_ONCE(), this is just moving
that failure point from a known good place ("we know this must not
succeed") to a possibly bad place ("this might cause silent and
hard-to-understand failures elsewhere").

IOW, in seq_buf_alloc() there's no need to warn. It's clear that a
bigger allocation can never be valid.

But in kvmalloc(), it needs to warn, because if it ever triggers we
need to check what triggered it.

So this is not just moving code from one place to another equivalent one.

                 Linus
