Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAB93E91DA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhHKMsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhHKMsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:48:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D728C061765;
        Wed, 11 Aug 2021 05:48:26 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628686105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UIGmo69KZrc2J9HeCu65ppUBj4zfHrwzhS5X2A72n+c=;
        b=ysr+3jUJrjWVrnARKplskpxUSmoqLGvr5hwN92aP4+nowhWjgmRtIHbHDALO5Nu/OKI1MH
        h6/YppAsbNtsvS3guAgjC5ATnP9p6LqPU3u+baQpVtIGoXeC9LOMv0slpTSguAphTVhPm3
        WyqxEwxTivaTuUa3A+B/qay/MlIis/2DYjRZpknk02YXO4T6dYFRCIcKCekqCWH+pw48Jh
        9hhZ+y1duXq4gjtKOnIbIDcKvz45hPkfXtEpJ2dgxoNX7PKRhxmo2sqHpZ+6TpRkh+1RdD
        hvQ4wLXbd06qxSGZ4Sgj9bwuYGGMwj1oqUDTI1V/MOiqLTPRnVIlXCqR935pOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628686105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UIGmo69KZrc2J9HeCu65ppUBj4zfHrwzhS5X2A72n+c=;
        b=yfxhM/yJc8O22ZYimus/Y+SjpdfR6O+BllFZ0Lgc1pX2gqxyHkWw18fE8ikVSRQ7ntiWuw
        uDC37QeXlRaVlUAA==
To:     linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        vincent.donnefort@arm.com, valentin.schneider@arm.com,
        peterz@infradead.org, mingo@kernel.org, rdunlap@infradead.org
Subject: Re: + kernel-cpuc-eliminate-all-kernel-doc-warnings.patch added to
 -mm tree
In-Reply-To: <874kbwp2te.ffs@tglx>
References: <20210811043016.-ahQ6%akpm@linux-foundation.org>
 <874kbwp2te.ffs@tglx>
Date:   Wed, 11 Aug 2021 14:48:24 +0200
Message-ID: <871r70p2p3.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11 2021 at 14:45, Thomas Gleixner wrote:
> On Tue, Aug 10 2021 at 21:30, akpm@linux-foundation.org wrote:
>> The patch titled
>>      Subject: kernel/cpu.c: eliminate all kernel-doc warnings
>> has been added to the -mm tree.  Its filename is
>>      kernel-cpuc-eliminate-all-kernel-doc-warnings.patch
>
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=smp/core&id=11bc021d1fbaaa1a6e7b92d6631faa875dd40b7d

I picked up the corresponding kernel/smp.c fix as well

Thanks,

        tglx
