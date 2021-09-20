Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E589C4110B7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 10:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235421AbhITIO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 04:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235387AbhITIO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 04:14:28 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACAC1C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 01:13:01 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0a2a0063d0dab944a9c04a.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:2a00:63d0:dab9:44a9:c04a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EB11C1EC0287;
        Mon, 20 Sep 2021 10:12:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1632125576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=/cgsPmDylT/xYQpxHIFB96D9RMykjPseOGDkp3zq2eU=;
        b=T/56O0ODvgMUzzTCwatcjNSFvw74w8rKo5O5/YBBtHA3h3c9ai0LoSXVfJf6jkso0P0c9F
        Q6LSDIWXu1mt0g/XZJz2dLnkcVWeLbJgECiuhN2Dfy8z2vGok0rSh1JJmPSWFgc2ulJ7B+
        AkObsCGr70oZdwZvrS3SVhLBeX1s8+k=
Date:   Mon, 20 Sep 2021 10:12:51 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] x86/mce: Get rid of machine_check_vector
Message-ID: <YUhCg/dQLEeaYM+T@zn.tnic>
References: <20210917105355.2368-1-bp@alien8.de>
 <20210917105355.2368-3-bp@alien8.de>
 <YUgUpXHciLMn4X20@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUgUpXHciLMn4X20@agluck-desk2.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 19, 2021 at 09:57:09PM -0700, Luck, Tony wrote:
> Does this __reserved field do anything useful? It seems to
> just be an annoyance that must be updated each time a new
> bit is added. Surely the compiler will see that these bitfields
> are in a "u64" and do the math and skip to the right boundary
> without this.

It is there to tell you how many bits you have left so that you don't
have to count each time. And updating it each time is simply Ctrl-x in
vim.

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
