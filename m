Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A66632BEF8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 00:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1576728AbhCCRrr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 3 Mar 2021 12:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244607AbhCCOs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 09:48:26 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60692C0613E5
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 06:46:48 -0800 (PST)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1lHSlx-0004m9-Px; Wed, 03 Mar 2021 15:46:45 +0100
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1lHSlv-0001j1-BD; Wed, 03 Mar 2021 15:46:43 +0100
Message-ID: <1d80a0d0a66e4dedba2beca51cae53ff5258a260.camel@pengutronix.de>
Subject: Re: [PATCH v6 22/37] reset: reset-scmi: port driver to the new
 scmi_reset_proto_ops interface
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com
Date:   Wed, 03 Mar 2021 15:46:43 +0100
In-Reply-To: <20210202221555.41167-23-cristian.marussi@arm.com>
References: <20210202221555.41167-1-cristian.marussi@arm.com>
         <20210202221555.41167-23-cristian.marussi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-02-02 at 22:15 +0000, Cristian Marussi wrote:
> Port driver to the new SCMI Reset interface based on protocol handles
> and common devm_get_ops().
> 
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
