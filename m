Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C528E41694B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 03:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243699AbhIXBRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 21:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240863AbhIXBRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 21:17:51 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEDAC061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 18:16:18 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id j15so3785665plh.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 18:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w5B8w4boy04cb2C9FnPWt5iQ9AQtwNvlUApWzI3TT6E=;
        b=fk/zXO6APsjQP2fh5wykxBplb9piOvz3CNMHFIPkMPwFt20Rurof4KpK+RCED8KfWg
         awr2VaO0bwCNMi6PCTnWMa1XeV3bxdLEGfMljXtedJWuUaehsap1a9+fq0dBtHOHqhrd
         VG1ySMWoZXdd4KZu0XVMzt+HO6rkK8NokbFFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w5B8w4boy04cb2C9FnPWt5iQ9AQtwNvlUApWzI3TT6E=;
        b=cQbwJqaceDIYhb14qtgsSEjSR9/5HFhoarQ9wXoyxU93aqEh065eekLtdjFUYqFCyG
         8l20QOq67N6BC9a3Yg7aKOOAipZO8sswD+GuUlUBp22l5zr/2xW2nMQ5bvoHgvW+7Yf8
         1mkKslsalEOdKQznj8liEYSyuK/sGapcCpEroBJ8x10W14DjK8gcDdb+Tg5155oOR3Kq
         qXbiiiZpGdFZyHx3vh0rDWS7QUfeX9j85VClBP9gzr8wg3qqz7FtgJFa10K22m5xiom7
         hVshrYw0ODJUGFiyrEImPPII8sqH9I5ACf2LUGMkUMTmCT/kzWva96WCAUJ7LnWumw1+
         3mDw==
X-Gm-Message-State: AOAM533ahjquK5yJlUyxVvg0ru/yXMydVAd2UwhuRWMnSSxDvKFkDdHv
        nYbpcfGj2oUy4kwAnnoeRCrYiA==
X-Google-Smtp-Source: ABdhPJxoF8k/yHeE9qADjZViLo/daJ+jbNYuOpCagSw2t25LlmK7gyi40AMK5wwRJHKxrmnGmfYBDw==
X-Received: by 2002:a17:902:e153:b0:13b:63ba:7288 with SMTP id d19-20020a170902e15300b0013b63ba7288mr6270393pla.33.1632446178067;
        Thu, 23 Sep 2021 18:16:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e14sm6519648pfv.127.2021.09.23.18.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 18:16:17 -0700 (PDT)
Date:   Thu, 23 Sep 2021 18:16:16 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Vito Caputo <vcaputo@pengaru.com>
Cc:     Jann Horn <jannh@google.com>, Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jens Axboe <axboe@kernel.dk>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stefan Metzmacher <metze@samba.org>,
        Andy Lutomirski <luto@kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kenta.Tada@sony.com" <Kenta.Tada@sony.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Michael =?iso-8859-1?Q?Wei=DF?= 
        <michael.weiss@aisec.fraunhofer.de>,
        Anand K Mistry <amistry@google.com>,
        Alexey Gladkov <legion@kernel.org>,
        Michal Hocko <mhocko@suse.com>, Helge Deller <deller@gmx.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        Ohhoon Kwon <ohoono.kwon@samsung.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] proc: Disable /proc/$pid/wchan
Message-ID: <202109231814.FD09DBAD3@keescook>
References: <20210923233105.4045080-1-keescook@chromium.org>
 <20210923234917.pqrxwoq7yqnvfpwu@shells.gnugeneration.com>
 <CAG48ez0Rtv5kqHWw368Ym3GkKodPA+JETOAN+=c2KPa3opENSA@mail.gmail.com>
 <20210924002230.sijoedia65hf5bj7@shells.gnugeneration.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210924002230.sijoedia65hf5bj7@shells.gnugeneration.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 05:22:30PM -0700, Vito Caputo wrote:
> Instead of unwinding stacks maybe the kernel should be sticking an
> entrypoint address in the current task struct for get_wchan() to
> access, whenever userspace enters the kernel?

wchan is supposed to show where the kernel is at the instant the
get_wchan() happens. (i.e. recording it at syscall entry would just
always show syscall entry.)

-- 
Kees Cook
