Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4298E32DF04
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 02:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbhCEBVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 20:21:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:47914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229458AbhCEBVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 20:21:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A8AD864FF0;
        Fri,  5 Mar 2021 01:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1614907280;
        bh=m4h7ZHJClpaGq4z31HFjlAN1BbQ52JQhKvIB5gkF1OA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gV3fjtZ7OYER8xZbyYzMav33XcDtppeuPKzWbAum91qZLWbgue6N2j0lWoP5Lesq9
         8r/lH+nkZkrrs7CqPKd6AvwppXlrL8851hkFWnrCCSWLoYmK1o9gzrdr6pGyuy+AXU
         J91a9bJZe8LWGJnCKATUTVWlpZDTQYuRy5UIJFig=
Date:   Thu, 4 Mar 2021 17:21:20 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] units: Add the HZ_PER_KHZ macro
Message-Id: <20210304172120.437d25238b880f5885e59142@linux-foundation.org>
In-Reply-To: <3ffdd3de-c30e-f237-7bd7-2700d426e53a@linaro.org>
References: <20210223203004.7219-1-daniel.lezcano@linaro.org>
        <CAHp75VcJwoye5KOYXF3Fs1F-82JPP-7VaU4z5OqBrYDr+AGQ5w@mail.gmail.com>
        <CAHp75Vcqug9qC_ejHE03YguiSy-XpsZV6g36-pe3VOFgTS2-tA@mail.gmail.com>
        <20210303163125.dcc0a086a939a58ed30750e8@linux-foundation.org>
        <3ffdd3de-c30e-f237-7bd7-2700d426e53a@linaro.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Mar 2021 13:41:27 +0100 Daniel Lezcano <daniel.lezcano@linaro.org> wrote:

> > Also, why make them signed types?  Negative Hz is physically
> > nonsensical.  If that upsets some code somewhere because it was dealing
> > with signed types then, well, that code needed fixing anyway.
> > 
> > Ditto MILLIWATT_PER_WATT and friends, sigh.
> 
> At the first glance converting to unsigned long should not hurt the
> users of this macro.
> 
> The current series introduces the macro and its usage but by converting
> the existing type.
> 
> Is it ok if I send a separate series to change the units from L to UL?

That's the way to do it...
