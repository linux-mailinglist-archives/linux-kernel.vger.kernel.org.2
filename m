Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B90A53A3E72
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 10:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbhFKJBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 05:01:09 -0400
Received: from router.aksignal.cz ([62.44.4.214]:55906 "EHLO
        router.aksignal.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbhFKJBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 05:01:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by router.aksignal.cz (Postfix) with ESMTP id BC08E47317;
        Fri, 11 Jun 2021 10:59:08 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at router.aksignal.cz
Received: from router.aksignal.cz ([127.0.0.1])
        by localhost (router.aksignal.cz [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id JoxcQDnsDsKA; Fri, 11 Jun 2021 10:59:08 +0200 (CEST)
Received: from [172.25.161.48] (unknown [83.240.30.185])
        (Authenticated sender: jiri.prchal@aksignal.cz)
        by router.aksignal.cz (Postfix) with ESMTPSA id 1BD0B47316;
        Fri, 11 Jun 2021 10:59:07 +0200 (CEST)
Subject: Re: [PATCH v9 1/5] nvmem: prepare basics for FRAM support
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Christian Eggers <ceggers@arri.de>,
        Arnd Bergmann <arnd@arndb.de>
References: <20210611052652.7894-1-jiri.prchal@aksignal.cz>
 <20210611052652.7894-2-jiri.prchal@aksignal.cz> <YMMjbCFzsfiT8dMA@kroah.com>
From:   =?UTF-8?B?SmnFmcOtIFByY2hhbA==?= <jiri.prchal@aksignal.cz>
Message-ID: <3c2beca6-8ef5-834d-a37a-5aea53bc1305@aksignal.cz>
Date:   Fri, 11 Jun 2021 10:59:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YMMjbCFzsfiT8dMA@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11. 06. 21 10:48, Greg Kroah-Hartman wrote:
> On Fri, Jun 11, 2021 at 07:26:48AM +0200, Jiri Prchal wrote:
>> Added enum and string for FRAM to expose it as "fram".
> 
> I have no idea what "FRAM" is, nor what "fram" is.
> 
> And why do you not add the documentation update here in this same
> commit?  This is where you are adding it, trying to dig later in the
> series to notice that you really did provide this is a pain, and is
> harder to track.
> 
> Please provide more information here in the changelog and move the
> Documentation addition here into this patch.

Should I also join #1 and 2 together?
