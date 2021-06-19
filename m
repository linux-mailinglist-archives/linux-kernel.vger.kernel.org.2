Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA0E33AD7F2
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 07:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbhFSFGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 01:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232924AbhFSFGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 01:06:07 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23DF1C061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 22:03:57 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so11843676otl.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 22:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=3mMdu9LseXe+ymUT/wP7oypou8lDboqPRRR7IbCiXfQ=;
        b=SCPLeFXlxJnkQ4idfbSuA//Lg2Tn8jS2nBveT4ICGwBzoHDlnP0gIhJ4pRCP9MgQ2D
         ZVvEtPAPhMHYrmfQx0KUG9inWuRi8C3jyBeJTuuponLZv8rmQQHOC87c9tRTqflPJXpO
         ERnL4GowTYJU2HhR9cypVKK0s/BnUFFWI6NZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=3mMdu9LseXe+ymUT/wP7oypou8lDboqPRRR7IbCiXfQ=;
        b=CQzFOT1u45OR3Ou7PiPpIcH31xKyU4tmZMhr/1Mu3PGrKLh6daaBN3XP1LPA7l4nGT
         HSakoP91mvS7o5RrdHnNXu71w/JGlIwQQKMlcQTtaW+9zVi/fneK/xVX+19oKWviPCxG
         ORspz+yEtNLyC7+igJUItwGwb2chc45hWx/plrT0GWIKPCHJaQF6LVYRUaVu3Dn0GVRI
         YH3Fu10tZ/mXXV8oleiiVJc3wcxD8/8Ptm8e+AFko83K1Lwonvf5fSDpGU+hr6dRYNmT
         AAexFofX5e0ZMB46RG24+VF0GbcyywyPf1eUYWAkBp1qawgUYxgbtWgP4/s2XXuqqBSG
         91MQ==
X-Gm-Message-State: AOAM532YlhN/9DpR1e8uV8aqkJ0mBpCrrbmjfDo+hJIKp4i6FqBvx+mz
        v1sjMFqbydMdthi4dCfhzUTdGF63RFx8WSQXolIHyA==
X-Google-Smtp-Source: ABdhPJzyHnvx+IHPysUXoXKO+WpriDPcIB8125hq5StBjgIs3XlXYEcb+4/k+SbDzhhuvn6FIlYMUCbPMUd1T25ABQ4=
X-Received: by 2002:a9d:4e7:: with SMTP id 94mr12250496otm.233.1624079036367;
 Fri, 18 Jun 2021 22:03:56 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 18 Jun 2021 22:03:55 -0700
MIME-Version: 1.0
In-Reply-To: <20210617071027.60278-1-hexin.op@bytedance.com>
References: <20210617071027.60278-1-hexin.op@bytedance.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Fri, 18 Jun 2021 22:03:55 -0700
Message-ID: <CAE-0n51T9ZGADCk6LaKJdnQwPvMCawSvjwUP+AF0hFohAFom0A@mail.gmail.com>
Subject: Re: [PATCH] debugobjects: add missing empty function debug_object_active_state()
To:     Xin He <hexin.op@bytedance.com>, keescook@chromium.org,
        tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Xin He (2021-06-17 00:10:27)
> All other functions are defined for when CONFIG_DEBUG_OBJECTS
> is not set.
>
> Signed-off-by: Xin He <hexin.op@bytedance.com>
> ---
>  include/linux/debugobjects.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/include/linux/debugobjects.h b/include/linux/debugobjects.h
> index 8d2dde23e9fb..af0d73d8d29b 100644
> --- a/include/linux/debugobjects.h
> +++ b/include/linux/debugobjects.h
> @@ -99,6 +99,9 @@ static inline void
>  debug_object_free      (void *addr, const struct debug_obj_descr *descr) { }
>  static inline void
>  debug_object_assert_init(void *addr, const struct debug_obj_descr *descr) { }
> +static inline void
> +debug_object_active_state(void *addr, const struct debug_obj_descr *descr,
> +                         unsigned int expect, unsigned int next) { }

I suppose it's a landmine that may go off at some point, but this isn't
fixing anything that's broken at the moment, correct?

>
>  static inline void debug_objects_early_init(void) { }
>  static inline void debug_objects_mem_init(void) { }
