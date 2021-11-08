Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F44447F78
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 13:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239489AbhKHMaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 07:30:13 -0500
Received: from mout.gmx.net ([212.227.15.19]:48143 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239477AbhKHMaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 07:30:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636374428;
        bh=UH9EY25P1vO8a9NU0FuLhNQf5AOdrOHOIROC3aFIIJ4=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=gEBSfauMfDLPMlWUFeF6yoFatpzl867dLmR4IFbjUVKhQZFy48fnr2RkHqYgNzCzQ
         sAjKMFU1RmZeUlaf84e+g2LCGqeIPF+lbdjj2buMGpXOD7KNdSoLTWdWPQLV2ldpPl
         2GBckNwnANVp0Zi7sv6JJuIIk6eZauRHycUu7css=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.151.151]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mj8mV-1mGCUr09tV-00fBX5; Mon, 08
 Nov 2021 13:27:08 +0100
Message-ID: <5543627ee8ac5337a74de4b9671240d617273607.camel@gmx.de>
Subject: Re: [PATCH] sched: Tweak default dynamic preempt mode selection
From:   Mike Galbraith <efault@gmx.de>
To:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Date:   Mon, 08 Nov 2021 13:27:06 +0100
In-Reply-To: <8735o6uca5.mognet@arm.com>
References: <20211105104035.3112162-1-valentin.schneider@arm.com>
         <ff53a94401f8d6abe0303ee381f86bfb475ad354.camel@gmx.de>
         <8735o6uca5.mognet@arm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.0 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IkJVfih0jfgqnrM+J2jJO1UPxJg4A3sSlZdAyQxFqjA6gQq0Kl0
 QXX7mqqWxv3/IrvWvWwVAye8Bw/AEA8FuBRGTXlJyO4f483CDUF7NqZdF6yn8kN2LMi6xM7
 ZC1bEWfGK/OSNYi10uSMG2dqmpyA/gYLUCmWJ2xCAcqUXZNb0j8x3IKAIFLNVKmJFBg3+2m
 Suz/DuYL9P6xNC0A01D3A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:fufUjyCac1E=:1ImMlJrTV3QAKDO0FJQosn
 oAyYX6cE0a8HLmZg3KmJJX8GUO/7IyDEovPRuiMNgXmoV8dyt4vob/ddpsGwJRFvgijRGANv9
 ifZXEUYckrBT+UFzhCtzFr2wIqCZVpXoTOhXrW3hax+lJZMV+5NKtmlpVXMFGvEfPj4tddqC6
 j6fT60Gy9T4MqNr5V1HAakjCSxgqlmM+p8qXqsIdm9BLMVRc0bfaZ07fabA5rrqmFciDzkU46
 JwY7DsoeNjAFjlD3EYejDBgagGiOk1oyAk8LDBb8EB1RyF7t4CDNzxqYYNC2ipJGKA5LhXN/X
 VR3VU1vOgXYFTcueytR5Lbm4Uzj/bBcwnha++0dvr/ZeHSJ+KUl/rZzngX+QxHJHoFeXFjU1a
 p4cacgqjXHJrjy5vznrswOAnOiADTRDuRvK2Ub+QROl4ef8QnvwBevRDnRflkYID1AaagOM0/
 9SR+pCWxT9xiuA8AZSyZfy6W6MhVV8acWa6UYhPkVkjv9npsws35XABp6X04tmL+mEqLLDbtC
 Xanb0dkdKqNBzfu+XXcRWMc4MIhwRrJMEL1pSezEyVAQix3njruEdNBCXUOEVGIl9vRVxrUkd
 2RYc79mQ0PUX9YH4SPYeLEX9gYESinWjSiQLudkidPhSdeEBYOR9GZdokdv6JimjCkuzaVsJj
 8ru1cI0inohqgZTZJHG9MBDoDCaqgLw5F36cjVdEUnrEjmQ21tUF7BuRuBOQGVT7eujNFQPft
 +rbICKvMfiSiIA4o6IJjnV+VII5q5P263/ZznuL0ggO6aI6Lq9IepbXyMZIIpd789S5JN3f0t
 AJ5TTL6loz8WQEQPv+M4UeoYFRf9DGp8BxAWCKFR+Tw3FZPHRXmXPwEwAwLpEkOTlra5yTCd8
 BED8GVK93Wn70YaMyMgS0YzHfUWEsg/3lZoelLc/l/iV8t9LqlkjEGa3zsHrnHb3iuYeUZWmi
 NnHvUQJtUu4wamlbwEND2zMQXGAh/wFlcr8utNVX8cOP9KSzaZ6MWmfAXnXQ41rzyktSoXwVt
 giGKEfYYxOsynalmPd72d62Bi5PapDK6loAKntOtoZe34ytFre+pGXqcTYQXsedI6kHs5M36m
 a/JZHCz7fhXjX0=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-11-08 at 11:17 +0000, Valentin Schneider wrote:
> On 06/11/21 05:40, Mike Galbraith wrote:
> >
> > Starting with a 5.15 config, to select RT you currently must first
> > select a model you don't want, then reject PREEMPT_DYNAMIC and you'll
> > be offered the full menu of models immediately. With your patch added,
> > that became worse.=C2=A0 After rejecting PREEMPT_DYNAMIC, I had to go
> > through new 5.15+ options before finally being offered the full menu.
> >
>
> Do you mean at the syncconfig step?

Um, not sure what that is, but it sounds about right.

> I've only really played with upstream
> arm64 / x86 defconfigs and didn't have to fight with any prompts, though
> yes for x86 the default-y PREEMPT_DYNAMIC makes it a bit annoying to sel=
ect
> PREEMPT_RT.

As long as RT depends on EXPERT it'll be a bit annoying regardless.  I
just thought it worth mention that what you want now and what RT will
presumably want upon merge completion appear to be mutually exclusive.

	-Mike
