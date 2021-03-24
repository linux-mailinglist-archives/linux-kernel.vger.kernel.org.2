Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 263DC34812B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 20:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237709AbhCXTEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 15:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237587AbhCXTEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 15:04:11 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1E0C0613DE
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 12:04:11 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id y5so18062051pfn.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 12:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=ydJslxZAK2WZvX/LZKXh2BcFE6drith5oqN9B/p/XPk=;
        b=OtUJnD8XZgupxktcYLPPE9/QS013oZxRJutmfngeqKi4Sn4/lvRn5iuiHAm5p3tsKn
         ATVTawjfdma7grv9QW1CLORFpoX1SJH2vWnfxORUSw2wcSUfmeoAYiPHcTCN2gh+C5WJ
         nv6ZyVXpSxuovVBiijU1P30/j6JVhEw099fZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=ydJslxZAK2WZvX/LZKXh2BcFE6drith5oqN9B/p/XPk=;
        b=klNFGWAwwqvsJTALv4Rn7pvdkj8gCeWBCLqLDX2IsiyTj9bFzqG4wU1DOf1ozrFEPr
         HuCjb0HnUmAOQVYtKtmCaTXQOqSOrlrbjWtLvspMTlI5y2JSg9b1V9GWtJnd/Yxl6NMz
         4k0l669H++LIE2iqabJ9GCPLT2ChbE6A+ywLxT1hlAGLA9I7slYO/Tf40VX4R1cRTwm8
         gg8yi7XClj09MyHPsGCVy7ikwe0X8X00Izb4N4yejxjq3fw98ZxMtJ3PQdmUL0waJqEX
         A0iF9PIEZfTywCvhQaX3ri07JDAYNPM4JLiDI9PBEeo+A039qSACazqbx7JJgUwhOjx4
         yhTA==
X-Gm-Message-State: AOAM530TAbF6Q1wUsJn76a5PIF5rk3+oTBaLt6ilftooFiXBOlX0rOkT
        +0YQPbb6ZJYLCdRYvYc+OgHm0TbiCj1K/Q==
X-Google-Smtp-Source: ABdhPJzikGnVG30zD3et0t/4zVeDLJHAbAGLf+pZlMK8RHOvuX6Ba6n2v4W9jHuEhpni1cPI/6rNtw==
X-Received: by 2002:a17:902:dac9:b029:e4:b52f:1d38 with SMTP id q9-20020a170902dac9b02900e4b52f1d38mr5035032plx.15.1616612650026;
        Wed, 24 Mar 2021 12:04:10 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:84ac:62f7:16a8:ccc7])
        by smtp.gmail.com with ESMTPSA id s76sm3502496pfc.110.2021.03.24.12.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 12:04:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <32011616573677@mail.yandex-team.ru>
References: <20210324020443.1815557-1-swboyd@chromium.org> <32011616573677@mail.yandex-team.ru>
Subject: Re: [PATCH v2 00/12] Add build ID to stacktraces
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Young <dyoung@redhat.com>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Ingo Molnar <mingo@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sasha Levin <sashal@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vivek Goyal <vgoyal@redhat.com>, Will Deacon <will@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Date:   Wed, 24 Mar 2021 12:04:08 -0700
Message-ID: <161661264804.3012082.14951998760354509511@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HTML mail?

Quoting Konstantin Khlebnikov (2021-03-24 01:23:55)
> 24.03.2021, 05:04, "Stephen Boyd" <swboyd@chromium.org>:
> =C2=A0
> Looks too noisy for me. Maybe print id in the line "Modules linked in:"?
> I suppose only out-of-tree modules need this?
> =C2=A0

Please see this note in patch 4:

Originally, I put this on the %pS format, but that was quickly rejected
given that %pS is used in other places such as ftrace where build IDs
aren't meaningful. There was some discussions on the list to put every
module build ID into the "Modules linked in:" section of the stacktrace
message but that quickly becomes very hard to read once you have more
than three or four modules linked in. It also provides too much
information when we don't expect each module to be traversed in a
stacktrace. Having the build ID for modules that aren't important just
makes things messy. Splitting it to multiple lines for each module
quickly explodes the number of lines printed in an oops too, possibly
wrapping the warning off the console. And finally, trying to stash away
each module used in a callstack to provide the ID of each symbol printed
is cumbersome and would require changes to each architecture to stash
away modules and return their build IDs once unwinding has completed.
