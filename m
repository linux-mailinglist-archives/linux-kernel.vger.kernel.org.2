Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27EC53066C1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 22:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234438AbhA0Vux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 16:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbhA0Vtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 16:49:47 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D12C0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 13:49:07 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id lw17so3658593pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 13:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wZd0cLL8ZkUlig0+5sOea8FRbUknLAg/BHGcl5UT8Zo=;
        b=V0jvldsgkAQ6p4niyE1KX+Xm7IHhqL4jpu0MX/D+zKeLACVujX9bdSRlz6ohuMYLVr
         rRieejh+eLgW4pOSVM7ixznGU6FFaGevQwdeoeAKtNWgPeTDeAsQsN6RRmmHlIcZy4zz
         r8Jy6tvObtXG//po8RxpMYEbSkZwaltYjLGPxkhU7YCT/0/aElCy97zDrIImXoU9iVWh
         U2bcVBCuz4W7tdmEO3DnsowlTo6qr9GP5PeeUx1OuKKsQjpmi3Z3VxbQuQNTtXHRQ8rg
         pbfAp8zfD4nxfhHHTWDIoOwOCu8tMNxQoEtpTRnvB9cjyxY9+ZsrjW9G5IzT6vY7hmbE
         XsIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wZd0cLL8ZkUlig0+5sOea8FRbUknLAg/BHGcl5UT8Zo=;
        b=fSrxF5qm/MpbIz7P0aFcy7+m7D7MVTjQ6KVDvI2Z1XTWE49dRyG2VLKXrYGvz2Galu
         njFjr2PwwGy//ZRDKnONaOAbzP8dvO+enD+qZxT/8H0y3bx352I8brTUvl963MYgWR/R
         MroKUHRggohh0fpyu2mUbk57woscRgmwnGL9GUcpJQcMWsfO4CD2ZZDOFkBeGZ6pWKVW
         OCFgygejziX0WkxMfMn3ct0N0BDPxMpknskuFvpGEU4+jkTapNjjMUXZKGiod4ibuVVd
         mt6TGBqiiHxY88S2i7ku70LS1lJZsQJ8510j6fqEvK0VryUZ8L06v+DWlUDmJrnKinra
         B6CA==
X-Gm-Message-State: AOAM5319hLj6DE3KMRiEardQQ2Ts4yTIicfrwcTSJRI7YKFu6cUlNm+x
        OW6iBJlBCE+SjNkw374AGXmcGhzzYHFk/z50w2gi6w==
X-Google-Smtp-Source: ABdhPJzrtLOY3/bRGtWXoxV/r9UfogmltpxURK2K3Xajg+ROBnmuxofCLWYR15ZE3gomKtDCpXVFBiqenHLbikV6eD4=
X-Received: by 2002:a17:902:ff06:b029:de:362c:bd0b with SMTP id
 f6-20020a170902ff06b02900de362cbd0bmr12924105plj.13.1611784146896; Wed, 27
 Jan 2021 13:49:06 -0800 (PST)
MIME-Version: 1.0
References: <20210125112831.2156212-1-arnd@kernel.org> <CAAeHK+yOTiUWqo1fUNm56ez6dAXfu_rEpxLvB1jDCupZNgYQWw@mail.gmail.com>
In-Reply-To: <CAAeHK+yOTiUWqo1fUNm56ez6dAXfu_rEpxLvB1jDCupZNgYQWw@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 27 Jan 2021 22:48:55 +0100
Message-ID: <CAAeHK+w4vt6ZDH+Nxy0z4-FzgViDDCDY+jhAXXsUgQKh0bPi7w@mail.gmail.com>
Subject: Re: [PATCH] kasan: export kasan_poison
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Walter Wu <walter-zh.wu@mediatek.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 10:25 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> On Mon, Jan 25, 2021 at 12:28 PM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > The unit test module fails to build after adding a reference
> > to kasan_poison:
> >
> > ERROR: modpost: "kasan_poison" [lib/test_kasan.ko] undefined!
> >
> > Export this symbol to make it available to loadable modules.
>
> Could you share the config you used to trigger this?

Never mind, I realized I've been using a branch that already contains
your fix :)
