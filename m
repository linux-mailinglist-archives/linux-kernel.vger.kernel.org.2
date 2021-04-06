Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B80AB355A47
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 19:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346937AbhDFR0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 13:26:44 -0400
Received: from mail.skyhub.de ([5.9.137.197]:48412 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346929AbhDFR0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 13:26:42 -0400
Received: from zn.tnic (p200300ec2f0a0d00e4e63576b95994ce.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:d00:e4e6:3576:b959:94ce])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 923CC1EC013E;
        Tue,  6 Apr 2021 19:26:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1617729993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=idqOHLAs7SL5nM66x3pkyyTPWUwrZsy38j6qZgr5RLg=;
        b=cU83McEx1YzXoD2G7k6cubs9rjMLIsjStpkhrDTfhPf0ASp5x3NkT/paHKNrlsy0AUJMUd
        +lnuIzl2WvESy5dTyTublV7i66yip7R6+yoRoA+dzHoTtVuafjylVdQ41GwiTgLI8UJ65x
        KvKJ/9CZBeDGGierdASAiE1jdzGxXCE=
Date:   Tue, 6 Apr 2021 19:26:32 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ramakrishna Saripalli <rsaripal@amd.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 0/5] Introduce support for PSF mitigation
Message-ID: <20210406172632.GO17806@zn.tnic>
References: <20210406155004.230790-1-rsaripal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210406155004.230790-1-rsaripal@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2021 at 10:49:59AM -0500, Ramakrishna Saripalli wrote:
> From: Ramakrishna Saripalli <rk.saripalli@amd.com>
> 
> Predictive Store Forwarding:
> AMD Zen3 processors feature a new technology called
> Predictive Store Forwarding (PSF).
> 
> <TODO:Insert link to AMD PSF whitepaper>

You probably should upload it here:

https://bugzilla.kernel.org/show_bug.cgi?id=206537

instead and then point to it in the docs. And by "docs" I mean, putting
all that nice text below which I've snipped in here:

Documentation/admin-guide/hw-vuln/

for future reference. Look at the docs there for an idea how to
structure it.

I have come to appreciate our documentation a lot these days when I've
forgotten all about those nightmares but needed to refresh them back in
my L1.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
