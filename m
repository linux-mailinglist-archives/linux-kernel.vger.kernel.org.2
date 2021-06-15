Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B79403A8777
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 19:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbhFOR1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 13:27:39 -0400
Received: from mail.skyhub.de ([5.9.137.197]:58096 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229492AbhFOR1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:27:38 -0400
Received: from zn.tnic (p200300ec2f0f270048ecafc2d258032c.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:2700:48ec:afc2:d258:32c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A4B691EC030E;
        Tue, 15 Jun 2021 19:25:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1623777931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=fROwX1Fe7yi2T3mwV8B7UzVtscUMWSlmHdaRIUoVzQc=;
        b=J0X6NhRjmNmNRvBShcsPVRh60eCtohIoXCFUk1Xq3zbWAuRFlYDFY/2u36ap2rbfkc99Cr
        QcHazIUor3FdlYmQSsSS3FgQKqwpg9h+jaEz69xJM/s4UtFxq8moD9YOTEpo76hdM1qNzl
        L/dYEmt13l/l+WbEacivx+ts9l3AHZs=
Date:   Tue, 15 Jun 2021 19:25:20 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     James Morse <james.morse@arm.com>
Cc:     Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        lcherian@marvell.com, "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH v4 00/24] x86/resctrl: Merge the CDP resources
Message-ID: <YMjigIy7iincvT67@zn.tnic>
References: <20210614200941.12383-1-james.morse@arm.com>
 <cc452592-491f-3ddf-983a-8669ad12df9a@intel.com>
 <4d2ba7c1-395b-d1ec-c92b-f906e2a551a1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4d2ba7c1-395b-d1ec-c92b-f906e2a551a1@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 05:48:25PM +0100, James Morse wrote:
> Please point me at something to rebase onto!
> (as far as I can see, tip/x86/cache hasn't moved)

Just use tip/master when that branch hasn't moved. We usually
fast-forward those branches to the latest Linus -rc before applying new
stuff.

And I'm sure we should be able to handle kernel-doc conflicts when
applying.

:-)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
