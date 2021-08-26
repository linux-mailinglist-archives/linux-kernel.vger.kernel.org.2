Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F473F8DF7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 20:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243347AbhHZSko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 14:40:44 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41626 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243344AbhHZSki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 14:40:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DqBauNYZguy26YC5MxjDf0SISmgxD/sdSKlavWitRc4=; b=WtZVI4ez8vSSahSqKdG+DaiPN3
        4ORAroBimZJZQ6sh2vFaN5c95MolkLoZ59ZjGFLi5Iqkl79WPrps7LZ8sV5J2tEkZJFG1Q1IGvoKp
        5vSTGvVlhkRhbFL8g6HG6GKEbvzn5Tk3jqfc+u7hp8vm6l1glbS06HjQFJN26VZS6ca0=;
Received: from 188.30.109.46.threembb.co.uk ([188.30.109.46] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <broonie@sirena.org.uk>)
        id 1mJKHs-00FYPH-M2; Thu, 26 Aug 2021 18:39:40 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 44CD4D14302; Thu, 26 Aug 2021 19:39:38 +0100 (BST)
Date:   Thu, 26 Aug 2021 19:39:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mark Hsieh <mark_hsieh@wistron.corp-partner.google.com>
Cc:     alsa-devel@alsa-project.org, cezary.rojewski@intel.com,
        kai.vehmanen@linux.intel.com, pierre-louis.bossart@linux.intel.com,
        mac.chiang@intel.com, lance.hou@intel.com, brent.lu@intel.com,
        bard.liao@intel.com, liam.r.girdwood@linux.intel.com,
        yang.jie@linux.intel.com, perex@perex.cz,
        linux-kernel@vger.kernel.org, mark_hsieh@wistron.com
Subject: Re: [PATCH] [v3] ASoC: Intel: sof_rt5682: Add support for max98390
 speaker amp
Message-ID: <YSff6gkGN/Rk9CzU@sirena.org.uk>
References: <20210826103032.22262-1-mark_hsieh@wistron.corp-partner.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BMVgk7TXFPHhMYjb"
Content-Disposition: inline
In-Reply-To: <20210826103032.22262-1-mark_hsieh@wistron.corp-partner.google.com>
X-Cookie: Where does it go when you flush?
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BMVgk7TXFPHhMYjb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 26, 2021 at 06:30:32PM +0800, Mark Hsieh wrote:
> Configure adl_max98390_rt5682 to support the rt5682 headset codec
> and max98390 speaker.

This doesn't apply against current code, please check and resend.

--BMVgk7TXFPHhMYjb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEn3+kACgkQJNaLcl1U
h9BLBgf+OvWq0XpMKC11U1vR44hq1uC4BXJlWk5/1fdNBmO522bnvEn+YLni/tZa
U+NoTKO7DUDxMEh4mAx99IGkkBQCiFyw1n1kfu/KdQMNxXtKJAM+UX7u/gFTH4fM
8GYJSoZgmq7rZ6kLxnGic0Wgu5fsaJ3jXZxGKnzzWD2caqa/WAw8rCQkr3oEWGs7
qrFfgxdth/mAGLa9KhNbw+Tz/qLtn3hBYLenkhyS65Pm0wpOpW1ypAioxFC+g/Vn
8kZHPIZUABOKDMTMQmnJfms3wDdDiixgCaS3iexaJmaLY0Xdjq2o1VXhphDL9MnN
T8IgldjErh2Rd/yxTL2ZQhF1YB7Acw==
=pRs0
-----END PGP SIGNATURE-----

--BMVgk7TXFPHhMYjb--
