Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9354139216D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 22:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235248AbhEZUXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 16:23:48 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47870 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234625AbhEZUXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 16:23:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Flou5G2qRaFN1RBhouhO7VrKDptlN46NUyosvJ2fVv4=; b=Xj6NPsaCLxk1j6IFvumjuYSNlb
        hyJTZgAJ7i/J9gVHq9N/FzIwjgU4vD5DZLo7auhP9bGyebb6/o4dPlfiarHbWlBI31PUChcmfo+zy
        bWW0Sr6DI5Gwr7MLs8HASEqap9rH4hysHLOBdVNL0ka/Vh2HosSYKJKykB7Ygdd4Aq8A=;
Received: from 94.196.90.140.threembb.co.uk ([94.196.90.140] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <broonie@sirena.org.uk>)
        id 1lm02H-0067nb-KA; Wed, 26 May 2021 20:21:49 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 3E2D7D0E9E1; Wed, 26 May 2021 21:21:48 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, YueHaibing <yuehaibing@huawei.com>,
        tiwai@suse.com, perex@perex.cz
Cc:     Mark@sirena.org.uk, Brown@sirena.org.uk, broonie@kernel.org,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] ASoC: wm8962: Use DEVICE_ATTR_WO macro
Date:   Wed, 26 May 2021 21:21:42 +0100
Message-Id: <162206049350.1916760.16325805496121481390.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210524114753.39544-1-yuehaibing@huawei.com>
References: <20210524114753.39544-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Brown,,, <broonie@kernel.org>

On Mon, 24 May 2021 19:47:53 +0800, YueHaibing wrote:
> Use DEVICE_ATTR_WO() helper instead of plain DEVICE_ATTR(),
> which makes the code a bit shorter and easier to read.

Applied, thanks!

[1/1] ASoC: wm8962: Use DEVICE_ATTR_WO macro
      commit: d04260393ea0ded33448c1fae944cf86c14da994

Best regards,
-- 
Mark Brown,,, <broonie@kernel.org>
