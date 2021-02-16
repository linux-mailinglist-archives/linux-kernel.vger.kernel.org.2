Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C498931C971
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 12:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbhBPLMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 06:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbhBPLMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 06:12:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFABC061756
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 03:11:27 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613473885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x8FkXp3EqZEn9d69BlnY/PCjn/1QFCUAVa1JYd0z9Zs=;
        b=tmg6TRrxepOd2CjT/u95PquZ90MdzonMkM4F/paMTyZb/pjDVavfEDcDp2hfD2m5hb4lQO
        xH7i8oXDCJwFX2ECxg422svbi4DkzmDcFEL9L7NM7p5d6XzqYm06Qqa12nyGfymq4sNW52
        LvcXnR4DqVqBPaTUqF34/aw4i34TfYoYHXNfdbxnCcPQ743Xyo0GKIWuVJZdu9RMRiWxCO
        moUaZb1WMTin1GKnYkPRpK07e1kiRQiiP1Pzw3SyDAd2sboiDjm0+aZ83oRCMDT8w0LCCX
        kckv5atb0CiT03DgQqrmxuXRIBZdZ2UqXgVBi5gookSJIuxlD8ekN6qK3FUhtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613473885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x8FkXp3EqZEn9d69BlnY/PCjn/1QFCUAVa1JYd0z9Zs=;
        b=9m4Ymt/FPCNrZmIgox9qh6a1+xPbpgHw4qxuJln6gozCbrn3H0RKSNU4WkePy2NnaTRKNn
        TS8OqkoXg0o7vSDw==
To:     Borislav Petkov <bp@alien8.de>, Petr Mladek <pmladek@suse.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>, it+linux-x86@molgen.mpg.de,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: smpboot: CPU numbers printed as warning
In-Reply-To: <20210216101449.GA10592@zn.tnic>
References: <e964b2ae-7a15-a510-e76a-56d704949d62@molgen.mpg.de> <YCuVEDXyIu+yE4c1@alley> <20210216101449.GA10592@zn.tnic>
Date:   Tue, 16 Feb 2021 12:17:24 +0106
Message-ID: <871rdg8dyb.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-16, Borislav Petkov <bp@alien8.de> wrote:
>> Also you should add '\n' into the previous string to make the behavior
>> clear. It will always be printed on a new line when pr_info()
>> is used.
>
> This was made to use pr_cont() on purpose so that the output is
> compact,

It is supported to provide loglevels for CONT messages. The loglevel is
then only used if the append fails:

    pr_cont(KERN_INFO "message part");

I don't know if we want to go down that path. But it is supported.

John Ogness
