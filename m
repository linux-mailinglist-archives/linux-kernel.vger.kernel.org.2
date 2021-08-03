Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64FF13DE3A6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 02:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbhHCAng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 20:43:36 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:52697 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232311AbhHCAnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 20:43:33 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 05F325C0167;
        Mon,  2 Aug 2021 20:43:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 02 Aug 2021 20:43:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-id:content-type:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=rTy3dKsPoajPmNli8ExRtsgRJClAC4+cHirejhq0af0=; b=gHaOx2og
        7UxXtoTnVvlBJFD4rhjsp2UJzdXIfpvua6QYeqYCW2YgY/e3hv4Nw36t/S1lYSFr
        U0KM0VFqiXYVi31udYjYGyJUD52E2PbLvprNuq6eoV5eOm7lUqLL0fZyQf2ijPRW
        LB8i/V9bTp83/k/+FNHobB3gXPzd1dLAKgu+mgvFyMqZwa/TEpWpCtoq5aW8GosT
        +jfkGmbUoCnBjH9XhQ163V1R25hkphTuG/AtG8IUdh64gbdAh1amM1BCWwMHn4Fh
        J8rlSSWmXtgRCS7rZqWll3bJWLn3ALJHJ0tIkKyfVoBUMqFPRxLmX73WhmlkSL9X
        Bjtga70UP5z43A==
X-ME-Sender: <xms:KJEIYf4vBGAfEVA5ewHcBKsN7xoyOKOLRlrccAJFQNz-eLlgu9KhGQ>
    <xme:KJEIYU6_BG_KyuAW0R1NnNsZw-B9NB9PFIOWO9Dwpq0ptAveGZUXl9KpneUNfOre3
    wf_NPLQM3cDcWZ2ic0>
X-ME-Received: <xmr:KJEIYWfgLYCO1Xl4fz7yTSxsTi7Wu_R4vUqgq9dWvgqoGxuNyjL9BweYmq5pYcM_pBvW5VQKxZbBdX3A5xWsCg9tzixMVQyRCP8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrieefgddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvufgjkfhfgggtsehmtderredttdejnecuhfhrohhmpefhihhnnhcuvfhh
    rghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtth
    gvrhhnpeetvedvueduheehkeejhedukeevheejkedvffdugeehkeffkeekgfehkedvleel
    teenucffohhmrghinhepfedvrdhssgenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehfthhhrghinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:KJEIYQKC_EDIXx5thghUnVKWJCBBfF6jZUG5XNYTMB_kc-Bqjm4hKw>
    <xmx:KJEIYTLrbFr5a-aT0AOLpzvw5mCcXSlYi9n0-gB7Xe39AfuqCPngJA>
    <xmx:KJEIYZysrQryQ8HXTPEoc9rErzUNVJKmLVqxynNuCkHXspzj3Ok8Dw>
    <xmx:K5EIYZjz_XMXWroheeZZ8i7aJHLFN8vap22H5P22yvZ5igJMuokyUQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Aug 2021 20:43:17 -0400 (EDT)
Date:   Tue, 3 Aug 2021 10:43:13 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Stan Johnson <userm57@yahoo.com>,
        LEROY Christophe <christophe.leroy@csgroup.eu>
cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Nick Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v3 31/41] powerpc/32: Dismantle
 EXC_XFER_STD/LITE/TEMPLATE
In-Reply-To: <9b64dde3-6ebd-b446-41d9-61e8cb0d8c39@csgroup.eu>
Message-ID: <216b7b17-28f4-7976-c338-1dedeba14ce7@linux-m68k.org>
References: <cover.1615552866.git.christophe.leroy@csgroup.eu> <ca5795d04a220586b7037dbbbe6951dfa9e768eb.1615552867.git.christophe.leroy@csgroup.eu> <666e3ab4-372-27c2-4621-7cc3933756dd@linux-m68k.org> <20210731173954.Horde.fV2Xkw7-sxjG0DUcZ_JO_g3@messagerie.c-s.fr>
 <1d601b7c-1e39-e372-39a5-e1e98e56e2a5@linux-m68k.org> <9b64dde3-6ebd-b446-41d9-61e8cb0d8c39@csgroup.eu>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="-1463811774-1281028418-1627951377=:28"
