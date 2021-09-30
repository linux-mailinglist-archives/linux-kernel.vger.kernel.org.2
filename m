Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D70841DB7E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 15:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351481AbhI3Nwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 09:52:42 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:46920 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235171AbhI3Nwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 09:52:40 -0400
Received: from bender.morinfr.org (unknown [82.64.86.27])
        by smtp4-g21.free.fr (Postfix) with ESMTPS id ECF2219F5B2;
        Thu, 30 Sep 2021 15:50:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=morinfr.org
        ; s=20170427; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=TpmKd8ecTW9mqTnjVYeVogjO8emgcTFqwPeCwSf8/lE=; b=IcnULAZZC+YMvmRgtI+7FL15QH
        FaGibOYDdl2JKZ06jioYXO3TcjV4EVGsTN9TFGgiR+WCBJQbohX3v1hg4NHPvcP4IHJh99lSwZQ+T
        siT7WDGxqtm/iqOGO4ZSa1hRwWQYegzAYUK7C1p2nt+CiVS1f0TN8eGjpxv4xEtZCx8Q=;
Received: from guillaum by bender.morinfr.org with local (Exim 4.92)
        (envelope-from <guillaume@morinfr.org>)
        id 1mVwSA-0001i5-J5; Thu, 30 Sep 2021 15:50:26 +0200
Date:   Thu, 30 Sep 2021 15:50:26 +0200
From:   Guillaume Morin <guillaume@morinfr.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: call_rcu data race patch
Message-ID: <20210930135026.GA6305@bender.morinfr.org>
References: <20210918040035.GX4156@paulmck-ThinkPad-P17-Gen-1>
 <20210918070836.GA19555@bender.morinfr.org>
 <20210919163539.GD880162@paulmck-ThinkPad-P17-Gen-1>
 <20210920160540.GA31426@bender.morinfr.org>
 <20210922191406.GA31531@bender.morinfr.org>
 <20210922192448.GB880162@paulmck-ThinkPad-P17-Gen-1>
 <20210927153842.GA12620@bender.morinfr.org>
 <20210927161046.GU880162@paulmck-ThinkPad-P17-Gen-1>
 <20210927164944.GA20372@bender.morinfr.org>
 <20210927214659.GV880162@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927214659.GV880162@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Sep 14:46, Paul E. McKenney wrote:
> On Mon, Sep 27, 2021 at 06:49:45PM +0200, Guillaume Morin wrote:
> > I personally don't need it sooner. But it's been broken for a while (5.4
> > based on the bugzilla report) and I can't imagine the original reporter
> > and we are the only ones hitting this. So my personal opinion would be
> > to get both patches into Linus's tree and stable branches asap, but
> > obviously this is entirely up to you.
> 
> I have it in -next with your Tested-by (thank you!), so let's see how
> testing and review go.

Sounds good. Things are still stable so I am pretty confident this is
now fixed.

Guillaume.

-- 
Guillaume Morin <guillaume@morinfr.org>
