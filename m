Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC17E3799CB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 00:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbhEJWQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 18:16:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39436 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbhEJWQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 18:16:40 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620684932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U4DwF9/Tu0CY7TspHUPgQGEsFfZQjPTALYWkPy0GpnQ=;
        b=l3/ylfDcE8PvRNxkqTHthC9O2iysd+rzANbRwmcyYrsl528S9Dre41EPPzL6rwnNKKeq4+
        LlW+ZRs24f4czgDtlKowzjjzYpLPhk2BZZRPOmqd9OsDcvcPxwikY/DgihiYbADYRQnokT
        F4lA/45hv5zkm36xrotDJ8ECrdPsQaDzCdYtLfveWFx1Gma7z0TPxV6DYDqJhSUDnXEp9U
        8Qz9PSAZwIQet0amqOyNKc4WFbwZh5bslS5EV5u6dAtwDYJJSBgHnl06NDXoCP3+UqjC4i
        56/x4og5ufqAbI7QqpKHX1oSf63+sVRPpfUO+v4wNWn0MmZJzQVEHj/GwXzBLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620684932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U4DwF9/Tu0CY7TspHUPgQGEsFfZQjPTALYWkPy0GpnQ=;
        b=asOXaR/974z/iqy1/EWbETxeBo+RTMGEjM4qCi9Yi16ITPIeXsR2b7+Ffa9Vk6dgFhU3JO
        leKknq5cmDxpAHDw==
To:     Kees Cook <keescook@chromium.org>
Cc:     "Saripalli\, RK" <rsaripal@amd.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        Jonathan Corbet <corbet@lwn.net>, bsd@redhat.com,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v5 1/1] x86/cpufeatures: Implement Predictive Store Forwarding control.
In-Reply-To: <202105101508.BC6CC99FAD@keescook>
References: <20210505190923.276051-1-rsaripal@amd.com> <20210505190923.276051-2-rsaripal@amd.com> <87wnsamvaa.ffs@nanos.tec.linutronix.de> <d134cbb1-a8a5-161a-1927-2a04df6b4b4a@amd.com> <87h7jagt7g.ffs@nanos.tec.linutronix.de> <202105101508.BC6CC99FAD@keescook>
Date:   Tue, 11 May 2021 00:15:32 +0200
Message-ID: <878s4mgrqz.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10 2021 at 15:09, Kees Cook wrote:
> On Mon, May 10, 2021 at 11:44:03PM +0200, Thomas Gleixner wrote:
>> Kees, any opinions?
>
> I agree: if PSF is a subset of SSBD, there's no need for the additional
> machinery.
>
> On a related topic, what happened to Andi's patch to switch the seccomp
> defaults? I can't find it now...

You mean this one:

  https://lore.kernel.org/r/20200312231222.81861-1-andi@firstfloor.org

If so, then it has lacks a follow up.

Thanks,

        tglx
