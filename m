Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB12347AEC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 15:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236337AbhCXOjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 10:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236270AbhCXOjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 10:39:37 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B5BC061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 07:39:35 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id b10so21703898iot.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 07:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=omwS5puHKjv17pejHb5i9USkJJrZLYB9ETUsyowGcHo=;
        b=L/zTmISKkPm4Bb8Zkz4hwGV9sdssGr2Fgi5D8wpbJMWJtrWdC+gTJCS9fZpsh1in1+
         wyzsjiYY1QuChIqAyEZI+fo2geyk4/Tn8TohZZ2W+LSh/CdmgtZVagTv0j0E4bjg9P0K
         Vup7OM0afjZgAcOZh5YBZiSDSi74G+2KdsJT2Yrt0ruc21A0ybA+V/7ekMdjTXMPneYO
         azIOAZp2YDdCQIBIS6kBXxsK0QRk0te0OTgj4Zkhg6wYK5WsqXNTT6zbGRz8mWwrh8JM
         NXj6jI+WIYRDAreFfy2WR0KNfD3GkJ1Ca86UrKD5SjX5zwVlHbJMKCXW6SxsyOTi397S
         bsiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=omwS5puHKjv17pejHb5i9USkJJrZLYB9ETUsyowGcHo=;
        b=oTkVxyCYCaHZrDHvhaPxmcgs7dipx6sKbbTxS69X0UCtly/Ti165NdGYD6gA2pfzDz
         sp4viOhYBDIbo1rfcmYVHd39R5K/9hV8VmQ+UXIRgbuHGgMltJRFKER+0hwcZ24i3z5d
         LEliUCi1d0yKqJTE7z7Vx18RrkCPnPpv+4HMcNGsyPskfGQqThswQfIx0dEyPtrVcRY8
         +zuK5upNhgwsnHhZu+cVovRhooOt1GsuETwHLaH9mIH2H39MdSK05KSOvyrcFuBy7AKr
         Sg0I822oCy1yrcC1eQJljjrR8Qu41rkUA4+Zxq4jSe0WK3MxB99+2bzi3bogcEseMpA+
         drjQ==
X-Gm-Message-State: AOAM530xu6wgAkkgi79Hk3c7PgJ8zs2wAtGdykqX2y9D4gZz09xiNRgL
        7aMTbxRJnIAxkiSXm2/aM96BMEMHn21F8oluP9RqIw==
X-Google-Smtp-Source: ABdhPJyTsVk1YCFajPZcgUTfkypi6NhdFvf0Emaq+8hkliOyOsf0lxwOTl6O/jALPngnl9Lo4OcfuWGA+zv8KAt4SuY=
X-Received: by 2002:a5d:93ce:: with SMTP id j14mr2794167ioo.172.1616596774845;
 Wed, 24 Mar 2021 07:39:34 -0700 (PDT)
MIME-Version: 1.0
References: <1f1fb01e-0616-34ea-ede6-dc7dd679c3d4@garloff.de>
 <c7074c16-5d64-e829-10f6-ef91f5f6222b@garloff.de> <f6143d7a-079d-3f3c-c947-47fc9858a2bb@debian.org>
 <YFsyh5tEaiVNjqT1@lorien.valinor.li>
In-Reply-To: <YFsyh5tEaiVNjqT1@lorien.valinor.li>
From:   Doug Smythies <dsmythies@telus.net>
Date:   Wed, 24 Mar 2021 07:39:28 -0700
Message-ID: <CAAYoRsXw5-ATytCdgDaOS0dCZ3e=wn_z1tKaxSAsNBkSrSeWWQ@mail.gmail.com>
Subject: Re: turbostat: Fix Pkg Power on Zen
To:     Salvatore Bonaccorso <carnil@debian.org>,
        Christian Kastner <ckk@debian.org>,
        Kurt Garloff <kurt@garloff.de>
Cc:     Len Brown <len.brown@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        dsmythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 5:38 AM Salvatore Bonaccorso <carnil@debian.org> wrote:
> On Mon, Mar 15, 2021 at 10:54:24PM +0100, Christian Kastner wrote:
> > On 01.02.21 10:01, Kurt Garloff wrote:
> > > Issue persists on Ryzen in 5.11-rc6:
> > > kvmadmin@KurtSrv2018(//):~ [0]$ sudo /casa/src/linux-stable/tools/power/x86/turbostat/turbostat

... deleted stuff that doesn't display properly ...

> > I was seeing the same issue (no stats, program just exits with 243), and
> > Kurt's simple patch resolved it for me.
>
> Does Kurt's patch seems good to you and can be applied or is there
> anything missing?

There were multiple patch submissions. Chen Yu kindly merged them into
one, which was put out for testing a couple of weeks ago. Try it and
report back. I'll forward it in a moment.
