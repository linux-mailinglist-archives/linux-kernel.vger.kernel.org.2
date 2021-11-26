Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5602245E80B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 07:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358937AbhKZGtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 01:49:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:43426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345573AbhKZGqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 01:46:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED9ED610F9;
        Fri, 26 Nov 2021 06:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637909019;
        bh=PWEeWSofYdLbFb5WTFOYP4ugJNkDjPaPw51K6zcxe6A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WDrqH/oNlGQ33k9gFHRXPFLwP0Xa8dCfO3uboOchXP/NZuIQjlLFXix7kUk3rLYHn
         37MESWm4j7bfK98tEDvP/GtfhCAvnBbOX0mqlbJHZ0M5nQUX58/p14/U5p3ez9IKQ3
         jdYkl9pv8rs+c8XkSHpWNNiOvPX+1hp0THj2Obug=
Date:   Fri, 26 Nov 2021 07:43:34 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v3 1/3] staging: zynpu: Add driver support for ARM(China)
 ZHOUYI AI accelerator
Message-ID: <YaCCFv2DLzeng+UE@kroah.com>
References: <20211126021904.32325-1-caihuoqing@baidu.com>
 <20211126021904.32325-2-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126021904.32325-2-caihuoqing@baidu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 10:18:59AM +0800, Cai Huoqing wrote:
> ZHOUYI NPU is an AI accelerator chip which is integrated into ARM SOC,
> such as Allwinner R329 SOC.
> Add driver support for this AI accelerator here.
> 
> This driver is not standard linux style, there are some clean up works,
> fixing code style, refactorring.
> And it only works with a closed source usermode driver, so need to
> reverse the libraries, and impelement it, then open source
> the usermode driver.
> So add this driver to linux-staging

Sorry, but no, I can not take this driver into the kernel tree until
there is an open source user of the new api that you are creating with
this driver.  This was discussed many times on the linux-kernel mailing
list and at the Linux kernel summit a few months ago (see the summary at
lwn.net about it.)

So please work on that first, and then we will be glad to revisit taking
this kernel driver into the tree.

Also, it is much simpler just to take a few hours and clean up the
coding style issues yourself rather than relying on the community to do
it for you over a few months.

thanks,

greg k-h
