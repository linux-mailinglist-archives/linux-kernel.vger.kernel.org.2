Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E7D44801A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 14:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239850AbhKHNQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 08:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239844AbhKHNQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 08:16:34 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB010C061714
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 05:13:49 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id l43so31341538uad.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 05:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wCwO4XStYiPzdzS4nIOsFCtzFEfsNHH4FacnUzvafCQ=;
        b=ThmXplP4IL5iiwXNCOtfVrvVcZdPEl4pH5vajs1II4iMrbzAEPM0gQNT2zQdZYc4wr
         LtUIGM5zMuUesN4IO2OjcJXws2H2NTSLEdBT9qebiN+Bss9aQiqbMf3GedUI8YezwU6l
         VP9jEeX1sKVj2kM3G9KX5cuRnYFpe98rOn+4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wCwO4XStYiPzdzS4nIOsFCtzFEfsNHH4FacnUzvafCQ=;
        b=jkfCgoFYTCzdcJtOidkOLtaWA2v2CBm0ph30YkJUtlv7PVhGqsG67MmYy6e9S01hJz
         9A27kmrOQ8QgGoN+I3xj7qZwQxNvt3CBpVoPoPSmpmRyvolO20A/7zm5gcbeSFPT4Nl8
         auxwISr2dl2Q02jG5gzjJPUkXoYM6MHdyolWm1s5Ye0HmGgFwb+YZX/5ntuJZs3kS3/e
         Kz3Ke8IagJPe5i+ehl2vBLcO+KTNsTZFN8g6hCSGRh5nAdkljKKINokIWyo1b9DSdtKL
         STKQIaUwdX098F9VtRHtZrlcD00Kp5JnIWzH0nqii+VQwu4lgBccOD32KQQuQJf7XD9L
         HANA==
X-Gm-Message-State: AOAM532IDL8Udr04kmK6cEF+JbHv0l9nhsnCoGe4TtSAQUR3GQeTVsQH
        q8GrWSIlJY3dHQBVUb/2GjLGxUDtnWUKAZrUC/SEqw==
X-Google-Smtp-Source: ABdhPJziU/lixGfO5RAx6kuZy4s+7867lk6OS5u8omESTSSlp9/d4OpA86duVfQSh5aESqDFtVkkGsBz1+OyXbiRtaY=
X-Received: by 2002:a05:6102:72a:: with SMTP id u10mr65700459vsg.9.1636377228738;
 Mon, 08 Nov 2021 05:13:48 -0800 (PST)
MIME-Version: 1.0
References: <YYG0KwuwSyH2uSqz@robh.at.kernel.org>
In-Reply-To: <YYG0KwuwSyH2uSqz@robh.at.kernel.org>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Mon, 8 Nov 2021 22:15:50 +0900
Message-ID: <CAFr9PXnftX3k3C0sAt=qF4fgOS1apF_j4REqJXKk=wzCTVnBfw@mail.gmail.com>
Subject: Re: [GIT PULL] Devicetree updates for v5.16
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Wed, 3 Nov 2021 at 06:57, Rob Herring <robh@kernel.org> wrote:
> Rob Herring (22):
>       kbuild: Enable DT schema checks for %.dtb targets

Sorry for replying to a pull request. I couldn't find the original
patch email for this commit to reply.

Anyhow, the above commit makes buildroot unhappy.
I see this when trying to build any of my buildroot environments:
scripts/dtc/Makefile:23: *** dtc needs libyaml for DT schema
validation support. Install the necessary libyaml development
package..  Stop.

I think this is some mess with pkg-config from somewhere (the host
distro, the buildroot host side,..) saying libyaml is available but
when the build actually happens the header it wants isn't actually
where it thinks. I think this is a pre-existing problem with
buildroot.
buildroot takes a list of the dtbs that you want to build and keep in
it's config and calls make with that list in the kernel build. So this
commit causes this issue to trigger when buildroot tries to build the
configured dtbs.

Not sure what the fix is and I think it's probably a buildroot problem.

Cheers,

Daniel
