Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0F9C3FA092
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 22:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbhH0U3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 16:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhH0U3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 16:29:02 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028A1C0613D9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 13:28:13 -0700 (PDT)
Received: from zn.tnic (p200300ec2f1117002bace1eb09205059.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:1700:2bac:e1eb:920:5059])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8D3551EC0453;
        Fri, 27 Aug 2021 22:28:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1630096087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=pnTc0M6ZftmjD2R7RaYQEnfdB8lJsv/icnnipiWvuQ0=;
        b=I7gqhgylYYqm4J1uLXIOrNf/kUVUq+b42L0vE7E0doMG4XEfEPsJnyZseptHKPqRWog77j
        DBDOCwYybjuRLZn2lbBLwD/NCRLHGQalHQWHWG4C139IqH/HWVMz+TZcdlgAMPU2W1WRjS
        FTf02XZXwTq6S4jvK2e4HaEcx0sNlIQ=
Date:   Fri, 27 Aug 2021 22:28:49 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Cathy Zhang <cathy.zhang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] Basic recovery for machine checks inside SGX
Message-ID: <YSlLAaNEhQ3kKZ1D@zn.tnic>
References: <20210728204653.1509010-1-tony.luck@intel.com>
 <20210827195543.1667168-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210827195543.1667168-1-tony.luck@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 12:55:37PM -0700, Tony Luck wrote:
> Here's version 4 (just 38 more to go if I want to meet the bar set by
> the base SGX series :-) )

You're off by 1:

https://lore.kernel.org/lkml/20201214114200.GD26358@zn.tnic/

you have only just 37 more.

:-P

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
