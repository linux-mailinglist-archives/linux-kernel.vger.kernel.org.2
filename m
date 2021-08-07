Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC9863E325B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 02:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhHGAdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 20:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbhHGAdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 20:33:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCB2C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 17:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=yLhQiIvD0VEAyQB7v7VIYIuOHBnEVwVlvpAvQNp7Vyw=; b=mN98SCznL7vpnvaHiFEoMjn02a
        VFNp/gG96A+NMebJYIrKRYFAGq2si8tlS8dehPclOeb4wuxdIfLP2UAkzydbGKemQKMPBN56mUJZP
        WZKEygBWU89Kfx0fsCG0AVnH3BN5ne+l2c0jAM08CSSWW2nG3eS/AOt2BdvCfXWvFmIe3ooahMV/m
        nslqB99oWxxA5c3pALvdXdcwRzHW3QOQ1pa/PzTp26NhjHoQ1lqwKiDgFy4o6Pkpk/OeBmc5WHZ2t
        li559l/0b0S3m9w4lQ04BoGEWnk7+I/xBBJN+cxLAjPF1QMRMJt7g3zFdUJYJtOBz+pFtjtz2tsqC
        KDJ++MsA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mCAGp-008jex-V3; Sat, 07 Aug 2021 00:33:03 +0000
Subject: Re: [RFC PATCH 1/3] drivers/mfd: rpisense: Raspberry Pi senseHAT core
 driver
To:     Joel Savitz <jsavitz@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        linux-rpi-kernel@lists.infradead.org, fedora-rpi@googlegroups.com,
        Charles Mirabile <cmirabil@redhat.com>,
        Mwesigwa Guma <mguma@redhat.com>
References: <20210807002722.2634585-1-jsavitz@redhat.com>
 <20210807002722.2634585-2-jsavitz@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <96e6b090-dd2b-ebd1-5f62-3cee9a676bb4@infradead.org>
Date:   Fri, 6 Aug 2021 17:32:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210807002722.2634585-2-jsavitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/6/21 5:27 PM, Joel Savitz wrote:
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 6a3fd2d75f96..614de080dee6 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -11,6 +11,16 @@ config MFD_CORE
>   	select IRQ_DOMAIN
>   	default n
>   
> +config MFD_RPISENSE
> +	tristate "Raspberry Pi Sense HAT driver"
> +	depends on I2C && GPIOLIB
> +	select MFD_CORE
> +	help
> +	  This is the driver for the Raspberry Pi Sense HAT. This provides
> +	  the necessary functions to communicate with the hardware as well
> +	  as a joystick and display interface. Linux communicates with the
> +	  hardwire using the GPIO pins via the I2C protocol.

	  hardware


What is HAT, please?

-- 
~Randy

