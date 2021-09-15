Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7AA40BCF5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 03:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhIOBOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 21:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhIOBOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 21:14:06 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDE9C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 18:12:48 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id k4so2450166lfj.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 18:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sj/ckwgRXA0XAritZwn0IRH2Tpo7u3DEDmkQl8JG/xo=;
        b=dbyS/C0beUkomGpbcmoDo+smCOcStzW4H0jI3Ml2At5hCXRIFGbWz1pwwdjYLAlRYU
         A98CSjoWpuu43A8QWRL0clUNwdVGLaxezC4DJZvDV9Zk4jWFQqkrc736DsMLED34nzve
         mUTM6WMWh8zOvT8K26z4LgHYACeX/DfmT1ZHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sj/ckwgRXA0XAritZwn0IRH2Tpo7u3DEDmkQl8JG/xo=;
        b=xoje0cR1yA7oxsu+ttlftE/wDpa6+iL/Hd+8J3aTCh5qDG3rkju5CY7wO5+6myZ39P
         Fdn1vDlmkpHgzP7PYhVyPArFqM71bwzdg6wEUn3gbRIEIdaRSj233+m3dfxWd5Dh6jBA
         fr6T9KqSvQFOuuowIe0+1RwAYHD+BMldD/+/9qwZw4iO1iJ6FLVyr41Y3rT6knyk0Teu
         nvFmrEAJLh6tle7TM4aXXazCQaRJA2k9EuWcwojtF/Wtfut9Lq2490V3NuzCu9JJud3/
         TtTbzLQlW2b8/XIoxB2ozYshpeDdIl8yKMXuWECGJJQE8XSkt2yVrpNu+dq555uohiTA
         TYOg==
X-Gm-Message-State: AOAM532qPz9RkgNq0z1A+tYewLJWJJwZ3Xa+y8ihgBTnwJ51xpxbSs6J
        vqTkCpqv5zKToZN+yYEJ06ZarXNe368+sQG1i0o=
X-Google-Smtp-Source: ABdhPJzDwBGUJbVcMrbvZxZdE/GmehN2VuwyUQACmETT6gRooR4zUITLSs7QBLhg2gs8ABQ2Hy/9fg==
X-Received: by 2002:a05:6512:2281:: with SMTP id f1mr195468lfu.576.1631668366270;
        Tue, 14 Sep 2021 18:12:46 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id r13sm1466425ljh.61.2021.09.14.18.12.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 18:12:44 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id a4so2438961lfg.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 18:12:44 -0700 (PDT)
X-Received: by 2002:a19:ae15:: with SMTP id f21mr5676587lfc.402.1631668364073;
 Tue, 14 Sep 2021 18:12:44 -0700 (PDT)
MIME-Version: 1.0
References: <163166717752.510331.12843735095061762373.stgit@devnote2> <163166718582.510331.11732633028925882626.stgit@devnote2>
In-Reply-To: <163166718582.510331.11732633028925882626.stgit@devnote2>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Sep 2021 18:12:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=whJAyOZN16BzB-YS8zYVNfSsRcCnMuvzfz6CMfuknwPDw@mail.gmail.com>
Message-ID: <CAHk-=whJAyOZN16BzB-YS8zYVNfSsRcCnMuvzfz6CMfuknwPDw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] bootconfig: Fix to check the xbc_node is used
 before free it
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
> Fix to check the xbc_node is used before calling memblock_free()
> because passing NULL to phys_addr() will cause a panic.

No.

That's the previous bad situation.

The whole point of memblock_free_ptr() is that it actually acts the
way a memory freeing function *should*, and has no problems with NULL
pointers.

>    - Rebase on top of Linus tree.

Please don't do a mindless rebase, take the actual changes into account.

         Linus
