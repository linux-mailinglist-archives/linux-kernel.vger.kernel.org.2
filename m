Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8427C32F9AC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 12:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhCFLSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 06:18:42 -0500
Received: from mail.skyhub.de ([5.9.137.197]:57950 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229917AbhCFLSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 06:18:25 -0500
Received: from zn.tnic (p200300ec2f1bd90027b3ba04162e9c54.dip0.t-ipconnect.de [IPv6:2003:ec:2f1b:d900:27b3:ba04:162e:9c54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4593E1EC0402;
        Sat,  6 Mar 2021 12:18:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1615029504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=JoN1l3YjsWEwrhXrFq/YfzpwEnBzmTi0W3gK6nPGqME=;
        b=h+sN2hlDui3qiKMUUEkZB4261xxER2Z2OdYCbuNAlw9zAB5iqHX5pI4x2Wba/C+XJtNTKQ
        kF1u/R9tRqxg5d+/302nflbHXiiB464dToOt4yo5aPiF9S883dijFvO9Qm/In1+Wze19TB
        pwz0onlKPLIcJoakll59FCBLTiH7Kvc=
Date:   Sat, 6 Mar 2021 12:18:15 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     menglong8.dong@gmail.com
Cc:     tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        hpa@zytor.com, peterz@infradead.org, ggherdovich@suse.cz,
        rafael.j.wysocki@intel.com, rppt@kernel.org,
        nathan.fontenot@amd.com, ashok.raj@intel.com, brgerst@gmail.com,
        linux-kernel@vger.kernel.org,
        Zhang Yunkai <zhang.yunkai@zte.com.cn>
Subject: Re: [PATCH] x86/smpboot: remove duplicate include in smpboot.c
Message-ID: <20210306111815.GA7596@zn.tnic>
References: <20210306065610.211901-1-zhang.yunkai@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210306065610.211901-1-zhang.yunkai@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2021 at 10:56:10PM -0800, menglong8.dong@gmail.com wrote:
> From: Zhang Yunkai <zhang.yunkai@zte.com.cn>
> 
> 'cpu_device_id.h' and 'intel_family.h' included in 'smpboot.c'
> is duplicated. It is also included in the 80th line.
> 
> Signed-off-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>

If you send another person's patch, then your SOB needs to follow his/hers:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin

Also, merge those two x86 patches removing includes into one please.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
