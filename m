Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 122B73AE344
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 08:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhFUGfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 02:35:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:33814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhFUGf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 02:35:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E3ADD61003;
        Mon, 21 Jun 2021 06:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624257195;
        bh=4CHyizIg9hIDQpvR1sUF6YvkzCW5f0Mg81yRETpYfxM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kkq/6Ie9xmSIeYZ0BVM7Kn12lEiK5wWTTUy2Odxg1XrCVA+Q+hve3E65qUukWEYUe
         C8Dl6tQm6Rol0GPks9qonx7BJW/+0hqC5DdNEXmxJZ6AsGqeRwefPV/gX370AQemD3
         0uNSntOyUmMJiY8Sztli/cHhWZcb1Z1AfFmIB20chdT3s2wYxMr7ErNKHnPXqczFsH
         HU2l7bp3nonEjEipvrdzq013S10bwUrXSagUO8w8CzNWXBpcYAEE5cCC/FhqIc/YSV
         Vdl3DxaXC2mQpVvkpTDBGTsfFqKnf0Ig5T55bG9lQKL3etV57yzSjk3RV/HIerC2CX
         tHIn22z54zpvg==
Date:   Mon, 21 Jun 2021 12:03:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH] phy: uniphier-pcie: Fix updating phy parameters
Message-ID: <YNAyqHH5PYSm9XMV@vkoul-mobl>
References: <1623037842-19363-1-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623037842-19363-1-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-06-21, 12:50, Kunihiko Hayashi wrote:
> The current driver uses a value from register TEST_O as the original
> value for register TEST_I, though, the value is overwritten by "param",
> so there is a bug that the original value isn't no longer used.
> 
> The value of TEST_O[7:0] should be masked with "mask", replaced with
> "param", and placed in the bitfield TESTI_DAT_MASK as new TEST_I value.

Applied, thanks

-- 
~Vinod
