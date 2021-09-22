Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB68415062
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 21:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237172AbhIVTQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 15:16:09 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:63618 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236431AbhIVTQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 15:16:08 -0400
Received: from bender.morinfr.org (unknown [82.64.86.27])
        by smtp4-g21.free.fr (Postfix) with ESMTPS id 6A9A219F595;
        Wed, 22 Sep 2021 21:14:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=morinfr.org
        ; s=20170427; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=CLCLBROe4Yr76HULuuZ6DO/jlU3FjYAABFTp+kA8u1M=; b=XQA5lTBi6G0RmqwgWvMm0RE+Gs
        hrMyernSpOV3oz7n9Ip9NY4angZTDI7A5k28avE5TZvWj4JBW+zjUmd52Ks03ZOrS3S2dS2NMWm1u
        INh002VWREo3Odl24Oc53OpY1Fgg3jLWAZaLsYnhCxdQ/axEkJoWxHZSWMEy8WKWKc9Y=;
Received: from guillaum by bender.morinfr.org with local (Exim 4.92)
        (envelope-from <guillaume@morinfr.org>)
        id 1mT7h1-0000wa-5i; Wed, 22 Sep 2021 21:14:07 +0200
Date:   Wed, 22 Sep 2021 21:14:07 +0200
From:   Guillaume Morin <guillaume@morinfr.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: call_rcu data race patch
Message-ID: <20210922191406.GA31531@bender.morinfr.org>
References: <20210917191555.GA2198@bender.morinfr.org>
 <20210917211148.GU4156@paulmck-ThinkPad-P17-Gen-1>
 <20210917213404.GA14271@bender.morinfr.org>
 <20210917220700.GV4156@paulmck-ThinkPad-P17-Gen-1>
 <20210918003933.GA25868@bender.morinfr.org>
 <20210918040035.GX4156@paulmck-ThinkPad-P17-Gen-1>
 <20210918070836.GA19555@bender.morinfr.org>
 <20210919163539.GD880162@paulmck-ThinkPad-P17-Gen-1>
 <20210920160540.GA31426@bender.morinfr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920160540.GA31426@bender.morinfr.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Sep 18:05, Guillaume Morin wrote:
> On 19 Sep  9:35, Paul E. McKenney wrote:
> > How is the testing of the patches going?  (I am guessing nothing yet
> > based on the failure times, but who knows?)
> 
> Nothing yet. I think we'll have a better idea by wednesday.

I am little afraid of jinxing it :) but so far so good. I have the a
patched kernel running on a few machines (including my most "reliable
crasher") and they've been stable so far.

It's definitely too early to declare victory though. I will keep you
posted.

Guillaume.

-- 
Guillaume Morin <guillaume@morinfr.org>
