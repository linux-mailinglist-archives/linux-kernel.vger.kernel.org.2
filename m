Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1214D40BD19
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 03:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbhIOBWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 21:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhIOBWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 21:22:47 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406D9C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 18:21:29 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id i4so2529556lfv.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 18:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x4VkY+TFyFo+mcrDLvn05mZKNpL11A9T/wyZkbRLEvw=;
        b=WcSzoKReTJLTL2aZ/b+qFuar86cyA8X1UAHLQP5uOOMjaIPKEImNq42IAR+dpDOOyO
         b2fhmZ3E1rr9/xaCbXjtkUBcrmjRjo5zePtYdy1BkHdF5OnKcF84F/1upMw1YJrS8vfP
         aHrPsZdWJg6FbF9WGF47DU2Wl6OlaBC6f3jpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x4VkY+TFyFo+mcrDLvn05mZKNpL11A9T/wyZkbRLEvw=;
        b=yhj5jSG18USdW4pzQngvg7fKMVs9yZRR1iHlS3obAWRk76XC3plEJNK3i7hsedtq7/
         G52NLUStbqMabTwQGcz0su63FnGz3D6zWzwYVzCK1sApUesqJq896udwUlq3fKkiLiIS
         cfPA1VAtSiolB6tz+v8WdFqmhMbhNXdFUhjYixQh7EJ0vS6dBUkW5h0xj0oLqvtnBiY5
         MLykIuCwFpc62K3QJhskgrI1l01cziWmY9YwGAQrlDrZ5y0hqVQIAer9fQqqYwECI+hd
         /I151oymMJb2g0tbDHBU7xSg7oT4Rms632RmCqcZ6Qg0rfeXncUipTjwGiGldKGdU2Y5
         Q7Xg==
X-Gm-Message-State: AOAM533HsO0Kkc2+4Ar3vWiBwwMB3j6HwxsWQhe+fOC0ROkDkD+0+FES
        G3OaymQ40L151IECEjfEjD880wndTDpf33DxJFA=
X-Google-Smtp-Source: ABdhPJysz66fBlsKKvuc0mCAw/tR6wIIUZoAiogzAgvZ7CVL0sFLtSy9a1/Bh57Gc1xFjSXFQ47mTQ==
X-Received: by 2002:a19:550c:: with SMTP id n12mr8176604lfe.511.1631668886760;
        Tue, 14 Sep 2021 18:21:26 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id y9sm1518618ljm.5.2021.09.14.18.21.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 18:21:26 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id h16so2447105lfk.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 18:21:25 -0700 (PDT)
X-Received: by 2002:a05:6512:114c:: with SMTP id m12mr15709190lfg.150.1631668885502;
 Tue, 14 Sep 2021 18:21:25 -0700 (PDT)
MIME-Version: 1.0
References: <163166717752.510331.12843735095061762373.stgit@devnote2> <163166721835.510331.4931010992364519157.stgit@devnote2>
In-Reply-To: <163166721835.510331.4931010992364519157.stgit@devnote2>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Sep 2021 18:21:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=whsAk7u0arWz37YbCyQPZgKfKOhrM1oKp+0B9uJk6J9OQ@mail.gmail.com>
Message-ID: <CAHk-=whsAk7u0arWz37YbCyQPZgKfKOhrM1oKp+0B9uJk6J9OQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] tools/bootconfig: Define memblock_free_ptr() to
 fix build error
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 5:53 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Since commit 77e02cf57b6c ("memblock: introduce saner
> 'memblock_free_ptr()' interface") introduced memblock_free_ptr()
> to lib/bootconfig.c, bootconfig tool also has to define
> memblock_free_ptr() wrapper, and remove unused __pa() and
> memblock_free().

Christ.

I grepped for this, and couldn't find any use of that memblock_free
function in the tools directory, so I ignored it.

It seems like the code in lib/bootconfig.c is compiled both into the
kernel and into that tool. This is a nightmare. We've explicitly tried
to avoid this for the tooling headers exactly because of issues like
this.

           Linus
