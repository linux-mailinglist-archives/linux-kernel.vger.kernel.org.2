Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00EA4321394
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 10:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhBVJ6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 04:58:25 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44248 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbhBVJ55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 04:57:57 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613987831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5H6YdPyY2+KS5kpNJtobaGzkb5jt2BuhCVimvEmkaOg=;
        b=jGOupvrsvxzbmBCsOXFLpSH8/0HEllj1Vtvu0FcGrQB7JU+aqjKlsXQK7P1B0Cz3rLztS+
        O9NJVc7O6drguhzZye/exi3f5gSM2z2M+vshp19+JO4FmhF5YuqBvePKlc+Pk1mSWYBO0S
        hgPpNKmzNwMNHsn8690dQLKAm0xEqC4F1buShuUZAfZPEHWP2QQCX4g6ibiK7V0y9ayE9H
        +ezHjjmOzjYULhkwFNIIOu2UOJcLgsIAce57UQT6i02ebFJxs+YQJuyeeTWTRKcMjASaZR
        LS9crcDmz1LkrxXRKQYMnejW24VjKwFPOx5OHBo6Zdpkvmy66QalqAMinHIKWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613987831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5H6YdPyY2+KS5kpNJtobaGzkb5jt2BuhCVimvEmkaOg=;
        b=fvltyaQIH4f46bmyHoA7cUwjP04r1/uqySR+jGYXISmGbfd/6SIzlqFR1rNE/T2kkZ4ZKl
        psb4JV9/WenA69AQ==
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Arnd Bergmann <arnd.bergmann@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>, trix@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL] timer drivers fixes for v5.11-rc5
In-Reply-To: <db09cb3f-5074-a5e6-ea88-c4f304194c9d@linaro.org>
References: <ae3bcda6-5180-639d-6246-d2dfd271c3e7@linaro.org> <7a90ec96-d8e5-e505-bd5a-38cc00892021@linaro.org> <db09cb3f-5074-a5e6-ea88-c4f304194c9d@linaro.org>
Date:   Mon, 22 Feb 2021 10:57:11 +0100
Message-ID: <87ft1otog8.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel,

On Mon, Feb 22 2021 at 09:36, Daniel Lezcano wrote:
> those fixes were not picked up

Ooops. Taking care right now.
