Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD9123189BB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 12:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhBKLo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 06:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbhBKLPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 06:15:24 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A7BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 03:14:36 -0800 (PST)
Received: from zn.tnic (p200300ec2f094f007c127c6ae8522aa3.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:4f00:7c12:7c6a:e852:2aa3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 988B91EC0445;
        Thu, 11 Feb 2021 12:14:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1613042068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=QE7u08u7dLz7Vbz2fekrYrl+HcX5ZE5gTFobJJDANLA=;
        b=IBeLvHzZYx3wz308cV7WwqKv1J218RjvYuJYsHK7hVA2it3JsJZkF15UTlxwC1bVqTkBK0
        Dl+EXlP088X77Tx02FcSwY9x0Pzp7anAvYW0OzY8pKrx5c8iPhf4yzQsgJS0daT6DqO6HR
        pDI4+vXneNirJlexKgoUWNW8Bz0MguY=
Date:   Thu, 11 Feb 2021 12:14:26 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     kernel test robot <lkp@intel.com>
Cc:     x86-ml <x86@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [tip:x86/mm] BUILD SUCCESS WITH WARNING
 c46f52231e79af025e2c89e889d69ec20a4c024f
Message-ID: <20210211111426.GB21330@zn.tnic>
References: <60250afb.uuto1B/nlljRhghR%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <60250afb.uuto1B/nlljRhghR%lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 06:46:19PM +0800, kernel test robot wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/mm
> branch HEAD: c46f52231e79af025e2c89e889d69ec20a4c024f  x86/{fault,efi}: Fix and rename efi_recover_from_page_fault()
> 
> possible Warning in current branch:
> 
> arch/x86/platform/efi/quirks.c:736 efi_crash_gracefully_on_page_fault() warn: ignoring unreachable code.
> 
> Warning ids grouped by kconfigs:
> 
> gcc_recent_errors
> `-- x86_64-randconfig-m001-20210211
>     `-- arch-x86-platform-efi-quirks.c-efi_crash_gracefully_on_page_fault()-warn:ignoring-unreachable-code.

Very useful bug report. And I had already asked you guys to explain how
one can reproduce this.

So I'm going to ignore it for now.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
