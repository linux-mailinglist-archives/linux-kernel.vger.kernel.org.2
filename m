Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 059EC3C8630
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 16:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239481AbhGNOd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 10:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbhGNOd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 10:33:27 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FBFC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 07:30:35 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id dj21so3485871edb.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 07:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nRGgwBFXIqj/fEVN9u7u5Lf4JMXSz/tXuESwz3X7tks=;
        b=RhPLCmPjgh4iItNwpJlwgpSmxqK61jCaySJVqobzMAnqnCGm7G4K8goipvYDzr2aNu
         93CHMW47jdG5H/l8tajoMmrHPNg/IPa4u1wmks1FThzoYGpgqRA9giTgWFoSAGYiqSrm
         szzf8ibiI8h858TxNH5gMKPhSVwXnhaMBKuojdePpmB3b0ibRCts4dFD7W8uB4i2dNgH
         VawrajRYfQaizMhJTFQeiu4UX4XzJcDO4Mzygdx22e7YDN1oT5drWKAve5Dy0qnp5gYf
         6Ukx9Xdo93yFb1nTB5PwxodY2zMkZ0+ZAJBVg1RT13QadOgaB1fnXQ7MKoMfxbWKOWot
         O/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nRGgwBFXIqj/fEVN9u7u5Lf4JMXSz/tXuESwz3X7tks=;
        b=qqJEF6RQUwQ009SWFuXBJbvrwKKBablT7AITOtPeI4AwhY6f20v1LJGQdcFKN8mRS3
         GCYkGGHwsG2yUjZrV0OonhQnSSo2OjvrQT6Sea/9Ax/QQftG2kRUqVGq9Yx+HCMEZz0/
         NnyGaFR7WHCp+MYHzZh1Pcr7h9R7lXN35+1fBIdiYQEpVBwSZfaJV/VE1MXSo/PS6hCa
         rkwkTDhOfNyFSZyB0VqbAZLK5p43bq+G4ayzCioQDIMZseDvpi95YXpe1Mx3ZFIWefiS
         8Aw6xxdZo55VobWvjGBIgALudlhybEA/roqDeEHdUtkZNtska8zr233EE0h/p/Jtsh20
         jLnw==
X-Gm-Message-State: AOAM532qwVRbpVDsFEhkTWk3x8Xuxsp08XBWhFLCOidNQcKT53yMHCax
        1gUUNeJZQA0yoMFLfuh6ETh8gQ/eLHokVPYje1c=
X-Google-Smtp-Source: ABdhPJyCOOjOLOAnVSSiY6Vl51bGzpgh8I5liY+x7Nw0jjUYSHPcBYU1ZE1+yv3F+5E1HazJNuD8iMiuQ5nl+1pzCPI=
X-Received: by 2002:a05:6402:10c7:: with SMTP id p7mr14256008edu.159.1626273034290;
 Wed, 14 Jul 2021 07:30:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAOH5QeChR8s6vENfRdGtUeeqKsSSbeFkY9TArmOyDcUvgAgU7Q@mail.gmail.com>
 <CAOH5QeC0PhnZY6Cpe4zZ8o07XHA4-5B3xGEontkezrYu=Jt0VQ@mail.gmail.com> <7074179d.c3fd.17aa3f148cc.Coremail.wuzhouhui14@mails.ucas.ac.cn>
In-Reply-To: <7074179d.c3fd.17aa3f148cc.Coremail.wuzhouhui14@mails.ucas.ac.cn>
From:   yong w <yongw.pur@gmail.com>
Date:   Wed, 14 Jul 2021 22:30:22 +0800
Message-ID: <CAOH5QeCV3c-=RiwGrUn7214NRZye7wYFmPSyFWxw-0Zvk=j2GQ@mail.gmail.com>
Subject: Re: Re: [BUG] ramfs system panic when using dd to create files
To:     wuzhouhui <wuzhouhui14@mails.ucas.ac.cn>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, nico@fluxnic.net, wang.yong12@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your reply!

> Limit max size of ramfs.
It's no use using size to limit the size of ramfs.
"mount -t ramfs -o size=10M ramfs /ramfs" is the command i use.

>
> The comments already explains why kernel should panic on this situation:
>             /*
>              * If we got here due to an actual allocation at the
>              * system level, we cannot survive this and will enter
>              * an endless loop in the allocator. Bail out now.
>              */
But it causes panic, actually , I don't want it panics
