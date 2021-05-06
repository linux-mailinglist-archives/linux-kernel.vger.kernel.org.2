Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4E3375C0F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 21:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbhEFUAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 16:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhEFUAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 16:00:47 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA97C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 12:59:46 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id u25so8629263ljg.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 12:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Dib0ap8pVVyzHGMoOnbjRtDpjw27aDT98CG5+FNDso=;
        b=ECX9wqZRsoNORdRgkAwtOgVZ5f0I5ReWfKPlVW9WkVoOyPkKuknHSV3aa7dCrEskjr
         eLl4a19vKpxAbnyuNLHYgAaVJZ0yFiPf5sq5mKSK7+zfa+U3ToLBk1xO2VbEbYrS60cd
         cBbNKvQcCAbUF5wwHqEEjpTN8YZv25Ilqr3sGqJzd/H1tcSA4ORq7vu5fYCYmZH4s0/3
         NjPm1U5i2M+kqrcGbsi5znKrK3jQHJ/BsShd2CxZVPRJIdJ7sUdhS6yu+dSeiTu+05ai
         AcSMfsx2Ji/8yWKv164fbCEUx0t4p260kzkAQIfTDq6Ok+QuiTuFpeC+z9JfbbcKYLBH
         t5rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Dib0ap8pVVyzHGMoOnbjRtDpjw27aDT98CG5+FNDso=;
        b=fGZD5kF+Nd0+1bG13WGOUTj5wLg9LTlRkKVifxNYD8S+VIdWM6xiHvej0GfvrQHPIs
         sRcgKIg1lPF1b4KVwVLA4sPi7xn7rInaubo0GtMy2VnQhOfoGa1NqnGSY3Jjo/m86P+K
         daF1fP9p5MAYhraUOFfIxYbB2npP0h7BZARp451ofHe9YgSKcZLQpZNmkP+njirXJd70
         LPk485ezkvNurOc6x7ILK2HLSsLvTkbBAg9a6nBHIxKqbz3LF0Hh0RIr0PlNmxM5aAXl
         ok7eQEZELHL4Rl3YwOX633vniP9BtIZsaV7QlrRL9pHguIGyAH+3g2NhXOyTqp0m3ftS
         jWPw==
X-Gm-Message-State: AOAM531jKP6pZowA3lskT7J18hQ+aK4x7uoEo9UJ5/qZTL/qU1h9GP4F
        aS7yuu3cz92U8YKya1YUPi4/3mrKUQ9MK6LXYsq/0A==
X-Google-Smtp-Source: ABdhPJzi5PMRWHuSj8/yG8mL821ma0ZSRlhIkybSIDQuUi+XMA3VYuGKc27HP/HxD2VRlDIpI6ivbxWlwza5oEZc7Kc=
X-Received: by 2002:a2e:6e13:: with SMTP id j19mr4941618ljc.116.1620331185244;
 Thu, 06 May 2021 12:59:45 -0700 (PDT)
MIME-Version: 1.0
References: <20201230155506.1085689-1-arnd@kernel.org> <20210105202047.31569-1-ndesaulniers@google.com>
In-Reply-To: <20210105202047.31569-1-ndesaulniers@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 6 May 2021 12:59:34 -0700
Message-ID: <CAKwvOdm4UkDOa00M6+U=RjEhAjo-RSZcuf_a9mhGtM2TRhvGOA@mail.gmail.com>
Subject: Re: [PATCH] ARM: avoid cpuidle link warning
To:     Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     d-gerlach@ti.com, Joe Perches <joe@perches.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>, ndesaulniers@gooogle.com,
        Miguel Ojeda <ojeda@kernel.org>, ssantosh@kernel.org,
        tony@atomide.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 5, 2021 at 12:20 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> > Since commit 83109d5d5fba ("x86/build: Warn on orphan section placement"),
>
>
> Might be better to use:
> commit 5a17850e251a ("arm/build: Warn on orphan section placement")
>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Which tree were you planning on sending this through?
0day bot just pinged us again about this.
https://github.com/ClangBuiltLinux/linux/issues/1372

-- 
Thanks,
~Nick Desaulniers
