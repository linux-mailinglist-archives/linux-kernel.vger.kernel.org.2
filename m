Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38AAE3AB608
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 16:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbhFQOgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 10:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbhFQOgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 10:36:22 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE55C061574;
        Thu, 17 Jun 2021 07:34:14 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0eb20047e0d50d7eeccd9e.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:b200:47e0:d50d:7eec:cd9e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 407621EC0587;
        Thu, 17 Jun 2021 16:34:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1623940452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=9A4uzd20AoYeVEiUFQvdsQsn30sk6E2K/EhLxqxg+EQ=;
        b=gHgITpKSzKbtDNybTfBzGlTdSvlSKZwAKA1n4ZZGggpfiYFEOKpy8+Gw5/R4uUlLjwCnST
        otpX9GZlcXkvdkh1pBA0ql0EkStmW76B/GIbmmpI6Y4ZwFQyDNTgzXWTb9I+H3hiCB6PvJ
        JmLV4AumAvBlK3ikYMB33x56owU2aME=
Date:   Thu, 17 Jun 2021 16:34:01 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Kai Huang <kai.huang@intel.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>, linux-sgx@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org, seanjc@google.com,
        dave.hansen@intel.com, tglx@linutronix.de, mingo@redhat.com,
        Yang Zhong <yang.zhong@intel.com>
Subject: Re: [PATCH] x86/sgx: Add missing xa_destroy() when virtual EPC is
 destroyed
Message-ID: <YMtdWduyALHxggoP@zn.tnic>
References: <20210615101639.291929-1-kai.huang@intel.com>
 <20210615132001.kd6cuktq37dvoq3l@kernel.org>
 <618b42d66a4f2087ef4c54cc50fd56d01233eab1.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <618b42d66a4f2087ef4c54cc50fd56d01233eab1.camel@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 12:30:04PM +1200, Kai Huang wrote:
> Thanks Jarkko. I literally need to find some way to avoid such error in future :)

That way is called "integrate checkpatch.pl into your patch creation
workflow".

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
