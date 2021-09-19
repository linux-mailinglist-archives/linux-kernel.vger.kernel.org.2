Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4B0410C5C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 18:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhISQhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 12:37:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:42832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229437AbhISQhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 12:37:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 36AC6611C8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 16:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632069340;
        bh=V4HgvipBQttIvPWgUIeG7T7DNHIK6v4oOUEZtOGIJV0=;
        h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
        b=F0e22hv5XKqRvR/3JWM1ZNxaafu9pA+RcnEXd5fG3seWzzBBq/AiXInHpn3BoZLBx
         ltZDagnjgKwAikiWVeyU/g54m2RfR0jYh3loJ0N9+nZ2szmVwmxXDk5UfL5vXTD+vl
         N73UlTZT9BYPas2C/yGQqKH9lyL3PNGJDiOZ56tVRSk59USnPuHYaqh7b9VpyRUS1k
         Qjnme8Ea4Hqz/W4tqfg1EF9eeHk7J0oVRNnSAWrhPaR8X+Qbo/zRYTVqNS5XpnL6D2
         30PmGnoFYNxCAT84g1njYs/wHf/mPYX8DouwE3etK0Pz5zOiR8nD++VPCn1sDP8GI3
         kFOGSNSuj/3jQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F13845C0692; Sun, 19 Sep 2021 09:35:39 -0700 (PDT)
Date:   Sun, 19 Sep 2021 09:35:39 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: Re: call_rcu data race patch
Message-ID: <20210919163539.GD880162@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210917191555.GA2198@bender.morinfr.org>
 <20210917211148.GU4156@paulmck-ThinkPad-P17-Gen-1>
 <20210917213404.GA14271@bender.morinfr.org>
 <20210917220700.GV4156@paulmck-ThinkPad-P17-Gen-1>
 <20210918003933.GA25868@bender.morinfr.org>
 <20210918040035.GX4156@paulmck-ThinkPad-P17-Gen-1>
 <20210918070836.GA19555@bender.morinfr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210918070836.GA19555@bender.morinfr.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 18, 2021 at 09:08:38AM +0200, Guillaume Morin wrote:
> On 17 Sep 21:00, Paul E. McKenney wrote:
> > That is them!  There are some flags that control their activities:
> > 
> > o	rcu_data structure's ->nocb_gp_sleep field (rcuog)
> > o	rcu_data structure's ->nocb_cb_sleep field (rcuoc)
> 
> >From the same kdump:
> 
> crash> pd rcu_data:all | grep -E 'nocb_cb_sleep|nocb_gp_sleep|per_cpu'
> per_cpu(rcu_data, 0) = $69 = {
>   nocb_gp_sleep = 0 '\000', 
>   nocb_cb_sleep = false, 
> per_cpu(rcu_data, 1) = $70 = {
>   nocb_gp_sleep = 1 '\001', 
>   nocb_cb_sleep = true, 
> per_cpu(rcu_data, 2) = $71 = {
>   nocb_gp_sleep = 0 '\000', 
>   nocb_cb_sleep = true, 
> per_cpu(rcu_data, 3) = $72 = {
>   nocb_gp_sleep = 0 '\000', 
>   nocb_cb_sleep = true, 
> per_cpu(rcu_data, 4) = $73 = {
>   nocb_gp_sleep = 1 '\001', 
>   nocb_cb_sleep = true, 
> per_cpu(rcu_data, 5) = $74 = {
>   nocb_gp_sleep = 0 '\000', 
>   nocb_cb_sleep = true, 
> per_cpu(rcu_data, 6) = $75 = {
>   nocb_gp_sleep = 0 '\000', 
>   nocb_cb_sleep = true, 
> per_cpu(rcu_data, 7) = $76 = {
>   nocb_gp_sleep = 0 '\000', 
>   nocb_cb_sleep = true, 
> per_cpu(rcu_data, 8) = $77 = {
>   nocb_gp_sleep = 1 '\001', 
>   nocb_cb_sleep = true, 
> per_cpu(rcu_data, 9) = $78 = {
>   nocb_gp_sleep = 0 '\000', 
>   nocb_cb_sleep = true, 
> per_cpu(rcu_data, 10) = $79 = {
>   nocb_gp_sleep = 0 '\000', 
>   nocb_cb_sleep = true, 
> per_cpu(rcu_data, 11) = $80 = {
>   nocb_gp_sleep = 0 '\000', 
>   nocb_cb_sleep = true, 
> per_cpu(rcu_data, 12) = $81 = {
>   nocb_gp_sleep = 1 '\001', 
>   nocb_cb_sleep = true, 
> per_cpu(rcu_data, 13) = $82 = {
>   nocb_gp_sleep = 0 '\000', 
>   nocb_cb_sleep = true, 
> per_cpu(rcu_data, 14) = $83 = {
>   nocb_gp_sleep = 0 '\000', 
>   nocb_cb_sleep = true, 
> per_cpu(rcu_data, 15) = $84 = {
>   nocb_gp_sleep = 0 '\000', 
>   nocb_cb_sleep = true, 
> per_cpu(rcu_data, 16) = $85 = {
>   nocb_gp_sleep = 1 '\001', 
>   nocb_cb_sleep = true, 
> per_cpu(rcu_data, 17) = $86 = {
>   nocb_gp_sleep = 0 '\000', 
>   nocb_cb_sleep = true, 
> crash>

This is consistent with CPU 0's rcuoc kthread processing callbacks
and all of the rcuog threads waiting for more callbacks.

How is the testing of the patches going?  (I am guessing nothing yet
based on the failure times, but who knows?)

						Thanx, Paul
