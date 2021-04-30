Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C197536F64B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 09:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbhD3HRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 03:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhD3HR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 03:17:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F2FC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:16:42 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619767000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kPbzot4RLWtBEWxgEfdGFpp7FYbQEbjEtsj+4/tgq3M=;
        b=aazuVuZtozTl6qoy7ztfq/HNAIj7Kf2ULYKkerfh2W3S3W6RdweBTpCiAvOgwQe3F6z5Dp
        Hrha34zfVv0zX3yQjHadD1ALhVK9Pim3RCzFXeDX41Ezez4N7Ix3SAe613sahqNvS6sbNJ
        GG2cRhoaPO55hEleEuX8dS453ppfkwEGTFgxCJi0fJiJbiHFzyxt9biBzKnMdcKXn31Wpx
        tYKWOoxxgYLOF0lOv//7WW36IyaXvOukJarysb/UL+lF80GE8nVCuqPhQZaXVpAtcxLJx/
        2BYTFsd1Tck5cOcrxS2y2wiOE5tw1+QGxjK3WpscpF660nJyqdUlX3S31oIHKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619767000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kPbzot4RLWtBEWxgEfdGFpp7FYbQEbjEtsj+4/tgq3M=;
        b=n/PX7RvkJMRZ11zy6sASLScdlrXd3ExPBLY/36mTfAcRB/ViZ5YNg8/worip+inHx1T9cV
        +gOAcZMfhiFirHAg==
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] alarmtimer: check RTC features instead of ops
In-Reply-To: <20210429214902.2612338-1-alexandre.belloni@bootlin.com>
References: <20210429214902.2612338-1-alexandre.belloni@bootlin.com>
Date:   Fri, 30 Apr 2021 09:16:40 +0200
Message-ID: <877dkkfdif.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29 2021 at 23:49, Alexandre Belloni wrote:
> Test RTC_FEATURE_ALARM instead of relying on ops->set_alarm to know whether
> alarms are available.
>
> Fixes: 7ae41220ef58 ("rtc: introduce features bitfield")
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
> Hello,
>
> This doesn't seem much but this solve an issue where following a change in the
> RTC driver, this part of the code will think the RTC is alarm capable while it
> is not, then breaking the alarmtimer functionnality.

So a driver has the set_alarm() callback but does not advertise
RTC_FEATURE_ALARM for whatever reason and why ever this makes sense.

I don't mind the patch, but the changelog is a bit meager in explaining
the WHY.

Thanks,

        tglx