Content-ID: <11d1109a-eda8-9252-f7e-84519fa8d55@nippy.intranet>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811774-1281028418-1627951377=:28
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <86b5d84-d157-9cb8-3a40-99b6e82a91fa@nippy.intranet>

On Mon, 2 Aug 2021, LEROY Christophe wrote:

> Le 01/08/2021 =C3=A0 03:21, Finn Thain a =C3=A9crit=C2=A0:
> > On Sat, 31 Jul 2021, Christophe Leroy wrote:
> >=20
> > > >=20
> > > > Stan Johnson contacted me about a regression in mainline that he
> > > > observed on his G3 Powerbooks. Using 'git bisect' we determined tha=
t
> > > > this patch was the cause of the regression, i.e. commit 4c0104a83fc=
3
> > > > ("powerpc/32: Dismantle EXC_XFER_STD/LITE/TEMPLATE").
> > > >=20
> > > > When testing 4c0104a83fc and all subsequent builds, various user
> > > > processes were liable to segfault. Here is the console log that Sta=
n
> > > > provided:
> > >=20
> > > Hi, i will be able to look at that more in details next week, however=
 I
> > > have a few preliminary qurstions.
> > >=20
> > > Can you reliabily reproduce the problem with the said commit, and can
> > > you reliabily run without problem with the parent commit ?
> >=20
> > Yes and yes. (I already asked Stan to establish those things before I
> > contacted the list.)
>=20
> I think I found the problem with that commit. Can you retry with the foll=
owing
> change:
>=20
> diff --git a/arch/powerpc/kernel/head_book3s_32.S
> b/arch/powerpc/kernel/head_book3s_32.S
> index 0a3d7d4a9ec4..a294103a91a1 100644
> --- a/arch/powerpc/kernel/head_book3s_32.S
> +++ b/arch/powerpc/kernel/head_book3s_32.S
> @@ -299,7 +299,7 @@ ALT_MMU_FTR_SECTION_END_IFSET(MMU_FTR_HPTE_TABLE)
>  =09EXCEPTION_PROLOG_1
>  =09EXCEPTION_PROLOG_2 0x300 DataAccess handle_dar_dsisr=3D1
>  =09prepare_transfer_to_handler
> -=09lwz=09r5, _DSISR(r11)
> +=09lwz=09r5, _DSISR(r1)
>  =09andis.=09r0, r5, DSISR_DABRMATCH@h
>  =09bne-=091f
>  =09bl=09do_page_fault

That patch doesn't apply to mainline. This version might help.

diff --git a/arch/powerpc/kernel/head_book3s_32.S b/arch/powerpc/kernel/hea=
d_book3s_32.S
index 764edd860ed4..68e5c0a7e99d 100644
--- a/arch/powerpc/kernel/head_book3s_32.S
+++ b/arch/powerpc/kernel/head_book3s_32.S
@@ -300,7 +300,7 @@ ALT_MMU_FTR_SECTION_END_IFSET(MMU_FTR_HPTE_TABLE)
 =09EXCEPTION_PROLOG_1
 =09EXCEPTION_PROLOG_2 INTERRUPT_DATA_STORAGE DataAccess handle_dar_dsisr=
=3D1
 =09prepare_transfer_to_handler
-=09lwz=09r5, _DSISR(r11)
+=09lwz=09r5, _DSISR(r1)
 =09andis.=09r0, r5, DSISR_DABRMATCH@h
 =09bne-=091f
 =09bl=09do_page_fault
---1463811774-1281028418-1627951377=:28--
