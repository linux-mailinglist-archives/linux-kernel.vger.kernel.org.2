Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEA83A7E9A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 15:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbhFONGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 09:06:15 -0400
Received: from mail.skyhub.de ([5.9.137.197]:42684 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230052AbhFONGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 09:06:14 -0400
Received: from zn.tnic (p200300ec2f0f2700dcf207dae2c80d14.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:2700:dcf2:7da:e2c8:d14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9367D1EC01A8;
        Tue, 15 Jun 2021 15:04:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1623762248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+ZOsDHbkZB94bYlEo43dL7IOMWSopQQm4aHhOShUR2I=;
        b=hGn7Q3YL0jTnFFFPhN8GFGkeQIrxC7AfYTWFM/8TYwXq/k+v/4za7qvYD8Pe+Gc95C+5oI
        829tQZUZpRWXwsCB33HW6jzRLN3kqGWklgL+rNeAjwzuGreMAjt/YsujoZ8U4hLxtyotMg
        YKh+ewjl90RdZvlwLg6CmQu77Mlwpzs=
Date:   Tue, 15 Jun 2021 15:04:03 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Philip Li <philip.li@intel.com>
Cc:     kernel test robot <lkp@intel.com>, x86-ml <x86@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [tip:tip] BUILD SUCCESS 3a1176a9af5a1b7d7a0a40b0975412008eb221c3
Message-ID: <YMilQyUe00ub9lKI@zn.tnic>
References: <60c3c723.X+QEHxMuTiZ6Pqj9%lkp@intel.com>
 <YMPMFUsmj0F8btKc@zn.tnic>
 <20210615025503.GA507303@pl-dbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210615025503.GA507303@pl-dbox>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 10:55:03AM +0800, Philip Li wrote:
> Got it, Boris, we will disable the testing of this tip branch, any branch
> else that you think we can ignore?
> 
> So far, the configuration is below
> 
> branch_denylist: auto-.*|tmp-.*|base-.*|test.*|.*-for-linus|tip

Looks about right.

If there's a branch missing, I'll let you know.

Thanks!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
