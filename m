Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 174DD41A5D8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 05:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238788AbhI1DEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 23:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238771AbhI1DEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 23:04:15 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9504C061604
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 20:02:36 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id h9-20020a9d2f09000000b005453f95356cso27127704otb.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 20:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CwQ0UfiMphl7UCupbZZAVfzMUncFhrOEd9zZGds8Kbw=;
        b=Gs16D0xiZeUMFi79L/U+okQVmp5Q+nFLVf+DFcwPNUndE280ILn7ENCHXGd90v3LCQ
         v8SjbMG8GS7tsO8kb2zQSjEfNcnsY7R+3/BexzFiX4IFtkS1dyFN4UHRVg+psoNWP9iB
         SpwNaPeJ9fqDohZQbTdq1ID/e0Pf/vYvVONanz8xhBpWxl1Bkg7vtcudwGkdwQbPl72d
         USbTbDzieG/qSJGrHzLB3jyOVBownWws0Qa6MwKp0qw73HMbWEFLtgYrZ/tCaJA5YEig
         2dYtwC99n4xmV+ptzHDvdRqUTyv2cqLTE60W1DPEiIyJ6SzCE7cs1WoS0AxtZCoJ48dK
         XnLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CwQ0UfiMphl7UCupbZZAVfzMUncFhrOEd9zZGds8Kbw=;
        b=pfjti4jS7vke/DTPUCsLROzf+41BqE3kumkZGRfuN4Mz3sm3vJTMLmdR9Qx551Grw1
         NsFYx9U7KUoVxcRV8Nf/CGPElcvSIZ7EnU984IQVcxiPBOIqjo9KMkxQn9h+pkJ4N3bA
         4ypG6vaq9Wt25Q+Ajys/bW7xSO/wbcAmWjYTyQ4iqXv5Jn/tG2O2xAq+jXhp2xu73otl
         k8pPw/blXX7OPcqeI7le0mOf5F9Xpc9xWpvNdsdGYd89+rhZucE4IHOaV5yIWrt54+aj
         TD1U9a7gycJaOiYu5uWT9MomUMSXNvEireP0Sbr6MAkCnbSwySFcEFyGJc9dSkD0quYQ
         aQYg==
X-Gm-Message-State: AOAM532xzmgwMORQosq2LJZ6dwJD75DWLn4P5tMe11xDzRHRA9PYtNVW
        PfbkNHEno2Oor6rshJCzecEWfw==
X-Google-Smtp-Source: ABdhPJwNvtHLkCCuN5Mmeww6TemgodBFbOvZSbD+GmIHb4CCsiKRO+wYsRHyND0Razrke67rEtg3FA==
X-Received: by 2002:a9d:7053:: with SMTP id x19mr3066995otj.229.1632798156178;
        Mon, 27 Sep 2021 20:02:36 -0700 (PDT)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id a8sm4624788oos.46.2021.09.27.20.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 20:02:35 -0700 (PDT)
Date:   Mon, 27 Sep 2021 20:03:10 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commits in the rpmsg tree
Message-ID: <YVKF7skeRjacpLhk@ripper>
References: <20210928084011.3f2318fc@canb.auug.org.au>
 <YVJXpBwfdMYKaE0R@ripper>
 <20210928104341.31521fb0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928104341.31521fb0@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 27 Sep 17:43 PDT 2021, Stephen Rothwell wrote:

> Hi Bjorn,
> 
> On Mon, 27 Sep 2021 16:45:40 -0700 Bjorn Andersson <bjorn.andersson@linaro.org> wrote:
> >
> > On Mon 27 Sep 15:40 PDT 2021, Stephen Rothwell wrote:
> > May I ask what tool you use to detect this? Given that checkpatch
> > doesn't care about the committer (afaict)...
> 
> After I fetch each tree, I give the new commit range to the attached
> script (check_commits) which calls the other script as well
> (check_fixes).

Thanks for sharing those Stephen, I'll try to incorporate them into my
checks.

Regards,
Bjorn
