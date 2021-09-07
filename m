Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A56D402940
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 14:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344515AbhIGMzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 08:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232913AbhIGMzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 08:55:03 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E880FC061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 05:53:56 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id m7-20020a9d4c87000000b0051875f56b95so12597963otf.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 05:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/5b7VcwcKdARXsla1TLijACSCc15UFN2/0L5kpbTrqs=;
        b=J2mf2xsgzpjY7S+6Hrs7B8a2690ctISNZeYNAljOgCmfLKgxF0PZ6xW8StksKB6hXb
         hfuSLvxNAVE6FQhlWSTHtNH/nAfuvmjaEL39PoxZwYrbWKH90lLZq4uvi2H/5NmwNJRw
         9qOkTDQbuIQFdmSrleKbdyFevRyJEmiKAcQtCFF+J2CGbCaJFUHMdQt/RLVcuALyGm45
         W9YsNfwWTbc22OFoPe+E3qWjF3NpEAmNYd/ix8GoAaLAYn8tDcXfdoOIN7+A5Cbo3+Ds
         JyiDriskFS5B5OutJ++h6uG2cmVNdYx7h2kjGiF8OvBb3tDQYtIJG1YAPB0QMzfUQRa9
         V/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=/5b7VcwcKdARXsla1TLijACSCc15UFN2/0L5kpbTrqs=;
        b=NmF3p0R/U5MNXblFM2l06Wvz3m/Oyf9UFFr9C9O06jF9S0sQqz/a4jHUMk/UTDjGLf
         OouI48Y9WpwKIQMhIsoJ1aIYUk8zd3c6K4Unf5N2tK2uEB+hMgXFWCRjKccUvMIPlOlo
         edNeCXO4JkCBbXPTiV2jcQ9jCf2JkPUCNC6/ZjW2/DX24uGst46zLip0jmNBg0qct9c0
         hXiRJiWTiVbO8rujtpnecSkymB78HLTlqWHgcR0Ti2xMNamdW000tsR8ulv200vLh1Nj
         s6fI/dlgyEbedZGLB+XggWdn1/Zgnte7O4Eo4beCkjgLAg7QxgrNcA/Jk0cJX6qgL4Sl
         Zaxw==
X-Gm-Message-State: AOAM531qAxegoRqUCamNkakwHzPx9PiN28cr4l0BbTypy+yGtCir84OW
        /kWSpZUXJCZ+VFEZ6lFatjwM/oGSZfU=
X-Google-Smtp-Source: ABdhPJwvhpnRrN6eqdk+uVDVkJ6oSamoYx11y/SEaEJcXUvm3y8Qpb6RG38Oct+nhazPVFyZpF3TcQ==
X-Received: by 2002:a05:6830:10d2:: with SMTP id z18mr15444773oto.341.1631019236351;
        Tue, 07 Sep 2021 05:53:56 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y138sm2057260oie.22.2021.09.07.05.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 05:53:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 7 Sep 2021 05:53:54 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: QA: Monitor Linux log messages as port of release (candidate)
 testing
Message-ID: <20210907125354.GE4989@roeck-us.net>
References: <458e0604-1fe9-bed0-d22f-84540b05ffb1@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <458e0604-1fe9-bed0-d22f-84540b05ffb1@molgen.mpg.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2021 at 10:40:31AM +0200, Paul Menzel wrote:
> Dear Guenter,
> 
> 
> Thank you for testing release candidates and releases [1]. Is your test
> setup documented somewhere?
> 
Not really, except its source is available at github:
	https://github.com/groeck/linux-build-test

> If not happening already, could the Linux messages (at least up to log level
> warning) also be monitored? For example, in Linux 5.14, a new warning snuck
> in by cefc7ca462 (ACPI: PRM: implement OperationRegion handler for the
> PlatformRtMechanism subtype) [2], which could have been caught early on, and
> fixed before the release.
> 
> The test summaries would then also notify about possible behavior change.
> 
Logs are available and can be examined at kerneltests.org/builders.
Reports are generated manually, so it would be way too much effort to add
build warnings to those. Besides, logs are way too noisy to be useful in a
summary e-mail.

Also, Geert's build reports already provide build warnings and errors.
The same applies to reports sent by 0-day. Indeed, I do see at least
one 0-day report against commit cefc7ca46235. What would be the point
of adding yet another report of build warnings on top of that ?

Thanks,
Guenter
