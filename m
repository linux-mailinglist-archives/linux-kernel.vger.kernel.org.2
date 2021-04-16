Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1438E362998
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 22:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241620AbhDPUp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 16:45:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59818 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235547AbhDPUpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 16:45:55 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618605929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=K2JEeuNPUyMaF6o07/3L9005UoABxWNubStaoEOOaDc=;
        b=lS9DbNkN1RKXdl+p+df2IXF7OLFvHm6b9SsjgoIRvp29IRMmD7zI3Zl9641AXMGspwVDm4
        N2h2rZ+cWzCVqXOaBwdSKwfUKnIHUSg5ChIv8w/arO6zQ/lVpowHKOrPr1xgoya4Tlw01x
        ZXUHC2YW7nJRuV8jY0LLdK3BQNyJYyfvbpdB2ehEbhOm0MUhmaICrDxcZ8KpSKkYTl17Oz
        Kr2Y8kt6btuccHd2V8lrtzE8BbJi81RJcSQuwuQS1L22hLtPOULQipc3kf+urn/jzNEtQz
        kZbForC9hpqLtAHxKTmhQqy3/tBUi/udD1uEKh9t37FzEdJD/EDNMTGgqmMHIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618605929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=K2JEeuNPUyMaF6o07/3L9005UoABxWNubStaoEOOaDc=;
        b=l+vCizgL80KtnSDWe00bSgpGzfv7X/advucn5PZLqCAR+9G5uKEOUnwakqZ9Q02YtYcz9J
        Aaxo4pB40Y0WESAg==
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com, "Paul E. McKenney" <paulmck@kernel.org>,
        Chris Mason <clm@fb.com>
Subject: Re: [PATCH v8 clocksource 2/5] clocksource: Retry clock read if long delays detected
In-Reply-To: <20210414043602.2812981-2-paulmck@kernel.org>
Date:   Fri, 16 Apr 2021 22:45:28 +0200
Message-ID: <871rbauffb.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13 2021 at 21:35, Paul E. McKenney wrote:
>  #define WATCHDOG_INTERVAL (HZ >> 1)
>  #define WATCHDOG_THRESHOLD (NSEC_PER_SEC >> 4)

Didn't we discuss that the threshold is too big ?

