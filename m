Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 195BC349CDB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 00:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbhCYXWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 19:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbhCYXVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 19:21:49 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB808C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 16:21:48 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id c17so3620075pfn.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 16:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=9Ws84vBwdALUNuDSs4jVAMy+diRDx2Md148g1OQbTTc=;
        b=bIomJr2Bk4Zm9vhKtqgmB0DgBhdG+cAXemq/KNJQ5YjdF4Ir8D3FPn0QzrNvJQji2X
         0FSNW5TDAS+UMEl7QAIPqKT4l92ItP2sI3vIMDpml6JDcdQeH+0GBbK+2yeD05dBYQHk
         rx5DXqpnAmlg6KEw7mE6P1laO6ApWHZvR4K+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=9Ws84vBwdALUNuDSs4jVAMy+diRDx2Md148g1OQbTTc=;
        b=fNwZ+6avpcUu135UoNzjqZm80z/jFll42JSnpYug+d5c2MngwR+duJwZgpjGpiNocp
         64xM/kmnCaMVHYLZVCDfkC00465/j+l9x9LU9ZKtoxTopZHVO4hex1XMFuDmD48VAshQ
         E2+XMS3COce7++t5yF+r5++rM4BHcSFaNM9eWR0g4RhoqrtXW0dSPADdJYuVBAsw1yJt
         S7wsqCtYe/WQ/0r4mzmGE7f0bZ1Poew4MY1UYYkGoH8YOwh7uwMb9LfxefC7s69Aiw1t
         JlIVNF/S/G85nJPP82n4l8mCGe5iD39IyfJc0/gYgn4vEaMwXWed/VgoHNbntqYgwqsX
         5Imw==
X-Gm-Message-State: AOAM530t7wBAFgdn8C+hMItvUs9VJhSaE9T56vFrCWcJBnTY4tpNftT2
        w75V5qZB0G8JZTX9JqHdV2KHkg==
X-Google-Smtp-Source: ABdhPJykDfKVVwZo+5CSu0mjkD2WFYRhREfbbV6tuLaHdiUl06r8vWpbnf33gx07jSpcUGpHl/oFiQ==
X-Received: by 2002:a17:902:bc49:b029:e6:6750:7fab with SMTP id t9-20020a170902bc49b02900e667507fabmr12773405plz.4.1616714508455;
        Thu, 25 Mar 2021 16:21:48 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:18a3:238:26c5:1521])
        by smtp.gmail.com with ESMTPSA id v18sm8077901pgo.0.2021.03.25.16.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 16:21:47 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <dbb430e1-2223-9df0-2563-4b017d6b409d@sony.com>
References: <20210324020443.1815557-1-swboyd@chromium.org> <20210324085543.GA2660708@infradead.org> <dbb430e1-2223-9df0-2563-4b017d6b409d@sony.com>
Subject: Re: [PATCH v2 00/12] Add build ID to stacktraces
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
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
To:     Christoph Hellwig <hch@infradead.org>,
        peter enderborg <peter.enderborg@sony.com>
Date:   Thu, 25 Mar 2021 16:21:46 -0700
Message-ID: <161671450646.3012082.10177164412320557022@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting peter enderborg (2021-03-25 04:06:17)
> On 3/24/21 9:55 AM, Christoph Hellwig wrote:
> > On Tue, Mar 23, 2021 at 07:04:31PM -0700, Stephen Boyd wrote:
> >>  x5 : 0000000000000000 x4 : 0000000000000001
> >>  x3 : 0000000000000008 x2 : ffffff93fef25a70
> >>  x1 : ffffff93fef15788 x0 : ffffffe3622352e0
> >>  Call trace:
> >>   lkdtm_WARNING+0x28/0x30 [lkdtm ed5019fdf5e53be37cb1ba7899292d7e143b2=
59e]
> >>   direct_entry+0x16c/0x1b4 [lkdtm ed5019fdf5e53be37cb1ba7899292d7e143b=
259e]
> > Yikes.  No, please do not make the backtraces a complete mess for
> > something that serves absolutely no need.

It serves a need. Please look at the patches to understand that I'm
adding the buildid to automatically find the associated debug
information on distros.

>=20
> Would a "verbose" flag be acceptable solution?=C2=A0=C2=A0=C2=A0 Somethin=
g like write 1 to /sys/kernel/debug/verbose_stack to get the extra info.
>=20
> I think I see a need for it.
>=20

Or a kernel config option and a commandline parameter? That would be OK
for me as I said on v1 of this series. I'll add that in for the next
patch series given all the distaste for some more hex characters next to
the module name.
