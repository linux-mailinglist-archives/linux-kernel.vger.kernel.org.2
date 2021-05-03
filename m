Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2DF7371218
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 09:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbhECHkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 03:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232934AbhECHjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 03:39:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7068DC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 00:38:14 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620027491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xaIWcLnnByR4wWPuKaw2fRs0IvDQ6p/FcccYM8RTHQw=;
        b=FsqSsNr2XVaO2DfaFUbh5XZ0yfW+eupuNu86SN9wU5TNUhNBljt8SEnMlykC/5avR9fivh
        6EkzkLYTJTm0v63IO4E06VB7k/kPhV31CcKR4h1TSdwbcL1EnzyGUk+nbtSqYkpVyJKC2v
        gFdgRgYpcLpbZsGniPP1eMZQhZ5KvqpJ5o9qPk8LhMD+2pvmdk7ytPybVzmRd9b7AFr2Nw
        HNYeAuJpOaxHHPlQ3/tR/mf3QiZzI7vZ5m3USExIwlvnEUT6uPOdWaX4HU3G6B9hsW1RRX
        Osy2Ebbeip0e9tsjp+i36M/fbZ8aO11afUcE2PnibExdOe9hgx8mM0ce0Z5JTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620027491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xaIWcLnnByR4wWPuKaw2fRs0IvDQ6p/FcccYM8RTHQw=;
        b=KcG1ClLVfPqmPrZG9hPe3+43tuUUOvwEBb49+pHc252rnPzit+Fahnpv5L0QOXvPp0N+uU
        icUTr0KA/JZlaKCg==
To:     Anand K Mistry <amistry@google.com>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86: Add a prompt for HPET_EMULATE_RTC
In-Reply-To: <20210429155950.v2.1.I2392cf11fb353d10459958100b69d93346fa167c@changeid>
References: <20210429155950.v2.1.I2392cf11fb353d10459958100b69d93346fa167c@changeid>
Date:   Mon, 03 May 2021 09:38:11 +0200
Message-ID: <87bl9se07w.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29 2021 at 16:00, Anand K. Mistry wrote:

> This does two things:
> 1. Makes the option visible in menuconfig, allowing the user to easily
>    disable this option
> 2. Allows olddefconfig to respect the option if it is set in the old
>    .config file

Well, it's pretty clear WHAT it does, but there is absolutely no
reasoning WHY this knob is needed in the first place.

Thanks,

        tglx
