Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1A03D3A82
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 14:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235020AbhGWMJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 08:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234857AbhGWMJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 08:09:31 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D1FC061575
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 05:50:04 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id l126so2323089ioa.12
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 05:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S7/a0CrZBTQx9NCUvzRct8p/jgzivwtgpsB1BZn4Wfk=;
        b=gUsPFbCrJ+3yw1Nlw2vUluw8VPUQXk3YdC8gUgl7vbdkzhglsE+E5M6rWWwKoURs7a
         u8KnJbUuLB21o2xQvpI2rtgrq3TWPt3X2tIeQ1sjwXZMfUK8rTYoFWBeVWUY8aMQ6j9P
         A0a+gE8LVAJ4Hcyiv4GaEPDDxZx0dlIIGXmsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S7/a0CrZBTQx9NCUvzRct8p/jgzivwtgpsB1BZn4Wfk=;
        b=uDDUQW5pDONX0kt+xBwNQVQ0qyhccHrXrBTDuC/sQGh3oVBBqfSvmLZO2Kramx0lrv
         XGBaPa6/9FtjuGPcz/YSoSlPrJe+MLwbh82D+0G9mFhZGKRAAiVZnz6EKMTxDd9vLNX9
         mBK0zSwcNFHBv74Ut4ngEMqdZO9/nSVm4Ne0CcWno49NjlmCuYjTZOqX7DaR9qzkflYZ
         oAof4JaIJgUfl5xZHFQA3s/C7P2Xpe5agrj/UxnPDV2hUO1azTDuRjn+82YNpO0Pt2xD
         oPpF54mr/DEPdRvI57kLP+JMAfqFaz0TO4ZjRKH+1/YyUSoFKk8+oVTuixfc3wHUVt3r
         Sisg==
X-Gm-Message-State: AOAM5337GhY+0vrHHGG5TDWaonedBpI2CDH6up7MeBd2NeVpeGDhiq6O
        Th9OlPSpL37K03oJXGnmlO5G9w==
X-Google-Smtp-Source: ABdhPJyB/udUXxyiF/BbxySNBeh0CUCizKCk5P4GVLlvtdxxP1UNlUewyXfifjkW9NB+MvJxP4+mdg==
X-Received: by 2002:a02:620a:: with SMTP id d10mr4159894jac.22.1627044603479;
        Fri, 23 Jul 2021 05:50:03 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id c16sm16892911ilo.72.2021.07.23.05.50.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jul 2021 05:50:02 -0700 (PDT)
Subject: Re: [PATCH 7/8] tty: drop put_tty_driver
To:     Jiri Slaby <jslaby@suse.cz>, gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Karsten Keil <isdn@linux-pingi.de>,
        Scott Branden <scott.branden@broadcom.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        David Lin <dtwlin@gmail.com>, Johan Hovold <johan@kernel.org>,
        Alex Elder <elder@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Jiri Kosina <jikos@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Oliver Neukum <oneukum@suse.com>,
        Felipe Balbi <balbi@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20210723074317.32690-1-jslaby@suse.cz>
 <20210723074317.32690-8-jslaby@suse.cz>
From:   Alex Elder <elder@ieee.org>
Message-ID: <26699850-f2a0-25d5-16d1-eaebe0f3100a@ieee.org>
Date:   Fri, 23 Jul 2021 07:50:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210723074317.32690-8-jslaby@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/23/21 2:43 AM, Jiri Slaby wrote:
>   drivers/staging/greybus/uart.c         | 4 ++--

Acked-by: Alex Elder <elder@linaro.org>
