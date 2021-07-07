Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E11C3BF0A4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 22:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbhGGUOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 16:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbhGGUOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 16:14:01 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF900C061574;
        Wed,  7 Jul 2021 13:11:20 -0700 (PDT)
Received: from [IPv6:2a01:e0a:4cb:a870:20a0:795:eeed:cfc0] (unknown [IPv6:2a01:e0a:4cb:a870:20a0:795:eeed:cfc0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id C1E681F4367F;
        Wed,  7 Jul 2021 21:11:16 +0100 (BST)
To:     peng.fan@oss.nxp.com
Cc:     abel.vesa@nxp.com, aford173@gmail.com, agx@sigxcpu.org,
        andrew.smirnov@gmail.com, devicetree@vger.kernel.org,
        festevam@gmail.com, frieder.schrempf@kontron.de,
        jagan@amarulasolutions.com, kernel@pengutronix.de, krzk@kernel.org,
        l.stach@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org, marex@denx.de,
        p.zabel@pengutronix.de, peng.fan@nxp.com, ping.bai@nxp.com,
        robh+dt@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org
References: <20210629072941.7980-1-peng.fan@oss.nxp.com>
Subject: Re: [PATCH V8 0/4] soc: imx: add i.MX BLK-CTL support
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
Message-ID: <34904917-787e-1cb7-5a88-6d96588e296e@collabora.com>
Date:   Wed, 7 Jul 2021 22:11:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210629072941.7980-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

I have try to use this series to implement BLK-CTL for IMX8MQ and to test it with G1 and G2 VPUs.
You can find the code here:
https://gitlab.collabora.com/benjamin.gaignard/for-upstream/-/commits/control_block_imx8mq

It seems that IMX8MQ requires to set 'fuses' registers to enable the VPUs, I have added that in your code.

Unfortunately that doesn't work, the VPUs are blocked like if they were never reset.
Note that use syscon to manage the reset is working fine.
Since IMX8MQ control block seems lightly different than for IMX8MM, would you mind to add the support for it in your next series ?

Regards,
Benjamin

