Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF6B37BCA8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 14:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbhELMjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 08:39:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:45682 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232847AbhELMjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 08:39:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6FF97AE85;
        Wed, 12 May 2021 12:38:30 +0000 (UTC)
Date:   Wed, 12 May 2021 14:38:28 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Zou Wei <zou_wei@huawei.com>
Cc:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] misc: eeprom: Add missing MODULE_DEVICE_TABLE
Message-ID: <20210512143828.04be05e5@endymion>
In-Reply-To: <1620801708-18965-1-git-send-email-zou_wei@huawei.com>
References: <1620801708-18965-1-git-send-email-zou_wei@huawei.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zou,

On Wed, 12 May 2021 14:41:48 +0800, Zou Wei wrote:
> This patch adds missing MODULE_DEVICE_TABLE definition which generates
> correct modalias for automatic loading of this driver when it is built
> as an external module.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>  drivers/misc/eeprom/eeprom.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/misc/eeprom/eeprom.c b/drivers/misc/eeprom/eeprom.c
> index 34fa385..3fefb70 100644
> --- a/drivers/misc/eeprom/eeprom.c
> +++ b/drivers/misc/eeprom/eeprom.c
> @@ -194,6 +194,7 @@ static const struct i2c_device_id eeprom_id[] = {
>  	{ "eeprom", 0 },
>  	{ }
>  };
> +MODULE_DEVICE_TABLE(i2c, eeprom_id);
>  
>  static struct i2c_driver eeprom_driver = {
>  	.driver = {

Nack. The "eeprom" driver is a legacy driver that is being phased out and
replaced by the "at24" driver. We do NOT want the "eeprom" driver to be
loaded automatically, because it would then potentially steal the
devices which the "at24" driver should be dealing with.

Plus, the only driver which should instantiate "eeprom" i2c devices
is the "eeprom" driver itself. So I can't see how adding a
MODULE_DEVICE_TABLE() would change anything in practice anyway. If it
does change something for you then you are using the "eeprom" driver
when you shouldn't. Please move to the "at24" driver.

-- 
Jean Delvare
SUSE L3 Support
