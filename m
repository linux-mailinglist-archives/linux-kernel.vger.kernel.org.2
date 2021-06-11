Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEBA53A4446
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 16:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbhFKOpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 10:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbhFKOpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 10:45:53 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91399C061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 07:43:39 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id z8so6350615wrp.12
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 07:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7mRwlF3jCUq6zVltwkxkBp/rryUHd8mfMwQJYGd2D1s=;
        b=rZYuMmISuBSI56IJokcggaVPw+ps0i0Ta4tlLPe62KUW2goaOFDyisehP/cXL3iOXi
         v1qcbDkTuEI2tMiJt5maZS0apItuYi2PDkSaBsINzg4itWFL3Am36YmABfyv0IZmHHhf
         QG1u6OSh1HP0459laVkuTHnBfLicn9AyogQS/5b0bRqgWHVoN//Lc/Ys2QETs4lPmt8i
         nf7Yogwk0FDa4ns2H5Sd+WRXNtmifOsM189ZqRpGhp+YrwUoxvMhjwXHz4yUadhWQbnX
         /7tyDLU672MVZqsknQ4Jjrr7/YlgVPq/Idy1w0UcXwffGS20Mp4C4aQFvxO2SKHH/kbz
         J2+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7mRwlF3jCUq6zVltwkxkBp/rryUHd8mfMwQJYGd2D1s=;
        b=ZhDBzWf6iiiImK2htDBeI2ZkCPcEXU8HiKxYY6CfWwCLyM9Q8FHn/R5YTllPwRlp3w
         XMfLMz/9ARI4TJBoravVsWl2BHqD9GZsbAblcH+On3Fl9eAYwdvsHTQahdmdm+LLtYvd
         3Y23GIaEwKHKDeclKgI+bEuuanFzUDmX1DCQXaG/YRsScfx7Tw/9HWIva+lsCPX9q6mi
         K4DR4Iuur6eizVBEKKv7Z6ByQVjSxzDLGSHxlq5jSo3w+FkF+myiet1ISXozC7m/38JT
         FxXISRgQLiK/jNj0rysut+K5QaJODJl0Ut6vs7Y82iBv0ofu7SGpBfWFXdDiTF8wTIAh
         xdcg==
X-Gm-Message-State: AOAM533TNjhU8jcSEe+j7LupU97UCZlU7yxjn3oIEhYAnc4RytsEzjaR
        h9abHwqr8cYo/aRj1koefwMxPg==
X-Google-Smtp-Source: ABdhPJxl3oqa7Z7VJHecj83Hw4BNgfHAn+qWngBF/wK+uRr+Seuri4o24/dcolA+TgN5HlZ82xEYLA==
X-Received: by 2002:a5d:414e:: with SMTP id c14mr4368371wrq.81.1623422617923;
        Fri, 11 Jun 2021 07:43:37 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id 32sm8331890wrs.5.2021.06.11.07.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 07:43:37 -0700 (PDT)
Date:   Fri, 11 Jun 2021 14:43:34 +0000
From:   Quentin Perret <qperret@google.com>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rickyiu@google.com, wvw@google.com,
        patrick.bellasi@matbug.net, xuewen.yan94@gmail.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 3/3] sched: Make uclamp changes depend on CAP_SYS_NICE
Message-ID: <YMN2ljLMUikvCBXk@google.com>
References: <20210610151306.1789549-1-qperret@google.com>
 <20210610151306.1789549-4-qperret@google.com>
 <20210611124820.ksydlg4ncw2xowd3@e107158-lin.cambridge.arm.com>
 <YMNgPyfiIaIIsjqq@google.com>
 <20210611132653.o5iljqtmr2hcvtsl@e107158-lin.cambridge.arm.com>
 <YMNp3EigvYjeMVAj@google.com>
 <20210611141737.spzlmuh7ml266c5a@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611141737.spzlmuh7ml266c5a@e107158-lin.cambridge.arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 Jun 2021 at 15:17:37 (+0100), Qais Yousef wrote:
> On 06/11/21 13:49, Quentin Perret wrote:
> > Thinking about it a bit more, a more involved option would be to have
> > this patch as is, but to also introduce a new RLIMIT_UCLAMP on top of
> > it. The semantics could be:
> > 
> >   - if the clamp requested by the non-privileged task is lower than its
> >     existing clamp, then allow;
> >   - otherwise, if the requested clamp is less than UCLAMP_RLIMIT, then
> >     allow;
> >   - otherwise, deny,
> > 
> > And the same principle would apply to both uclamp.min and uclamp.max,
> > and UCLAMP_RLIMIT would default to 0.
> > 
> > Thoughts?
> 
> That could work. But then I'd prefer your patch to go as-is. I don't think
> uclamp can do with this extra complexity in using it.

Sorry I'm not sure what you mean here?

> We basically want to specify we want to be paranoid about uclamp CAP or not. In
> my view that is simple and can't see why it would be a big deal to have
> a procfs entry to define the level of paranoia the system wants to impose. If
> it is a big deal though (would love to hear the arguments);

Not saying it's a big deal, but I think there are a few arguments in
favor of using rlimit instead of a sysfs knob. It allows for a much
finer grain configuration  -- constraints can be set per-task as well as
system wide if needed, and it is the standard way of limiting resources
that tasks can ask for.

> requiring apps that
> want to self regulate to have CAP_SYS_NICE is better approach.

Rlimit wouldn't require that though, which is also nice as CAP_SYS_NICE
grants you a lot more power than just clamps ...
