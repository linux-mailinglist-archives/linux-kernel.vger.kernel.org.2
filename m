Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5A2542ADD2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 22:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234577AbhJLUcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 16:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232986AbhJLUcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 16:32:00 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E045DC061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 13:29:58 -0700 (PDT)
Received: from zn.tnic (p200300ec2f194200461a217ceec11f7e.dip0.t-ipconnect.de [IPv6:2003:ec:2f19:4200:461a:217c:eec1:1f7e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3728C1EC0445;
        Tue, 12 Oct 2021 22:29:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1634070597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=LV49XJer83pNAamSOHet+vAqgvGNQ6uIlzh1Yld/GaY=;
        b=lBAaeMnL+gGQAkvkoFNbLTpMVPNhi/XqTPiQOGS/UpPZ57+561GItHaIG5My2cKsLcxotO
        zLJEE5vCcbaYw/ZpIAQJMfOJwZnQWuDEufELstKNhQ6yNNKapYFoGcYH4G09gLpe4SCuAw
        yD29qv/cbiDF/ffT7wtB6cYMGXa1spo=
Date:   Tue, 12 Oct 2021 22:29:55 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Ammar Faizi <ammar.faizi@students.amikom.ac.id>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] tools/nolibc: x86: Remove `r8`, `r9` and `r10` from the
 clobber list
Message-ID: <YWXwQ2P0M0uzHo0o@zn.tnic>
References: <20211012052822.GA28951@1wt.eu>
 <20211012083644.543775-1-ammarfaizi2@gmail.com>
 <20211012090638.GD28951@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211012090638.GD28951@1wt.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 11:06:38AM +0200, Willy Tarreau wrote:
> Let's indeed wait for any of the x86 maintainers to confirm your
> analysis.

I guess the official doc you guys are looking for is the x86-64 ABI:

https://gitlab.com/x86-psABIs/x86-64-ABI/

and recent pdfs are here:

https://gitlab.com/x86-psABIs/x86-64-ABI/-/wikis/x86-64-psABI

and there you scroll to

"A.2 AMD64 Linux Kernel Conventions

...

A.2.1 Calling Conventions"

and that section explains which regs go where.

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
