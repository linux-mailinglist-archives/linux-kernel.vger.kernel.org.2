Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA53232DA3A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 20:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234447AbhCDTQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 14:16:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbhCDTQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 14:16:24 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C14C061756
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 11:15:44 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id j12so19615518pfj.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 11:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=/DirTSyzKAFs29sO/OTqSEfZoXrfa4YRqvZXWzw4lEc=;
        b=jWt4jO507Km1b5syJWNiJrbVQdBCDkjOcfveEo6nskQ+iuVTrNcd45QPb3pvJJFAnw
         0oaAYiWg42G7cIYNOIN7GUjey2bdFwa09CiAD26s7kNDomSEKG840AYFUQvVVekpa4KL
         f24HZUavc2U5ZZFe70NGahxVOpOy2gpIjKT7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=/DirTSyzKAFs29sO/OTqSEfZoXrfa4YRqvZXWzw4lEc=;
        b=XB3YBFoAnKN5TLbAqiTtqVNoLDbd9cO7mcEDBUsDWocd1Z2cINzad5WLxPe64mKyDB
         un2mTNmzVEFOAe/WsN2dA16OYAcgyd6usI8yLw4N3IWxWaS+leaKJejZNyhK1LmnxZJH
         TPRagSY+lyJvR7Crplcq5KKJ83nZ8nECz4sesKw0l+ycDf9BkkX4iv63OxXMgVoNT6Hn
         wBvisU8XaTO2xGHb6EwbXGbUd76s3pWjyzKgzfYAouslfYCEB7vHSAPpRUEac/lufEli
         224SL7SYEpoVLsJKedkslrulvUklDQVOsD2Zf/EBNman5KgaANCC/UkVB/Q/G0FECq9t
         2Evw==
X-Gm-Message-State: AOAM530miSMl7A0eB7inQMvhoRfC3P2Bn9ipldMd/btbtI0j+jgZPIHu
        RMfkEb/WjCUIs3IUDf+0pQxjvA==
X-Google-Smtp-Source: ABdhPJzkyJhoKERLQjGxYl7xwpPNa4F8mRz/Eqt230PYYG+U0Pa3JyOBJF08lEVNVlL6NyM8GsgCbw==
X-Received: by 2002:a63:e911:: with SMTP id i17mr4880717pgh.255.1614885343741;
        Thu, 04 Mar 2021 11:15:43 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:b498:4a2d:bc34:b77e])
        by smtp.gmail.com with ESMTPSA id ig12sm48600pjb.36.2021.03.04.11.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 11:15:43 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210304170052.GK2723601@casper.infradead.org>
References: <20210301174749.1269154-1-swboyd@chromium.org> <20210301174749.1269154-6-swboyd@chromium.org> <20210304170052.GK2723601@casper.infradead.org>
Subject: Re: [PATCH 5/7] printk: Make %pS and friends print module build ID
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-doc@vger.kernel.org
To:     Matthew Wilcox <willy@infradead.org>
Date:   Thu, 04 Mar 2021 11:15:41 -0800
Message-ID: <161488534185.1478170.10285681551102444519@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthew Wilcox (2021-03-04 09:00:52)
> On Mon, Mar 01, 2021 at 09:47:47AM -0800, Stephen Boyd wrote:
> > Example:
> >=20
> >  WARNING: CPU: 4 PID: 3255 at drivers/misc/lkdtm/bugs.c:83 lkdtm_WARNIN=
G+0x28/0x30 [lkdtm] (ed5019fdf5e53be37cb1ba7899292d7e143b259e)
>=20
> Would the first 12 characters instead of all 40 make it more palatable
> without reducing its utility?

I can't seem to request debuginfo from debuginfod without the full 40
characters. It's not a git sha1 hash.=20

> And I feel it should be within the [], so maybe this:
>=20
> WARNING: CPU: 4 PID: 3255 at drivers/misc/lkdtm/bugs.c:83 lkdtm_WARNING+0=
x28/0x30 [lkdtm ed5019fdf5e5]
>=20

Sure I could put the hex numbers inside the brackets. I suspect changing
%pS or updating the "Modules linked in:" line isn't going to be
palatable. I've decided to introduce another printk format %pT to print
the stacktrace and then updated the architecture code on arm64 and x86
to see how it goes. Other architecures can be updated if this is
acceptable. I'll send out a patch series in a little bit that also
updates the decode_stacktrace.sh script to parse this.
