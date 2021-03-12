Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20BA8338F2F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 14:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbhCLNxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 08:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbhCLNxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 08:53:24 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF14C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 05:53:24 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id ga23-20020a17090b0397b02900c0b81bbcd4so10779282pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 05:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V6BEPK+M0OwagrMXpdDRFVmxDxwlzupSAEzWiSG+mbk=;
        b=JmtfWbWcbcFdvwc33ScaRwQAPoJBoWnp2CYLsvoDyB0E+WHnqbmYaPqc0fcQQ+sYDm
         97/AabALJGwziQZ4sKn81GH0MYT4eVBBQy6CGBtBQxTcGIg6c+/e8DQ5YiE6g09R7eE3
         05pVQlJRx935HTGcryuuM8wY1sBv/lh6ZFau07g71vIqHT85P7VYCzvDyrqd0e96hbQQ
         xHdkK0mJAbPWFsxqfFdykTgUzJsTSN0I0uocCLYKOrsSFzMMLqLIKYxsuQS3GTi/ErBh
         Vo+bKwQcBJDU+D9/tjgQ01kuLTDAZPu7+VljPdzq6X/mV4LUyWrhh2sDzXMls2OgqopK
         pmtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V6BEPK+M0OwagrMXpdDRFVmxDxwlzupSAEzWiSG+mbk=;
        b=coVLSJ6FW+qNFkGeBlNy5IJQw+qYaMytVPBH7kSZq263dpxofovirQyzBZ3HcNL7z3
         lww/rWncUI6SwuH6SWhAmKGz9EnifUG/PGfcu5amU+Xq38ddbnMd/2QykRE+luHAL5iz
         HvDbS9i4gSITyLA3Z/isdDMnZDeQBAL6e7klXOvNHRbVvvNCLroX5qYdpmADXlP7LOmZ
         PWb2PB92rWgkGlxWSkGj6qeKJBeuQ1MQlLQcZRIAaeA8Necm3dPvNlTCT/rs/kF5wQSx
         hG7IwNzSp5D6Mj+VdCfe8z270oAWsvpUcEgsgLfcceBFl/eV3CMofNef8rcYXZoQxOQb
         SQjA==
X-Gm-Message-State: AOAM532Jbg7iuvOHbaes8KkzUcN5jWFj7jUNY888x4H1fBnboMHCLpKn
        96yFcp78K1VVnuvoQam7CFwdlAmLClcAQD43gvCHMw==
X-Google-Smtp-Source: ABdhPJydMJr38hmVBj83KUD0wIxgHWQHFVZRl2Ir7oen7b0CdLnh6BGcpALYVrRKKypZd2ZA/DOxFVcnPU0+fgW0Xrw=
X-Received: by 2002:a17:90a:a10c:: with SMTP id s12mr14172815pjp.166.1615557203811;
 Fri, 12 Mar 2021 05:53:23 -0800 (PST)
MIME-Version: 1.0
References: <f6efb2f36fc1f40eb22df027e6bc956cac71745e.1615498565.git.andreyknvl@google.com>
 <f9e2d81b65dac1c51a8109f039a5adbc5798d169.1615498565.git.andreyknvl@google.com>
 <YEtGpCV6jwWk1ZNO@elver.google.com>
In-Reply-To: <YEtGpCV6jwWk1ZNO@elver.google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 12 Mar 2021 14:53:12 +0100
Message-ID: <CAAeHK+zbvDvSw=3kE+R+L2SFkwCaEN58nt8xFWwNsvuVvHh_oQ@mail.gmail.com>
Subject: Re: [PATCH 11/11] kasan: docs: update tests section
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 11:47 AM Marco Elver <elver@google.com> wrote:
>
> On Thu, Mar 11, 2021 at 10:37PM +0100, Andrey Konovalov wrote:
> [...]
> > -With ``CONFIG_KUNIT`` enabled, ``CONFIG_KASAN_KUNIT_TEST`` can be built as
> > -a loadable module and run on any architecture that supports KASAN by loading
> > -the module with insmod or modprobe. The module is called ``test_kasan``.
> > +   With ``CONFIG_KUNIT`` enabled, KASAN-KUnit tests can be built as a loadable
> > +   module and run by loading the `test_kasan.ko`` with ``insmod`` or
>
> s/`test_kasan.ko``/``test_kasan.ko``/
> (Missing `)
>
> Also, "the" before test_kasan.ko is incorrect if nothing follows ("the
> test_kasan.ko module" on the other hand would be fine).

Will fix both, thanks!
