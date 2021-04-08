Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6DAF357BED
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 07:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhDHFoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 01:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhDHFoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 01:44:15 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B086FC061760
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 22:44:03 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id y2so443184plg.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 22:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=EkHfFpR6mRQDl4oJirm0PloxNhQZM6zzTuwn8wuG5RI=;
        b=DmcgUUF53Mo/CbIv2slW80r0AyvtxHvESwkRQ0QMYy6OfKSdNVCL44gVHeYTqxDQka
         /9Ji1qVyonRP1tqUnl4rIje/mA0m5g6AB+4iD5jksRUZMezKWFh/m7lIreI8+aXlnFNi
         wZXjp5VtKmqvMyZTtWPbvmtykyCJEV4i4KOIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=EkHfFpR6mRQDl4oJirm0PloxNhQZM6zzTuwn8wuG5RI=;
        b=f2UwWJF9ptH+IPJSCxivp/VMr/Et/3FuvL+Dt2kTTDWJF7mplxGC2VBJQdM9mdzzH4
         Vplq9dPP7/LGC+pgfM6U+xGC7a3415gnxFX2J6NTw/2K9QnjRNu254GJhlbD55d8G+d5
         VrND78cFLEQN+AAcF0eVAT/5agWcGnL27BryodSXTLAs2Lgbq1Ece+VvwC9JxFivoSrM
         0wcmYqPuN6p+pMacxvLfwtL7A1GJPuWQ/nAVTHvNZRlui/9hYTUiEx8EOJXEveUDmW8p
         0v8kskDvKzsBR4MrTqwD11vYLjeapgAnFW6qRR19WtcXaHsVwQUidfhDsvmbdLIts5CH
         RtEg==
X-Gm-Message-State: AOAM533+A/n8S7URgilkxZIAxExiFaH3a/6i/LgyKd+5b/zPcybF4IUr
        5eD/KBsCFgduUvKGEZMnsfD/eQ==
X-Google-Smtp-Source: ABdhPJytOBgMko8ppqBDmO+OJyRqUooVvL47gBLUIkf+JBVRoWYtngCTQ1JtJhTLs/6gGMICWNqKHA==
X-Received: by 2002:a17:90a:e50d:: with SMTP id t13mr5111783pjy.160.1617860643252;
        Wed, 07 Apr 2021 22:44:03 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:e193:83c5:6e95:43de])
        by smtp.gmail.com with ESMTPSA id n21sm813679pjo.25.2021.04.07.22.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 22:44:02 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YG22znIOouERDND0@alley>
References: <20210331030520.3816265-1-swboyd@chromium.org> <20210331030520.3816265-4-swboyd@chromium.org> <YG22znIOouERDND0@alley>
Subject: Re: [PATCH v3 03/12] dump_stack: Add vmlinux build ID to stack traces
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>
To:     Petr Mladek <pmladek@suse.com>
Date:   Wed, 07 Apr 2021 22:44:01 -0700
Message-ID: <161786064151.3790633.17528429348664284217@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Petr Mladek (2021-04-07 06:42:38)
>=20
> I think that you need to use something like:
>=20
> #ifdef CONFIG_STACKTRACE_BUILD_ID
> #define BUILD_ID_FTM " %20phN"
> #define BUILD_ID_VAL vmlinux_build_id
> #else
> #define BUILD_ID_FTM "%s"
> #define BUILD_ID_VAL ""
> #endif
>=20
>         printk("%sCPU: %d PID: %d Comm: %.20s %s%s %s %.*s" BUILD_ID_FTM =
"\n",
>                log_lvl, raw_smp_processor_id(), current->pid, current->co=
mm,
>                kexec_crash_loaded() ? "Kdump: loaded " : "",
>                print_tainted(),
>                init_utsname()->release,
>                (int)strcspn(init_utsname()->version, " "),
>                init_utsname()->version,
>                BUILD_ID_VAL);
>=20

Thanks. I didn't see this warning but I see it now after compiling
again. Not sure how I missed this one. I've rolled in this fix as well.
