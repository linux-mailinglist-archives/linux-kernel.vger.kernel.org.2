Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 673F338BDC2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 07:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239421AbhEUFLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 01:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238672AbhEUFLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 01:11:10 -0400
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ef0:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2388CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 22:09:48 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 3976D2800B3CA;
        Fri, 21 May 2021 07:09:46 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 2CCCD1EDD; Fri, 21 May 2021 07:09:46 +0200 (CEST)
Date:   Fri, 21 May 2021 07:09:46 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Mark Brown <broonie@kernel.org>, kernel-team@android.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] spi: Don't have controller clean up spi device before
 driver unbind
Message-ID: <20210521050946.GA26930@wunner.de>
References: <20210505164734.175546-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210505164734.175546-1-saravanak@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2021 at 09:47:34AM -0700, Saravana Kannan wrote:
> When a spi device is unregistered and triggers a driver unbind, the
> driver might need to access the spi device. So, don't have the
> controller clean up the spi device before the driver is unbound. Clean
> up the spi device after the driver is unbound.
> 
> Fixes: c7299fea6769 ("spi: Fix spi device unregister flow")
> Reported-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
> 
> v1->v2:
> - Made the clean up more symmetric. 
> 
> Lukas,
> 
> Can you test this one your end to make sure you don't have issues
> anymore?

Tested-by: Lukas Wunner <lukas@wunner.de>

My apologies for the delay, yesterday I was finally able to set up a RasPi
in my home office and test the patch.  I'm not seeing any issues when
unloading/reloading the SPI controller module, so this LGTM.

Thanks,

Lukas
