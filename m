Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADED037036C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 00:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbhD3WVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 18:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbhD3WUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 18:20:54 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D8AC06138C
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 15:20:05 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id d15so31313381ljo.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 15:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LPHXuFLy5stLpGwQaeIuIJPobdMaEnCqfseYzg/gd2Y=;
        b=CocY4j7++UJ3Tc8jJmqROkOnzc8H9GEFjGGcDlbZNXrn4v38F9dgTWsMHGhZynPK76
         npc+QlQdePfy2Mzi3UYBTefVTgTCaLxr5YqshopI64WjF2MnPwTs9nH2p8i+0HCbUwBx
         2bVS4qj4KPhfsKsMVy+FfBkC1jGCVOP2yxCug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LPHXuFLy5stLpGwQaeIuIJPobdMaEnCqfseYzg/gd2Y=;
        b=sygLqkqo5c6k1KkA4MGBR8jdE9lFTWfrrAo6OSQzVujd3VafE4PcgGhEk61D+JZkte
         DB1iCxOf39QeOOQLYnftiJOHeY0DirTfSGZgZW0H1hCKTGB4zJY/Ovb0uQtQ30659g2U
         nPJvHPsL6l3pLMLWh5x4KjMAt+td5tePPhmWwgy9UfSdbB5ACeaaBUNk3FQcZQaVxmSi
         RP2AYOo8VRXdFv1WBb3RUh3p4ueZiXkAPmVhG79zWEmQ0Mci0jvXHv7NW1nyloef1An1
         aWgeSoE6VltbeRKtWMpSs5caMtYgpjFB09lyrCT82aXqeruPofRl/QoA1ZPcOv4/zEbl
         T2zQ==
X-Gm-Message-State: AOAM531YuVOJpM2WLvhN+e6ETOQpOp7jy7uBBOuDm1dxhOHdYxoK2YlV
        UhCZ9p5klgZI2OZOFniYYpUZj/ti2cyarf9T
X-Google-Smtp-Source: ABdhPJyBjmPTM7J3NmEGDg2k5hFup4D27H7tN2bEBwX81Xo9WpMjvCVg3Ug0F9ffTjVwu6UoEbiZiA==
X-Received: by 2002:a05:651c:50b:: with SMTP id o11mr5235158ljp.323.1619821203608;
        Fri, 30 Apr 2021 15:20:03 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id h19sm398072lfj.154.2021.04.30.15.20.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Apr 2021 15:20:03 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id b23so29793093lfv.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 15:20:02 -0700 (PDT)
X-Received: by 2002:a19:c30b:: with SMTP id t11mr4728228lff.421.1619821202593;
 Fri, 30 Apr 2021 15:20:02 -0700 (PDT)
MIME-Version: 1.0
References: <YIwYirYCIdcVUjk6@miu.piliscsaba.redhat.com>
In-Reply-To: <YIwYirYCIdcVUjk6@miu.piliscsaba.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 30 Apr 2021 15:19:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh+RrxDNLJJoANx02QEBYYBfJbHRjRV1FD+di6x+tTiNw@mail.gmail.com>
Message-ID: <CAHk-=wh+RrxDNLJJoANx02QEBYYBfJbHRjRV1FD+di6x+tTiNw@mail.gmail.com>
Subject: Re: [GIT PULL] overlayfs update for 5.13
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2021 at 7:47 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> - Miscallenous improvements and cleanups.

Life hack: everybody misspells 'miscellaneous', which is why we have
the very special kernel rule that we always shorten that word to
"misc".

Problem avoided ;)

              Linus
