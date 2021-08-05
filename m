Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDEB53E0C32
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 03:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238038AbhHEByz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 21:54:55 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:57651 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231771AbhHEByy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 21:54:54 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 8052A5C0066;
        Wed,  4 Aug 2021 21:54:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 04 Aug 2021 21:54:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=0m0kND
        DSKnw2s+k1hnku4qEezhE8ScVFX1ntU+XniXg=; b=knqJzrLyBc06hkq/6DEiDY
        E1RzWWvBo64ohEcPw3wY+7SchZgZtjCArjUp7i2SCqyc0Dp71sINPDWPraLECbMK
        VeDTFROZYd3tdV1ruepqgKYAbD7KAr4mirhUOVcAlx+gTCwJw1T6zbgG+h/Vyxfc
        XW64kUy+yEyXdtZ0aoL3SmkDMMdsq4IIhRLcndjdb+X05g/XpE6c7EbjMt/P8bAV
        7GufJq8GB/MJJtH9EvUqW4ulktMPEi/RkbiOEL9l1lGY34rIuvLczw9Nuz9QeBce
        QOGCsUYg2oEJCL1P8nq+nhZxEfrjUyX7kTATqNrpB0AEbyU5lwTYlpe76rcneHfg
        ==
X-ME-Sender: <xms:3kQLYV_beL8Txg50zjCbBr_AdjIHpZtLm5Xd2TRjZK9-Xwt568VBKA>
    <xme:3kQLYZvdFgHaPUhsz7GXa-6-xgNWKt0ni8OsnBz5OSn8plYzwULEaVTmegxyHaRb1
    sgfBH75f5knwlXWu9U>
X-ME-Received: <xmr:3kQLYTD1Ga6uQ7v7aIBRtmfDaVUc6h-RGxj9Wi_EyRPWT-kK4QbUdJbfu3K9k5Of8GvmmjGtxFlzH8j3Nw-T72eco3obXr1Hi80>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrieekgdeglecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcuvfhh
    rghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtth
    gvrhhnpeekveevtdekfedtfefhvdfgleelfefhtdefieetjeejvefghfdufeejkeehgfeu
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepfhhthhgrihhnsehlihhnuhigqdhmieekkhdr
    ohhrgh
X-ME-Proxy: <xmx:3kQLYZfxeWDzsnyThlawJtyMPXI_ipu4Q4ULEcgq3BZXPssaerq8mA>
    <xmx:3kQLYaNLcYhtINzzLodHyUCL6eR2L-dVU3zbE5kHK7cvljlbphGI2A>
    <xmx:3kQLYblCXHfrNMviz0mPN-0Ma81Va7iArdeGoVlKknhxYiD1sfC3fQ>
    <xmx:4EQLYXpdsWTXex6bQgoj8PSXM81N7BFp5zaNNMCFpxz5CMCa3_7Zfg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Aug 2021 21:54:35 -0400 (EDT)
Date:   Thu, 5 Aug 2021 11:54:29 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, userm57@yahoo.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/32s: Fix napping restore in data storage interrupt
 (DSI)
In-Reply-To: <b04a90a9-9d62-2192-f896-ea99be911604@csgroup.eu>
Message-ID: <cec92a8a-34a0-6c5c-20e1-7de7d768a596@linux-m68k.org>
References: <731694e0885271f6ee9ffc179eb4bcee78313682.1628003562.git.christophe.leroy@csgroup.eu> <ce20d16c-b0b2-94c-3e22-794d95c376b@linux-m68k.org> <b04a90a9-9d62-2192-f896-ea99be911604@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 4 Aug 2021, Christophe Leroy wrote:

> 
> This patch is related to the bisect you did that pointed to 4c0104a83fc3 
> ("powerpc/32: Dismantle EXC_XFER_STD/LITE/TEMPLATE")
> 
> I think maybe the starting point should be to (manually) apply the patch 
> on top of that commit in order to check that the bug to leaded to 
> pointing that commit as 'first bad commit' is now gone.
> 

Stan has now confirmed this. He applied this patch on top of 4c0104a83fc3, 
and it did indeed resolve the bug that 'git bisect' isolated [1]. Thanks 
Christophe.

[1]
https://lore.kernel.org/lkml/666e3ab4-372-27c2-4621-7cc3933756dd@linux-m68k.org/
