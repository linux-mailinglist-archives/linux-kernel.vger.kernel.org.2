Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68AB93886E7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 07:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237951AbhESFrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 01:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245129AbhESFnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 01:43:16 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCEDC0612A4
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 22:37:19 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id d24so11837039ios.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 22:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m16P8W12BKtEz5Sc0o7ZQfhgwcZLYGTm5U/XmQyeo8s=;
        b=Khx1Dmmkgi2W/J6i9Pe1HK3PhiIOcB7SLliild/sLSX2F+qlQQLSL1/9e8yaNnQUjA
         ZGLW8gB2lGeHD3rzWeXKRjl4ImQk1kFOIghQvT3vHFtEhYfiwOS4cfC11lHDO4K2lzBC
         7voRhgdVGfkzNqOd2fS24euIwE06JjRun8EmRDJUmLU6mRKSay9paxa+Nc/9T+P4EVCD
         BktNEqTKLZ4Ir5MvN7CPRXFdp1FuN0/KsZoaojjU61Ell2ptb+aI46DQtsnknpSNn+yO
         SJNSeWGkFSob4OWs+CIUuZGVpY8bC5uqP3t1VHpHpG4/SYCqO8esECe5iygPDl2vaOMq
         epzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m16P8W12BKtEz5Sc0o7ZQfhgwcZLYGTm5U/XmQyeo8s=;
        b=Qd+dqqY2OXa14i5mcMEMy44u0+UUGfVflPOG4+2IbQoTdpbc1v15rn4TqGS8ydwj8+
         1QtNNPf4Y6lNVpJSQSC9OzPQwNNtlzT9eoKDVAxwjKO/7E2Ii5FaIwB7FiTm0sro5XHN
         GwQc+8tp62+xitVpx1ZoF+6Ph4KKnvF8rsQXcMjUcqN8/+ohxZraAaOkjZT9osrY9N0T
         1uv5eexe6VaZeXhGYLgfOB3RR0dXf1f4kn13DbxSvgfRvJ+JGQMQxETNNHeDppK2AjiZ
         uoK5mnQ3I+TOcdkBB3JPdmE8GErzi1QidjMxmrgXCftDbQXdWQ0y5qoeSRKon0QqacOc
         8ulw==
X-Gm-Message-State: AOAM53087n+lrWo2GlowWl+KztGkIzV5BGCcNza2NBqDViP2AG5hSHk2
        I125J0m13PJoz34cE+oQ5S1dh3MT425qhok7deTH7Q==
X-Google-Smtp-Source: ABdhPJxh9mqdez+8Y/0OTSjsMgTMU/mgX7RCSZx6WUJ0BdnaOokbJ7S2xmS1sQMmIKVMsG/w7BmqjYlFJ/Bd/rL6xf4=
X-Received: by 2002:a05:6638:2594:: with SMTP id s20mr10758186jat.140.1621402638614;
 Tue, 18 May 2021 22:37:18 -0700 (PDT)
MIME-Version: 1.0
References: <fb6c8a4e284a9b6c043f4ac382387b19bd100976.camel@linux.intel.com>
 <20210513132051.31465-1-ggherdovich@suse.cz> <CAAYoRsUcyFsFWDE=r+aMgDBa6hcgXgtE2jJ_NHas5e4TdgiBTg@mail.gmail.com>
 <CAJZ5v0g5_BY3DCi=VxqkRh+TYPS5nkJ-J96EzPVrc975uiWf3Q@mail.gmail.com> <be4d7573a33a1d515fab5e6368ef33dee5a06187.camel@suse.cz>
In-Reply-To: <be4d7573a33a1d515fab5e6368ef33dee5a06187.camel@suse.cz>
From:   Doug Smythies <dsmythies@telus.net>
Date:   Tue, 18 May 2021 22:37:10 -0700
Message-ID: <CAAYoRsXN9fxieCYXppU2N+VnXL-4Ydx43U6AuJWhTFLitcbSfg@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: intel_pstate: Add Icelake servers support in
 no-HWP mode
To:     Giovanni Gherdovich <ggherdovich@suse.cz>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dsmythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 4:33 AM Giovanni Gherdovich <ggherdovich@suse.cz> wrote:
> On Mon, 2021-05-17 at 17:26 +0200, Rafael J. Wysocki wrote:
> > On Fri, May 14, 2021 at 5:31 PM Doug Smythies <dsmythies@telus.net> wrote:
> > > Hi All,
> > >
> > > Can I on-board to this patch or do you want me to submit another?
> >
> > Please send another one.
>
> Hello Rafael, Doug,
>
> I can resend a series with two patches, one adding ICELAKE_X and the
> second adding COMETLAKE to the intel_pstate_cpu_ids array.
> I'll prepare it.

That is very nice of you. Thanks.

... Doug
