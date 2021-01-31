Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F12309E6F
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 20:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbhAaT4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 14:56:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbhAaTgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 14:36:13 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20D8C061A28
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 11:27:01 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id e2so16193029lfj.13
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 11:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b1V81F4Ydn2puqMz42w9oFOyXtkAUVLX+Y3b7UfXRik=;
        b=fvoAu1c3foj39EJDfYIrFi9b8IYHukEGKSWMl+vmSkZ/AEuX/lganByfWLNtAojHdz
         TV1i88wTX5AY0k6Y8rU2EVA+4ywlDvR1IlpKI35n4zWIHlBBpy38GCk930ppb99eNrtr
         1V7YXKQdirWWp01taNS51RKLPgDDb7g9V+8Ls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b1V81F4Ydn2puqMz42w9oFOyXtkAUVLX+Y3b7UfXRik=;
        b=fQxbJZIa1XQKhiG6aaAZMGqTOTIbc5oRVrQqiy8Mf2OKI+WuKWTFh77yjQnJzgAx6a
         0tSdxKLCusX/Wa0sMiVozowxLObSqRmygfhyHaBoVc3tXPclqBN8ECB5QFmdJQHz4CQh
         U41YZQch2e9SgnJ+xonuRPmGukBcsdaXL54AANCQZfw0oEykxDjwnTIui3dNW0JLy4Vw
         s88qLUtUsBFrnDalgPFzZ+dypCkLHhQmWqdJ2XOVUZ5vXCh43ic/JLDOh8lkj+Jq3CUi
         +3CTqD4cZCgtBcCFwTkxwKKz3uCPQGoLSjuOY/M1hoJaKMpns75LwzCzDMut/QGy0z0E
         MORw==
X-Gm-Message-State: AOAM5313Xp9ab0o1pjFmDKuvbxmPUMUCHA+QKVcae6Q78m4vyDcSk/3h
        Rm1LEoTnhWHCVrl5CUAWv9olKZLhW6BgBw==
X-Google-Smtp-Source: ABdhPJxrv+6MHLOtRAV/7512owNh0jQDdAouno5zDdNcID/gG88ALcs72u8XfyphwwtxTY+4BQMPEQ==
X-Received: by 2002:a19:7019:: with SMTP id h25mr7157565lfc.627.1612121220166;
        Sun, 31 Jan 2021 11:27:00 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id c16sm3341120ljj.20.2021.01.31.11.26.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 11:26:59 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id u25so19806794lfc.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 11:26:58 -0800 (PST)
X-Received: by 2002:a05:6512:516:: with SMTP id o22mr6263102lfb.487.1612121218644;
 Sun, 31 Jan 2021 11:26:58 -0800 (PST)
MIME-Version: 1.0
References: <20210131094255.GA31740@duo.ucw.cz>
In-Reply-To: <20210131094255.GA31740@duo.ucw.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 31 Jan 2021 11:26:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wih0mO6E4cvrAypwPu6xe--DziANaRmqhoRgdX9cM0shw@mail.gmail.com>
Message-ID: <CAHk-=wih0mO6E4cvrAypwPu6xe--DziANaRmqhoRgdX9cM0shw@mail.gmail.com>
Subject: Re: [GIT PULL] LEDs chagnes for v5.11-rc
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 31, 2021 at 1:43 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> This pull is due to "leds: trigger: fix potential deadlock with
> libata" -- people find the warn annoying. It also contains new driver
> (still should be okay late in -rcs, right?) and two trivial fixes.

I've pulled it, but please don't add new drivers in -rc's.

Yes, we traditionally accepted them as hardware enablement, but
honestly, our development cycles are so reliable and consistent these
days that it makes very little sense any more.

So aim for just new device ID additions rather than new drivers,
unless it's some *hugely* popular hardware that actually causes
problems for people bootstrapping the system (ie things like a disk or
network driver from a major company that is expected to actually be
widely available and an actual issue for people trying to install
Linux on their own).

                   Linus
