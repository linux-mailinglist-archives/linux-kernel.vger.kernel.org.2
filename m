Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC1F63A841F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 17:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbhFOPkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 11:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhFOPkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 11:40:11 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E10AC061574;
        Tue, 15 Jun 2021 08:38:06 -0700 (PDT)
Received: from [IPv6:2001:4c4c:2228:2400::1000] (20014C4C222824000000000000001000.catv.pool.telekom.hu [IPv6:2001:4c4c:2228:2400::1000])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: hs@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 4CD6582934;
        Tue, 15 Jun 2021 17:38:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1623771482;
        bh=Ej4rCqetLA22T9wWq3Szx63Mg97UjXN4quAi/wmiorE=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=w4UPMvakgrKUQLtejM2GLU9QSfH7jmaSn0I5dlhseWNIAOGyl5FisWyRK0pRjCCvl
         8kvSrxaNS3XltIoG/0EZVeLWo2y27z6TwDiiMIG+a9vBM4FDOixEDgBOR8mzOYu6x0
         FXpnQ6KY67mpuZk3BWnfo7c9qwa77Oqr3q4sdT4JtPttbeN9GYQ6eItnTnLyuo2tws
         91yY9sa0utKNYOmT+xsFkYwEpnQqhn2mTwhPHkVJBquSPSvAZZghMrLP8ZRe7aP8r/
         /uTyW9EMS/JMqUuI+cYr9w/VBZs70HvQbV4LnqrYXdUFcFUgrV4bZOmfFmiYmE4sQN
         Oq+Ld8PkTfzvA==
Reply-To: hs@denx.de
Subject: Re: [PATCH][next] mtd: devices: mchp48l640: Fix return of
 uninitialized value in ret
To:     Colin King <colin.king@canonical.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210615140652.59521-1-colin.king@canonical.com>
From:   Heiko Schocher <hs@denx.de>
Message-ID: <b0d971da-ff2e-7ad4-cba7-32a1406b983d@denx.de>
Date:   Tue, 15 Jun 2021 17:38:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210615140652.59521-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Colin,

On 15.06.21 16:06, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> In the case where the read or write lengths are zero bytes the return
> value in variable ret has not been initialized and a garbage value
> is returned. Fix this by initializing ret to zero.
> 
> Addresses-Coverity: ("Uninitialized scalar variable")
> Fixes: 88d125026753 ("mtd: devices: add support for microchip 48l640 EERAM")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/mtd/devices/mchp48l640.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks!

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
