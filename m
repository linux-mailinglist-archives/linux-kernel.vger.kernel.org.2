Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCE834AAC5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 16:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhCZPBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 11:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbhCZPAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 11:00:48 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152A6C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 08:00:48 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id e7so6626446edu.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 08:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uzYeVMLWtYWQz05xWB069OFUBHR89kN8Qxc22E4Cdhg=;
        b=uH147oDZLF79lf5uu1CDTjiXo37gA07GguBjQ8vdQcMJ1TR7wKuxecUGFVUW1IKZ/L
         0B4ZjWOnkBZ/oZChaqnQWG+2l8zX8YgR/oAOdWI+YPbO47/Z8aB2fhE1w1pSZmJP/58B
         NfwzIH3/6sCUSkdiMZnOzUl0ZO0CAaz/7rXsbAmYx+Q0gCPLgEUgGsbvYfYc9uxWD48w
         su5AlcAPt1oYYaGldaNn2r8No97Oo7I1ud8cq+zOqlrNvjgkggi34hs7wP6yFnLpTjij
         42QvY8Njv0v9+ggnGvQpm2a4TuJG8v4GkmkH/bR3lug5qTzQfp97ymzVQxMFoRa2H6ww
         bLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uzYeVMLWtYWQz05xWB069OFUBHR89kN8Qxc22E4Cdhg=;
        b=YsQCaq+AxLZrnzmJBr3VoPISTxnAuCEXsi9Tlm6edMZxlFb088GBeqaZWATo/XTYzf
         nWH4sseSbKWfmuNVotuyJ3m/fF86WbbXI2eA2eafm7K9OiVaYH+8FbfCMwzwS2pJiLyb
         L2If4/c1lL5Z2o1G6WQHNC6Jk0FgrArIrO0qMlZKxRnEPUTGvjWNaynJ97cLTjgJ37AH
         IsmaCP8n7D3uumix90PYQN1EtG8pBTR8IBxALNx76BgydhUT2h2YV1lSTdC8av56IwVo
         XRQiavRPn5HcidQMsT3ZTJHmwo9ArehNry9eeP5+rxA3HVyB7874VfEq40yudWlN1Hl4
         cE8A==
X-Gm-Message-State: AOAM533tZbQJlKaPYnH+ez91mOi3MuXorbVJiE3ikSdHs4D/WuZt+Qln
        NBc4Wjcq9c85rf7mcqL+mmjLcgWmhqQEnp+/ev0=
X-Google-Smtp-Source: ABdhPJyfk9YyNSM1GH7XdMq80e/gEUw0RxPC5o+TlFgrqevLZuNygZjNsvE755NqY3NmHmsEbNmubu5zdS1pkqCQCBI=
X-Received: by 2002:aa7:dbd3:: with SMTP id v19mr15496635edt.314.1616770845023;
 Fri, 26 Mar 2021 08:00:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210326112650.307890-1-slyfox@gentoo.org> <4e23d404-5125-6c9c-4aa7-5eff0fa1ba33@redhat.com>
In-Reply-To: <4e23d404-5125-6c9c-4aa7-5eff0fa1ba33@redhat.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Fri, 26 Mar 2021 16:00:34 +0100
Message-ID: <CA+fCnZeC8AWearU9CQaYrFM-ZCUaQpX1e7vBkRMNtqqf_=ucGA@mail.gmail.com>
Subject: Re: [PATCH] mm: page_alloc: ignore init_on_free=1 for page alloc
To:     David Hildenbrand <david@redhat.com>,
        Sergei Trofimovich <slyfox@gentoo.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 2:49 PM David Hildenbrand <david@redhat.com> wrote:
>
> > I observed use of poisoned pages as the crash on ia64 booted with
> > init_on_free=1 init_on_alloc=1 (CONFIG_PAGE_POISONING=y config).
> > There pmd page contained 0xaaaaaaaa poison pages and led to early crash.
> >
> > The change drops the assumption that init_on_free=1 guarantees free
> > pages to contain zeros.
> >
> > Alternative would be to make interaction between runtime poisoning and
> > sanitizing options and build-time debug flags like CONFIG_PAGE_POISONING
> > more coherent. I took the simpler path.
> >
>
> I thought latest work be Vlastimil tried to tackle that. To me, it feels
> like page_poison=on  and init_on_free=1 should bail out and disable one
> of both things. Having both at the same time doesn't sound helpful.

This is exactly how it works, see init_mem_debugging_and_hardening().

Sergei, could you elaborate more on what kind of crash this patch is
trying to fix? Where does it happen and why?
