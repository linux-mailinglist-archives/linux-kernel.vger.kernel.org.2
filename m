Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0F0830DD29
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 15:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233228AbhBCOpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 09:45:51 -0500
Received: from mail.skyhub.de ([5.9.137.197]:42804 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233115AbhBCOpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 09:45:39 -0500
Received: from zn.tnic (p200300ec2f0c840069616d97dc1db5f6.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:8400:6961:6d97:dc1d:b5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 75E5D1EC0257;
        Wed,  3 Feb 2021 15:44:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1612363497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=8oV49+Dx0p2m/AaseZo/xAUqdYQQo9oznARjmTVwMo8=;
        b=fZ6X69/bxc807sK5VIqm0DDm+si/u3bq1tXCBq/yEUn4QKQf8JtwTZ21kzHUoQgAqXbIoe
        R1x+3qDANOZzCNq9VYg1v7MTGb/ONArVTI3q2MnQWlEB8CKVmaLzn4N1h/JeL6XhLSqoFx
        aY0EBK/DfDzItztypH9h1HEGDEY/cZI=
Date:   Wed, 3 Feb 2021 15:44:52 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 03/11] x86/fault/32: Move is_f00f_bug() do
 do_kern_addr_fault()
Message-ID: <20210203144452.GD13819@zn.tnic>
References: <cover.1612113550.git.luto@kernel.org>
 <ed19363b46753f1a4cc980bf13487269c444a648.1612113550.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ed19363b46753f1a4cc980bf13487269c444a648.1612113550.git.luto@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 31, 2021 at 09:24:34AM -0800, Andy Lutomirski wrote:


> Subject: Re: [PATCH 03/11] x86/fault/32: Move is_f00f_bug() do do_kern_addr_fault()

s/do /to /

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
