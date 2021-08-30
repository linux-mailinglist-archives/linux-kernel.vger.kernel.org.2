Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEF1C3FBB29
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 19:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237949AbhH3RmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 13:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238117AbhH3RmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 13:42:19 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F196DC06175F
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 10:41:25 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0b3b00d8cdf5b388faf601.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:3b00:d8cd:f5b3:88fa:f601])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 90DFF1EC03FE;
        Mon, 30 Aug 2021 19:41:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1630345280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=I7AOGAytPqE7C8qa9A/aHAcVwJiDOLW+1xpi4wixpbo=;
        b=MBhrqdBNQwgaRZ1UuFK/lo3Qy8G/DusLMbsfzRAVuRMBtUhdLvYnk/0ioefqyJziN5w3AB
        K/LfbaR2hd3FQmIeQqWktj5ceDO6L2+vTg12whSPoq15XpWTNkJ8SrNgMNniPdAwFfAhj6
        CSP5laALdRZrPKKMHF3AA+Ma0QzTlVI=
Date:   Mon, 30 Aug 2021 19:41:57 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Len Brown <lenb@kernel.org>
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, thiago.macieira@intel.com,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 12/26] x86/fpu/xstate: Use feature disable (XFD) to
 protect dynamic user state
Message-ID: <YS0YZZFyy0Z7slk6@zn.tnic>
References: <20210730145957.7927-1-chang.seok.bae@intel.com>
 <20210730145957.7927-13-chang.seok.bae@intel.com>
 <YR00U19168BGoRB9@zn.tnic>
 <CAJvTdKk6kh3yT==FFRJ0RXDSrpnWecOo06EAEgHctnWbwTg50Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJvTdKk6kh3yT==FFRJ0RXDSrpnWecOo06EAEgHctnWbwTg50Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 06:21:23PM -0400, Len Brown wrote:
> MSR_IA32_XFD and MSR_IA32_XFD_ERR are architectural.
> 
> (which is why they follow the convention of having an "IA32" in their name)

Where is that official statement I can refer to that says that MSRs with
"IA32" in the name are architectural?

Perhaps that section of the SDM:

"2.1 ARCHITECTURAL MSRS"

?

In any case, those MSRs are not there yet, maybe they need to trickle
from the ISA to the SDM docs at some point first.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
