Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF423382FC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 02:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbhCLBAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 20:00:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbhCLBAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 20:00:17 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71636C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 17:00:17 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id w7so7621282pll.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 17:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=gv+xWsQfcMIOQNOovYei3JCwJn5hpNQ/FSKLCaKdqn8=;
        b=W74o9hWGlvn00KI1/2TNKoG5g2mE1OhPtw8DGPyd5+TQlCXCp+ti1l9C/ehXqBT59S
         W1mEa5HQOsLs182A3l4vd0A+PKB+QD6i5GYQUcHx+ltotWgMklhjs5K1D+WuwEvdFpaW
         WzTFxg+6XRbGSTWAhI61T6/kG8rKSKAIORGCmcs26Id6sQkcQN8lTrhxOmfFaLd3Ryt2
         5iM9NQk35cNoIo6+ai8XNtiz1/AuDtlC9aDaBWED3NPysoRCmhg7Yco0rEAWXI17qFrV
         CFOx6BMe1CzDiACCXErNYh9Um5EHKrbxHdn8Z7f5fVlUfSumsMWUiifYoY84sauU+YL0
         uBzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=gv+xWsQfcMIOQNOovYei3JCwJn5hpNQ/FSKLCaKdqn8=;
        b=kVSxafAyueEHmCj9cz8P/thIPl6Nh2H5Wv+T1TChRnp47jF8o2+G1eZ0qo2ASDdDdS
         6fhR4JWSWqNSqtxhnh/PcCrenjrrF6I5plXkBXVRtGvymhK9eDk0+9c/AvIT98sLgq9j
         ocRCMTU43XA8REWN4KtEzezT89zra+ZytbCzzU5ZexfsmPrJFS8XIIJROE+ZBHOKFtgW
         HU0WydyP/KxZES2Zu8nIm+dlnvzPrzopLlXSpp2o4E64sLFa5A9mao3tPH6wsHJ35snI
         04s0Vs6bdcpDuCQzcsLsVo6nXkEcuAlrqGroniYGx9KztywrfLhKxpkP2tOsGEiKqVZ4
         oleQ==
X-Gm-Message-State: AOAM531W2+pCuzNHsP+MEwLdxzDBbP9d9gi1+UK0WDt0RmnD2C8zDkDw
        li60u7Av4FmR5Y4UhoB/kO8ecV19bm0=
X-Google-Smtp-Source: ABdhPJyBjVxYp/bY5ZCLnj5g+/WCwYIiJuGyGicbGZC4UNROy8kbx+b25aWfVFADwBt1Wat7ZPK+nQ==
X-Received: by 2002:a17:90a:e7cc:: with SMTP id kb12mr8591004pjb.31.1615510816986;
        Thu, 11 Mar 2021 17:00:16 -0800 (PST)
Received: from localhost (58-6-239-121.tpgi.com.au. [58.6.239.121])
        by smtp.gmail.com with ESMTPSA id j10sm255097pjs.11.2021.03.11.17.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 17:00:16 -0800 (PST)
Date:   Fri, 12 Mar 2021 11:00:10 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 36/43] powerpc/32: Set current->thread.regs in C
 interrupt entry
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1615291471.git.christophe.leroy@csgroup.eu>
        <8d523f9ecee1de0515cc31d43030c12ab171a670.1615291474.git.christophe.leroy@csgroup.eu>
        <1615339900.vmbtzuirqw.astroid@bobo.none>
        <035298ad-4d0b-5e74-6f5c-e03677580924@csgroup.eu>
        <5a80e05e-27d7-0e95-67c7-0fe3255c4be1@csgroup.eu>
In-Reply-To: <5a80e05e-27d7-0e95-67c7-0fe3255c4be1@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1615510691.0vpkz8qib3.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of March 11, 2021 10:38 pm:
>=20
>=20
> Le 11/03/2021 =C3=A0 11:38, Christophe Leroy a =C3=A9crit=C2=A0:
>>=20
>>=20
>> Le 10/03/2021 =C3=A0 02:33, Nicholas Piggin a =C3=A9crit=C2=A0:
>>> Excerpts from Christophe Leroy's message of March 9, 2021 10:10 pm:
>>>> No need to do that is assembly, do it in C.
>>>
>>> Hmm. No issues with the patch as such, but why does ppc32 need this but
>>> not 64? AFAIKS 64 sets this when a thread is created.
>>=20
>> Looks like ppc64 was doing the same in function save_remaining_regs() in=
 arch/ppc64/kernel/head.S=20
>> until commit https://github.com/mpe/linux-fullhistory/commit/e5bb080d
>>=20
>> But I can't find what happend to it in that commit.
>>=20
>> Where is it done now ? Maybe that's also already done for ppc32.
>>=20
>=20
> I digged a bit more and found a later bug fix which adds that setting of =
current->thread.regs at=20
> task creation: https://github.com/mpe/linux-fullhistory/commit/3eac1897
>=20
> That was in the ppc64 tree only at that time, and was merged into the com=
mon powerpc tree via commit=20
> https://github.com/mpe/linux-fullhistory/commit/06d67d54

Nice archaeology!

> So we have it for both ppc32 and ppc64 and ppc32 doesn't need to do it at=
 exception entry anymore.=20
> I'll remove it.

Good, that's what I hoped (otherwise ppc64 would have been missing=20
something).

Thanks,
Nick
