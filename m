Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66444439824
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 16:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbhJYOL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 10:11:26 -0400
Received: from mail.skyhub.de ([5.9.137.197]:42184 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233281AbhJYOLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 10:11:25 -0400
Received: from zn.tnic (p200300ec2f0f4e00a9aecab73d80ddb1.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:4e00:a9ae:cab7:3d80:ddb1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 691D71EC04F2;
        Mon, 25 Oct 2021 16:09:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1635170942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=LS7jPgBLHtGsBky4rBZ6EVeQmJ79NARMLmaWT23khvI=;
        b=SFzlb3KN7NwgMt7lYWynFsIqaJk9i1LROlkqZZ/18phGDdq9wNHdoDD/Sgy+xCdi4vVm0m
        KK5tEI5+GYnhN20YVTBIBqKvunFFXnDdGCeeRD4hbNZjXyiTea+s+w4XKhEfxAaphmhUjs
        uO33q8I71JPloazfxbtHdAM6hIF4Bb8=
Date:   Mon, 25 Oct 2021 16:09:04 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com,
        ndesaulniers@google.com
Subject: Re: [PATCH v2 06/14] x86/asm: Fix register order
Message-ID: <YXa6gLi3TVxfGx0a@zn.tnic>
References: <20211020104442.021802560@infradead.org>
 <20211020105842.859476776@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211020105842.859476776@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 12:44:48PM +0200, Peter Zijlstra wrote:
> Ensure the register order is correct; this allows for easy translation
> between register number and trampoline and vice-versa.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/include/asm/GEN-for-each-reg.h |   13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> --- a/arch/x86/include/asm/GEN-for-each-reg.h
> +++ b/arch/x86/include/asm/GEN-for-each-reg.h
> @@ -1,11 +1,15 @@

<--- while you're at it:

WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
#75: FILE: arch/x86/include/asm/GEN-for-each-reg.h:1:
+/*

I.e., put

/* SPDX-License-Identifier: GPL-2.0 */

at the 1st line there.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
