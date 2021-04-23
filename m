Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0F0368EEE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 10:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241430AbhDWIiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 04:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbhDWIiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 04:38:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C29BC061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 01:37:31 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619167047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8U3rcB+Q9yZ2WnidDfmaiDsiZHkhyItX3WlZksHmevA=;
        b=BQ2XacMiUhjfF8iECoMGcLGZdLSoqWyu3vw/2PdlU67y6VZpoupuH6IEYdV/MYI8IgFzGv
        UuosIYSUAgXaPDULfsj/wHzl6IDHSL3Saz6qcLfybu8cAwE62i2En2EimwSb74K+z3uduL
        uzbnoMXcqE5IMjDBcG3hfDfEF/qJH0MAPQrHbPDNiV2l/XYLOZnADfTAFxeImGFWXdJjrt
        Lh8zHv/Wbx7QjjbMOhYBJPrOG3P34ILcedt3BRdC3HHNP2NS4C3KINjjJpl8Z9xZZ44M0N
        Fbo/xXuMykIVtRyR13Ua+1R0iu9QYe/9MObAYDwO1slW4yB19agg5PIRQmUFig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619167047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8U3rcB+Q9yZ2WnidDfmaiDsiZHkhyItX3WlZksHmevA=;
        b=1c3NzoPQAxa/hdZ4ussrM0zrFLuR775gn19NiQ0DBDFbsKZzr3qAKJwpGNkt9lh7v6qNKV
        Ns42EBSRkQTNKbAg==
To:     Xu Yihang <xuyihang@huawei.com>
Cc:     mingo@kernel.org, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dwmw@amazon.co.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] x86/apic: Force logial APIC ID in range from 0 to 8
In-Reply-To: <20210423075324.133463-1-xuyihang@huawei.com>
References: <20210423075324.133463-1-xuyihang@huawei.com>
Date:   Fri, 23 Apr 2021 10:37:26 +0200
Message-ID: <87czulwg55.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23 2021 at 15:53, Xu Yihang wrote:
> According to Intel 64 and IA-32 Architectures Software Developer=E2=80=99=
s Manuals
> Vol. 3A 10.6.2.2, Logical APIC ID locates on bit 24 to 31, can only
> support up to 8 local APIC under flat mode. Also C99 says left shift exce=
eding
> maximum value representable in the result type is undefined behavior. But
> under x86 architecture, it seems doesn't do any actual damage.
>
> There is KASAN warning on a 80 cores machine after booting #64 CPU.
> ```
> [    1.681097] UBSAN: Undefined behaviour in arch/x86/kernel/apic/apic_fl=
at_64.c:51:11
> [    1.688739] shift exponent 64 is too large for 64-bit type 'long unsig=
ned int'
> ```

This function should not be invoked on a 80 core machine at all.

Can you please add 'apic=3Dverbose' to the kernel command line and provide
a full boot log?

Thanks,

        tglx
