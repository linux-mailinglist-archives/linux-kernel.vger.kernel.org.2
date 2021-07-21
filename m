Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C30B33D183E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 22:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbhGUT6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 15:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbhGUT56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 15:57:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385E8C061575
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 13:38:34 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626899912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kx33BaNtRMi/Cr+LubGcPaYEfYoSSN2sEnv6KnS7qMs=;
        b=eBJOtFTXoJzBZ7w4E9OiFnqCpxQRZVLf5Vl6y40eePTheoSDa0PN+NWf7rLUnZ/9bB41z9
        xoUPkK4DvSEyXMHukUNv7AsI5g8eN1WfOxBHz6xLoaDUzejPBdZr6kxFEzCZLY0F8RFhN9
        rU9tX3/bayBDkRZHvb3HyVo8fKjWgmUu9s2LdGpjXuk3ataPa/hVS59ikSCdm3XUeuDDWh
        QUnT6rGUepfx8pGF5yRJsZJEL5eYgHGiwcj0tSdObbPRCNAGkyZ/r3kvBq77teBUOCGWO1
        JrxOA/LSmEsBd1GrNbVTzGibDMKVUPnfSOcnjfhc5rTdRuKd2uuIPeaMGHofjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626899912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kx33BaNtRMi/Cr+LubGcPaYEfYoSSN2sEnv6KnS7qMs=;
        b=TAmdBeDymkFnwWDvrbqCpYOigTJmEG3cWdnZqf3iQBAAVmUmCWVIGmpTBq2quMXBvEuMIk
        VGCDzv1W+rYUNZDw==
To:     Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, kernel-team@fb.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Subject: Re: [PATCH] x86,mm: print likely CPU at segfault time
In-Reply-To: <a9f568139f0bd82cc8460c2c4f831f03a74f2a89.camel@surriel.com>
References: <20210719150041.3c719c94@imladris.surriel.com> <c8e023cb-6f50-36f5-65d4-c5e25b264029@intel.com> <a9f568139f0bd82cc8460c2c4f831f03a74f2a89.camel@surriel.com>
Date:   Wed, 21 Jul 2021 22:38:32 +0200
Message-ID: <87pmvbpflj.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19 2021 at 15:34, Rik van Riel wrote:

> On Mon, 2021-07-19 at 12:20 -0700, Dave Hansen wrote:
>
>> If it's as trivial as:
>>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0printk(KERN_CONT " on cp=
u/core %d/%d",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0raw_smp_processor_id(),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0topology_core_id(raw_smp_processor_id()));
>>=20
>> it would be handy.=C2=A0 But, it's also not hard to look at 10 segfaults,
>> see
>> that they happened only on 2 CPUs and realize that hyperthreading is
>> enabled.
>
> One problem with topology_core_id() is that that, on a
> multi-socket system, the core number may not be unique.

Just add topology_physical_package_id() and you have a complete picture.

Thanks,

        tglx
