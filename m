Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5682D334020
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 15:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbhCJOPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 09:15:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbhCJOPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 09:15:09 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5BBC061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 06:15:09 -0800 (PST)
Received: from zn.tnic (p200300ec2f0a9900452923910729ca7d.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:9900:4529:2391:729:ca7d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0D6E01EC026F;
        Wed, 10 Mar 2021 15:15:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1615385708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xInftdEM72Yr3cDyfCScGyACeH4pMYE+757zoD3NCTM=;
        b=Ypf/zLPu/DN+SzbMFOoHUaGduzDPcW4G6qiHGNzRZljOMuLTfcQsSq9WJmae4/MHG38EQR
        R3FTVdXqG5bR/i75nBy7m9HXmVtedaR6EZ36Wdkp35HgcYrQG2Hz+QCG2kFottyNxE5TMc
        QjAl70dhe8qXdLHzBPjBD28Brsyvu1g=
Date:   Wed, 10 Mar 2021 15:15:10 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v6 04/12] x86/alternative: support not-feature
Message-ID: <20210310141510.GG23521@zn.tnic>
References: <20210309134813.23912-1-jgross@suse.com>
 <20210309134813.23912-5-jgross@suse.com>
 <20210310060705.GB23521@zn.tnic>
 <1b95376a-56e1-ab3e-aa85-73a9d38aaaf7@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1b95376a-56e1-ab3e-aa85-73a9d38aaaf7@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 08:52:40AM +0100, Jürgen Groß wrote:
> Did you look at patch 13? :-)

Well, I usually review in increasing patch order. :-P

But make that change here pls because otherwise unnecessary churn.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
