Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB9B03C734D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 17:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237094AbhGMPeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 11:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236970AbhGMPeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 11:34:15 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF96C0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 08:31:25 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id j199so19981747pfd.7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 08:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=4JLkHqv40CmG7uaGdF0kdga9f1jTWV2dMUz/yJdaz2M=;
        b=1bEk/KHyfwxs/+kzKDxxY7JFrLkIpI/mXtVxGpwQyXXefp3BWTb4QPBxyFaJnM8EnD
         BMRcSyHVcxIcR3lHi5ZLTdj6OV0HrN29C8EON3OVFEoaAf8fk1AFYRRD+5G1G2eDsmbW
         6QoUhOtXl2fruqEPnFtIwFj3uzeXJ3LYEEol0dZpGboJDOHaiJu9mbV9iW37lcFM7Kyk
         GKuUt0OY3YBZvsAlTYdBgLziLouoamMyxv/XwdJqsoXIcyQAIQPVZ8OiEs1z8fELgT/5
         StXBFLTQMWFxtxxuomVEvWutWnEVo+oYMdzXHfY3Y8TcUSEwGEDcLxxOKT9YILmPIBAC
         Vghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=4JLkHqv40CmG7uaGdF0kdga9f1jTWV2dMUz/yJdaz2M=;
        b=ifVwySV0QNKekFyzms544WUn7czeaN0wqqV9zlUoV1Tf5aZ4UozWSIGWA95uiouOK/
         Bw835baTPyt9OYnWTkvrIEY3rsD68mQlMz/Z2+reMzZaJI15wq0yuPRLeRVjN0o+UEGK
         Y/LPUTbod2QruG1gSr2ubemVwEVsu74j2MKPjx6r1zHfWIVB2LYl17fKYwKTg8wRa6Dd
         ezjXSb6VEcXeGpABAY0aDBI6KIBDYo6enXZv3I1r+hiqsi03pbvuADLSggSwx4QfQbO5
         RRfKdq5f30zcJVyVu/FVIoDx5hWxzyftTvW4iFGWB2tX0vS7zy376Jg2/Cybne615DRf
         6+NQ==
X-Gm-Message-State: AOAM533OWVBptO82Y94Zv3cJ85EDKGozO4FnquGG7yUN4EM6b7Nh8XHh
        KjUeNLKLMLaotW/+yu7D2Wh2uQ==
X-Google-Smtp-Source: ABdhPJzVMt8k6+c8LLV5O+qm3jxfHbpWKx2YvsfRMst3gyzs2SB+AI/zmEdQtaug45xTYV5+0m/hgw==
X-Received: by 2002:a62:2942:0:b029:2f4:e012:fb23 with SMTP id p63-20020a6229420000b02902f4e012fb23mr5021592pfp.55.1626190284569;
        Tue, 13 Jul 2021 08:31:24 -0700 (PDT)
Received: from anisinha-lenovo ([115.96.158.88])
        by smtp.googlemail.com with ESMTPSA id j13sm3545843pjl.1.2021.07.13.08.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 08:31:24 -0700 (PDT)
From:   Ani Sinha <ani@anisinha.ca>
X-Google-Original-From: Ani Sinha <anisinha@anisinha.ca>
Date:   Tue, 13 Jul 2021 21:01:06 +0530 (IST)
X-X-Sender: anisinha@anisinha-lenovo
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Wei Liu <wei.liu@kernel.org>, Ani Sinha <ani@anisinha.ca>,
        linux-kernel@vger.kernel.org, anirban.sinha@nokia.com,
        mikelley@microsoft.com, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH] Hyper-V: fix for unwanted manipulation of sched_clock
 when TSC marked unstable
In-Reply-To: <20210713131756.GD4170@worktop.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.22.394.2107132051590.2135909@anisinha-lenovo>
References: <20210713030522.1714803-1-ani@anisinha.ca> <20210713130446.gt7k3cwlmhsxtltw@liuwe-devbox-debian-v2> <20210713131756.GD4170@worktop.programming.kicks-ass.net>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 13 Jul 2021, Peter Zijlstra wrote:

> On Tue, Jul 13, 2021 at 01:04:46PM +0000, Wei Liu wrote:
> > On Tue, Jul 13, 2021 at 08:35:21AM +0530, Ani Sinha wrote:
> > > Marking TSC as unstable has a side effect of marking sched_clock as
> > > unstable when TSC is still being used as the sched_clock. This is not
> > > desirable. Hyper-V ultimately uses a paravirtualized clock source that
> > > provides a stable scheduler clock even on systems without TscInvariant
> > > CPU capability. Hence, mark_tsc_unstable() call should be called _after_
> > > scheduler clock has been changed to the paravirtualized clocksource. This
> > > will prevent any unwanted manipulation of the sched_clock. Only TSC will
> > > be correctly marked as unstable.
> >
> > Correct me if I'm wrong, what you're trying to address is that
> > sched_clock remains marked as unstable even after Linux has switched to
> > a stable clock source.
> >
> > I think a better approach will be to mark the sched_clock as stable when
> > we switch to the paravirtualized clock source.
>
> No.. unstable->stable transitions are unsound. You get to switch to your
> paravirt clock earlier.
>

I believe manipulating sched_clock was never the intention of the original
author who added the code to mark tsc as unstable on hyper-V:

commit 88c9281a9fba67636ab26c1fd6afbc78a632374f
Author: Vitaly Kuznetsov <vkuznets@redhat.com>
Date:   Wed Aug 19 09:54:24 2015 -0700

    x86/hyperv: Mark the Hyper-V TSC as unstable


The original author simply wanted to mark TSC as unstable on hyper-V
systems because of reasons the above commit log will describe. Sched clock
manipulation happened accidentally because from where the
mark_tsc_unstable() was being called. This patch simply fixes this.

Michael Kelly from Microsoft has tested this patch already.

--Ani

