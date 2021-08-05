Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2DC3E0FCC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 10:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239164AbhHEIA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 04:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbhHEIA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 04:00:27 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A28C061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 01:00:12 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id c9so5274191wri.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 01:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wumc4OZ7mBGOruxhA75GZYnXNkQhB5mW1nT6BqQbhoM=;
        b=OzEDvkO70XEjJpSxi59DeN+Dn6kIot+RdgCjtY4yI40znzqsrqBWxOANTs5It1hlVQ
         wWl7kpglPubk2ubzYbZPHmqRadHU2jbkvRemE5TEh5xjIByLkJxxxZF1Cf1/Hxa/4o3Z
         EMF1lgFJsvGL3bRxSmf3SLeuUYOo6wZI4xcHtsZiJAqRf7D/EqeGkXU/KmX0OXwXC1gV
         5gEOrbj+bXMZ35y70DOAqq2L+kXBst0eJJ6YjpuDbcrCIy2GAzQLTnLdHvka4Uw5I6wx
         xoEfm6xYSKMY3+A+cGWn8XLltL9F0QnvsT7EmpF6gAgRlGKwCmcO9Rq1bnRJFaLnquuS
         Ggdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wumc4OZ7mBGOruxhA75GZYnXNkQhB5mW1nT6BqQbhoM=;
        b=TEZQ3iwYdoOxyzcx/a3V0Y00yoTrlzHj4+nHl0SLZno/nQNcbx4sKUZKgCZfgSSyIw
         TDFgXMKht/fmKhcAJlQ0oYWJ8HqRvg0WiwLQZxHesmbkcRdcNUOmW5GZuo2qDju2hBrE
         xZ5OWIqZzTYc4TPENk6nfzDrwflMlg9Vxm67ROtasb0T7h7i+3foOs1jgazMewN63rlC
         ZGizpOHOFAz877vHtfHLzRXJVzb5BGkp7AZqbzWJt0yIyjyCt6RtYgeExWipmCinCV3q
         okwcpwLO5V7sKh2kYvtlCKiHOahkZXXJtLtrieOYANxXnA21t0lLXgVtW02sGnD8y7+1
         yVQQ==
X-Gm-Message-State: AOAM530mXM4XhX9fU5YSscPnDlBRiCeMXU/HmVsdB+A4/e9d7T9ooHBA
        LNm14UKyM4smSE8AqJFPZXEfTA==
X-Google-Smtp-Source: ABdhPJwwI7OpevysCPXVydCiImYOL403jvLwB9REh/tzZacm4rsI/wiorAFciqp4F5XD5r0f76eBSQ==
X-Received: by 2002:a5d:424d:: with SMTP id s13mr3652510wrr.356.1628150411445;
        Thu, 05 Aug 2021 01:00:11 -0700 (PDT)
Received: from google.com ([109.180.115.228])
        by smtp.gmail.com with ESMTPSA id f15sm5133528wrp.12.2021.08.05.01.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 01:00:10 -0700 (PDT)
Date:   Thu, 5 Aug 2021 09:00:09 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH 2/2] mfd: db8500-prcmu: Handle missing FW variant
Message-ID: <YQuaiW/MSZY4bmok@google.com>
References: <20210801233314.3150754-1-linus.walleij@linaro.org>
 <20210801233314.3150754-2-linus.walleij@linaro.org>
 <YQejHNP1AzFHZ6gK@google.com>
 <CACRpkdaK0pBgmFSazjJ5NOj9rF9DzUyCfumxyi8PNaS_61_=Ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdaK0pBgmFSazjJ5NOj9rF9DzUyCfumxyi8PNaS_61_=Ww@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Aug 2021, Linus Walleij wrote:

> On Mon, Aug 2, 2021 at 9:47 AM Lee Jones <lee.jones@linaro.org> wrote:
> > On Mon, 02 Aug 2021, Linus Walleij wrote:
> >
> > > There was an "unknown" firmware variant turning up in the wild
> > > causing problems in the clock driver. Add this missing variant
> > > and clarify that varian 11 and 15 are Samsung variants, as this
> > > is now very well known from released products.
> > >
> > > Cc: Michael Turquette <mturquette@baylibre.com>
> > > Cc: Stephen Boyd <sboyd@kernel.org>
> > > Cc: linux-clk@vger.kernel.org
> > > Cc: phone-devel@vger.kernel.org
> > > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > > ---
> > > Clock maintainers: could you please ACK this so Lee can take
> > > this into the MFD tree? The chances of merge collisions are
> > > zero, this code changes very seldom.
> > > ---
> > >  drivers/clk/ux500/u8500_of_clk.c | 3 ++-
> >
> > >  drivers/mfd/db8500-prcmu.c       | 6 ++++--
> > >  include/linux/mfd/dbx500-prcmu.h | 3 ++-
> >
> > Acked-by: Lee Jones <lee.jones@linaro.org>
> 
> Actually I intended for the clock people to ACK it for you
> but since it is completely independent of 1/2 it actually works
> either way, maybe they will rather pick it up, who knows? :D

That's fine too.

I assume they will not require an immutable branch, as the turn-over
in this file is very low.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
