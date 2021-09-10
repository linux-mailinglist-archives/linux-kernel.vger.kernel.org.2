Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 786724071B3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 21:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbhIJTIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 15:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232711AbhIJTIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 15:08:37 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE27C061574;
        Fri, 10 Sep 2021 12:07:25 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id l10so6047033lfg.4;
        Fri, 10 Sep 2021 12:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nbTL9R97Ke/lh7QPNGiJCVVZOB6w129a/LtSq9pDVx0=;
        b=AhAkLbfHag1+GQrZjvSiR1U9MCGIj/PK3aBrteDkbqZEQjiUP3bqxuD/n3gR+JmI14
         BFsLx2B2MUl0nDTtsCKSgNAumBL8ACM9o+DvCO2YJLxLpSfFjJ36rHS1j8DpEfhDAAwb
         MR3QVoeg8Y+rwVPX5QJKu20pbYfBHtvcC6K05fhpdpK81EjxJl0cGLJbHl0JLEe+CGZj
         e18VWI8NVrWpYscRi6FxRyMocUF83vdcHrdvvgY33FmnWd0YAhoskYR65MOKhLpq6E0M
         7sGuQZrVD1IN1p6zXpUG1SjXAMBTyR1HEgazwmuqMSZYRmC5VVyl40pnZRSKlnX5Rgk/
         cK0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nbTL9R97Ke/lh7QPNGiJCVVZOB6w129a/LtSq9pDVx0=;
        b=fb+ejmN49oXb9OH3RVgAwMUddoC0WWfXEN6t/A7GSFAoF4jDcA3euuNAZcQn5QOUby
         lhn9poJ6F9+9B+CIsPA6Aded3nBtwskW9fLuM0S5WroS7jbKxK5lCIafFBgWOHTUZETp
         LLZv2J4nBS4N1+epSzqf/o3RXyd3WAnv+t1yeAY2K7egM9z59Zr4B7Yp2j1aDXDQp86I
         cOzU71WKRcH5rq1p8gMKGqvQ4Hjx0KLtRODcGsuA+1QXN3a/zYaivPTUR8cjkRMpEqEl
         mai7UzPAHvkfvxj76OE9ncXuRrCt/+LCxTTHSMD7QzFdykYy5IY+DCuuMvwwtlpW3ROB
         bX1g==
X-Gm-Message-State: AOAM533ZbCB1VeSHQq/jLbCMjAdGK9S0ZIOJnHCL+w2XtIiqa0/7Rl3d
        eufMkWPvksx8JJTPS+hjioKXONaQClk=
X-Google-Smtp-Source: ABdhPJwYghBQHugttMu6yPGiRebRP6F/J+LTI9uOYxio78N9HSE7lTJYL5iqOXpWoaDnD91/pB7/og==
X-Received: by 2002:ac2:4c0a:: with SMTP id t10mr5111852lfq.481.1631300844112;
        Fri, 10 Sep 2021 12:07:24 -0700 (PDT)
Received: from [192.168.1.102] ([31.173.81.230])
        by smtp.gmail.com with ESMTPSA id v14sm670070lji.32.2021.09.10.12.07.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Sep 2021 12:07:23 -0700 (PDT)
Subject: Re: [PATCH 1/2] dt-bindings: usb: atmel: add USB PHY type property
To:     cristian.birsan@microchip.com, stern@rowland.harvard.edu,
        gregkh@linuxfoundation.org, nicolas.ferre@microchip.com,
        ada@thorsis.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com
Cc:     linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210910163842.1596407-1-cristian.birsan@microchip.com>
 <20210910163842.1596407-2-cristian.birsan@microchip.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <55c75f95-6a14-7f05-c15c-64d4dbc1dee8@gmail.com>
Date:   Fri, 10 Sep 2021 22:07:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210910163842.1596407-2-cristian.birsan@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 9/10/21 7:38 PM, cristian.birsan@microchip.com wrote:

> From: Cristian Birsan <cristian.birsan@microchip.com>
> 
> Add USB PHY type property for controllers with HSIC support.
> 
> Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
> ---
>  Documentation/devicetree/bindings/usb/atmel-usb.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/atmel-usb.txt b/Documentation/devicetree/bindings/usb/atmel-usb.txt
> index a4002624ba14..f512f0290728 100644
> --- a/Documentation/devicetree/bindings/usb/atmel-usb.txt
> +++ b/Documentation/devicetree/bindings/usb/atmel-usb.txt
> @@ -39,6 +39,10 @@ Required properties:
>  		"ehci_clk" for the peripheral clock
>  		"usb_clk" for the UTMI clock
>  
> +Optional properties:
> + - phy_type : For multi port host USB controllers, should be one of

   Hyphens are preferred to underscores in the property names.

> +   "utmi", or "hsic".
> +
>  usb1: ehci@800000 {
>  	compatible = "atmel,at91sam9g45-ehci", "usb-ehci";
>  	reg = <0x00800000 0x100000>;

MBR, Sergei
