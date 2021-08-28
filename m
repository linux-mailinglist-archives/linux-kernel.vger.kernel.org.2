Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 287323FA663
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 17:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234407AbhH1PMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 11:12:39 -0400
Received: from netrider.rowland.org ([192.131.102.5]:46581 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S230060AbhH1PMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 11:12:38 -0400
Received: (qmail 288731 invoked by uid 1000); 28 Aug 2021 11:11:46 -0400
Date:   Sat, 28 Aug 2021 11:11:46 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Evgeny Novikov <novikov@ispras.ru>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Mike Turquette <mturquette@linaro.org>,
        Kirill Shilimanov <kirill.shilimanov@huawei.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: Re: [PATCH] usb: ehci-orion: Handle errors of clk_prepare_enable()
 in probe
Message-ID: <20210828151146.GA288644@rowland.harvard.edu>
References: <20210825170902.11234-1-novikov@ispras.ru>
 <20210825172937.GD192480@rowland.harvard.edu>
 <c22d943a-581c-c1bd-d453-3f0f6176c8a5@ispras.ru>
 <20210826152438.GB228824@rowland.harvard.edu>
 <303a5695-e0c4-1cae-ee1f-6f34a9717b77@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <303a5695-e0c4-1cae-ee1f-6f34a9717b77@ispras.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2021 at 01:47:12PM +0300, Evgeny Novikov wrote:
> Hi Alan,
> 
> On 26.08.2021 18:24, Alan Stern wrote:

> > I don't know whether these errors can occur or not.  To find out, you need to
> > ask someone who knows more about the clock framework.
> > 
> > On the other hand, the fact that the functions do return an error code means
> > that they expect callers to check its value.  In fact, whoever changed the API
> > should have gone through all the callers to make sure they did so.
> > 
> > (Let's put it this way:  If those functions can return an error, we should
> > check the return code.  If they can't return an error then they shouldn't be
> > defined to return an int, so the API should be changed.)
> > 
> > So on the whole, I think making these changes would be a good thing.  At the
> > very least, it will help make all the different EHCI and OHCI drivers
> > consistent with each other.
> Though I may be wrong, but after the discussion with Dan, it does not seem
> that we can expect any considerable changes in the clock API and support
> from the static analysis tools soon. So, if you still would like to see
> corresponding fixes in EHCI and OHCI drivers, I can prepare them.

Yes, please do so.

Alan Stern
