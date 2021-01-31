Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2164309EDB
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 21:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhAaUZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 15:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbhAaULr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 15:11:47 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0D1C061573
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 12:11:07 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id q12so19909993lfo.12
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 12:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nDA7mpEh3U7ppRPTzz7tPCDtMKgFR/+ntGuz/7ehGXk=;
        b=JSgILjkLLdNTou+PCKRUtqCgKXdTLh1yUBWNLBm+tUI0HVzQBwsdU4d0txqWgNT0Oy
         zqSk5/paVhwLlBxgpG+SmmOMIcw9mGln4nUh5598ry1d+4RwI6HO4VL5z4Hl+y9pX9mx
         9zPecw2Bp/afxmxIXlO4aGZ3Q5SEVUoofckp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nDA7mpEh3U7ppRPTzz7tPCDtMKgFR/+ntGuz/7ehGXk=;
        b=GPZwMAIQQlHiNLb6hxnqwrhTUoFcRxzVrMelHIGObkRzm1WTcvsOyKCnnFX/DjZl4i
         d0J7vC85+/yviyP15JH7qx4SQR/CzJbnKX27zg53UZL0rBO9RTMf7V28m5uH03suebzA
         qaCnl4xSKLnSHcVVpANDbhVHjTQz52I9DzX0pTyeb51BBIfcDvKf2aspgiiPUvaSTdNv
         YjDx1RWMFvz8yE2hQLjcf2C6EwTxbiTePICBytYVl8IsMXq7BvIrvwsHc2J6jfqiXJtw
         wBuKcy4yLOULUnDv56H9DqA087n3IAxLNyHssnwFAw3wCv2+fDhOm/MWeLb4YI0vw53F
         dGow==
X-Gm-Message-State: AOAM532eADXD5E8H5dyFmx8hAd+mK7ZDEtod0/ZgyxY1tlgmdzuCbq9/
        0eEkMscge7kV8+Vlqf5+F/dsZcbb3K209g==
X-Google-Smtp-Source: ABdhPJx8WzjNCz25yZ42IDwYhitScaNUx23U574liaUvnRc/pnInjdQIdglxNKQ9ndYLldnJmJD7eg==
X-Received: by 2002:ac2:4c8c:: with SMTP id d12mr6598916lfl.361.1612123865919;
        Sun, 31 Jan 2021 12:11:05 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id q1sm2738861lfu.48.2021.01.31.12.11.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 12:11:05 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id u4so15489901ljh.6
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 12:11:04 -0800 (PST)
X-Received: by 2002:a2e:b70b:: with SMTP id j11mr8044741ljo.61.1612123864504;
 Sun, 31 Jan 2021 12:11:04 -0800 (PST)
MIME-Version: 1.0
References: <CAP045ApxLJ7vXOVp5Cwx7WEyDr6v01D9YD3xGFDv3WAp6czaMQ@mail.gmail.com>
 <87v9bdc4yc.fsf@m5Zedd9JOGzJrf0>
In-Reply-To: <87v9bdc4yc.fsf@m5Zedd9JOGzJrf0>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 31 Jan 2021 12:10:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=wixO7LJKwtD+CQJTQHgJFQjr=sSi_pQEGqcYdczTphncg@mail.gmail.com>
Message-ID: <CAHk-=wixO7LJKwtD+CQJTQHgJFQjr=sSi_pQEGqcYdczTphncg@mail.gmail.com>
Subject: Re: [REGRESSION] x86/entry: TIF_SINGLESTEP handling is still broken
To:     Yuxuan Shui <yshuiv7@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        open list <linux-kernel@vger.kernel.org>,
        "Robert O'Callahan" <rocallahan@gmail.com>,
        Kyle Huey <me@kylehuey.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 31, 2021 at 10:54 AM Yuxuan Shui <yshuiv7@gmail.com> wrote:
>
> But renaming the definition in x86 is not enough, as TIF_SINGLESTEP is
> set in current_thread_info()->flags, and the same commit has removed the
> code that checks those flags. We have to also migrate TIF_SINGLESTEP from
> thread info flags to syscall work flags, to make the whole thing work again.

Ok, so I now have the first fix merged, but what's the next step here?

As you say, the x86 ARCH_SYSCALL_EXIT_WORK is now entirely unused.

It's called ARCH_SYSCALL_WORK_EXIT these days, but that's for the
SYSCALL_WORK_SYSCALL_xyz flags, not for the TIF_xyz ones.

Revert? Or does somebody have a fix patch?

            Linus
