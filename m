Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF9A3E4E6E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 23:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbhHIVZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 17:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbhHIVZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 17:25:57 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F67C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 14:25:36 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id n6so12440646ljp.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 14:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GciiGnwukZUcZuMgRkuX2+Oq98OfQGEGL0PbIUMdbwY=;
        b=DkW8bjkdCbaSSZSwXUD4dP7zGs+heKPA+Oy5FoJ3PhXwaSYav89OxOAcJNbCZqAFmL
         0h1nLAi6SdzNhvMaS1Nzft4JS4BHDBbOx4s0vutZIhoGZgzoNkz1aA+MU8kA1xMDmbqc
         PFME9G1HDX5AzRGqzhBS/Ml77jddOYE1oapDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GciiGnwukZUcZuMgRkuX2+Oq98OfQGEGL0PbIUMdbwY=;
        b=IwgqDd8xzcbm/vbc0rqLH4CayFkB6O5mazfhyldJsabmY6mfabUOQ6DSqamnZZ83oI
         qK+73TGpycuCaOwU+biqkrBZvgDSf+Zzlf+QwaCyTABPAYcfY3JvSfD+geV5wZaDoo0l
         9WY/GrMAKJSiPWNOggxW1ZptvCmhxKT18b/+gYkX0KCIgvaPkIa+q4xoihBLpuZuEqn0
         4RvdOnH5hzf0cBqL+l+1mkZ8mik7uijXXekS87sw+Lm0n4WBliTI58vlRjC5sErVnKKr
         zBkNCHKzZsDAQNrSQNkIYTTv7ehNDDfoNUQKYNcEoytBZyIzzjxBEDRCEPSovAi5Ztin
         NGbg==
X-Gm-Message-State: AOAM532+HBTY8GTNDRSW+XH16h8StoHJcYI0zKgczThE4I8a2D6QibYJ
        Bn+0YOOCEKxSsM23AZ4PxBS5zphuV6yefw+2
X-Google-Smtp-Source: ABdhPJzjjgMaHjJ1yD0pM5ouU+oeyEIJZbz1luvARAHo2iLsIxjbBgLf+aZwWYuq8jZHBG6aAazGtw==
X-Received: by 2002:a2e:7f1a:: with SMTP id a26mr16644253ljd.183.1628544334269;
        Mon, 09 Aug 2021 14:25:34 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id d4sm1842725lfg.178.2021.08.09.14.25.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 14:25:33 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id h2so13494282lji.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 14:25:33 -0700 (PDT)
X-Received: by 2002:a2e:b703:: with SMTP id j3mr7222089ljo.220.1628544333584;
 Mon, 09 Aug 2021 14:25:33 -0700 (PDT)
MIME-Version: 1.0
References: <YRFfGk5lHL0W27oU@miu.piliscsaba.redhat.com>
In-Reply-To: <YRFfGk5lHL0W27oU@miu.piliscsaba.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 9 Aug 2021 14:25:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wigKQqEqt9ev_1k5b_DwFGp7JmCdCR1xFSJjOyisEJ61A@mail.gmail.com>
Message-ID: <CAHk-=wigKQqEqt9ev_1k5b_DwFGp7JmCdCR1xFSJjOyisEJ61A@mail.gmail.com>
Subject: Re: [GIT PULL] overlayfs fixes for 5.14-rc6
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 9, 2021 at 10:00 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
>       ovl: fix mmap denywrite

Ugh. Th edances with denywrite and mapping_unmap_writable are really
really annoying.

I've pulled this, but I really get the feeling that there's duplicated
code for these things, and that all the "if error goto" cases  (some
old, some new) are really really uglky.

I get the feeling that the whole thing with deny_write_access and
mapping_map_writable could possibly be done after-the-fact somehow as
part of actually inserting the vma in the vma tree, rather than done
as the vma is prepared.

And most users of vma_set_file() probably really don't want that whole
thing at all (ie the DRM stuff that just switches out a local thing.
They also don't check for the new error cases you've added.

So I really think this is quite questionable, and those cases should
probably have been done entirely inside ovlfs rather than polluting
the cases that don't care and don't check.

                 Linus
