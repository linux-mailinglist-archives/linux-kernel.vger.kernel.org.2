Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A15D339324F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 17:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235595AbhE0PUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 11:20:11 -0400
Received: from sender11-op-o11.zoho.eu ([31.186.226.225]:17120 "EHLO
        sender11-op-o11.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235683AbhE0PTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 11:19:40 -0400
X-Greylist: delayed 905 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 May 2021 11:19:39 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1622127771; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=B8O4rpU9cliQfNQvgtHtVd5VlcwBlm4k2zygcq1bAsS5Hl86KPLX0WJo/mCirxoDuBFt2AMQWHIdXlTtU3YFABIiYXg9gslTTKtm987i7/kePzvrG+uSRdKoNRewGPen48qM3xVnurUrNCZmSmriIXif5s9Zu+2qUS8aOYjFpc0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1622127771; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=Ney13/SDgPkyWtR1MJDUY+tAf59DyZxsIbEbYe1aHpI=; 
        b=MPQY3TWUPCn+eC++jzIuTNVSZi8QFoNlxNfnXbSSjnrheXHxzxhhHDwTx+BCqKj0X32+Qa45DubOHSiojpSUavBGiJWR4XR2S6LfTS8dBVexHZroWxZE+UAGKXJyt/c3sbaFsmRQWsX/Wnv1bjnQPc90ugAls0lmm5wq+THeSyM=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org>
Received: from [192.168.99.29] (pool-72-69-75-15.nycmny.fios.verizon.net [72.69.75.15]) by mx.zoho.eu
        with SMTPS id 1622127768365197.51234161517937; Thu, 27 May 2021 17:02:48 +0200 (CEST)
Subject: Re: [PATCH net-next] net: hippi: remove leading spaces before tabs
To:     Hui Tang <tanghui20@huawei.com>
Cc:     linux-kernel@vger.kernel.org
References: <1621483047-32583-1-git-send-email-tanghui20@huawei.com>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <04909949-0316-ff34-682b-9286fac1a8a7@trained-monkey.org>
Date:   Thu, 27 May 2021 11:02:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <1621483047-32583-1-git-send-email-tanghui20@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/21 11:57 PM, Hui Tang wrote:
> There are a few leading spaces before tabs and remove it by running
> the following commard:
> 
>     $ find . -name '*.[ch]' | xargs sed -r -i 's/^[ ]+\t/\t/'
> 
> Signed-off-by: Hui Tang <tanghui20@huawei.com>
> ---
>  drivers/net/hippi/rrunner.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Acked-by: Jes Sorensen <jes@trained-monkey.org>

