Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14ECC3F4782
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 11:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236101AbhHWJ17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 05:27:59 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:44365 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236176AbhHWJ1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 05:27:50 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4GtRhp4y77z9sX2;
        Mon, 23 Aug 2021 19:27:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1629710827;
        bh=8BXXBtQt+1six414IipXx+ZF0Q+/K8eZxJyi7uOZhx0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=G3WVQLYVSGPUp+NSZIpreMKRAr7Ct6YGNWAsxdtSSrH9hTjHCu9kZEE8UFTGXCHUE
         9X6ZVr8mb/t1M0ionAwn2+39MHkBea/2LQhhYGIlkulmf447bspR4kQvebMAeFT21T
         kfOWkBf8xDOAx0/eIQuo1EAH2niYTwT39JLRoG1fY+boekcvc5uFMDAKs/YRo49hKD
         wRati/Hx/is1ls7Xj2jk1VBxsBw36AijIebf91QJeWdOceRhpzHJGCgVdK53Seb5pK
         khUi3GSOKSYVE/MyZxTHTSQ4JTFcLrMNV+RuBHti6LQg0rEkPgUjowOpF9gf7G/Z/5
         O/It9AdVbEkRg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Andreas Schwab <schwab@linux-m68k.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/syscalls: Remove __NR__exit
In-Reply-To: <ac141039-ace3-c068-41fa-ec5781750114@csgroup.eu>
References: <6457eb4f327313323ed1f70e540bbb4ddc9178fa.1629701106.git.christophe.leroy@csgroup.eu>
 <87y28ssgpx.fsf@igel.home>
 <ac141039-ace3-c068-41fa-ec5781750114@csgroup.eu>
Date:   Mon, 23 Aug 2021 19:27:04 +1000
Message-ID: <87h7fgcxzr.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 23/08/2021 =C3=A0 10:33, Andreas Schwab a =C3=A9crit=C2=A0:
>> On Aug 23 2021, Christophe Leroy wrote:
>>=20
>>> __NR_exit is nowhere used. On most architectures it was removed by
>>=20
>> ITYM __NR__exit, which is what you are removing.
>>=20
>
> Indeed.
>
> Michael, can you fix when applying or do you prefer a new patch ?

I can fix.

cheers
