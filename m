Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F6A40B525
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 18:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbhINQpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 12:45:21 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:41072 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229448AbhINQpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 12:45:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=n6CAK2ehnhV5D05PFbTpVXv8GW58kVhsKzx/9xBlgbw=; b=YtvEUTDvdgQVZL7zt/8QUe4Ad6
        E+vOcMKr33Yxv5tZ/9x3bLPCnKLaJlj9Jr/26HWLKSp0ii0o1rCvoNXCpoFyruWvWDhNSuyMxEMXF
        0C3yiCmTY52QBhtbUuzH/m1CgGKRBoIIWgDPsywSj8JjQ3hZbej80WZaX+Zyb0IqCevM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1mQBXE-006cqY-EE; Tue, 14 Sep 2021 18:43:52 +0200
Date:   Tue, 14 Sep 2021 18:43:52 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Vladimir Oltean <olteanv@gmail.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 5/5] driver core: Add fw_devlink.debug command line
 boolean parameter
Message-ID: <YUDRSIR2g6Pt1umn@lunn.ch>
References: <20210914043928.4066136-1-saravanak@google.com>
 <20210914043928.4066136-6-saravanak@google.com>
 <YUC7c9BNuHPOEg4g@lunn.ch>
 <CAGETcx-B+yE8X2rn4GdzAikVO-swXb9a5-CxOG_HSuiQoHQZcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx-B+yE8X2rn4GdzAikVO-swXb9a5-CxOG_HSuiQoHQZcw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I did think of this, but the problem is that dynamic debug logs can
> get compiled out (when DYNAMIC_DEBUG isn't set). I think debugging of
> fw_devlink needs to be possible without having to recompile the
> kernel. So in a sense similar to how initcall_debug works today.

My off the shelf Debian kernel has it enabled. Maybe you can check
other mainline distributions and see if it is enabled by default.

You are also on a slippery path. You argue this is needed all the time
and add a custom knob. Somebody else adds a new feature which they
also argue always needs bug, and add there own custom knob. We soon
have lots of custom knobs, each doing it slightly differently, in
different places. Chaos. So you need a really good argument why your
code really is special.

I would suggest you start with dynamic debug, and collect some
statistics of how often you need to ask people to recompile their
kernel.

	Andrew
