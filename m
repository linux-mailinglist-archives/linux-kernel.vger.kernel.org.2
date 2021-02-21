Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A40320E39
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 23:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbhBUWLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 17:11:38 -0500
Received: from mail.skyhub.de ([5.9.137.197]:52526 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231440AbhBUWLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 17:11:24 -0500
Received: from zn.tnic (p200300ec2f205c0001ea2f1fa764c384.dip0.t-ipconnect.de [IPv6:2003:ec:2f20:5c00:1ea:2f1f:a764:c384])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 890531EC04A9;
        Sun, 21 Feb 2021 23:10:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1613945439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6TFnR2wTHAnoA9eOghAbSgZz+AhRgqpjAOQoEVveYec=;
        b=VqjTp8Dxc0afvsW7ir4R3wD6S11U/WUDPCCHnPJvcBaQGRFfLYDZvNyVENvylCVAzeExHe
        0ju1GlhqhN9ZoJ1NguQ1qy25L0oaVgRv+kBx1RAsN0K9NYL204Pv6qLgtUtHxmIhrKyVqC
        OIqs80vngvlzR4k4cSmr1ZTKIN4x7yI=
Date:   Sun, 21 Feb 2021 23:10:37 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: *Wrong EFI loader signature.* logged on non-EFI boot
Message-ID: <20210221221037.GD1897@zn.tnic>
References: <e5c0c46b-1fc2-9b38-0351-96dbff4e3008@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e5c0c46b-1fc2-9b38-0351-96dbff4e3008@molgen.mpg.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 21, 2021 at 10:22:56PM +0100, Paul Menzel wrote:
> It’s unexpected to see the EFI loader signature to be checked in this
> scenario.

Why is it unexpected? You have enabled that check through CONFIG_EFI=y.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
