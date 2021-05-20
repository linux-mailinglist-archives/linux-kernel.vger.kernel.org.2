Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 825B6389E65
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 08:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbhETG4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 02:56:32 -0400
Received: from router.aksignal.cz ([62.44.4.214]:60604 "EHLO
        router.aksignal.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbhETG4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 02:56:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by router.aksignal.cz (Postfix) with ESMTP id 4F29747F49;
        Thu, 20 May 2021 08:54:53 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at router.aksignal.cz
Received: from router.aksignal.cz ([127.0.0.1])
        by localhost (router.aksignal.cz [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id RTsHQFNjaj3O; Thu, 20 May 2021 08:54:53 +0200 (CEST)
Received: from [172.25.162.36] (unknown [83.240.30.185])
        (Authenticated sender: jiri.prchal@aksignal.cz)
        by router.aksignal.cz (Postfix) with ESMTPSA id CC25B47F48;
        Thu, 20 May 2021 08:54:52 +0200 (CEST)
Subject: Re: [PATCH v4 1/4] nvmem: eeprom: at25: add support for FRAM
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Christian Eggers <ceggers@arri.de>,
        Arnd Bergmann <arnd@arndb.de>
References: <20210520054714.8736-1-jiri.prchal@aksignal.cz>
 <20210520054714.8736-2-jiri.prchal@aksignal.cz> <YKX5aaV3DGvIm8RP@kroah.com>
From:   =?UTF-8?B?SmnFmcOtIFByY2hhbA==?= <jiri.prchal@aksignal.cz>
Message-ID: <81420093-7af6-bed3-eee7-38be125a67e4@aksignal.cz>
Date:   Thu, 20 May 2021 08:54:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YKX5aaV3DGvIm8RP@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: cs
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 20. 05. 21 7:53, Greg Kroah-Hartman wrote:
> On Thu, May 20, 2021 at 07:47:11AM +0200, Jiri Prchal wrote:
>> Added enum and string for FRAM to expose it as "fram".
> 
> documentation???
> 
Hi Greg,
please help me, you mean more explanation in commit message?
