Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE9B4529DA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 06:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235248AbhKPFkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 00:40:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235200AbhKPFkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 00:40:32 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C718C0E646C
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 18:55:34 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id e136so52966966ybc.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 18:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rpqDaIvxd8atjdNJzYkyVRAJyAC7aztRzEj4r3gO0pg=;
        b=oSeIDCVNGsGEVXFab6uHOW5y/tU6dCosRJNm8cBd6SB2tIa+QdWw8Bho0kGLw4muyN
         eZH8Kop1RkUJ2T9Ndf26h1x7X9674XMPtZUhUxo04UqFnOScyeZSXqNCuKicvOitGlcs
         uafaqgkcDVW4drNAjZJV8mZxXP4uSIR/+RyMW/Ksnr4p4Fae4+4B1yoeOfrZm30Xb+8f
         oVQNQCmL/R7/2Z0BBlvg5pcEv7E91LzdOx9tekxQ+WIDNVoS4daBXOcuyYljeeRaFSgj
         hafEXhqTpyw1WOUW0bz50gxhXy/1MsG7dUV+CXCazhIEEMp+F9j3rt/S07Q129V6beKZ
         nRxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rpqDaIvxd8atjdNJzYkyVRAJyAC7aztRzEj4r3gO0pg=;
        b=2gV4vUZ1RbOH0czrNW03L5Kb4BWoxGqtKNNIKcw29IdNL/IEv1yHb+egkMm4VPIhQv
         0/E8FB4uwF/24RVOEW0wl/gRGEbGYF2NaJG2NOqa7CXjAbo42S96e+wvor/60eGBddiB
         xoyGwUE5obaNJ806MqoKeFtVH8qe+PW6NB3eFVEA9aKwrmHmmmzUMezP0cpEyqfX2E+X
         tvEIZoMNLZcrtzIpCD5uV8IibA7ddfBORiBAv6lFBr2yOyh91q8rQapU1YgoZaTX2+2t
         mdU3A9ywKr7iP7/PcUi7lUfJ1LUYMGXLG1GXEdb4OhwAkPvDCalqYqfo9v0RFdzq1MS2
         Fx0w==
X-Gm-Message-State: AOAM5315nEHwUgTvsgHt9c3A+BadP+tWFBrnAu1TWlfLJTy4wdKiepiw
        ql5EM08+ujAdgJ9YooWlWmv0nyXIwwOKUymtJE5P8w==
X-Google-Smtp-Source: ABdhPJxT40IF9I4AT6hA6vyiNjJ7uBJV0B7ydVaE8t/+5pTk6/UDSyL+eXhgQEEqlJQnZDNNzuYQz2kzumRuSLOpriE=
X-Received: by 2002:a5b:648:: with SMTP id o8mr4668222ybq.208.1637031333423;
 Mon, 15 Nov 2021 18:55:33 -0800 (PST)
MIME-Version: 1.0
References: <20211115020850.3154366-1-rkovhaev@gmail.com>
In-Reply-To: <20211115020850.3154366-1-rkovhaev@gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 16 Nov 2021 10:54:53 +0800
Message-ID: <CAMZfGtXqxe6Sf62s2Uk8pYOj-L=rUB4viHJ04YPFQOTSN0zBLw@mail.gmail.com>
Subject: Re: [PATCH] mm: kmemleak: slob: respect SLAB_NOLEAKTRACE flag
To:     Rustam Kovhaev <rkovhaev@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 10:09 AM Rustam Kovhaev <rkovhaev@gmail.com> wrote:
>
> When kmemleak is enabled for SLOB, system does not boot and does not
> print anything to the console. At the very early stage in the boot
> process we hit infinite recursion from kmemleak_init() and eventually
> kernel crashes.
> kmemleak_init() specifies SLAB_NOLEAKTRACE for KMEM_CACHE(), but
> kmem_cache_create_usercopy() removes it because CACHE_CREATE_MASK is not
> valid for SLOB.
> Let's fix CACHE_CREATE_MASK and make kmemleak work with SLOB
>
> Fixes: d8843922fba4 ("slab: Ignore internal flags in cache creation")
> Signed-off-by: Rustam Kovhaev <rkovhaev@gmail.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
