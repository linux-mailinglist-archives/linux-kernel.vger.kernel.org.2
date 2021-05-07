Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE8FE376812
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 17:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237932AbhEGPeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 11:34:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50240 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbhEGPem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 11:34:42 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620401621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=puuKmPm6gMZ82fM8Br4IvWjvLvrdClJN7zrP9vWnsN4=;
        b=F2HHw5jqZ18/TJSN+SvvqP/QJ6Hb8JF8V6AByT7RqOvGGT64C4U6cUtD3tzZbZhV1uGO6x
        x3xmpngQ6Jc2+ihmo4hc0IzJSo3oPKmqm+F784xhQ+/W/v9S48ZpSTnfMZEz4E9e08BsUW
        TRsG6xpDRR1IamIYEv3eWjzZl1iU3m7ewjT2GvfL9SGj6uVmcK32ZNskLkn9BgYknM4idx
        81ZGMrua+Gt0KHpcm9ePvdeWwxi1RNC2UYgmeLdWMggPThovD5N8uH2SLpGebKkD1wcjPn
        k1HoBNsHQTrLPqZm+7qWvG8vzNTZMYZvtgoFGE07aVAyWMuRVAWb8vxhNEu/Cw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620401621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=puuKmPm6gMZ82fM8Br4IvWjvLvrdClJN7zrP9vWnsN4=;
        b=X0qMbXgBUxCljx/5QNwwodjxl8JaONvMXspXyQkEjNsi/fWn3iOcFwS2fjMiv9M0VwunGJ
        n9J2nvRn/kh6/sBg==
To:     "Saripalli\, RK" <rsaripal@amd.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, Jonathan Corbet <corbet@lwn.net>,
        bsd@redhat.com, Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v5 1/1] x86/cpufeatures: Implement Predictive Store Forwarding control.
In-Reply-To: <661f2603-1db3-9601-617a-6cc44b6e94ab@amd.com>
References: <20210505190923.276051-1-rsaripal@amd.com> <20210505190923.276051-2-rsaripal@amd.com> <87wnsamvaa.ffs@nanos.tec.linutronix.de> <661f2603-1db3-9601-617a-6cc44b6e94ab@amd.com>
Date:   Fri, 07 May 2021 17:33:41 +0200
Message-ID: <87tunemucq.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 07 2021 at 10:23, RK Saripalli wrote:
> On 5/7/2021 10:13 AM, Thomas Gleixner wrote:
>> Something like the below. You get the idea.
>
> I agree and the first patchset did indeed treat this vulnerability just
> like others. It was converted to this patchset based on reviews from the upstream
> community.

Yes, I saw that and said so.

But I fundamentaly disagree with that for the reasons I mentioned. Sorry
for not paying attention early on.

Thanks,

        tglx

