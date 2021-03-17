Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA73F33F24B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 15:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhCQOIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 10:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhCQOIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 10:08:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26233C06174A;
        Wed, 17 Mar 2021 07:08:38 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615990116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ltvbdEYCicy5LXKX9c2Kk4mupJOajlC2tJ0Ya55K9SA=;
        b=LJCTYha1FsipHOuMHuAXt81cWkcg/tQega7VZhIT98tBIFdYPHgFKmndnV/dHUtb5Clb44
        0bmtRt9doLkY3PurgKeqyBlGwDSRmxcmi5KFo7lM4n1P0a+z8ZVJ2udEEULMgFfPt0YFhD
        5AW+RHZrP8QM7UaRH2I/vI6qwxP8yrFlhYUSOZN6bMNq7xQZANvmSjs/WTSYoXUXfYGVkG
        vsRMI9pJl8jdCedsSuNvj8zkZ4Oo4JZHw6pmiX1SyiNhl0fAPSWRlUWm+pZMr71a6IGemk
        /NOtYCCMNoLYcSXvrwbV7XpsyBGwFnTxzSfU9yBm+1S/jQFb5sMalZ8cmij3EA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615990116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ltvbdEYCicy5LXKX9c2Kk4mupJOajlC2tJ0Ya55K9SA=;
        b=wxmKTTJUwJ3onzKhFMGgYY065CfHtW+kRmyqMqCRNXzQ369m4h1enQJAj7MdbB0/F/Xa6h
        3VkyFpqY7PrZ3OBQ==
To:     Johan Hovold <johan@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: threadirqs deadlocks
In-Reply-To: <YFILfPT1SFypmOAj@hovoldconsulting.com>
References: <YFCO+FEjWPGytb2W@hovoldconsulting.com> <87eegdzzez.fsf@nanos.tec.linutronix.de> <YFILfPT1SFypmOAj@hovoldconsulting.com>
Date:   Wed, 17 Mar 2021 15:08:36 +0100
Message-ID: <8735wtzxcr.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17 2021 at 15:00, Johan Hovold wrote:
> On Wed, Mar 17, 2021 at 02:24:04PM +0100, Thomas Gleixner wrote:
>> Something like the below.
>
> Looks good to me. Do you want to spin that into a patch or shall I do
> it after some testing?

I'll send one in a few
