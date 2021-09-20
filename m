Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C16D4110BF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 10:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234426AbhITIQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 04:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233811AbhITIQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 04:16:45 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22311C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 01:15:19 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0a2a0063d0dab944a9c04a.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:2a00:63d0:dab9:44a9:c04a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9FD121EC0354;
        Mon, 20 Sep 2021 10:15:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1632125713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Paa1kzOmpJBMRxri1T1/v3bJ/87hSVXjiGD94CSac6I=;
        b=Wd1Oo1WzCVjhv2Z3jVSPmQaJvCKFebmMUzmkYAceAfhB4dMEn/2Q8gYVpQcS4PgaZSA9M6
        AIUwGr1AOD87tmB+nyaI21sY0IxAo2mByg+ZTjX8mZ6CiJ37mqhujQaz9q9oT0eIQaYXVK
        SQFNx2F6DQCVAg0K7yxLTfCNeqmqszM=
Date:   Mon, 20 Sep 2021 10:15:13 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] x86/mce: Get rid of machine_check_vector
Message-ID: <YUhDEToGR5C/t0ZY@zn.tnic>
References: <20210917105355.2368-1-bp@alien8.de>
 <20210917105355.2368-3-bp@alien8.de>
 <YUgUpXHciLMn4X20@agluck-desk2.amr.corp.intel.com>
 <5eb3ac0a-4887-08b2-82fa-0348e04ace95@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5eb3ac0a-4887-08b2-82fa-0348e04ace95@rasmusvillemoes.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 09:42:22AM +0200, Rasmus Villemoes wrote:
> And, since in the concrete case mca_config just has four bool members
> before the bitfields, we see that the 1-bit bitfields are put within the
> first 8 bytes of the struct, while the __reserved field gets an entire
> u64 all to itself:

I probably should move that into alignment.

> But why the messy mix between 1-bit bitfields and _Bools in the first place?

My intention was to convert those boolean flags into a bitfield.
But you can't convert them all, unfortunately:

In file included from ./include/linux/miscdevice.h:7,
                 from arch/x86/kernel/cpu/mce/core.c:14:
./include/linux/device.h:148:64: error: cannot take address of bit-field ‘dont_log_ce’
  148 |   { __ATTR(_name, _mode, device_show_bool, device_store_bool), &(_var) }
      |                                                                ^
arch/x86/kernel/cpu/mce/core.c:2415:8: note: in expansion of macro ‘DEVICE_BOOL_ATTR’
 2415 | static DEVICE_BOOL_ATTR(dont_log_ce, 0644, mca_cfg.dont_log_ce);
      |        ^~~~~~~~~~~~~~~~
make[4]: *** [scripts/Makefile.build:277: arch/x86/kernel/cpu/mce/core.o] Error 1
make[3]: *** [scripts/Makefile.build:540: arch/x86/kernel/cpu/mce] Error 2
make[3]: *** Waiting for unfinished jobs....
make[2]: *** [scripts/Makefile.build:540: arch/x86/kernel/cpu] Error 2
make[1]: *** [scripts/Makefile.build:540: arch/x86/kernel] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1874: arch/x86] Error 2
make: *** Waiting for unfinished jobs....

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
