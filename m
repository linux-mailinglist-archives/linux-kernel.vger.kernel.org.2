Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 272593EAFB3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 07:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238743AbhHMFhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 01:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbhHMFhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 01:37:38 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0DBC061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 22:37:12 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id bq25so6177485ejb.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 22:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kbfFIzCXJXm2mb2HL21fYHsJzsbToxStao3lrf8Xu6s=;
        b=RsSxJ35HiHNogTvJHfC/o7Or10a/19DXuVUr9aKlkfAdrL/E8CpzheEeOKgWyoEu1Z
         m5QXB+VZKQSifYBy6s8OyL85N5LK7DyNURyYguM5wkB4twxScIw0zexGnXlYYjjgrKQ0
         BXZolhKgYbABSxKr3YZEAMroumpYhGg2EbAAlu27lpyFOSrj3EWxdEMignmwM/1iqGOs
         psJdgmxtiBUS5O6CJO9GnPa8pxHjJqCRg5G7NqWfwcsF2T9IRTtH5YSo+eV+Jk87rO77
         JUfzyYNOTGptWPD0shv//P6WHY/ZELmU6lEQ7ETlNH8yuAqOSYLA9Oc0hog4jyw+9vZe
         6TPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kbfFIzCXJXm2mb2HL21fYHsJzsbToxStao3lrf8Xu6s=;
        b=gYZIvicvvTPgIgeiQHm1QI8ZbQbRwdj13uXwZLIydIdFUhYjuPiBTQ3FjCJwQlRcgM
         CYLAxng+is6miQJBRMtB2Kh7jceGZgE+sgpwFtCbTtsCDK56FuJxi6oJh7TneVddlIub
         xnO75eDESzWnxnCO8JQ+ZRRM8q0JVFoSyfMKJVC9DcG2IrQWYYWCGF3yT/adjVBAuL12
         jcCNnTnaopZjXWQNN9IT43HUnSCAbVchmvEj5okcQCfzEn48X0L+lVf1F0fS0r9ajwQ6
         n/3n8MBqPClw+aVaSGbrm2G77gIBx7r7fVxE6tB8ZT6V1o5+tW5L3moTYgNutlQA1uWD
         4a0Q==
X-Gm-Message-State: AOAM533DIlWZLdiCt98lTm7MjW3U2p7bo1OgmfvuUQ+Q5owv0c0RJMT8
        vs8TvnnmnviZpwvZJwnV0vQBEXCQCUOepgVSc5I=
X-Google-Smtp-Source: ABdhPJzgVjmdjPAB+6bo7s+LzEpblcSMEA5+lydV8hrMyCB6P2Ti2ivVZ0/O9/YwPU2BNNizrVGSMx8i1nIle47EqcA=
X-Received: by 2002:a17:906:5d6:: with SMTP id t22mr811797ejt.98.1628833031203;
 Thu, 12 Aug 2021 22:37:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210811163731.186125-1-masahiroy@kernel.org> <20210811163731.186125-2-masahiroy@kernel.org>
In-Reply-To: <20210811163731.186125-2-masahiroy@kernel.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Thu, 12 Aug 2021 22:36:59 -0700
Message-ID: <CAMo8BfJSfxQtDFknb8Zs-DzUMbpB3OCk+02Hq03bGzAJagQ65Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] xtensa: do not build variants directory
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Chris Zankel <chris@zankel.net>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021 at 9:38 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> None of arch/xtensa/variants/*/ has Makefile, so 'buildvar' is always
> empty.
>
> Perhaps, downstream variant code might be dropped in, but given the
> fact that none of upstream variants builds anything in their variant
> directory, I doubt this is needed.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  arch/xtensa/Makefile | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Thanks, applied to my xtensa tree.

-- 
Thanks.
-- Max
