Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBC693433CE
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 18:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhCURit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 13:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbhCURiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 13:38:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DC7C061574;
        Sun, 21 Mar 2021 10:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lkvyMUw6Tedb3zFSRD9J+ZKIUC7Vf2Uyb31sp/b4PJo=; b=SfuPmyO7gfE+7FnBfYuWmBfdRw
        gPNz1Vy2qy2tzOF+wpPNXlbEPrTl/A6+BeBO3/YhYH3L3QsD1HTnzMtBJVhcFJtmUS1RARdrgofOU
        EIkFkbCDo+4nwMSFUPfY8+9r3Kns0Ma9pmBNNnCdg3h7HEhh6gb/tUMLChp462TiOON1grTY+0dSD
        6BT0KdtuH94iY2sctInKpEnFYKhaJkjD5zYFuPQHD8jLlBaJ8RgnRdHFy2AQic2cyPXSQv1+sApky
        foFagInnDf6qL42LUn8EH5QKTrzn1kVzAaN5hUa8Hd04SYr8lhosNQi2MhJIEnIXntM6Wen4gIlx4
        vHeT+O5w==;
Received: from rdunlap (helo=localhost)
        by bombadil.infradead.org with local-esmtp (Exim 4.94 #2 (Red Hat Linux))
        id 1lO21m-002QYX-OY; Sun, 21 Mar 2021 17:38:15 +0000
Date:   Sun, 21 Mar 2021 10:38:14 -0700 (PDT)
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Alistair Francis <alistair@alistair23.me>
cc:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com
Subject: Re: [PATCH v3 2/2] mfd: sy7636a: Initial commit
In-Reply-To: <20210321141322.298-2-alistair@alistair23.me>
Message-ID: <9f40beda-c72c-5eb-61e3-37213c7c4c42@infradead.org>
References: <20210321141322.298-1-alistair@alistair23.me> <20210321141322.298-2-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210321_103814_821861_79FE5D48 
X-CRM114-Status: GOOD (  12.09  )
X-Spam-Score: -0.0 (/)
X-Spam-Report: Spam detection software, running on the system "bombadil.infradead.org",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  Hi, On Sun, 21 Mar 2021, Alistair Francis wrote: > Initial
    support for the Silergy SY7636A Power Management chip. > > Signed-off-by:
    Alistair Francis <alistair@alistair23.me> > --- > v3: > - Address comments
    in V2 > - Drop regulator patches > > driv [...] 
 Content analysis details:   (-0.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 NO_RELAYS              Informational: message was not relayed via SMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,


On Sun, 21 Mar 2021, Alistair Francis wrote:

> Initial support for the Silergy SY7636A Power Management chip.
>
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
> v3:
> - Address comments in V2
> - Drop regulator patches
>
> drivers/mfd/Kconfig         |  10 ++
> drivers/mfd/Makefile        |   1 +
> drivers/mfd/sy7636a.c       | 246 ++++++++++++++++++++++++++++++++++++
> include/linux/mfd/sy7636a.h |  46 +++++++
> 4 files changed, 303 insertions(+)
> create mode 100644 drivers/mfd/sy7636a.c
> create mode 100644 include/linux/mfd/sy7636a.h
>
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index b74efa469e90..a285d11d5be3 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1351,6 +1351,16 @@ config MFD_SYSCON
> 	  Select this option to enable accessing system control registers
> 	  via regmap.
>
> +config MFD_SY7636A
> +	tristate "Silergy SY7636A Power Management chip"
> +	select MFD_CORE
> +	select REGMAP_I2C
> +	select REGMAP_IRQ
> +	depends on I2C=y

So why is this driver tristate but depends on I2C=y?
That's a little confusing.

Thanks.

> +	help
> +	  Select this option to enable support for the Silergy SY7636A
> +	  Power Management chip.
