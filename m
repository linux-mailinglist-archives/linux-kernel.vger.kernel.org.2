Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC42399316
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 21:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbhFBTEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 15:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhFBTEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 15:04:33 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E61C06174A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 12:02:50 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0f0e00fb29af68c81f5342.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:e00:fb29:af68:c81f:5342])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F15C01EC051E;
        Wed,  2 Jun 2021 21:02:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1622660569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=7zIq0LDS+UeVrnhHPH+gBvIs+7Zwr9hskZ3IDbgvQCM=;
        b=G80GYF1nFzsm0dEYl5hkKFRgR4l2xIFXQkA51Qsq8gKedZPwnc1UrqauFyolkSFhW1l6bf
        b4lF6r+Yb9i9Qo+bd6GWAJCB9B/n6pxuhsaKYVANe8SKjOpJ6QpkHLZAZogTdSgKFTAgSW
        xfob+RjmjBMV1F3ySFkydvgIPNyfQJg=
Date:   Wed, 2 Jun 2021 21:02:44 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Jiashuo Liang <liangjs@pku.edu.cn>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] signal/x86: Don't send SIGSEGV twice on SEGV_PKUERR
Message-ID: <YLfV1CiJXBoUrt6h@zn.tnic>
References: <20210601085203.40214-1-liangjs@pku.edu.cn>
 <87wnrcqfap.fsf@disp2133>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wnrcqfap.fsf@disp2133>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 01:42:22PM -0500, Eric W. Biederman wrote:
> Does one of the x86 maintainers want to pick up this trivial fix or
> should I pick it up?

I can, tomorrow.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
