Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81815330AA5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 10:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbhCHJys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 04:54:48 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:46493 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbhCHJya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 04:54:30 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id D819622246;
        Mon,  8 Mar 2021 10:54:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1615197269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mvygtkil7ta1nozc09CcL7f9MLw8A5Zp+hHf8eHw7v0=;
        b=Ye/rqwKUxNumwFtS7Qw0eWMlNbKg02NQEwnkqh6XRnIQxigDXjBotwb6MkmQ6mvMQ1h6Ye
        7ch5bpimuMjVl1eYIMgC4/vSuq7God5Q48m4dUZ7X9UbnMTooanMqiPhBxgnjX80nkrIyy
        A5qEh8B6MpeBInvZIJQ0e/Y6bEz0pNg=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 08 Mar 2021 10:54:28 +0100
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     p.yadav@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com
Subject: Re: [PATCH] MAINTAINERS: Add Michael and Pratyush as designated
 reviewers for SPI NOR
In-Reply-To: <20210308092333.80521-1-tudor.ambarus@microchip.com>
References: <20210308092333.80521-1-tudor.ambarus@microchip.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <87d94fa3b49a568f2c20ebcd9f1ab935@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-03-08 10:23, schrieb Tudor Ambarus:
> It's already been the case for some time that Michael and Pratyush
> are reviewing SPI NOR patches. Update MAINTAINERS to reflect reality.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Acked-by: Michael Walle <michael@walle.cc>
