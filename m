Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B05C438B7CF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 21:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237207AbhETTuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 15:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233763AbhETTuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 15:50:46 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD2BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 12:49:22 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 250C62224F;
        Thu, 20 May 2021 21:49:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1621540160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xyoIeN35KyACIUB9MIasxTVjdgU2oSu4rX9sr8VLho4=;
        b=t9Krgx+fyQolZ5LOweq2ffcExdJpwo9CJOn7OK5FUjbFwZPJUGSvKBxAf+R2IJtkvAI9gS
        J23PfaTuI05k5BwVdMt8qnMSJQb+eltWoAq5B19Lz5jdttmWHnmclfACeXpTyn4ZkTVfOk
        pUCXaOQjonH4T2zCuWMOOV5ol8HqiIU=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 20 May 2021 21:49:20 +0200
From:   Michael Walle <michael@walle.cc>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH] mtd: spi-nor: Add documentation for spi_nor_soft_reset()
In-Reply-To: <20210511093958.17258-1-p.yadav@ti.com>
References: <20210511093958.17258-1-p.yadav@ti.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <a158404bfbe5835075d66112fc1db3cd@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-05-11 11:39, schrieb Pratyush Yadav:
> Document what the function does and that it should only be used when it
> is known that the device supports it. This will avoid unaware
> programmers thinking that they can arbitrarily use it to reset the
> device.
> 
> Suggested-by: Michael Walle <michael@walle.cc>
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>

Reviewed-by: Michael Walle <michael@walle.cc>
