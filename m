Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 345BC39DF1F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 16:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbhFGOto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 10:49:44 -0400
Received: from router.aksignal.cz ([62.44.4.214]:49766 "EHLO
        router.aksignal.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbhFGOtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 10:49:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by router.aksignal.cz (Postfix) with ESMTP id 2FF20443B4;
        Mon,  7 Jun 2021 16:47:46 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at router.aksignal.cz
Received: from router.aksignal.cz ([127.0.0.1])
        by localhost (router.aksignal.cz [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id YQcUhtKgRNN1; Mon,  7 Jun 2021 16:47:45 +0200 (CEST)
Received: from [172.25.161.48] (unknown [83.240.30.185])
        (Authenticated sender: jiri.prchal@aksignal.cz)
        by router.aksignal.cz (Postfix) with ESMTPSA id 3A4FC443B2;
        Mon,  7 Jun 2021 16:47:45 +0200 (CEST)
Subject: Re: [PATCH v7 4/5] nvmem: eeprom: at25: export FRAM serial num
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Christian Eggers <ceggers@arri.de>,
        Arnd Bergmann <arnd@arndb.de>
References: <20210607122640.143582-1-jiri.prchal@aksignal.cz>
 <20210607122640.143582-5-jiri.prchal@aksignal.cz>
 <YL4S2/hlfRwRM+Ug@kroah.com>
From:   =?UTF-8?B?SmnFmcOtIFByY2hhbA==?= <jiri.prchal@aksignal.cz>
Message-ID: <56f088fe-8db2-54d4-bef3-72e5f893a414@aksignal.cz>
Date:   Mon, 7 Jun 2021 16:47:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YL4S2/hlfRwRM+Ug@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07. 06. 21 14:36, Greg Kroah-Hartman wrote:
> On Mon, Jun 07, 2021 at 02:26:39PM +0200, Jiri Prchal wrote:
>> +	return sysfs_emit(buf, "%016llx\n", *(unsigned long long *)at25->sernum);
> 
> That's a horrid hack, why not use the %*phN modifier?

Prints as little endian, is that OK?

Jiri

