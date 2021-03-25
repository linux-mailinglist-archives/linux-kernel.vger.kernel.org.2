Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03DE0349CD1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 00:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbhCYXTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 19:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbhCYXS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 19:18:57 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76888C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 16:18:57 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id h3so3585202pfr.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 16:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=E8j/bdX2kJWue1KfFfCvsB+FUorkATZNWqrPIA9V9io=;
        b=fPenDc9g4ElZjbnp9wO0ZEo9yJBBmKT4skMDK1gIw7yzZ35xxLWcOcn7+Y1OvWo2op
         WbNhplaWof6tDYhjhgoYKgr1C4E6/xabG93hv9JLwCaXf0NIIy2XegAbUI37I+y68UHS
         BHZIs0CAvyofBUY/+7sH2EXthFU/EzsBjQcCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=E8j/bdX2kJWue1KfFfCvsB+FUorkATZNWqrPIA9V9io=;
        b=XTZHFWlikyCW8Vzw4qCmBqLmLHwUvaflyJj6kMe6j/Ph8oEHUyW0bN0R1CrBi2QwrD
         FgQavdHRadXRaAaoTdam6BKw4OWFHCrKOvmkE1w6SizEgeNGAhsxB/f03g50G/rxJ/xg
         dMP8WtTyU9Glh5KJHwPGLOka/GrqlR79sDn09x+4PhlnpUuCY0bh01bnGfLgm07jjej6
         d/8ba6PdLAMhFuoWRyUtwfyW6ZPJpa0SxHbesfs4DJ9ePKZfjF9fgKYEFnyzD4WOIpFK
         i6yh4XQ9F05T2G/ejTm6Wm2GkZHH1x7LM7Hpbpt3fdQx5n/9og4m9MZ2IbpPybmNmWTh
         P9Tg==
X-Gm-Message-State: AOAM532k3N6gjIThQP6jjrlclyoNiIPsBJsVL81yGNzefxuYHBRpBCzQ
        jIZF0o/zXROpesMTW7TNQjzBHq4f+K2rNg==
X-Google-Smtp-Source: ABdhPJys5ddfm6i49Gf1rvQpJirSrhY5z4HOtE0oXEK58wl0DIRsoGxj6h+wB3BH871rWsH7gxPVtw==
X-Received: by 2002:a63:24d:: with SMTP id 74mr9447813pgc.98.1616714336899;
        Thu, 25 Mar 2021 16:18:56 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:18a3:238:26c5:1521])
        by smtp.gmail.com with ESMTPSA id z18sm7253821pfa.39.2021.03.25.16.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 16:18:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <a7a5e6b4-109b-fdf6-5d72-1d8675a2b1ae@sony.com>
References: <20210324020443.1815557-1-swboyd@chromium.org> <a7a5e6b4-109b-fdf6-5d72-1d8675a2b1ae@sony.com>
Subject: Re: [PATCH v2 00/12] Add build ID to stacktraces
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Young <dyoung@redhat.com>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Ingo Molnar <mingo@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, kexec@lists.infradead.org,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sasha Levin <sashal@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vivek Goyal <vgoyal@redhat.com>, Will Deacon <will@kernel.org>,
        x86@kernel.org
To:     Andrew Morton <akpm@linux-foundation.org>,
        peter enderborg <peter.enderborg@sony.com>
Date:   Thu, 25 Mar 2021 16:18:54 -0700
Message-ID: <161671433461.3012082.9521190652380269571@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting peter enderborg (2021-03-25 04:14:31)
> >   el0_sync_compat_handler+0xa8/0xcc
> >   el0_sync_compat+0x178/0x180
> >  ---[ end trace 3d95032303e59e68 ]---
>=20
> How will this work with the ftrace?
>=20

It won't affect ftrace, if that's the question you're asking.
