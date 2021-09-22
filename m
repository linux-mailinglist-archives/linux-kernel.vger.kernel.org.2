Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C26414B31
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 15:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234405AbhIVN4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 09:56:54 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41570 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232720AbhIVN4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 09:56:46 -0400
Received: from zn.tnic (p200300ec2f0efa00329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:fa00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 800941EC0537;
        Wed, 22 Sep 2021 15:55:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1632318911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3m6cKNpk+E6RV35CGSfdU3ra4mzOfmEwHnOQ3B7mt98=;
        b=lk8ZGHtrhRSAOqxjTjeSSCwsKoxITLZZqF20I7PGIhOPkT1P5BiHu5ysIm8OlXPFzfnPUG
        tmfcG2B0x6VVHAuDswoUApx1koedA3rQliWlrhT98G2HXAmO7uKUI9N2IymEksytauiME3
        +gPW/QER28xDph0utGk/JX54SHKoNXo=
Date:   Wed, 22 Sep 2021 15:55:10 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] x86/mce: Get rid of msr_ops
Message-ID: <YUs1vu7lxevL1EpO@zn.tnic>
References: <YUsesVeZ8PPC5iV5@zn.tnic>
 <2B1FFC77-A740-41AE-BF8C-FB238B9DF7F5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2B1FFC77-A740-41AE-BF8C-FB238B9DF7F5@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 01:23:28PM +0000, Luck, Tony wrote:
> Looks nice. I don’t think you need those “break;” after each “return …;”

Yah, all gone.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
