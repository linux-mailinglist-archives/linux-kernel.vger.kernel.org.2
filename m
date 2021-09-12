Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB5A340820D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 00:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236627AbhILW1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 18:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235898AbhILW1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 18:27:39 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32043C061574
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 15:26:25 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id t1so7607322pgv.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 15:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9cU7lpqvAHNumkHnAUGNlG4OxLWgD/mVHJkBijtpen8=;
        b=VmIR4ZXwRl3v3b9Ix2GwBskb0c5479P5u8yqr/Mv136ZfItsdGsopiu2BPMjh7jEBJ
         9wFQKqflauoIqvg3wBjL/A6cLWNrBpurX39cUnMDSDH+xA3TkOnOZYC9cT7JZZikBSC/
         Q3hVi5gTjW2FbkbmuI20qKRVOZHsAGKm+adC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9cU7lpqvAHNumkHnAUGNlG4OxLWgD/mVHJkBijtpen8=;
        b=8Mu6moYz7vUZ4zS2kZXeCND7RYpuo/EAtsapW2lISJ3EQPaiChbw0sLehLcXL7bU4d
         MCBgaKIwXRfVw3t4m2vQ+Rak+8id6G4D5ms44hNM/wJzS324shbAS654vP08ZWVl1LWZ
         nPH/gG16nEAsFYVwpZ7CVCbH0bleRUj6rgJOv20FaH+TSeRrW2K9kq6QRTSy4kYon+y/
         agyaQp7BL8eClqSka5yGI+BM7kRO6xJ69uHJLlQeXDN7Z87dcpjZYxJI4D0aQHPxTEiO
         qQMQj2whLyz58X+l6Ybu++k/B3xk3iG73s1+dk7wMJWL0hV+1jc8WTu8HkV13Yx6zZu/
         R2xg==
X-Gm-Message-State: AOAM530h3LGZI+rbj1/AMYM1wigpQm+O3ROO/xSn/0Rt5kbQ6zJv6iuH
        lKmSJnqBW/Dq+FPTtbaTQ8ItxQ==
X-Google-Smtp-Source: ABdhPJzIcH9usrkEU/z+do4g5cPlgLKrK8I2stlAek6Dh6ue0/rcMpZ5CpQR1vn0wk2v7pIb+X7CDA==
X-Received: by 2002:a05:6a00:140e:b029:38b:c129:9f2f with SMTP id l14-20020a056a00140eb029038bc1299f2fmr8149527pfu.75.1631485584745;
        Sun, 12 Sep 2021 15:26:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v23sm4713263pff.155.2021.09.12.15.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 15:26:24 -0700 (PDT)
Date:   Sun, 12 Sep 2021 15:26:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Misc driver fix for 5.15-rc1
Message-ID: <202109121526.9E3F7DC@keescook>
References: <YT4IvKLQHm9mfpR+@kroah.com>
 <CAHk-=wh7FYyewcJkozsjA95yj0AYvmpMDoZd0RxQ3ZbMMdXUdQ@mail.gmail.com>
 <202109121213.A47D575@keescook>
 <CAHk-=wiVEEzLPLTkb9U6YB-2qXpbuqP3a1q=gRx8Nkg-dpLeqw@mail.gmail.com>
 <202109121236.4C17E6B00B@keescook>
 <CAHk-=wiFvfkoFixTapvvyPMN9pq5G-+Dys2eSyBa1vzDGAO5+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiFvfkoFixTapvvyPMN9pq5G-+Dys2eSyBa1vzDGAO5+A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 12, 2021 at 12:55:54PM -0700, Linus Torvalds wrote:
> On Sun, Sep 12, 2021 at 12:44 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > Right, I completely understand that. If you really want it gone, I
> > will rip it out; it'll just make it more time consuming to analyze some
> > CI reports.
> 
> Well, I've pulled it, so it is what it is.
> 
> I would ask you to try to get the CI cases fixed, and then remove the
> odd printouts from LKDTM, but it's certainly ok by me if that doesn't
> happen immediately.

Okay, sounds good. Thanks!

-- 
Kees Cook
