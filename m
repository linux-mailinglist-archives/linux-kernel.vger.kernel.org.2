Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F69B415070
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 21:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237188AbhIVT0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 15:26:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:35334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233678AbhIVT0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 15:26:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F1BA60FE8;
        Wed, 22 Sep 2021 19:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632338688;
        bh=PJO7tzJ/Irs+TFM64SrlIqLdQjdFxHkXls5kKgEVSIc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=LtYoVq14WFCNxsfE6ITFzc+2u0p/141TSsD6W8YVRcd/Fih8iQU/yibo51TZ9iVxT
         +TGp4HaBALxxOvgKJ1nJVQjdGkB7unTU35aCk384ReTJD5CALbaCBFIxCh77jyN/9M
         +cCBNzSc+H4HeAdfQSd4e/lNQn/h+0UcodaVveCWq6LmvK7GvNhHvPrxVj5QHL7IB7
         1lpPpcLmACaX4woMcsi16Cfx8w0V3q+Wj2kCZXOKp7wT1moXu8CNNW08Z/+l7HgW4C
         gD6miofbFwT0gKTuEilECU5QIFhvwRmrQyWDV3Buxi5RzejQTxKw8T76md43ZrrBtx
         WYCNBN5KZuckA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1D7905C0A54; Wed, 22 Sep 2021 12:24:48 -0700 (PDT)
Date:   Wed, 22 Sep 2021 12:24:48 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Guillaume Morin <guillaume@morinfr.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: call_rcu data race patch
Message-ID: <20210922192448.GB880162@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210917191555.GA2198@bender.morinfr.org>
 <20210917211148.GU4156@paulmck-ThinkPad-P17-Gen-1>
 <20210917213404.GA14271@bender.morinfr.org>
 <20210917220700.GV4156@paulmck-ThinkPad-P17-Gen-1>
 <20210918003933.GA25868@bender.morinfr.org>
 <20210918040035.GX4156@paulmck-ThinkPad-P17-Gen-1>
 <20210918070836.GA19555@bender.morinfr.org>
 <20210919163539.GD880162@paulmck-ThinkPad-P17-Gen-1>
 <20210920160540.GA31426@bender.morinfr.org>
 <20210922191406.GA31531@bender.morinfr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922191406.GA31531@bender.morinfr.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 09:14:07PM +0200, Guillaume Morin wrote:
> On 20 Sep 18:05, Guillaume Morin wrote:
> > On 19 Sep  9:35, Paul E. McKenney wrote:
> > > How is the testing of the patches going?  (I am guessing nothing yet
> > > based on the failure times, but who knows?)
> > 
> > Nothing yet. I think we'll have a better idea by wednesday.
> 
> I am little afraid of jinxing it :) but so far so good. I have the a
> patched kernel running on a few machines (including my most "reliable
> crasher") and they've been stable so far.
> 
> It's definitely too early to declare victory though. I will keep you
> posted.

Here is hoping!  ;-)

							Thanx, Paul
