Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C085F3A25BB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 09:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbhFJHrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 03:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhFJHrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 03:47:45 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DD7C061574
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 00:45:34 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id r9so1063679wrz.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 00:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sSvIpA5rJJggmkmb3RNOzMU8GwHLDANDD2wgJj5dyO4=;
        b=EGOjej4OYcF88r6cNm/DWQguN2ZNuIP3nHMCOvyIH2vYBqmx2EyjsA+RASBiZ2edaB
         sxXGLbMB3m8+BIeER0F64X1L+IAcVaz92kLczii+NUzxB5ekDDu4ucBdPRx3Z1SovY+A
         Lj+Qy9/5a2jYRGmd3zSFwGBGPWpYDxhFc8WQykBD/ANlC3vNXk65uee8L7DYkxA4XMS/
         8FZ1SWkjhW5SyJIMaBY/HOKI+ZzPouRxCcf2qcpCxKIczP7O+ArVaeEbIFcCUW6fbcD8
         FPo+NapWFBgrUxQGPXn8oQhNJoP9KihNeUNM6HglrBD3q0M9jGPoWDLi03z6u/4qQ/d6
         mMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sSvIpA5rJJggmkmb3RNOzMU8GwHLDANDD2wgJj5dyO4=;
        b=mJTIsAV/gcG4XfhsWHLUWRRXwMHzgTXU1WK5S5TqWmhmy/KB9RMCWYBIQCJ5C4KBE/
         E2Mp0DJOxP/uNSFGRqL2891peMJ4yY+hnlhcmMuEWBQPQVAUlg/KqHwM7acF1Kq/rYrl
         4HWg3edqcNw2rWx5AhWbChAjlF3iAp9hfMl+35l6HzPZZYlDFTDqU68TTuJ1LrfM35ir
         IQRcDjBdaQjD0qj8ExYtok/PoI2efMWIYB+RnpdK1+7xE4YITaQFTdaAnR8BSwYKBV2L
         IPLnZBn2REe1NmZ7ITqbiD4/mDvcoJshKxkk1GB5ft4VmI0H7kXXF5iPOm6J0I2TNhU/
         +UUw==
X-Gm-Message-State: AOAM533eIb+tRWiqQZHgOmtPNlnzb2FUmxNZOee3tECo6ZZFjFuLpO75
        FbTFvAK59fP+ylUvfaNmn1XrXg==
X-Google-Smtp-Source: ABdhPJyz6Qsfu0q4mB/JyIFwa9OHEagLpSaNgzwefeA/kbtrd4OWuz80gC26BWmfW26hiRRUYtY45g==
X-Received: by 2002:adf:a550:: with SMTP id j16mr3833398wrb.25.1623311132886;
        Thu, 10 Jun 2021 00:45:32 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id f14sm7524738wmq.10.2021.06.10.00.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 00:45:32 -0700 (PDT)
Date:   Thu, 10 Jun 2021 07:45:29 +0000
From:   Quentin Perret <qperret@google.com>
To:     Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Qais Yousef <qais.yousef@arm.com>, rickyiu@google.com,
        wvw@google.com, Patrick Bellasi <patrick.bellasi@matbug.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team@android.com
Subject: Re: [PATCH] sched: Make uclamp changes depend on CAP_SYS_NICE
Message-ID: <YMHDGZM5d1DKm4lh@google.com>
References: <20210609175901.1423553-1-qperret@google.com>
 <CAB8ipk_LY=9G5E8TcE3b7i3Ntfj+vJUuqSR7LWYn8=yOaTtCEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB8ipk_LY=9G5E8TcE3b7i3Ntfj+vJUuqSR7LWYn8=yOaTtCEg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 Jun 2021 at 11:33:04 (+0800), Xuewen Yan wrote:
> On Thu, Jun 10, 2021 at 2:16 AM Quentin Perret <qperret@google.com> wrote:
> > +static bool uclamp_reduce(struct task_struct *p, const struct sched_attr *attr)
> > +{
> > +       int util_min, util_max;
> > +
> > +       if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
> > +               util_min = p->uclamp_req[UCLAMP_MIN].value;
> > +               if (attr->sched_util_min > util_min)
> > +                       return false;
> > +       }
> > +
> > +       if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX) {
> > +               util_max = p->uclamp_req[UCLAMP_MAX].value;
> > +               if (attr->sched_util_max > util_max)
> > +                       return false;
> 
> when the attr->sched_util_max = -1, and the util_max < 1024, here may
> should return false, but it would return ture.

Aha, indeed, I missed that -1 could be used to reset the clamps. I'll
send a v2.

Thanks!
Quentin
