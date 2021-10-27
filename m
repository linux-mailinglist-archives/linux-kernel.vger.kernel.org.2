Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0100C43CF2A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 18:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243089AbhJ0RAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 13:00:48 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41092 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239242AbhJ0RAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 13:00:47 -0400
Received: from zn.tnic (p200300ec2f16150008d5435da1919031.dip0.t-ipconnect.de [IPv6:2003:ec:2f16:1500:8d5:435d:a191:9031])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D952B1EC05C4;
        Wed, 27 Oct 2021 18:58:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1635353900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=jrEaPSOTWZS1MQQsmJg4E3UK3eoom5eGC0Nm/ZKb2Dg=;
        b=rBuzR8jmil7PILkQbqOcdzeRTbM8oYGz4VWoA3YIcDbfDZs7IqB9Jdh7vwITEObawrjVFD
        kFu+QdF0O5IWJmybk2KbmNA5ZtDGfAnlFtm7fDko91T7rgsj2rn7NWjdIqVMLS/XQn21mc
        qAC4/WqpYTP7DduODKNmVLQ26hSxfq8=
Date:   Wed, 27 Oct 2021 18:58:21 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Noah Goldstein <goldstein.w.n@gmail.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, X86 ML <x86@kernel.org>,
        hpa@zytor.com, Andy Lutomirski <luto@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] x86/xstate: Make AVX512 status tracking more
 accurate
Message-ID: <YXmFLTEzxdc6soxS@zn.tnic>
References: <20210920053951.4093668-1-goldstein.w.n@gmail.com>
 <20211015204713.2855996-2-goldstein.w.n@gmail.com>
 <YXky/qrRSvvhI3JN@zn.tnic>
 <CAFUsyfJGxpLz14pZ-_nC-3651WaeZeb6p1yteCP2J4=aTKRsrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFUsyfJGxpLz14pZ-_nC-3651WaeZeb6p1yteCP2J4=aTKRsrA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 11:28:07AM -0500, Noah Goldstein wrote:
> Got it. Thanks.

Did ya?

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
