Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFAA3A1369
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239517AbhFILut convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 9 Jun 2021 07:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239690AbhFILtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:49:21 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7BAC0613A3
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 04:47:08 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1lqwfn-0004A1-KW; Wed, 09 Jun 2021 13:47:03 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1lqwfm-0006Ua-Rk; Wed, 09 Jun 2021 13:47:02 +0200
Message-ID: <3bf7b5a82072484362fae4af946381e1ae846917.camel@pengutronix.de>
Subject: Re: [PATCH 2/2] reset: Add compile-test stubs
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 09 Jun 2021 13:47:02 +0200
In-Reply-To: <20210609112806.3565057-3-thierry.reding@gmail.com>
References: <20210609112806.3565057-1-thierry.reding@gmail.com>
         <20210609112806.3565057-3-thierry.reding@gmail.com>
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

Hi Thierry,

On Wed, 2021-06-09 at 13:28 +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Add stubs for the reset controller registration functions to allow
> building reset controller provider drivers with the COMPILE_TEST
> Kconfig option enabled.
> 
> Reported-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Suggested-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Thank you, I've applied patch 2 to reset/next.

regards
Philipp
