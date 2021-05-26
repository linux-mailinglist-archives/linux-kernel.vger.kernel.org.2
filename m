Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C44E839216B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 22:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235005AbhEZUXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 16:23:43 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47866 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234915AbhEZUXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 16:23:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=v/NuGg3MB4oiZfDhpuhNhKlAfNFXtF+3rZwIPQvb1C8=; b=w4J/K5d2E1O83vCyW3esSwTLXz
        8Z8lm5rKtxzqN9doPkEIIysL7KWpyrzbfx4FykJy12jc3UvDift2t4YGh7FLzcsa9ZOC35wPsUGLW
        avjC5yUl8XWN9lnjGOZ0c9tPW69wdWofepAv66+uda/ew8Awq1dWipT4/P9IQRUAbAR8=;
Received: from 94.196.90.140.threembb.co.uk ([94.196.90.140] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <broonie@sirena.org.uk>)
        id 1lm02H-0067nc-L2; Wed, 26 May 2021 20:21:49 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 4AD6CD0E9E5; Wed, 26 May 2021 21:21:48 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, james.schulman@cirrus.com, perex@perex.cz,
        david.rhodes@cirrus.com, YueHaibing <yuehaibing@huawei.com>,
        tiwai@suse.com
Cc:     Mark@sirena.org.uk, Brown@sirena.org.uk, broonie@kernel.org,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] ASoC: cs42l56: use DEVICE_ATTR_WO macro
Date:   Wed, 26 May 2021 21:21:46 +0100
Message-Id: <162206049350.1916760.8418619085166876436.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210524114503.26460-1-yuehaibing@huawei.com>
References: <20210524114503.26460-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Brown,,, <broonie@kernel.org>

On Mon, 24 May 2021 19:45:03 +0800, YueHaibing wrote:
> Use DEVICE_ATTR_WO() helper instead of plain DEVICE_ATTR(),
> which makes the code a bit shorter and easier to read.

Applied, thanks!

[1/1] ASoC: cs42l56: use DEVICE_ATTR_WO macro
      commit: 3ef6253cd0805d281eacbbd6a21e822ef4c3fef5

Best regards,
-- 
Mark Brown,,, <broonie@kernel.org>
