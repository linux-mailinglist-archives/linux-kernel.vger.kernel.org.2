Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6287D42C08C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 14:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbhJMMvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 08:51:42 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:56301 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231294AbhJMMvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 08:51:41 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 864845C01FE;
        Wed, 13 Oct 2021 08:49:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 13 Oct 2021 08:49:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=fm1; bh=
        Nezv3xX9C+NZ3LE8aAUySU2l+Ulj3A/5fhcFrlbpAkA=; b=IQlOZL6hhDVF+Sfj
        b5SD7OxXBACGfPkmchisG25DHwxpjtbisDRlLJlUm8m69Vu7oAliOLmgMApubyAJ
        gUyoF3nIVZVfRDgjizoA7VKzWJOEwus06uaUNlBTSTHmO5cbK6yE5O0fnBwgUPB5
        XC2N+NMhKcYDmIjze9dXXD+YfyNAe7ZhaIUFBygcCm6V6QlhnLVYe9oxleoYfosZ
        GeQtzN4rfAWGCGYrINC0vH+0sdZsGIlTbEXgFefuXj+jdU5NPjmecJuY7p6wfZTm
        dqy2skZkRxPYAITD3r4szmS7/aybY92Bat6oXda+T3W7vSt+naBgcOmWSs94IkMq
        sA2a5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=Nezv3xX9C+NZ3LE8aAUySU2l+Ulj3A/5fhcFrlbpA
        kA=; b=SW7QpByU2qd7Y+kokRmuk8uyTjRhevFld6UF/vcxtI4ml/5M95wBW6rSJ
        PDHh+OOH2mcMwO/Osnqd0N4UxlMb3Zpif8on9FGsUn7yzMFUKj0i4rP02ftgxZ7I
        wxfWmcith79pZa7HBRfJ3ZSEXc5nQjfzsC5Fo0KKEHarfFyJYspwo7facUjLg2Ln
        20WRghoRfzgX+pQDpFZNzMxiiigh7i66h92rT52G1YmH4c2dz9sTfBZrcty9rtLU
        0b74Z9KH/RFWBNcQgzJtijhx1SZ5qPbeDRBrf47fEh7b+j8hNZtCpGXZz2xIhnAj
        xvVvA0AKkQEIUPXTtiqjac7kQ76PA==
X-ME-Sender: <xms:4NVmYf70s91LlOf0NTVzdG27gPJskaNC0XRZQlkGjLTakoUuSMSBzw>
    <xme:4NVmYU6g2XkvKA6LzSb-Tb1lEsBte_GyahvbkQxE1CpjI26kd5nC5LHwZjWXbfs_j
    22CBYCNPlZEo3F_7Jo>
X-ME-Received: <xmr:4NVmYWet98qPYshPq0vUzPb9Cpwy0tr_gKT_3VDxfI67-SlOWXRmj2HTNmIYZVv42oPv7Kj3GUZKdx41k4Vll7lSm_PthdAHIiG7z-TZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddutddgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeejuefggeekfffgueevtddvudffhfejffejjedvvdduudethefhfefhfeeg
    ieekkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:4NVmYQLLFmPd0BZaG7KqQ-yQeo0cjh0bDT_crWesPnQ-kfJL-WRvNg>
    <xmx:4NVmYTIANMlVT6A11gQcLVZ_hgTQ95rRqET2qTWbu9dRImYJpWl6Ww>
    <xmx:4NVmYZydT269C8DTez7242PBkk1m0FzqlBZMi366htxiJ5yuJmsTrA>
    <xmx:4dVmYZjsVU5FsflMMV-sl9GL_1nh791MoAbm0vDGWW0cyLK_f5h2og>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Oct 2021 08:49:36 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     mripard@kernel.org, wens@csie.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH] bus: sun50i-de2: Adjust printing error message
Date:   Wed, 13 Oct 2021 14:49:28 +0200
Message-Id: <163412936102.160436.18173629691350762862.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211010071812.145178-1-jernej.skrabec@gmail.com>
References: <20211010071812.145178-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Oct 2021 09:18:12 +0200, Jernej Skrabec wrote:
> SRAM driver often returns -EPROBE_DEFER and thus this bus driver often
> prints error message, even if it probes successfully later. This is
> confusing for users and they often think that something is wrong.
> 
> Use dev_err_probe() helper for printing error message. It handles
> -EPROBE_DEFER automatically.
> 
> [...]

Applied to local tree (sunxi/drivers-for-5.16).

Thanks!
Maxime
