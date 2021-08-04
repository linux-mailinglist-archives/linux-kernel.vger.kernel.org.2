Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5FF73DFA2A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 06:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbhHDEEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 00:04:51 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33541 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229562AbhHDEEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 00:04:50 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id A363F5C0129;
        Wed,  4 Aug 2021 00:04:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 04 Aug 2021 00:04:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=zhqS3u
        ONZN5n4HL/DQug9GqUIhjPXsIGOz3wxqAvewU=; b=fUJzBzWRskYL9S60bfH0nN
        lHlT1WH1s47IjAf9RZHIzCY1EXzstC7mBp7xEdg2hXQTZLGw90c1MlHxo72NXrrJ
        831Oxc7/1uSrsT/MEL8UqNhsAf/G3sW5UgSm3kgZbr7fY9dEzql41hsA8RDJ9E06
        O4q+ccY+bXnKIuajuDKmuZMX2yrAoyJmL9pZIl0PI4UPOAsvcx4liFZhsh5Y/57Z
        tzNFdELHDY6ZU/2PxEoLem8Hdq+1P4Wk+sxzyjhh/hiNS5Dr94iYLvoqXnln4kE5
        7jGtLCfMqqo0xO2rBpwn0iHyAMmy7dzET/dd8UuIWZN6nJFIPzxnAawfhxyPHU1w
        ==
X-ME-Sender: <xms:0xEKYdGaUUY3wmx4-3xxaJ0R3S-UL8PZDQCX6B_xXK8fXz2JyL0cmg>
    <xme:0xEKYSXNeIBeFsjiV7SBwnzQxRl2UStknKL8IJbdDU7LPEX90mBvWx-5vke6zBzAY
    R8yTViIK65K9H_Emes>
X-ME-Received: <xmr:0xEKYfLuOmePxxdVpdnefipLiSAgLSbB9Cdn9ujzXIV89RcHAUXBV6aNdz5STdoqsik360bs-XgDC7cqJ2A_Iz480ymIBX5sxJc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrieehgdejhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcuvfhh
    rghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtth
    gvrhhnpeffudfhgeefvdeitedugfelueegheekkeefveffhfeiveetledvhfdtveffteeu
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfth
    hhrghinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:0xEKYTGVwE5Vu1vy9aljXPRzMS_sUucpuwEEoa9MfqoK6K6BISC8Hg>
    <xmx:0xEKYTVQedE_425BM7uY-axX9pj6cSp8x9lI14zcb3BMElFnkg9i_g>
    <xmx:0xEKYeNgeZZX-hudjSiytjpeYXWJrhQrt4lcgxJ5p9Xgvh_NIHCa0Q>
    <xmx:1REKYZzLXrEEpa7giA_S1LmbKqUktRaSTdJZmcI6w_0ouJdJI-UeNQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Aug 2021 00:04:33 -0400 (EDT)
Date:   Wed, 4 Aug 2021 14:04:28 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, userm57@yahoo.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/32s: Fix napping restore in data storage interrupt
 (DSI)
In-Reply-To: <731694e0885271f6ee9ffc179eb4bcee78313682.1628003562.git.christophe.leroy@csgroup.eu>
Message-ID: <ce20d16c-b0b2-94c-3e22-794d95c376b@linux-m68k.org>
References: <731694e0885271f6ee9ffc179eb4bcee78313682.1628003562.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Aug 2021, Christophe Leroy wrote:

> When a DSI (Data Storage Interrupt) is taken while in NAP mode, r11 
> doesn't survive the call to power_save_ppc32_restore().
> 
> So use r1 instead of r11 as they both contain the virtual stack pointer 
> at that point.
> 
> Reported-by: Finn Thain <fthain@linux-m68k.org>
> Fixes: 4c0104a83fc3 ("powerpc/32: Dismantle EXC_XFER_STD/LITE/TEMPLATE")

Regarding that 'Fixes' tag, this patch has not fixed the failure below, 
unfortunately. But there appears to be several bugs in play here. Can you 
tell us which failure mode is associated with the bug addressed by this 
patch?

------------[ cut here ]------------
kernel BUG at arch/powerpc/kernel/interrupt.c:49!
Oops: Exception in kernel mode, sig: 5 [#1]
BE PAGE_SIZE=4K MMU=Hash SMP NR_CPUS=2 PowerMac
Modules linked in:
CPU: 0 PID: 1859 Comm: xfce4-session Not tainted 5.13.0-pmac-VMAP #10
NIP:  c0011474 LR: c0011464 CTR: 00000000
REGS: e2f75e40 TRAP: 0700   Not tainted  (5.13.0-pmac-VMAP)
MSR:  00021032 <ME,IR,DR,RI>  CR: 2400446c  XER: 20000000

GPR00: c001604c e2f75f00 ca284a60 00000000 00000000 a5205eb0 00000008 00000020
GPR08: ffffffc0 00000001 501200d9 ce030005 ca285010 00c1f778 00000000 00000000
GPR16: 00945b20 009402f8 00000001 a6b87550 a51fd000 afb73220 a6b22c78 a6a6aecc
GPR24: 00000000 ffffffc0 00000020 00000008 a5205eb0 00000000 e2f75f40 000000ae
NIP [c0011474] system_call_exception+0x60/0x164
LR [c0011464] system_call_exception+0x50/0x164
Call Trace:
[e2f75f00] [00009000] 0x9000 (unreliable)
[e2f75f30] [c001604c] ret_from_syscall+0x0/0x28
--- interrupt: c00 at 0xa69d6cb0
NIP:  a69d6cb0 LR: a69d6c3c CTR: 00000000
REGS: e2f75f40 TRAP: 0c00   Not tainted  (5.13.0-pmac-VMAP)
MSR:  0000d032 <EE,PR,ME,IR,DR,RI>  CR: 2400446c  XER: 20000000

GPR00: 000000ae a5205de0 a5687ca0 00000000 00000000 a5205eb0 00000008 00000020
GPR08: ffffffc0 401201ea 401200d9 ffffffff c158f230 00c1f778 00000000 00000000
GPR16: 00945b20 009402f8 00000001 a6b87550 a51fd000 afb73220 a6b22c78 a6a6aecc
GPR24: afb72fc8 00000000 00000001 a5205f30 afb733dc 00000000 a6b85ff4 a5205eb0
NIP [a69d6cb0] 0xa69d6cb0
LR [a69d6c3c] 0xa69d6c3c
--- interrupt: c00
Instruction dump:
7cdb3378 93810020 7cbc2b78 93a10024 7c9d2378 93e1002c 7d3f4b78 4800d629
817e0084 931e0088 69690002 5529fffe <0f090000> 69694000 552997fe 0f090000
---[ end trace c66c6c3c44806276 ]---
