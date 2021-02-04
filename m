Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F7F30FF45
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 22:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhBDV15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 16:27:57 -0500
Received: from marcansoft.com ([212.63.210.85]:45724 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229513AbhBDV14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 16:27:56 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 020AD4267C;
        Thu,  4 Feb 2021 21:27:11 +0000 (UTC)
Subject: Re: [PATCH 07/18] tty: serial: samsung_tty: enable for ARCH_APPLE
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>
References: <20210204203951.52105-1-marcan@marcan.st>
 <20210204203951.52105-8-marcan@marcan.st>
 <CAK8P3a1n+C5V5J24myy_h67DVp2YTN5Hd=tCWjPUYZcrAX4hCg@mail.gmail.com>
From:   Hector Martin 'marcan' <marcan@marcan.st>
Message-ID: <6eab2c0c-d44d-ff67-7e92-f2de2bf0c6a1@marcan.st>
Date:   Fri, 5 Feb 2021 06:27:09 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1n+C5V5J24myy_h67DVp2YTN5Hd=tCWjPUYZcrAX4hCg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/2021 06.16, Arnd Bergmann wrote:
> On Thu, Feb 4, 2021 at 9:39 PM Hector Martin <marcan@marcan.st> wrote:
> 
>>
>>   config SERIAL_SAMSUNG
>>          tristate "Samsung SoC serial support"
>> -       depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
>> +       depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST || ARCH_APPLE
> 
> By convention, please keep "|| COMPILE_TEST" last in the list.

Ack, good catch! Fixed for v2.

-- 
Hector Martin "marcan" (marcan@marcan.st)
Public Key: https://mrcn.st/pub
