Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B56C41518C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237695AbhIVUoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:44:05 -0400
Received: from mail.skyhub.de ([5.9.137.197]:46768 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237555AbhIVUoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:44:04 -0400
Received: from zn.tnic (p200300ec2f0efa00329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:fa00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 77C921EC0529;
        Wed, 22 Sep 2021 22:42:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1632343348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=mruKkH25AxlMcsYqUUFu27McSeFfJSDCJEWOyKe2PCg=;
        b=maQ8j7/ch80PeHoAU2njxWui0pO4OgTRj7V312xCAHLMNnZdfuBqxCNMtysfoTEUIIGwOF
        jY9p0cFCT1XI4MIGFFZHWl9+zVwxVQkJQsz0Ffx1E18JMslL+mkjPkTHeluoeLZ1Qlnj7R
        QhL6SKdiAzNIFxgWbjiMJsK/NzFRZIg=
Date:   Wed, 22 Sep 2021 22:42:20 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 0/5] x86/mce: Remove indirect calls
Message-ID: <YUuVLBPOm4N2y0Ji@zn.tnic>
References: <20210922165101.18951-1-bp@alien8.de>
 <YUuTfd/NmrNPgkqM@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUuTfd/NmrNPgkqM@agluck-desk2.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 01:35:09PM -0700, Luck, Tony wrote:
> Looks good to me.
> 
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> 
> Some light testing of injection/recovery still
> works too.

Thanks!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
