Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE5F932DA26
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 20:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbhCDTMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 14:12:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbhCDTMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 14:12:31 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC56C061762
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 11:11:51 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id i4-20020a17090a7184b02900bfb60fbc6bso4939039pjk.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 11:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=qo7JldTnJo6GF/avOLXGrmdYjouVdk0OdVSsXFxxTyM=;
        b=Ea4IXmaDS12tOW7BTFzuRKuEXNr+yoP6VLnxJJ4Hg5oDmXwdeX58elNPluiRgSfXzs
         5gaTCp6dysybX/zFf/2R9YT0I4/DACygZKfBgB/T6hFxhWhHhDGCYvvGIYA4OglgVfP0
         6x9FMusgBu5e/E/8enT+WlKh+A6h/4HeltiZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=qo7JldTnJo6GF/avOLXGrmdYjouVdk0OdVSsXFxxTyM=;
        b=GQ/InZVEp3x7oPcWiO/38cPWHSyVeAJD5fH2kE/3KEAn7FZTPNupgoQTx/s3qSdEeh
         0q5fVrrzfqMTFUhEqWIB0yvQMMd/Hl1Uzfe0RDf3RPVpPgRw+gM86x2QdvTTVdQAyGx8
         UtmvrPnRF1y9Zf7oJaEH+UZJDT7vHBLR4d887cQsDA6gSFWTsmiXG6bZKOBi+H21tzEf
         xVQZvuHW5aDcS7DCAcL3thF4Ku+Bc3c9KwOHBds5QnWiLDDAC+P3BTy7MZI0VHD4eUDv
         tGcebXCMYM1ei2VVo/++Jw9ELfDqfb3Kz9jLeyZoF/0zEJHUvKgPv8rcUTiQ+QtssRLO
         tsBA==
X-Gm-Message-State: AOAM532n/4aI2Ep1OGTo3gdeIpa2hg/8HFpJvKl8gNNRSd6/FyKbkJqL
        +HaUE+9HJOVspRtLfqv+TOeMpg==
X-Google-Smtp-Source: ABdhPJxC5A0+IaAQ0PUPigRvFIHoD6yGe5Amxvl+HrMxh08Ji/XC9DG/+QThKvN9g73D+DKhAxpCzw==
X-Received: by 2002:a17:90a:5887:: with SMTP id j7mr5971637pji.178.1614885110727;
        Thu, 04 Mar 2021 11:11:50 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:b498:4a2d:bc34:b77e])
        by smtp.gmail.com with ESMTPSA id y72sm158597pfg.126.2021.03.04.11.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 11:11:50 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210304171940.GL2723601@casper.infradead.org>
References: <20210301174749.1269154-1-swboyd@chromium.org> <20210301174749.1269154-6-swboyd@chromium.org> <20210301214319.7e54c66f@oasis.local.home> <20210304171940.GL2723601@casper.infradead.org>
Subject: Re: [PATCH 5/7] printk: Make %pS and friends print module build ID
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-doc@vger.kernel.org
To:     Matthew Wilcox <willy@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Date:   Thu, 04 Mar 2021 11:11:48 -0800
Message-ID: <161488510845.1478170.2089177121697044390@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthew Wilcox (2021-03-04 09:19:40)
> On Mon, Mar 01, 2021 at 09:43:19PM -0500, Steven Rostedt wrote:
> > On Mon,  1 Mar 2021 09:47:47 -0800
> > Stephen Boyd <swboyd@chromium.org> wrote:
> >=20
> > > The %pS printk format (among some others) is used to print kernel
> > > addresses symbolically. When the kernel prints an address inside of a
> > > module, the kernel prints the addresses' symbol name along with the
> > > module's name that contains the address. Let's make kernel stacktraces
> > > easier to identify on KALLSYMS builds by including the build ID of a
> > > module when we print the address.
> >=20
> > Please no!
> >=20
> > This kills the output of tracing with offset, and can possibly break
> > scripts. I don't want to look at traces like this!
> >=20
> >           <idle>-0       [004] ..s1   353.842577: ipv4_conntrack_in+0x0=
/0x10 [nf_conntrack] (3b39eb771b2566331887f671c741f90bfba0b051) <-nf_hook_s=
low+0x40/0xb0
>=20
> Would it make sense to only print the build-id if it differs from the
> build-id of the kernel which has loaded it?

No. The build-id of the module is different from the kernel that loaded
it all the time, so it would always be printed.
