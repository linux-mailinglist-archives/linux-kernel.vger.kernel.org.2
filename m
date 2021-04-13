Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED9A035E1ED
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 16:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240313AbhDMOxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 10:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238478AbhDMOxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 10:53:38 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564B3C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 07:53:18 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0b8400dc5952bb5bba9b51.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:8400:dc59:52bb:5bba:9b51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 84C811EC0118;
        Tue, 13 Apr 2021 16:53:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1618325596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Zng+s8B6UzBFhAFGTLiOGYpjULkd5L9TFnuYZ/fZJMw=;
        b=sfqiW9QpHo+w0Mdf7b+STf9grriXJSRP8r96BYJ9IR7mx6BfYZWWjzZJEsCi3zCnfkyBt4
        KzXh30fBsl8U9/Z59iYeeErqvQkOfW2fuWqUtSfDzg7KtMbyyb+7/X0CLl0fZ2SK/qFAUt
        ZFSanaWN0PkXvf+qbFA2pVZNiV4KdpU=
Date:   Tue, 13 Apr 2021 16:53:15 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Kemeng Shi <shikemeng@huawei.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Subject: Re: Re: [PATCH] x86: Accelerate copy_page with non-temporal in X86
Message-ID: <20210413145315.GF16519@zn.tnic>
References: <3f28adee-8214-fa8e-b368-eaf8b193469e@huawei.com>
 <20210413110137.GD16519@zn.tnic>
 <bfa4fd38-0874-63b3-991a-1102af9f47a6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bfa4fd38-0874-63b3-991a-1102af9f47a6@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 08:54:55PM +0800, Kemeng Shi wrote:
> Yes. And NT stores should be better for copy_page especially copying a lot
> of pages as only partial memory of copied page will be access recently.

I thought "should be better" too last time when I measured rep; movs vs
NT stores but actual measurements showed no real difference.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
