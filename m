Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1569E3A959B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 11:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbhFPJMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 05:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbhFPJMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 05:12:44 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E050EC061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 02:10:37 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id x19so806285pln.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 02:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pIJxUfgtPOEpyIe2V89TTN9ZqQgFTVMc4Nh9n4XFBl0=;
        b=EUoxJcMR5ig4BSimcszBBQjwhH7MyXoT5uw1AjOwr158ISRXPmu7nXA9V7lPBbUTLW
         DUrvTZEHtWqpoAJX024kpTizlRRrVyaOdt4EClYy7qK3BtTmaN74dFLoHlZ3dW0ofaqm
         7ie4x7W5wVHoU8IO43C1cKj4hiUrRJ+l+t3U+RAMJPMMYblstTV2mHoy5DG8xXKBlj1W
         VkgxHYqF3fnw/qd/6iNyIz3IlvfMvvaQh2KmcSby5wLTjmb96NLfpteLnkl4HR1Yw8K4
         ZQGbOp46NB/b5JeLYUmsv5jtl4tI903aate+qbbytVEqkc1l5ALyop34CvP3KaJBrHyP
         tP8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pIJxUfgtPOEpyIe2V89TTN9ZqQgFTVMc4Nh9n4XFBl0=;
        b=R8A0ZSE5H5PQU9IwahpA1+wxt4nZLqU9zZs+ZZgRctORkvMU2S3g1JCj331ZOMJVQs
         pHAIU85H2eOdwQSAoFEtD1pcvJ8mis5MrjHsyPFTP8ZJ6fF5eZ6DWA6X2/mBxJ3BdSVJ
         6Aka4ElJ8TyxZQlm9nN3d8KozXCaEHTxFDPmDE2DIJVM6JP1niYeR0SeiK73bqhQ6wb6
         e69iwfMJmqcB1FVRvNLyQQf5EYnnO5Xn/lOG+MeNeSUrmBPaULJYpgTjJ/qobfwzSFzs
         FqY/8fwmVxtlFqt0feFa4VfTNNIzaTrfV6w7X0E/MQ4FrgHwKMyUY5CP+N+JiWF4zMCS
         XREQ==
X-Gm-Message-State: AOAM5325faIYx1fqnLve1DJVW40XNio0FebKRyWvoxHsYiGryT84IMzR
        F0BDQWay8s1aSVK6XDQs88SnwQ==
X-Google-Smtp-Source: ABdhPJx6rcOQbDV1ixH+cz+L8wMrwnmq2LptaULTFOM+DqwF6drMmPLDqkgB1uQLUuO5ybvDCpDh7Q==
X-Received: by 2002:a17:90a:8001:: with SMTP id b1mr9797235pjn.17.1623834637465;
        Wed, 16 Jun 2021 02:10:37 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id p19sm4877320pjv.21.2021.06.16.02.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 02:10:37 -0700 (PDT)
Date:   Wed, 16 Jun 2021 14:40:35 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qian Cai <quic_qiancai@quicinc.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/3] arch_topology: Avoid use-after-free for
 scale_freq_data
Message-ID: <20210616091035.qcb5nhwfvtyhrwqe@vireshk-i7>
References: <cover.1623825725.git.viresh.kumar@linaro.org>
 <9dba462b4d09a1a8a9fbb75740b74bf91a09a3e1.1623825725.git.viresh.kumar@linaro.org>
 <YMmu3bS3Q6avUfEW@kroah.com>
 <20210616081859.idzpwzdyeu666xpz@vireshk-i7>
 <YMm2y6vvLpsIkXPT@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMm2y6vvLpsIkXPT@kroah.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-06-21, 10:31, Greg Kroah-Hartman wrote:
> On Wed, Jun 16, 2021 at 01:48:59PM +0530, Viresh Kumar wrote:
> > On 16-06-21, 09:57, Greg Kroah-Hartman wrote:
> > > On Wed, Jun 16, 2021 at 12:18:08PM +0530, Viresh Kumar wrote:
> > > > Currently topology_scale_freq_tick() may end up using a pointer to
> > > > struct scale_freq_data, which was previously cleared by
> > > > topology_clear_scale_freq_source(), as there is no protection in place
> > > > here. The users of topology_clear_scale_freq_source() though needs a
> > > > guarantee that the previous scale_freq_data isn't used anymore.
> > > > 
> > > > Since topology_scale_freq_tick() is called from scheduler tick, we don't
> > > > want to add locking in there. Use the RCU update mechanism instead
> > > > (which is already used by the scheduler's utilization update path) to
> > > > guarantee race free updates here.
> > > > 
> > > > Cc: Paul E. McKenney <paulmck@kernel.org>
> > > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > 
> > > So this is a bugfix for problems in the current codebase?  What commit
> > > does this fix?  Should it go to the stable kernels?
> > 
> > There is only one user of topology_clear_scale_freq_source()
> > (cppc-cpufreq driver, which is already reverted in pm/linux-next). So
> > in the upcoming 5.13 kernel release, there will be no one using this
> > API and so no one will break.
> > 
> > And so I skipped the fixes tag, I can add it though.
> 
> It would be nice to have to answer this type of question, otherwise you
> will have automated scripts trying to backport this to kernels where it
> does not belong :)

Sure, I will add these to the next version.

-- 
viresh
