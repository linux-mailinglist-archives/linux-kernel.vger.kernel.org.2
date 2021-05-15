Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6108381716
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 11:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234553AbhEOJHY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 15 May 2021 05:07:24 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:52103 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbhEOJHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 05:07:23 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M6UVr-1layUq3von-006tUV for <linux-kernel@vger.kernel.org>; Sat, 15 May
 2021 11:06:09 +0200
Received: by mail-wr1-f44.google.com with SMTP id x5so1405515wrv.13
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 02:06:09 -0700 (PDT)
X-Gm-Message-State: AOAM533ZfvSzkQmff0+v3h2SMhSdZ30QgpTY3uBUQw+7qeN1Kygwp9T/
        cCW1ECw6GXkVf92OKTkZUAUHQldsFeNtHAflAcE=
X-Google-Smtp-Source: ABdhPJxa9ga0gRy5e6nzNdn42FfeS/06D9LKUViTeagdJ1e1i+BEI55jfoywfqUYIjrsLyOPxqavndmJMysqb9ykebg=
X-Received: by 2002:a05:6000:1b0b:: with SMTP id f11mr26260943wrz.165.1621069569668;
 Sat, 15 May 2021 02:06:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210514062150.3533786-1-yukuai3@huawei.com> <CAK8P3a01oF7QZzjbd703QwiK+6ZPx1w-fSBcLjeMm4KQ0X0amw@mail.gmail.com>
 <7dc2aaca-20d1-46fc-e5a0-312f3fbc7ea4@huawei.com>
In-Reply-To: <7dc2aaca-20d1-46fc-e5a0-312f3fbc7ea4@huawei.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 15 May 2021 11:05:06 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2Qx4F50E3YAr0FQswD_Fg7T6wkmyaAtCOCnN6UcfqPGA@mail.gmail.com>
Message-ID: <CAK8P3a2Qx4F50E3YAr0FQswD_Fg7T6wkmyaAtCOCnN6UcfqPGA@mail.gmail.com>
Subject: Re: [PATCH] char: pcmcia: remove set but not used variable 'tmp'
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     Harald Welte <laforge@gnumonks.org>,
        gregkh <gregkh@linuxfoundation.org>, akpm@osdl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:QXrKMStL1P6KdDJo0jx1pv/nIdiYh7vrrlMBdWdM0qO7wV3ysTB
 /mJhwjQmo1fdhWsqeMj61KdaQZE1bDhvaXRfs0e86uv2oa8Va+lpJWIm4zfmPxEANDYZmWL
 1udfLBck1CKT7prhDpeaaUkt/ZIukdrhtHHsfqf0OgXODV1vYqvRKsnexw+m/GhHh/gDndW
 Bir6cRsn+dJWA96NyV8RQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4cgsz6+4T38=:HjbcCi9GyoLVZQxEm0ucNV
 h167aYibQfYHyVu1M9O9iOJ50GXad9sxJnIvgVLiqCJTWqXSMIgCmPG9ubO0aXnAunrQ47un8
 9lyRiibm/gXlaAnlHswl7MQztetm1ir+rHm6fnPfNDPT73fvBKH2UTnb534mYTozlKBJTG+jL
 InAnbmUOMFK7yf+9S0wm12sYgyl3FDjUl6xqUMrHABb9NPy4girNgG974mGLBzFqEUq5nnuPd
 e3tnLtCzy9l90pHKmNUJz7+EspKxhwGas+1Te2ETfsZYsfB8HCqfUYqqr4o1ZVazONQ8s42t/
 l2WsWgm98CjWN87jqTaz6OHXYoRxqLaXRq7ixlORrXsO17Hd7rP8XPhvi8DdgVRuDSHrrH8Lv
 IVkE0D/hxmhxx7NDRbhtnqhFuSfZKORl9k19ZMsQCfW56OOcdMC/C6KkPLs3kHDHizG1pCaKw
 Ha2M6JrKrwuvWyBgSlSMhREJVAN6QftSiO8R1RnqjlqCRz65Q5t0PhiFtaFgTdoFW/1KYallJ
 AHC05Moltgb/vybs6pqBqE=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 15, 2021 at 9:15 AM yukuai (C) <yukuai3@huawei.com> wrote:
> On 2021/05/14 14:28, Arnd Bergmann wrote:
>
> I'm not familar with the logical here, however, if io_read_num_rec_bytes
> may get 'num_bytes_read' greater than 4, this loop will cause index out
> of boundary. It make sense to me to add a range check. Futhermore, since
> 'num_bytes_read' is ensure to >= 4，I think we can change the loop to:
>
> for (i = 0; i < 4; ++i) {
>         xoutb(i, REG_BUF_ADDR(iobase));
>         pts_reply[i] = inb(REG_BUF_DATA(iobase));
> }

Obviously it still has to use the num_bytes_read value to determine
how many bytes were actually received, but there should be an
added cap to tell the compiler that this is never more than 4.

       Arnd
