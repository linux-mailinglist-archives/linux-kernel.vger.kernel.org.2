Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D256F3A3161
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 18:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbhFJQx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 12:53:57 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:41562 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbhFJQx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 12:53:56 -0400
Received: by mail-ed1-f49.google.com with SMTP id g18so31847706edq.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 09:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bp6LvbTQVyzjMEi6wu5Mnp8jX00/m6s57GNvET58FOo=;
        b=ZnadtM5epcBD+4Cp5Oz7XjM95Tc8RoqKEZiTjoS3+g/5zNMiTlJ9tnG4dnpp5ZypOi
         11CWXzvKZtG3yPeoXJ28Cgn5m6xRhPdzVqKyn/Ioedu6456TybmNOtgyKVyHH5sUuSZD
         Pc/X6VQitO34zJbnYbd8haf0Md4wgmUSBrXwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bp6LvbTQVyzjMEi6wu5Mnp8jX00/m6s57GNvET58FOo=;
        b=l6mNGMADcQsnK39P+5k2uCMQ+Thqaa+e75h32gofpO9XA2xXMeL3WVOEm1NT40sjCe
         ugNeeAmb9oDtkQL8Vd6LB3B5MdrVQcEjyDviDVKkxruodozRvqo6E0ZDeW9ZLLbygjCg
         /ojXuM78dBy5Jl3YUn678OUnIAGDzfLdhncpNG5QfxIS6pEkzFn8qeStGp35km1SIqBq
         iY4DwRMuWsU+qPvUL+4H8l5qQYYK/hLLlLoezeAP6AhtD5OenkUsN/idXpgMekU9T8Jc
         CM5znFvDmJMSzI6INhChXFmCfb7sXPehWtuwa5ZxBZSSdWiFIj9PfU8JBxFvI6F8b9HU
         mb2g==
X-Gm-Message-State: AOAM5325QPbxDPIaSl10u9B/ggNOLsmfAEnaEx/rcPZ7rfKeV/O4Sf94
        iMSpj31CXzxpCquO/0Rbzo8cgMTawH+9vd03RhiY4Q==
X-Google-Smtp-Source: ABdhPJz+ZmiSGZrHNtkFBN4miDJMJymldyO+LnR6cbXH+76gEcwRIpP8yXh1meoLW8CFrdoyZFxFp3qkh09HONZa9qQ=
X-Received: by 2002:a05:6402:10cc:: with SMTP id p12mr411825edu.328.1623343858979;
 Thu, 10 Jun 2021 09:50:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210608230929.GA1214@raspberrypi>
In-Reply-To: <20210608230929.GA1214@raspberrypi>
From:   Micah Morton <mortonm@chromium.org>
Date:   Thu, 10 Jun 2021 06:50:47 -1000
Message-ID: <CAJ-EccMvTNpnZXAF6n2x7oXu_hsSOnbJvvQA6NsK1VG26t5CeQ@mail.gmail.com>
Subject: Re: [PATCH] LSM: SafeSetID: Mark safesetid_initialized as __initdata
To:     Austin Kim <austindh.kim@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        austin.kim@lge.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the patch. Looks right, since that variable is only used in
safesetid_security_init() and safesetid_init_securityfs(), which are
both marked __init. I can merge it to the safesetid-next branch today
and send the patch through my tree during the 5.14 merge window.

On Tue, Jun 8, 2021 at 1:09 PM Austin Kim <austindh.kim@gmail.com> wrote:
>
> Mark safesetid_initialized as __initdata since it is only used
> in initialization routine.
>
> Signed-off-by: Austin Kim <austindh.kim@gmail.com>
> ---
>  security/safesetid/lsm.c | 2 +-
>  security/safesetid/lsm.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
> index 1079c6d54784..963f4ad9cb66 100644
> --- a/security/safesetid/lsm.c
> +++ b/security/safesetid/lsm.c
> @@ -22,7 +22,7 @@
>  #include "lsm.h"
>
>  /* Flag indicating whether initialization completed */
> -int safesetid_initialized;
> +int safesetid_initialized __initdata;
>
>  struct setid_ruleset __rcu *safesetid_setuid_rules;
>  struct setid_ruleset __rcu *safesetid_setgid_rules;
> diff --git a/security/safesetid/lsm.h b/security/safesetid/lsm.h
> index bde8c43a3767..d346f4849cea 100644
> --- a/security/safesetid/lsm.h
> +++ b/security/safesetid/lsm.h
> @@ -19,7 +19,7 @@
>  #include <linux/hashtable.h>
>
>  /* Flag indicating whether initialization completed */
> -extern int safesetid_initialized;
> +extern int safesetid_initialized __initdata;
>
>  enum sid_policy_type {
>         SIDPOL_DEFAULT, /* source ID is unaffected by policy */
> --
> 2.20.1
>
