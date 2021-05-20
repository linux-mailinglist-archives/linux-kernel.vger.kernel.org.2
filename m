Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADEF38B4E0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 19:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234739AbhETRFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 13:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234357AbhETRFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 13:05:46 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDC9C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 10:04:25 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id k4so5800209qkd.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 10:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lCSr/SzE2iIrgBlIlQqVKl0fiziIXta89RXBs1cqiuo=;
        b=EWJPiCkxcV/aOg9B6lync+fGTxKK5I8d0PMjCFqSP+f1CgSa3LkPFQILqcpz6bGuLu
         ZFhDEtixjezfEE+BUaG30PuOzVn0gZm+SXp2cgoCplG6ZZhDF2FP1kGVJoU3ZvrPRnKG
         Z1U5lyAjYzkAC0daTg/cQMf6WKyHWboKcHn3MuBJpZSx2euRAFEkLUjiCazbiOK7cK77
         zwXcN0jOGyDKiluxmh75+44wyw2H1IBvNY9CYgzOjfmnAY8zo+OCH/64qh4ZEuCHFPVM
         KaVZFfsc5OW1SBK6DeAhbHT91MYfMab3Dym6E92JRk/CGPlEWtAVAot3j6gNGyHDUYPq
         9B0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=lCSr/SzE2iIrgBlIlQqVKl0fiziIXta89RXBs1cqiuo=;
        b=qN9aikB4EbNI7lbHeVTLwiZ99hutMUW2oUSW0wdfBLt0LNziafEJi/73aVrkragd+Q
         KljvbTsS6YyGnW7uwVgiEvMk2d3aP+Q8QFhG4sR25y2mr4lD/jEtecVxFzdjb4ApzqXM
         r+liD5PaUrkoLOlraKmDugE8dSWkEEN8MiZZnCrMJpCIGbx078X514PFuu3PCMaYpJG3
         ZZxq+LWIlesgxtwfnVvOmjW6bZDx5q62Fw/ep+k+J4YMBTNn/CLN7hK3Mwg7QHsxkQtl
         71YAC5WFPwzFsuLCNwivwuQyCOb7babUDPFdQebnpog64oYNIuEHfGJqq6ul2+JUz8O+
         5Hgg==
X-Gm-Message-State: AOAM531Dr/WK8s5qW+gvVOJRjIKrW0o8NgDuzKmYRDfoB4172akobajR
        LfLqKr1HQ/UEaFp6CC0AFEk=
X-Google-Smtp-Source: ABdhPJzTtity4iGFC4Yp5v982tt2+qUmlvmszQepKE4k5SKwionwyfKcSoXMNYdSY4UmnK2lEcKoeQ==
X-Received: by 2002:a05:620a:818:: with SMTP id s24mr6053508qks.425.1621530264529;
        Thu, 20 May 2021 10:04:24 -0700 (PDT)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [199.96.183.179])
        by smtp.gmail.com with ESMTPSA id s24sm2230298qtx.94.2021.05.20.10.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 10:04:23 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 20 May 2021 13:04:23 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Odin Ugedal <odin@uged.al>
Cc:     Huaixin Chang <changhuaixin@linux.alibaba.com>,
        Benjamin Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        dtcccc@linux.alibaba.com, Juri Lelli <juri.lelli@redhat.com>,
        khlebnikov@yandex-team.ru,
        open list <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        pauld@redhead.com, Peter Zijlstra <peterz@infradead.org>,
        Paul Turner <pjt@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        shanpeic@linux.alibaba.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        xiyou.wangcong@gmail.com
Subject: Re: [PATCH v5 1/3] sched/fair: Introduce the burstable CFS controller
Message-ID: <YKaWl7A6N5Jyyi01@slm.duckdns.org>
References: <20210520123419.8039-1-changhuaixin@linux.alibaba.com>
 <20210520123419.8039-2-changhuaixin@linux.alibaba.com>
 <CAFpoUr2mNO87XFAyHF=HA3f6KC8EkuGrwQQe54q4kmF1WgfG7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFpoUr2mNO87XFAyHF=HA3f6KC8EkuGrwQQe54q4kmF1WgfG7w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Odin.

On Thu, May 20, 2021 at 04:00:29PM +0200, Odin Ugedal wrote:
> >   cpu.max
> >     A read-write two value file which exists on non-root cgroups.
> >     The default is "max 100000".
> 
> This will become a "three value file", and I know a few user space projects
> who parse this file by splitting on the middle space. I am not sure if they are
> "wrong", but I don't think we usually break such things. Not sure what
> Tejun thinks about this.

Good point. I haven't thought about that. It would make more sense to
separate it out to a separate file then - e.g. sth like cpu.max.burst, but
it seems like there are important questions to answer before adding new
interfaces.

Thanks.

-- 
tejun
