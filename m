Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4293AC7D2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 11:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbhFRJmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 05:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbhFRJmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 05:42:21 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50947C061574;
        Fri, 18 Jun 2021 02:40:12 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 50AAB22239;
        Fri, 18 Jun 2021 11:40:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1624009207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BjckcDOMY6ny4V2/ZL/9WmTbYDu5KRR7Z/WfGf4tNs8=;
        b=Qh6pFvpHLi1cg1EvHgs3SyWCmNuIS1mbrMjc09p/kCZrrSj0M4OIrqk8DkrEHQQACU0xsN
        tWDXENHlqTYhMbvVjyOe+WegaFKRtOg6gdJ1syJc4LvbuZ1PRok6C7zYfgX4erat+FSMVX
        xQjqC/uWYb5jnJPYE9DV8ozdASCk9Qw=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 18 Jun 2021 11:40:06 +0200
From:   Michael Walle <michael@walle.cc>
To:     Colin King <colin.king@canonical.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  mtd: spi-nor: remove redundant continue statement
In-Reply-To: <20210618093331.100006-1-colin.king@canonical.com>
References: <20210618093331.100006-1-colin.king@canonical.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <59bfda9fc1040ecd1be3f57aa436cce6@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-06-18 11:33, schrieb Colin King:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The continue statement at the end of a for-loop has no effect,
> invert the if expression and remove the continue.
> 
> Addresses-Coverity: ("Continue has no effect")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Michael Walle <michael@walle.cc>

-michael
