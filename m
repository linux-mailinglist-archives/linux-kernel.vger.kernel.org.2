Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE9B3BA1C1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 15:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbhGBN40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 09:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbhGBN4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 09:56:25 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77859C061762
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 06:53:53 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 094332224D;
        Fri,  2 Jul 2021 15:53:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1625234030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6sLZmtTJ3lZ2BT+RPe8crlPHg3GfiEiEEdvrAfSxeA4=;
        b=n+cG1Vrb2yzW+YE4YEpsLUO4bbKOajH4Ey5GZpsbQbOw84kGySHlVpiYv8qxSt9Xi1mz1M
        q9nzU2sujMQihJqTHoLInJ2dy9Sd9RmWfejCKy+Iwuq0miNortKFRCnnrZuSQ2RTGQLyeV
        nAoXimI42zXfMW0B6VrjU1b8F7/F3x8=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 02 Jul 2021 15:53:49 +0200
From:   Michael Walle <michael@walle.cc>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH] mtd: core: handle flashes without OTP gracefully
In-Reply-To: <499cf369-c98a-ac48-dfe6-6903314e9606@roeck-us.net>
References: <20210702093841.32307-1-michael@walle.cc>
 <499cf369-c98a-ac48-dfe6-6903314e9606@roeck-us.net>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <ae770937ec2ddf12b294fbee3d815dd4@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-07-02 15:49, schrieb Guenter Roeck:
> On 7/2/21 2:38 AM, Michael Walle wrote:
>> There are flash drivers which registers the OTP callbacks although the
>> flash doesn't support OTP regions and return -ENODATA for these
>> callbacks if there is no OTP. If this happens, the probe of the whole
>> flash will fail. Fix it by handling the ENODATA return code and skip
>> the OTP region nvmem setup.
>> 
>> Fixes: 4b361cfa8624 ("mtd: core: add OTP nvmem provider support")
>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>> Signed-off-by: Michael Walle <michael@walle.cc>
> 
> Tested-by: Guenter Roeck <linux@roeck-us.net>

Thanks for confirming, and sorry for the inconvenience.

-michael
