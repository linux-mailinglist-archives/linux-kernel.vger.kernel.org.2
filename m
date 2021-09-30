Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 914B941D194
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 04:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347892AbhI3Cqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 22:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347849AbhI3Cqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 22:46:44 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FBCC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 19:45:02 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id x27so18876866lfa.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 19:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rbhsc9J7XsMrioXJqfrxY/zmGhcXPZ+JV/XkI67QIjQ=;
        b=IwaYxISK5oSeVmHWe75HUpypgzEmLhpIY5wMJH92Lj4/2lNQSxa95Oq7sCfF3Bq/l8
         QcBh4WdW2wMf2WHlaUvQx9amF8G6tBphTKNN7prwZo2IdiKrt2mAyqIXD4RtJ2KW8XVx
         q52Wnl7mt+ZZxHZ/4LjUzlxhsi/kvhB0OL4YAqfdCn53/UnKxQY502s1PhvHQuJtCQHu
         gm77meiCKmO3Nh8bPkl56cgcwf74w4Q4RHqu6p65vmCZn157xUz3PyVYX5FTe3GMLqeH
         63I9qj5KbiefBz1k1e1A+g8bAP/iwvx9Mm8Us5EmGX5JOYIxotojnP2FE/By/q37x1kN
         HyvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rbhsc9J7XsMrioXJqfrxY/zmGhcXPZ+JV/XkI67QIjQ=;
        b=3NXMahPSo69yqjD6iZNn1a9TpqvxIS0eKWs9oiewBn7AW5Y5V3sfElwZAcMWk4ILYh
         j79lN7508SBQcEZV6ZaJhoo0jOow58otfW9azUxsc+IFs+d5xCXLyhMVgjLiqDF7rDGI
         Cf7AaZTGAtjAhpKpX6jk+KJiHUK82gzlIJ6PxUn0kxQPghGIVGJL2/s1r2lzSO4kQyQf
         PvLghQfa2iGRbpfHq8GDKlF3lUhE3GzjA6WEQ25rZY3Qy/uzliIiX/A7mqKzO/1UcU9B
         JM6Wn91yUgmc6TW++YFXnQ35iChVNS5yLItoGAtCbs0v7kwU1dtlto0hzLWIKX1M4y6Z
         rS8A==
X-Gm-Message-State: AOAM530WHZfefN5c6vwZT86btCvc1cPPOFi3KQ2YoMWPNQh1iA4rUSFM
        F+auCSNnyhiIQEMByHHLPMjzSLHxUyE1Nm3VMlgMRg==
X-Google-Smtp-Source: ABdhPJyQJRVQGyEYu5wfNE6U6Pt+vKWE6vtHQppYUn0Bj+uAdeYrnCq4LIUiSjO0TXF1W62OsGwC3pRNI5s3rOVYJ40=
X-Received: by 2002:a05:6512:b08:: with SMTP id w8mr3159158lfu.505.1632969900574;
 Wed, 29 Sep 2021 19:45:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210916231325.125533-1-pasha.tatashin@soleen.com>
 <20210916231325.125533-6-pasha.tatashin@soleen.com> <20210929121336.GB21631@willie-the-truck>
In-Reply-To: <20210929121336.GB21631@willie-the-truck>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 29 Sep 2021 22:44:23 -0400
Message-ID: <CA+CK2bCcawYWO+EjLbSciLQaM3g4eUWQN0uokNs1zN+An9KYSA@mail.gmail.com>
Subject: Re: [PATCH v17 05/15] arm64: kexec: skip relocation code for inplace kexec
To:     Will Deacon <will@kernel.org>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mm <linux-mm@kvack.org>,
        Mark Rutland <mark.rutland@arm.com>, steve.capper@arm.com,
        rfontana@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        Selin Dag <selindag@gmail.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        madvenka@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

> > +             cpu_install_idmap();
> > +             restart = (void *)__pa_symbol(function_nocfi(__cpu_soft_restart));
> > +             restart(is_hyp_nvhe(), kimage->start, kimage->arch.dtb_mem,
> > +                     0, 0);
>
> Why can't you call:
>
>         cpu_soft_restart(kimage->start, kimage->arch.dtb_mem, 0, 0);
>
> here instead of open-coding it?

This is part of a cleanup to remove cpu_soft_restart() wrapper and the
header file that contains it. The wrapper is simple enough and has
only one call site. It makes more sense to do what is needed directly
from machine_kexec().

Pasha
