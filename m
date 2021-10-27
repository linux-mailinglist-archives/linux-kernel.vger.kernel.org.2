Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3BF43CFFF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 19:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243367AbhJ0RsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 13:48:15 -0400
Received: from mail.skyhub.de ([5.9.137.197]:48230 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243378AbhJ0RsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 13:48:10 -0400
Received: from zn.tnic (p200300ec2f161500c684d7dcfa146303.dip0.t-ipconnect.de [IPv6:2003:ec:2f16:1500:c684:d7dc:fa14:6303])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 55A791EC05D4;
        Wed, 27 Oct 2021 19:45:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1635356744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=TFZpJ306vv31pBniXWJi6Tw4yimAtEnxP/vp0xT3/RY=;
        b=RS97Uen5A6zEtgQDEsRKox0WJjevM8jx/9F8ZVTFdtckQ4/+NPMkyAiXpmDaYOT4ZQYeWq
        5QfOtep7Uf4cUmszoziMa8avlTA1SMypcov44hpwgLnHjVqAcUV/JM59LwWhnklb+Ug4X8
        pbS2eoY8B0fyRPslcRQiUuBkSfMfokc=
Date:   Wed, 27 Oct 2021 19:45:44 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Noah Goldstein <goldstein.w.n@gmail.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, X86 ML <x86@kernel.org>,
        hpa@zytor.com, Andy Lutomirski <luto@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] x86/xstate: Make AVX512 status tracking more
 accurate
Message-ID: <YXmQSG7BYCcZ6jqZ@zn.tnic>
References: <20210920053951.4093668-1-goldstein.w.n@gmail.com>
 <20211027162615.1989004-1-goldstein.w.n@gmail.com>
 <20211027162615.1989004-2-goldstein.w.n@gmail.com>
 <YXmIP2EPg12N7foP@zn.tnic>
 <CAFUsyf+Y76TxLnxMSfHiNqY3OOZPtBR4m_EbTcow=N65nvGdKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFUsyf+Y76TxLnxMSfHiNqY3OOZPtBR4m_EbTcow=N65nvGdKA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 12:37:16PM -0500, Noah Goldstein wrote:
> What about just splitting off a field for 'AVX512_ZMM_Hi256'?

Let's please not perpetuate this into what it cannot become anyway. The
more stuff we add to it, the more people will start using it and we're
stuck with it forever. And soon that thing will be worthless anyway.

So what's the point...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
