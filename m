Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1358353101
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 00:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235140AbhDBWWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 18:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbhDBWWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 18:22:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC68DC0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 15:22:43 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617402160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=32K9Ik03e28YnDkSk7ke2VS2Eux8le3wwkUl1uhOBVM=;
        b=FXJawQezMiikEi576mT+AJq4kdnHecwFFAnmBWLGGQDDXnrbjfOjl4zS3rS1yVeilzXphh
        cTBP8iF4MfyJF+1FCyccHELCs7JPcP3jabviwCeACHbjsd5uqRr8P9qw/X4Rz+ABkFcVLs
        nZAlS62seZeSzrKU62/hLhBIEcUR80ShYSjDrz1DjmUdGv3wCVlGwgm+Nm4vUCFJk4+fZQ
        EVipaZvXcTksZqISoAZiLUnXC0UB/Yh4aIVKAZ2Fay7DhEQ+BjXI6AAd2fK2PNqvZKqOKc
        TF2tvRGlTR5CJbnKSW5ReB/WnwOugnSviPAnZ3ApqKiKN/kSbF/Fft96d/Tavw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617402160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=32K9Ik03e28YnDkSk7ke2VS2Eux8le3wwkUl1uhOBVM=;
        b=bBRChUZZHUE0LeJNcg39ue62tYG+dm1ZWv+mVb7iZi0FJNKdYq1jrrc5nKxURoZ3oJqUqY
        Ru5FZOKi+cPY71Cg==
To:     paulmck@kernel.org, linux-kernel@vger.kernel.org
Cc:     john.stultz@linaro.org, sboyd@kernel.org, corbet@lwn.net,
        Mark.Rutland@arm.com, maz@kernel.org, kernel-team@fb.com,
        neeraju@codeaurora.org, ak@linux.intel.com,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v6 clocksource] Do not mark clocks unstable dueclocksource: Provide module parameters to inject delays in watchdog
In-Reply-To: <20210402203137.22479-1-paulmck@kernel.org>
References: <20210402202929.GA22273@paulmck-ThinkPad-P72> <20210402203137.22479-1-paulmck@kernel.org>
Date:   Sat, 03 Apr 2021 00:22:40 +0200
Message-ID: <87pmzc498v.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02 2021 at 13:31, paulmck wrote:

The subsystem prefix does not parse:

    [PATCH v6 clocksource] Do not mark clocks unstable dueclocksource: Provide module parameters to inject delays in watchdog

I look at the actual code changes after the easter break.

Thanks,

        tglx
