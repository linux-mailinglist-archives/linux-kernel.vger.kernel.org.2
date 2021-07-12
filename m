Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A6E3C5B77
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbhGLLZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 07:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhGLLZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 07:25:58 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610ACC0613DD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 04:23:10 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id oj10-20020a17090b4d8ab0290172f77377ebso10367445pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 04:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kt2AGmYUjTDZkmm8PzAzZyi3di7YXnW8FBFskgtoS3g=;
        b=s1ps5tGeXfoWJ4G/NUXXXpU4CB9aPWxOpulMhvVGofy82TEf6BnyXc8kSTarA+GfNU
         ayYomYkpKF0/Qoz831Xs49CFChLkwONquhsFrAHJU1ul+Xeo7lMnrpDHqaNRIhjmRYMl
         BqmZnm7kvO1oApawTJx8R9yF1yRjro981kQ/QgC77sihwLUVjKoVqFiSWXCavBqbe4PA
         tVKljQR1SaGAU+hsHoPG37xwdK4JXJ6OtzWe+3EWctNvvcW579h+vfyvD9JCGi1KcfqB
         FO7lfcV4loBmu2LV4IvtBp8isVkljfzzefENBjea+fxiIvm7faR5OoMItOWMOKSvy2Rv
         EWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kt2AGmYUjTDZkmm8PzAzZyi3di7YXnW8FBFskgtoS3g=;
        b=XKu+2sLRvDWCXOrhQ3RT6xbg2ErHfHSEQWB7e82snnL+AJYtU+4Jfkrh0JSUu3zCFG
         y6dI/31oWH0CGSWbZPW45sNQdPWYWGkDqq4YdMvl2eexhIdqYAs3NlT7fwUZMNcNQJ+2
         rqsQAbJ8srySkJ1VNBRAnEB8AKiozrJzPlTLFI14+EZyowyXLL0NbJgBUbUe39XlbiIc
         eezm03pN59wvd1jnZkg4LzYP4jq/A6welbhewgnnrBDgn+lB+2xtLiY03jX0C9O65Zmx
         cfMYTMbnOwZR4sq7OSwZFsnIP03mJ5n/RSpPBXBb8tMw1uj8ipjRcoeDKNy0REi29Dfr
         Uc1A==
X-Gm-Message-State: AOAM531uf3qC18taMeoA4ELbgm+4mx5ye7NTR3X1spVS7mot56uEUmgz
        W5GrhRPGHOMvnYRfwZrm2wGxV9uhhf12UAbALKg=
X-Google-Smtp-Source: ABdhPJxnbBUtCRd8IUB8RZUFuj9gymPfTMAXuubf+nYYfgurgNSVnJiJtFjEufNaW+4v2EPvULH8yK76Iy8cYi9LBV4=
X-Received: by 2002:a17:902:b08e:b029:129:a9a8:6dbb with SMTP id
 p14-20020a170902b08eb0290129a9a86dbbmr29438350plr.21.1626088989908; Mon, 12
 Jul 2021 04:23:09 -0700 (PDT)
MIME-Version: 1.0
References: <202107121816.wo6I99CS-lkp@intel.com>
In-Reply-To: <202107121816.wo6I99CS-lkp@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 12 Jul 2021 14:22:30 +0300
Message-ID: <CAHp75Vc53u=Rgawnwn3nGCBn9Vqd24Z7fSkBiC35rzbC=VGKiQ@mail.gmail.com>
Subject: Re: [gustavoars-linux:for-next/kspp 5/5] kernel/debug/gdbstub.c:1049:4:
 warning: fallthrough annotation in unreachable code
To:     kernel test robot <lkp@intel.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        kbuild-all@lists.01.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2021 at 2:11 PM kernel test robot <lkp@intel.com> wrote:


> All warnings (new ones prefixed by >>):
>
> >> kernel/debug/gdbstub.c:1049:4: warning: fallthrough annotation in unreachable code [-Wimplicit-fallthrough]
>                            fallthrough;
>                            ^
>    include/linux/compiler_attributes.h:210:41: note: expanded from macro 'fallthrough'
>    # define fallthrough                    __attribute__((__fallthrough__))
>                                            ^
>    1 warning generated.

> 53197fc4954924 Jason Wessel        2010-04-02  1039             case 'Z': /* Break point set */
> 53197fc4954924 Jason Wessel        2010-04-02  1040                     gdb_cmd_break(ks);
> 53197fc4954924 Jason Wessel        2010-04-02  1041                     break;
> dcc7871128e994 Jason Wessel        2010-05-20  1042  #ifdef CONFIG_KGDB_KDB
> dcc7871128e994 Jason Wessel        2010-05-20  1043             case '3': /* Escape into back into kdb */
> dcc7871128e994 Jason Wessel        2010-05-20  1044                     if (remcom_in_buffer[1] == '\0') {
> dcc7871128e994 Jason Wessel        2010-05-20  1045                             gdb_cmd_detachkill(ks);
> dcc7871128e994 Jason Wessel        2010-05-20  1046                             return DBG_PASS_EVENT;
> dcc7871128e994 Jason Wessel        2010-05-20  1047                     }
> dcc7871128e994 Jason Wessel        2010-05-20  1048  #endif
> df561f6688fef7 Gustavo A. R. Silva 2020-08-23 @1049                     fallthrough;

Obviously this should be inside ifdeffery. Easy to fix cases.

-- 
With Best Regards,
Andy Shevchenko
