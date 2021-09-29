Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B44C41CDF2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 23:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346899AbhI2VVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 17:21:31 -0400
Received: from ixit.cz ([94.230.151.217]:59878 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232258AbhI2VVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 17:21:30 -0400
Received: from [192.168.43.127] (78-80-97-115.customers.tmcz.cz [78.80.97.115])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id BFB3623B26;
        Wed, 29 Sep 2021 23:19:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1632950386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=XdD4z8tJzQeXmWMRITRvTyCwu8N9yjjNeHgeazkXRqY=;
        b=Itr0+U1WJl97CkalbLnh9Feq2GYAgCM5MQ3nDBEPtOWFyJS0ypZ/w+jOl8ajH8oR6zmSwZ
        6o8yVIv2Q4LKam65BRWMGPQXl8oS672Dv7KXiEz7xiy/y6b+IItuB1Sw9hvl24pN8Qzl8n
        YQhfyLSJKQ+ZNdHeGRqBvQNt6PtUzDY=
Date:   Wed, 29 Sep 2021 23:18:21 +0200
From:   David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH] ASoC: dt-bindings: rt5682s: fix the device-tree schema
 errors
To:     derek.fang@realtek.com
Cc:     broonie@kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, lars@metafoo.de, flove@realtek.com,
        oder_chiou@realtek.com, jack.yu@realtek.com, shumingf@realtek.com
Message-Id: <LIS70R.CEFK42MUM5NG1@ixit.cz>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our CI seems to be happy again. Thanks

Reviewed-by: David Heidelberg <david@ixit.cz>
Best regards
David Heidelberg


