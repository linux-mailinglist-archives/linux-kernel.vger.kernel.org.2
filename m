Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0620843D0A4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 20:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238534AbhJ0S0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 14:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236888AbhJ0S0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 14:26:04 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE50C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 11:23:37 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id l13so8033990lfg.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 11:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jm/RSf4rCAITEo2BV23aNePeo8qwzmc9rjVyo//Sm2w=;
        b=DE53XnOsp2UZoHcQaGjN87P4NcbSE8qj1rBVRDhKYNzC81Sy+TaGIz6zgbRDa/vuDJ
         KNWTN52x9VpgsgZRqOL49qcoT+nz81r0kHjinwiCaa6y+XsG7oaM0JEJJuqnooFAR5rx
         khuxM+qC3sGdFQGJ0MWfcvEMyCP8aVzIrasBq9RSYVlPsbVMAgYtQJKAQz8niwOYnkmU
         +q7PL8YBOW6lnqyHqFrFjcNLK/ZstGzw28n466sjq53t8f8HTWiQnObvcohU2V9fhCSA
         dvMuInKsZVBJ2FFVNuh2nesWSw4OQtn5G3i6ZPX3fLEMSpntmgamQnPW3jdgETvX10Np
         pNUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jm/RSf4rCAITEo2BV23aNePeo8qwzmc9rjVyo//Sm2w=;
        b=jDEI0b6Yrc37dTy2zRoWxne27exfihQY6SH1fiGkwhIXmpkMnzeJgqxjduoIhEwgtH
         WN+Wm4ugd1sxpsOZ+heDgc+ShE4OjcpU9QjW3/DrQwxFo/au78eN8OLk5uAYkJDfaRiT
         rvHFM9gKRnQOEqg+OAVLSdvUulVG1vAh7T89mjlgM++UJNEllvDr23mOV3vy5vOoq7/L
         f5G8wv/7nArxXpzfIsVerhFbMORqXgrTHdb4BdZwY4ytEPBB83yLLAQPEsxqjRLW0Q6c
         z2wco2CSYsbnyceBOjwT5IW797f1mLj06jSz7O9F2hJhBXzU3NgnF60NCIxnFLgabZaz
         QKGQ==
X-Gm-Message-State: AOAM532sL2Hsjc7G/Y+G+rC11+dOcXO/vSeiH7x91rcsZRRvmp3H5ORO
        HNQukpeL2lRbcnl2LGrNOBPfQbrR/9aoqYFl69QMGA==
X-Google-Smtp-Source: ABdhPJzF9GpWULmhvrOQLqZG1vjigpdCyvN06x5InpHqzQbrjC7IEgs8r9nSKwjIi/xqAB5PqByC37tkZTYQpF/rWLE=
X-Received: by 2002:a05:6512:1046:: with SMTP id c6mr12998783lfb.475.1635359016292;
 Wed, 27 Oct 2021 11:23:36 -0700 (PDT)
MIME-Version: 1.0
References: <20211026173822.502506-1-pasha.tatashin@soleen.com>
 <20211026173822.502506-2-pasha.tatashin@soleen.com> <YXhbq/6OIpIAr7Tx@casper.infradead.org>
 <CA+CK2bCZO5J-NRqavWFKXt+yB1u17dFA9VrW48HLBepiQLJtcA@mail.gmail.com>
 <CA+CK2bBP_XJXN+wM=hmRO3C7x2Fi_SnbT_J0fU9xH0vnxU_Omg@mail.gmail.com> <YXjByyquuaN3ZKRq@casper.infradead.org>
In-Reply-To: <YXjByyquuaN3ZKRq@casper.infradead.org>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 27 Oct 2021 14:22:58 -0400
Message-ID: <CA+CK2bA3aXXb4j9GwwWakZE+M9Fipet7eZioUsg_Ljx0UuTooA@mail.gmail.com>
Subject: Re: [RFC 1/8] mm: add overflow and underflow checks for page->_refcount
To:     Matthew Wilcox <willy@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        linux-m68k@lists.linux-m68k.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        william.kucharski@oracle.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        schmitzmic@gmail.com, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>,
        Muchun Song <songmuchun@bytedance.com>, weixugc@google.com,
        Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 11:05 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Oct 26, 2021 at 09:21:29PM -0400, Pasha Tatashin wrote:
> > I think we can do that by using:
> > atomic_fetch_*() and check for overflow/underflow after operation. I
> > will send the updated series soon.
>
> Please include performance measurements.  You're adding code to some hot
> paths.

I will do boot performance tests to ensure we do not regress
initializing "struct pages" on larger machines. Do you have a
suggestion for another perf test?

Thanks,
Pasha
