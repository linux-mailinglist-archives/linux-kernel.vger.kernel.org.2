Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6302432BDBD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573773AbhCCQ3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 11:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234645AbhCCLwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 06:52:46 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46851C061356
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 02:56:35 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id a24so13808653plm.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 02:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7q/j7uiT6CW13D8ObhzBqHbvkgzpG7ZEAqZ/ZCUXXzI=;
        b=KzehwLUKvHb1+sFHgkSnV3kQ+sHQoekbGdUgxpLXhwAwfrouwDGrD+5tFFdrOu/SKz
         qNOGwpV8DVgXBLh1n4d+Z1yvxaKtkLYPR3sdVpx815mW9jfkbhWiUVya3102XafaAhoY
         wRajJq3WDqinVP55EBDQeTEjXH06SEHIcS71T6XDUpESrrIUkSwaq1GwTubb0eBlqRQm
         qVt5JcVBawphoKWItFIGeTxbEUVvXYk5gZSx2GzGILJwHAsqi7/+F/+uRBWzQmg1EskC
         xhwrkb8rD/ZVCHANhbJzifkPUB+ntQ/2jTQhCHOwmVX6Ve32Kt+cO4llhadB4HggxkKL
         Ff0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7q/j7uiT6CW13D8ObhzBqHbvkgzpG7ZEAqZ/ZCUXXzI=;
        b=on4MH+yy6ZmdBKhTcL3y6Bkvtc3IazhX2HKcj3VCcWaO/jNHozrxVsCAPQly7w4CI8
         nLDQBDG/pLPYVwiqR+Yi3x+YZFr5hocuyGnd4UkykwepEgxd89rZvhVjwmcTLbQwuLK3
         FRlb86vzeAIuFcw3Bpoxyhfa6re4vCLyJSswHWsVVhk0RBkTO9gvzXJrqV6A/QOFG1uO
         k7dd8lpo0KmVMIeVE+MA5zDf/h2QpNVGW6/CsAoVGdeLoGeEs+nTHdijjvq2m2r40bFt
         C+1Z/5vz3RSyA2SDRBBmUqzOCXZOaIxWs6/X5LHWDaUemT45qSDzT75tcL4V5R5fCZ+C
         8Rww==
X-Gm-Message-State: AOAM532i9YC5kt3nRPfh66OgcLSl2gp72QzyAo8Le5IiAHXfVnupZbDa
        Jh5TqHSqtRloYaxYRcf7qY/ZEg==
X-Google-Smtp-Source: ABdhPJx6aUAi5z7HLvt/vc/WXBjRpWduAQZXiTfvXoETfo0Mr84TMmm9G30F5qMvX712L25hjUbNLA==
X-Received: by 2002:a17:90b:691:: with SMTP id m17mr9348371pjz.191.1614768994752;
        Wed, 03 Mar 2021 02:56:34 -0800 (PST)
Received: from localhost ([122.171.124.15])
        by smtp.gmail.com with ESMTPSA id fs9sm6483409pjb.40.2021.03.03.02.56.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Mar 2021 02:56:34 -0800 (PST)
Date:   Wed, 3 Mar 2021 16:26:32 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        Frank Rowand <frowand.list@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Anmar Oueja <anmar.oueja@linaro.org>,
        Bill Mills <bill.mills@linaro.org>,
        Rob Herring <robh@kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V9 2/4] kbuild: Add generic rule to apply fdtoverlay
Message-ID: <20210303105632.osvwsxkku2cpvdb4@vireshk-i7>
References: <cover.1614745266.git.viresh.kumar@linaro.org>
 <263ac0777bee9384b66fb4e74ed3abdc45a1bb82.1614745266.git.viresh.kumar@linaro.org>
 <CAMuHMdUMn4qDLE4z98vDwgBZ5pUAk40o4A4A5JG3bOpPNZj9mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUMn4qDLE4z98vDwgBZ5pUAk40o4A4A5JG3bOpPNZj9mg@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-03-21, 11:49, Geert Uytterhoeven wrote:
> Hi Viresh,
> 
> On Wed, Mar 3, 2021 at 5:36 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > From: Rob Herring <robh@kernel.org>
> >
> > Add a generic rule to apply fdtoverlay in Makefile.lib, so every
> > platform doesn't need to carry the complex rule.
> >
> > The platform's Makefile only needs to have this now:
> >
> >  DTC_FLAGS_foo_base += -@
> >  foo-dtbs := foo_base.dtb foo_overlay1.dtbo foo_overlay2.dtbo
> >  dtb-y := foo.dtb
> 
> Is there a way to autogenerate the DTC_FLAGS_foo_base rule, based on
> the foo-dtbs rule?

Since the first entry in "foo-dtbs" is always going to be the only
base file, maybe we can do that.

-- 
viresh
