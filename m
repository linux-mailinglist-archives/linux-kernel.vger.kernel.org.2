Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5760343C2C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 09:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhCVI5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 04:57:19 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:48423 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhCVI5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 04:57:08 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id E5AEF2223E;
        Mon, 22 Mar 2021 09:57:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1616403423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mNtl7wKZCKuA1tKkydoWUzCQ/+4X78f16aDFry4OxBg=;
        b=AZiVx4MM9z7YyEYBV0Nvus1SpSkdDqjRcI69JjvpzcwbJ+SKc+/h9BOcshUr8BzR/TRTNY
        wWTWEzjrrHE7LIFMpUvaXIHwWEKhySHtQIQTMxhhTdSGseywf5LeAeMrR3Jc9hpWFg3lFR
        IpT5p+ye+uacSnEDEh+Hi3UA5+11cuc=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 22 Mar 2021 09:57:02 +0100
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     vigneshr@ti.com, p.yadav@ti.com, miquel.raynal@bootlin.com,
        richard@nod.at, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Joe Perches <joe@perches.com>
Subject: Re: [PATCH v3 2/2] mtd: spi-nor: swp: Improve code around
 spi_nor_check_lock_status_sr()
In-Reply-To: <20210322075131.45093-3-tudor.ambarus@microchip.com>
References: <20210322075131.45093-1-tudor.ambarus@microchip.com>
 <20210322075131.45093-3-tudor.ambarus@microchip.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <67fc86c6757c19efa448098c83eb62d9@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-03-22 08:51, schrieb Tudor Ambarus:
> - bool return value for spi_nor_check_lock_status_sr(), gets rid of
>   the return 1,
> - introduce temporary variables for better readability.
> 
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---

Reviewed-by: Michael Walle <michael@walle.cc>

-michael
