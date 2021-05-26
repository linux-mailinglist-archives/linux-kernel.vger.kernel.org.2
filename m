Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3DC39216A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 22:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235026AbhEZUXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 16:23:38 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47862 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234695AbhEZUXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 16:23:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9o/+5u5tA1kuPdlelQMV9ZLE9NfmsMXW6ysFycWxE5k=; b=luw4CGcqa2WUbj53UXFQ2RLHNr
        iM6w4H4Fr0+H1rvaecpsz/1YOQGVUcMMQcyzAsRV7GIYsEmq7NzgS6f5NWglDFFsYShmL1aHb4FKY
        cQv19WvuH6ls+2l0EZ6D2ej7pIzDekRqDxwQy/kLRH2TL3y02rj1++xtHiDsYAARQZVI=;
Received: from 94.196.90.140.threembb.co.uk ([94.196.90.140] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <broonie@sirena.org.uk>)
        id 1lm02H-0067ne-LT; Wed, 26 May 2021 20:21:50 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 47443D0E9E4; Wed, 26 May 2021 21:21:48 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, james.schulman@cirrus.com, perex@perex.cz,
        david.rhodes@cirrus.com, YueHaibing <yuehaibing@huawei.com>,
        tiwai@suse.com
Cc:     Mark@sirena.org.uk, Brown@sirena.org.uk, broonie@kernel.org,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] ASoC: cs42l52: use DEVICE_ATTR_WO macro
Date:   Wed, 26 May 2021 21:21:45 +0100
Message-Id: <162206049349.1916760.10677861794866535039.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210524114239.7960-1-yuehaibing@huawei.com>
References: <20210524114239.7960-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Brown,,, <broonie@kernel.org>

On Mon, 24 May 2021 19:42:39 +0800, YueHaibing wrote:
> Use DEVICE_ATTR_WO() helper instead of plain DEVICE_ATTR(),
> which makes the code a bit shorter and easier to read.

Applied, thanks!

[1/1] ASoC: cs42l52: use DEVICE_ATTR_WO macro
      commit: 058efb40641845432c52777443b3372dbc97c032

Best regards,
-- 
Mark Brown,,, <broonie@kernel.org>
