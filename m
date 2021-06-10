Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD95A3A25D7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 09:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhFJHxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 03:53:37 -0400
Received: from router.aksignal.cz ([62.44.4.214]:33820 "EHLO
        router.aksignal.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbhFJHxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 03:53:31 -0400
Received: from localhost (localhost [127.0.0.1])
        by router.aksignal.cz (Postfix) with ESMTP id 033574635E;
        Thu, 10 Jun 2021 09:51:34 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at router.aksignal.cz
Received: from router.aksignal.cz ([127.0.0.1])
        by localhost (router.aksignal.cz [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id fzyabMmuYz4l; Thu, 10 Jun 2021 09:51:33 +0200 (CEST)
Received: from [172.25.161.48] (unknown [83.240.30.185])
        (Authenticated sender: jiri.prchal@aksignal.cz)
        by router.aksignal.cz (Postfix) with ESMTPSA id 2DEFD4635D;
        Thu, 10 Jun 2021 09:51:33 +0200 (CEST)
Subject: Re: [PATCH v7 4/5] nvmem: eeprom: at25: export FRAM serial num
From:   =?UTF-8?B?SmnFmcOtIFByY2hhbA==?= <jiri.prchal@aksignal.cz>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Christian Eggers <ceggers@arri.de>,
        Arnd Bergmann <arnd@arndb.de>
References: <20210607122640.143582-1-jiri.prchal@aksignal.cz>
 <20210607122640.143582-5-jiri.prchal@aksignal.cz>
 <YL4S2/hlfRwRM+Ug@kroah.com>
 <56f088fe-8db2-54d4-bef3-72e5f893a414@aksignal.cz>
 <YL8ybqOfgOqjlpoX@kroah.com>
 <b1c0eab3-8d07-5c52-300e-45974f7fea9c@aksignal.cz>
 <YL8+NOdz+ue3MTGg@kroah.com>
 <e32ad2d9-f2b3-f5de-54e5-fe43cd5403a9@aksignal.cz>
Message-ID: <7bb829e8-bdfe-02d1-c191-ca03f9586aed@aksignal.cz>
Date:   Thu, 10 Jun 2021 09:51:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <e32ad2d9-f2b3-f5de-54e5-fe43cd5403a9@aksignal.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08. 06. 21 12:07, Jiří Prchal wrote:
> 
> 
> On 08. 06. 21 11:53, Greg Kroah-Hartman wrote:
>> It's up to you, what do you want to do with it and what does a tool want
>> it to look like?
> 
> Right now I export it as bytes separated by space. But no problem to 
> change it.
> Just asking: for generic users what would be better or is there "best 
> practice"?

Hi Greg and others,
if nobody bothers I'll make it as space separated bytes, MSB first.

Jiri
