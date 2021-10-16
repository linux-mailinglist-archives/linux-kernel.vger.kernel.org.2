Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37E2E430210
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 12:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244120AbhJPKhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 06:37:50 -0400
Received: from mail.skyhub.de ([5.9.137.197]:45452 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235855AbhJPKht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 06:37:49 -0400
Received: from zn.tnic (p200300ec2f1ceb003bc77e8b3da10c60.dip0.t-ipconnect.de [IPv6:2003:ec:2f1c:eb00:3bc7:7e8b:3da1:c60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 438A11EC0105;
        Sat, 16 Oct 2021 12:35:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1634380540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=H3Avw2wjksPe/3ttNQLpNAvBZVGLhcdcKMBwVY6uVRM=;
        b=cgGqeN/1UirZKtqmpzTlvi2UpO0zno2FgctsBSHqOTuH2Eih//BJZwPgLBeVpKGOQMQiee
        MBWMP/O7XNY/2Vu/hpuvt4elHdAUJk/aDmMSro7/83wqIh/6Y6dXoeK2wqp/4lBRi1FH6D
        yBh/COraTnEFV7qsRrGJBTcicxcMOis=
Date:   Sat, 16 Oct 2021 12:35:39 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ser Olmy <ser.olmy@protonmail.com>
Cc:     Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [regression] commit d298b03506d3 ("x86/fpu: Restore the masking
 out of reserved MXCSR bits")
Message-ID: <YWqq+/BtR+tqGXJA@zn.tnic>
References: <YWgYIYXLriayyezv@intel.com>
 <YWhCAqDxAuTh1YwE@intel.com>
 <YWhFOJCF1pxIBANv@zn.tnic>
 <YWhG0kv/d/hddf+t@intel.com>
 <YWhsvSM5tAvwqprN@intel.com>
 <YWhwdDI5ECoMZQzU@zn.tnic>
 <YWh7GgCgdtwRj3GU@intel.com>
 <YWiAPQCRm4RnOiCd@zn.tnic>
 <YWlgPJwxmFL5nX4c@zn.tnic>
 <jrf08svYO7V3wrXiL9wLzsLx74V4QmXRdlfLeeL2zEmta8REOAVFwpEt8npiWRfbrCf_WEfQxJyg45H-VGa83bFfnhTYYe1R7iWao4Y9wRg=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <jrf08svYO7V3wrXiL9wLzsLx74V4QmXRdlfLeeL2zEmta8REOAVFwpEt8npiWRfbrCf_WEfQxJyg45H-VGa83bFfnhTYYe1R7iWao4Y9wRg=@protonmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 16, 2021 at 07:26:25AM +0000, Ser Olmy wrote:
> Tested-by: ser.olmy@protonmail.com
> 
> Working fine here with the patch applied to a stock 5.14.12 kernel.

Thanks!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
