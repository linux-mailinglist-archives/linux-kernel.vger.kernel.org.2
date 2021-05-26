Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3957139216C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 22:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbhEZUXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 16:23:45 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47868 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbhEZUXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 16:23:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FR4Jrc6UzDYcZneMNMkrrs/GKN+Fv8BlCPwuM+IslNs=; b=TM1mcR3jz+pbT0+xUzPbzVI5pz
        vjlW+weomgBYv5VxfPqNWTRiHlAssqwTe64OIZUbIDXjhVKcH0FflrPsUVm0faDv0kcBPgsyatCC2
        bdo9UYvixrXrMkhZs1AVGp8p+jF4om7Lpf0tFhE9+gqKIDjoObLihUppyYCt/wAVTCHQ=;
Received: from 94.196.90.140.threembb.co.uk ([94.196.90.140] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <broonie@sirena.org.uk>)
        id 1lm02H-0067nf-Pt; Wed, 26 May 2021 20:21:49 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 444BBD0E9E3; Wed, 26 May 2021 21:21:48 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, james.schulman@cirrus.com, perex@perex.cz,
        david.rhodes@cirrus.com, YueHaibing <yuehaibing@huawei.com>,
        tiwai@suse.com
Cc:     Mark@sirena.org.uk, Brown@sirena.org.uk, broonie@kernel.org,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] ASoC: cs43130: Use DEVICE_ATTR_RO macro
Date:   Wed, 26 May 2021 21:21:44 +0100
Message-Id: <162206049349.1916760.15392128119414962686.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210524114017.18672-1-yuehaibing@huawei.com>
References: <20210524114017.18672-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Brown,,, <broonie@kernel.org>

On Mon, 24 May 2021 19:40:17 +0800, YueHaibing wrote:
> Use DEVICE_ATTR_RO() helper instead of plain DEVICE_ATTR(),
> which makes the code a bit shorter and easier to read.

Applied, thanks!

[1/1] ASoC: cs43130: Use DEVICE_ATTR_RO macro
      commit: 6405941e6884dac80f836acfc7ec52089ea6aa99

Best regards,
-- 
Mark Brown,,, <broonie@kernel.org>
