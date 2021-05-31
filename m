Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A974739590F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 12:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbhEaKlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 06:41:49 -0400
Received: from mail.skyhub.de ([5.9.137.197]:59604 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230518AbhEaKln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 06:41:43 -0400
Received: from zn.tnic (p200300ec2f080f0029ca4f7a5f3cda43.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:f00:29ca:4f7a:5f3c:da43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D5E781EC0556;
        Mon, 31 May 2021 12:40:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1622457600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=WUgUwx39xVYZ11/15SQd1ZJkFjifBzAGdzkPCYAD/J0=;
        b=DSj90rkGY8JyE/oqn4kNbJA/r8rqwL/x0ucFuTqoUjStiPEB6PdkXzvG64grdWZJcjMOkh
        0BQEkjxXlVqO4im4HgtuD4+2KB8qSK5CS2SK0Pz4YhSw5JVv+prRDxjyecZnZMIW3xUWqg
        OUio1c6UnN/yyIBoTKjIMuMorc6HC+o=
Date:   Mon, 31 May 2021 12:39:54 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Qiheng Lin <linqiheng@huawei.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] x86/kprobes: functions should not be declared
 extern
Message-ID: <YLS8+gMRp62s4WEY@zn.tnic>
References: <20210531031009.21737-1-linqiheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210531031009.21737-1-linqiheng@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH -next] x86/kprobes: functions should not be declared extern

The condensed patch description in the subject line should start with a
uppercase letter and should be written in imperative tone.

Also, the subject is wrong. Hint: "declaration" vs "definition".

On Mon, May 31, 2021 at 11:10:09AM +0800, Qiheng Lin wrote:
> The function declaration in kprobes.h is already marked extern, thus its
> definition should not have the keyword.
>
> This quiets the following sparse warning:
>  function 'arch_unoptimize_kprobes' with external linkage has definition

This sounds like you're fixing something just because some tool
complains and not because there's a real problem you're fixing.

Please rewrite your commit messages to state what the problem is and
why you're fixing that problem. The tool output can be used to say
something along the lines of "this problem was caught by this tool" but
not as "see, tool X complains and creates a warning and I must fix that
warning immediately."

Ok?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
