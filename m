Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3784498A4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 16:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241043AbhKHPqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 10:46:04 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:55883 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236127AbhKHPqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 10:46:01 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 349B222205;
        Mon,  8 Nov 2021 16:43:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1636386195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VdzImpsfe23Fb4V1nNW/QvmmMLEtkLMoeL/e6kYeyek=;
        b=H7YRReVNPBSpcw1sbgLJ3R36siXN+BrCZTzDEEqc9/XIbpVoMQICQ3zSNZ2cTpL7TNpN38
        s7uVV4fd20C83ZVp1HRLPsK0hgt6JT3VK6djZKJCMdDg86jUthThcGKCI6xGEaCb1LEUzp
        aXJBCFANUqtvmEwq+v/n1Pf543Xl9sM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 08 Nov 2021 16:43:15 +0100
From:   Michael Walle <michael@walle.cc>
To:     shiva.linuxworks@gmail.com
Cc:     tudor.ambarus@microchip.com, p.yadav@ti.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: Re: [PATCH 1/4] mtd: spi-nor: micron-st: add advanced protection and
 security features
In-Reply-To: <20211027103352.8879-2-sshivamurthy@micron.com>
References: <20211027103352.8879-1-sshivamurthy@micron.com>
 <20211027103352.8879-2-sshivamurthy@micron.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <24469d5c42e62959390c3f0aa75fc57a@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 2021-10-27 12:33, schrieb shiva.linuxworks@gmail.com:
> From: Shivamurthy Shastri <sshivamurthy@micron.com>
> 
> Micron SPI NOR flashes are enabled with advanced sector protection
> features, using volatile lock bits, non-volatile lock bits, global
> freeze bits and password.
> 
> Advanced sector protection and security features offers additional
> levels of protection against accidentally corrupting code and data
> stored, and it also prevents malicious attacks that could intentionally
> modify or corrupt the code or data stored.
> 
> Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
> ---
..

> +static const struct spi_nor_sec_ops authenta_ops = {
> +	.secure_read = authenta_secure_read,
> +	.secure_write = authenta_secure_write,
> +	.read_vlock_bits = authenta_read_vlock_bits,
> +	.write_vlock_bits = authenta_write_vlock_bits,
> +	.read_nvlock_bits = authenta_read_nvlock_bits,
> +	.write_nvlock_bits = authenta_write_nvlock_bits,
> +	.erase_nvlock_bits = authenta_erase_nvlock_bits,
> +	.read_global_freeze_bits = authenta_read_global_freeze_bits,
> +	.write_global_freeze_bits = authenta_write_global_freeze_bits,
> +	.read_password = authenta_read_password,

Could you please explain what secure read and write and all the
other ops actually are? Why is there no write password?

They all seem to be used together with advanced sector protection.
But you're just exporting all these ops to userspace. We already
have lock and unlock ioctls in place. I'd expect that this
sector protection will make use of these. Just exporting all the
commands to userspace is not the way to go.

-michael
