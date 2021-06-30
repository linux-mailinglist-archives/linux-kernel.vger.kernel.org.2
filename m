Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1973B7C90
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 06:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbhF3EZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 00:25:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:50752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230200AbhF3EZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 00:25:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0089661D28;
        Wed, 30 Jun 2021 04:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625026995;
        bh=kfVIrUp5BJMPXgGi+SKitP2xMU5X2s71OIZL89q3Jik=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=kgwc52ch1Jj2pGPsqlFcsAZUODYdbMVPDP66X4tyfZpqHLKfKtPPs7/reb9Rjb8T3
         OcS8P9e59CEDzDFpxzejRkxYBucWRPsSYXUrO2uqcEt0JoSGKFtYxMq4q3+dsC5qXc
         GksYOcvBuUmiLbrD0YzwlGNUdllKkD/9eoC/BANZ5/a1sWv0a2FicTnSGjC6iH+BWG
         zpSWfA8eu9FEAEQ6BjqGvKU767A//2N6HoVZZOUbMV4KdSmhDfdh6YhsmisqG/lT2t
         PBy0jCnIoKb24zlXJWHbVSK9pgypQ1toEtWosXoBqiMDPSELQehz4AZu4BK8lXDM+M
         V52flCkQ18OGw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DBD8F5C02AB; Tue, 29 Jun 2021 21:23:14 -0700 (PDT)
Date:   Tue, 29 Jun 2021 21:23:14 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     liu.song11@zte.com.cn
Cc:     fishland@aliyun.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Remove unnecessary updates to ret in rcu_gp_fqs_loop
Message-ID: <20210630042314.GU4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210629174408.GS4397@paulmck-ThinkPad-P17-Gen-1>
 <202106301122531910761@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202106301122531910761@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2021 at 11:22:53AM +0800, liu.song11@zte.com.cn wrote:
> > rcu: Remove useless "ret" update in rcu_gp_fqs_loop()
> >      
> >     Within rcu_gp_fqs_loop(), the "ret" local variable is set to the
> >     return value from swait_event_idle_timeout_exclusive(), but "ret" is
> >     unconditionally overwritten later in the code.  This commit therefore
> >     removes this useless assignment.
> 
> The revised commit log is exactly what I want to express, it is perfect.

Thank you for looking it over!

							Thanx, Paul
