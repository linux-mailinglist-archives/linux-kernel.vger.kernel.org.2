Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07F66456DEE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 12:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234926AbhKSLEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 06:04:04 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:37621 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232004AbhKSLED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 06:04:03 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 0407C5C00D4;
        Fri, 19 Nov 2021 06:01:01 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 19 Nov 2021 06:01:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=fm1; bh=
        aqV1j+PWhw1EcvbQXT1J3L/THztodbDSfacb7pAVugM=; b=ftbKAxf07PobC8tc
        3xnTmS8A5B+lTLU5mM6sNe0Cl17dgo+Hfm8byyKLzo/D3VXtRpWUZlBtlN6+5qfB
        J4jOlfRjj2JD6mUbSeUyVfg+8hhkDxL7yeoJFZGc0g6Dhp7HGYbf9t6YrERVO/Ad
        TqRGbafDqh5BmIUuCvnHyVH5gB8UkBgdw43nl2BPk4GI3CW1cKMKCk0mgcfOBdjB
        JOtD5/AVeBa2oxOPNVt+/SsvQRG84nWJChTt7suSCZOzfrDfXrWoRCVYOFpHg4j8
        fw9dKu9zDIsGpYQBhro2Cr0Lm29hb+DFFxBYmm0Zx7uhB8Sche/0uNXeWe7YKlWn
        8JYY+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=aqV1j+PWhw1EcvbQXT1J3L/THztodbDSfacb7pAVu
        gM=; b=H+4YAfIklh5jmWWnXafnjUsLSKbg8zIQ6nqM9avIZ5UkAj8TY3VrP5ytF
        xYsa1YbPh/ZRzZRt0V9Kz9cScuC+duehuhZJO6WLvLjgq4ywoah2FGJGFsILV4mF
        7QEzjMao7pgC3svRBzSFxZlMKCtXwwzlrIQqJTR8HBNndKlJFK29bRfgJ++21AUY
        5u00wP5Hk0wAK7PvD8FCfbNszvC8c0H37PLwUjSBXOIfUIQR616EK8xrPnW5mX1R
        96jhNdiGIiq1Y8qCa930xlOzvkaib6c4uKNvDffud72i6EUQcz++E+fYpeanR1bx
        KgJzQOM/DjqiV8sA9Gyq3Tu5HrMtg==
X-ME-Sender: <xms:7IOXYTk49j4kro134d7Of7BnHXnls_ilMt4e_L-OuRNdSPxr9Q_Nrw>
    <xme:7IOXYW1C249-KZMTjIelZ0JsWVVlmHFBuPXyXNfNcy-8ZQaUhKI-OBsI_1MSWQENN
    unxs3yhG3atuiMQVQc>
X-ME-Received: <xmr:7IOXYZqO5ffRpQ5pE25xuLk1GXQXW2nJqykQpCU23Ev9mo4TwVI64sJEKq4UwSFZUhTCa1MsaR0aNf_6kN4PKsGEFcxHASdm1e6jd0_3OVc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrfeekgddvvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepjeeugfegkeffgfeuvedtvddufffhjeffjeejvddvudduteehhfefhfefgeei
    keeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:7IOXYbl_txF_lipHZxwMYl3vuVcleg7hb0kA2rlX1MuoZCdXUhRlkQ>
    <xmx:7IOXYR1csdC__J0iMFBBRpXe10cLUSPi3Xte1rlcON4tGV5KIAcGdg>
    <xmx:7IOXYavi6MWKPRZlRoEz5smVrZ_vI6cxquVWMDCjK0ISsMleY8uk5g>
    <xmx:7IOXYelB_ig3WITGQ5wJDq0Mtj9d2bGg3r69G3qXL02K80cDdOPY2w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Nov 2021 06:00:59 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Emma Anholt <emma@anholt.net>
Cc:     Maxime Ripard <maxime@cerno.tech>, kernel-janitors@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH] drm/vc4: fix error code in vc4_create_object()
Date:   Fri, 19 Nov 2021 12:00:56 +0100
Message-Id: <163731964127.830809.14126199659521737361.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211118111416.GC1147@kili>
References: <20211118111416.GC1147@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Nov 2021 14:14:16 +0300, Dan Carpenter wrote:
> The ->gem_create_object() functions are supposed to return NULL if there
> is an error.  None of the callers expect error pointers so returing one
> will lead to an Oops.  See drm_gem_vram_create(), for example.
> 
> 

Applied to drm/drm-misc (drm-misc-fixes).

Thanks!
Maxime
