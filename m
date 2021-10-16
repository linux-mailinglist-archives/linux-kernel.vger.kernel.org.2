Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA96430304
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 16:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244414AbhJPOa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 10:30:27 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:35173 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244409AbhJPOa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 10:30:26 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id B515E5C0151;
        Sat, 16 Oct 2021 10:28:17 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute1.internal (MEProxy); Sat, 16 Oct 2021 10:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm2; bh=GRVN2QCx3h8Dn7GgNwjavdJhWEpR
        Qp2xWgOHeVQLVvo=; b=YvuFEt51buyLnuxSDUrv9YRlgyQVfGP4h+/v/1tFppYT
        MQf1RXPnyZeGX019XpTTlHxZz5+xKOQZ31iQlk4xJVATrfImPI0YVMXjRtZOPs2t
        aHTmXjypvIw9AKLW1+Bf7fAwWBxmcjwOVnPE1hr9x2n5CRLYVQmtRbZMp8ku9moC
        23uh/sakaRP5HPrng4k9L3qnGnhicX7KfeMXIYBwGQUIDdaqrQPaGt+73nB0Ju+V
        bJLoSp+l8/1kM86sM1q2nvKUfia/ddZ9AEGTYejGiZrfI2I5HpP2oR/tnUrl/ApL
        oNxAZaUDPMBgS5j9v4mCaJhRkR2yLnyy0fV2fyGzng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=GRVN2Q
        Cx3h8Dn7GgNwjavdJhWEpRQp2xWgOHeVQLVvo=; b=VbZSpCJdYtTZ00mqc5fXsa
        KQN88RDWOYKti20ui4VnDo7OM+0JBh9FPiCqaOP7/YL+NdSuNXoz8e0a+OS5T0eg
        FyyVP/+rlUzzuYhKK/AcEBwmVhGlgIfANsIA688mpLQ7SBKU60E+E2Rb3MB/PoCn
        GlO+yN+bVCW6uJCmi9W3dOoFrDNrXidhTq23RMP78op5V0mhj6TOg0oe7CjEkDm6
        J0JH3rCOGxIaS6jlttTAbfzrC3hjG/ypZIq3pJrfDVGPEjPbkBnCtYOrTdgXaga8
        JXTFjMpfO8rZVlxg17D7bv1f1dquMslNIJvnaGPT/x27Vn0mPWoieynx6k4SwLpw
        ==
X-ME-Sender: <xms:gOFqYcCU1r8z0YLfxjeSZYxcOQ9RvmvQcM2_pzcwuHZW66HWswCXqg>
    <xme:gOFqYejx92BPMSd6pIPgYY0Ywi4uR8tiGgFzuf-Lflwyh8uK-hf-zYH8T-jycraB5
    HOiIILgxn-FxKcoq0s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvdduiedgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
    feekffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:geFqYfnHKDbVwP-Ut9NGO3JARMYuHQnpFC_ewqsZNGl8moD_ysJSGA>
    <xmx:geFqYSxHdj8XZg39Y5phltkZ1BCg21WuEfA1dSegpiMc4hN8yytI_g>
    <xmx:geFqYRSaIUqFDMxpApzgL2Cp3_MdV2lOKE4CRLNTYqoLDTR3ZqdP7A>
    <xmx:geFqYfMFw47j06gBMUM16CG5VpaDCQQM50U9XD_iecx5H3xnSFOIVA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id EB7802740063; Sat, 16 Oct 2021 10:28:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1345-g8441cd7852-fm-20211006.001-g8441cd78
Mime-Version: 1.0
Message-Id: <df7d123b-772d-4969-b091-78b09b6497b9@www.fastmail.com>
In-Reply-To: <20211013063441.29888-1-wanjiabing@vivo.com>
References: <20211013063441.29888-1-wanjiabing@vivo.com>
Date:   Sat, 16 Oct 2021 16:27:55 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Wan Jiabing" <wanjiabing@vivo.com>,
        "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        "Joerg Roedel" <joro@8bytes.org>, "Will Deacon" <will@kernel.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
Subject: Re: [PATCH] iommu/dart: use kmemdup instead of kzalloc and memcpy
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, Oct 13, 2021, at 08:34, Wan Jiabing wrote:
> Fix following coccicheck warning:
> drivers/iommu/apple-dart.c:704:20-27: WARNING opportunity for kmemdup
>
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  drivers/iommu/apple-dart.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Looks good to me, thanks!

Acked-by: Sven Peter <sven@svenpeter.dev>


Sven
