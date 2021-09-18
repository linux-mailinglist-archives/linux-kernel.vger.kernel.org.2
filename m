Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9F141049C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 09:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242514AbhIRHKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 03:10:03 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:34500 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242021AbhIRHKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 03:10:02 -0400
Received: from bender.morinfr.org (unknown [82.64.86.27])
        by smtp4-g21.free.fr (Postfix) with ESMTPS id 75DA719F57B;
        Sat, 18 Sep 2021 09:08:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=morinfr.org
        ; s=20170427; h=In-Reply-To:Content-Type:MIME-Version:References:Reply-To:
        Message-ID:Subject:To:From:Date:Sender:Cc:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1qFwO3DrhH2zVLW4R4mdKKAUPYQ975frokWG+kY28E4=; b=vZ9fceg907Df+YembdRrVDxOIr
        hKn28jAWxRgXBBWlrS4xvciU28+K3h6r37ljuuXgCbq4cFDUgQ5VH/sq2XCYIFCZdhyIlh7DZBFQk
        Um6twlSQZooEMO3kgpEInn1mCBkroL1d1T8vZaFYwpremnhO+SIA/iK1KsG2aSgemz/0=;
Received: from guillaum by bender.morinfr.org with local (Exim 4.92)
        (envelope-from <guillaume@morinfr.org>)
        id 1mRUSk-00056s-64; Sat, 18 Sep 2021 09:08:38 +0200
Date:   Sat, 18 Sep 2021 09:08:38 +0200
From:   Guillaume Morin <guillaume@morinfr.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: call_rcu data race patch
Message-ID: <20210918070836.GA19555@bender.morinfr.org>
Reply-To: Guillaume Morin <guillaume@morinfr.org>
Mail-Followup-To: "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20210917191555.GA2198@bender.morinfr.org>
 <20210917211148.GU4156@paulmck-ThinkPad-P17-Gen-1>
 <20210917213404.GA14271@bender.morinfr.org>
 <20210917220700.GV4156@paulmck-ThinkPad-P17-Gen-1>
 <20210918003933.GA25868@bender.morinfr.org>
 <20210918040035.GX4156@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210918040035.GX4156@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Sep 21:00, Paul E. McKenney wrote:
> That is them!  There are some flags that control their activities:
> 
> o	rcu_data structure's ->nocb_gp_sleep field (rcuog)
> o	rcu_data structure's ->nocb_cb_sleep field (rcuoc)

From the same kdump:

crash> pd rcu_data:all | grep -E 'nocb_cb_sleep|nocb_gp_sleep|per_cpu'
per_cpu(rcu_data, 0) = $69 = {
  nocb_gp_sleep = 0 '\000', 
  nocb_cb_sleep = false, 
per_cpu(rcu_data, 1) = $70 = {
  nocb_gp_sleep = 1 '\001', 
  nocb_cb_sleep = true, 
per_cpu(rcu_data, 2) = $71 = {
  nocb_gp_sleep = 0 '\000', 
  nocb_cb_sleep = true, 
per_cpu(rcu_data, 3) = $72 = {
  nocb_gp_sleep = 0 '\000', 
  nocb_cb_sleep = true, 
per_cpu(rcu_data, 4) = $73 = {
  nocb_gp_sleep = 1 '\001', 
  nocb_cb_sleep = true, 
per_cpu(rcu_data, 5) = $74 = {
  nocb_gp_sleep = 0 '\000', 
  nocb_cb_sleep = true, 
per_cpu(rcu_data, 6) = $75 = {
  nocb_gp_sleep = 0 '\000', 
  nocb_cb_sleep = true, 
per_cpu(rcu_data, 7) = $76 = {
  nocb_gp_sleep = 0 '\000', 
  nocb_cb_sleep = true, 
per_cpu(rcu_data, 8) = $77 = {
  nocb_gp_sleep = 1 '\001', 
  nocb_cb_sleep = true, 
per_cpu(rcu_data, 9) = $78 = {
  nocb_gp_sleep = 0 '\000', 
  nocb_cb_sleep = true, 
per_cpu(rcu_data, 10) = $79 = {
  nocb_gp_sleep = 0 '\000', 
  nocb_cb_sleep = true, 
per_cpu(rcu_data, 11) = $80 = {
  nocb_gp_sleep = 0 '\000', 
  nocb_cb_sleep = true, 
per_cpu(rcu_data, 12) = $81 = {
  nocb_gp_sleep = 1 '\001', 
  nocb_cb_sleep = true, 
per_cpu(rcu_data, 13) = $82 = {
  nocb_gp_sleep = 0 '\000', 
  nocb_cb_sleep = true, 
per_cpu(rcu_data, 14) = $83 = {
  nocb_gp_sleep = 0 '\000', 
  nocb_cb_sleep = true, 
per_cpu(rcu_data, 15) = $84 = {
  nocb_gp_sleep = 0 '\000', 
  nocb_cb_sleep = true, 
per_cpu(rcu_data, 16) = $85 = {
  nocb_gp_sleep = 1 '\001', 
  nocb_cb_sleep = true, 
per_cpu(rcu_data, 17) = $86 = {
  nocb_gp_sleep = 0 '\000', 
  nocb_cb_sleep = true, 
crash>

-- 
Guillaume Morin <guillaume@morinfr.org>
