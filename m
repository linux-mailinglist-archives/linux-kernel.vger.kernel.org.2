Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF8544CE31
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 01:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbhKKAXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 19:23:14 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:49217 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230210AbhKKAXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 19:23:13 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 88D4C5C026E;
        Wed, 10 Nov 2021 19:20:24 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 10 Nov 2021 19:20:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-id:content-type:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=Z4Xz+6xEcDj+0NeWLO8w8RSF9W7GJQNkEgunDvZ8ejc=; b=LoxML2ro
        Ehj8/VSZcVweJFB/ZvPKg3JM1pIZW6A2wiRKtNOtjI05EnEX8KiFtxooXHCDTjQE
        JXm7iCs7AjfASPX3RBO//ZQUANq3n7HmUPwSIV8V2IFzNQ1x5ek5pLioyFaKeYac
        go/3/DAPVQa6kAlrvHNTXr8A7TN1hRN9fjdtPVOyNHFYUh1qK15JHeEQCs9QOZ/0
        S2WHCfqV+LCluq8czo/BJW4ClZtP8s717d535enu1GzuL8KZMv9U/FEuyMyzKEVu
        1Rgi/UTOucP1OlnSAojL47rvBQo0vbTtV1/JwHj8hdoEAF2CxZrJKXJkHLX1OrFH
        weqZeKaMx3pSNg==
X-ME-Sender: <xms:x2GMYeE6NF6OHu-L4jwCw3s16c-QN11vutWueBd49ckXmS8h3mKvtg>
    <xme:x2GMYfVThbaClyOX_2TrgD5qPDlY83IE-dxmF21yMlMxFtSWE-TqFu3L_mGm8o77v
    0_vMmXlxkbHL-iSIz8>
X-ME-Received: <xmr:x2GMYYI1b1OylmwylytNZze05zaR-D_JNAwktZEZhdaSo4GH0jjYGEhFXtaXW3UY4OEum7Q8b2SZO2QS-W29WHLPmwX30vv1CYs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrvddtgddujecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvufgjkfhfgggtsehmtderredttdejnecuhfhrohhmpefhihhnnhcuvfhh
    rghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtth
    gvrhhnpeefffejiefgheevheefvefhteeggfeijeeiveeihfffffdugfefkeelfffhgfeh
    vdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfth
    hhrghinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:x2GMYYEAKMVV2GnHyC6xYNE8QeCEDWo-wWFeqMSdv7a_nMFFBRH33w>
    <xmx:x2GMYUXhq3Ox4bPzudDSiovrZ4jQ8F5HNgz3fNWrfVDEDsaZ_3ERDg>
    <xmx:x2GMYbOEFa9xZ2xeaxehrs63YydfXYF_p68e9F-u2V-1CDrFQOTTGQ>
    <xmx:yGGMYSxNNVAB24hZtwbj9lgdCHnRKsEiIxdVCez8h-D2fe4R0szZwg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Nov 2021 19:20:21 -0500 (EST)
Date:   Thu, 11 Nov 2021 11:20:09 +1100 (AEDT)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "Christopher M. Riedl" <cmr@bluescreens.de>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: Fix sigset_t copy
In-Reply-To: <ed04d4a1-7a60-ee39-f64b-203b299e8875@csgroup.eu>
Message-ID: <cb5f10c3-5630-547-23c1-66a44d7c8892@linux-m68k.org>
References: <08bbe7240b384016e0b2912ecf3bf5e2d25ef2c6.1636501628.git.fthain@linux-m68k.org> <ed04d4a1-7a60-ee39-f64b-203b299e8875@csgroup.eu>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="-1463811774-88831904-1636589924=:27"
Content-ID: <5c1556be-eba3-979a-fca0-533951763259@nippy.intranet>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811774-88831904-1636589924=:27
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <48a2d42c-41dc-69ad-20-46aed9554e35@nippy.intranet>

On Wed, 10 Nov 2021, Christophe Leroy wrote:

> Le 10/11/2021 =C3=A0 00:47, Finn Thain a =C3=A9crit=C2=A0:
>=20
> > Christophe, I hope this change is the one you wanted to see upstream=20
> > (?). If it is acceptable please add your signed-off-by tag.
>=20
> I'm on holidays, I was planing to handle this next week.
>=20

OK. I'll leave it with you.
---1463811774-88831904-1636589924=:27--
