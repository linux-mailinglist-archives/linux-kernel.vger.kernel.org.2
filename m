Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1B9F4192B0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 13:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbhI0LDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 07:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233908AbhI0LDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 07:03:10 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61622C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 04:01:32 -0700 (PDT)
Received: from zn.tnic (p200300ec2f088a001ce91a9f1eb42005.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:8a00:1ce9:1a9f:1eb4:2005])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E922E1EC05A1;
        Mon, 27 Sep 2021 13:01:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1632740487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=qsNwbHHsJ5JBPUltaA7rHw16cotuHQQqEfsJSb1s3lE=;
        b=B0CD5SlF62HvWSdBakSHIygIWwWLAwoYzp2c2QrwRapnhttEd3Mt1HOtudPmQdufMElpj4
        aUWCMvpIoz7CKpzbZHdsxNH0SPmVyjVUO90krwc78zzGEFD/NiM+jicns/6MuWuWio9wiw
        eJnFWZYVtvYxr58jbk4C72IiwhBlrlM=
Date:   Mon, 27 Sep 2021 13:01:26 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <jroedel@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Juergen Gross <jgross@suse.com>, Chester Lin <clin@suse.com>
Subject: Re: [PATCH V2 02/41] x86/traps: Remove stack-protector from traps.c
Message-ID: <YVGkhlaDBwASW7dZ@zn.tnic>
References: <20210926150838.197719-1-jiangshanlai@gmail.com>
 <20210926150838.197719-3-jiangshanlai@gmail.com>
 <YVGalJLOyK235XvG@zn.tnic>
 <d4e653e7-1f23-eec9-4db7-964298fc1dc5@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d4e653e7-1f23-eec9-4db7-964298fc1dc5@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 06:49:16PM +0800, Lai Jiangshan wrote:
> Using only "-fno-stack-protector" is enough to disable stack protector with
> my .config, I'm not so sure about other configuration.

What does the gcc manpage say about it?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
