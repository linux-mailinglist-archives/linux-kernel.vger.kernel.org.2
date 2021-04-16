Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B82BA362601
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 18:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237610AbhDPQvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 12:51:38 -0400
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:35060 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237482AbhDPQvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 12:51:36 -0400
Received: from [192.168.1.18] ([86.243.172.93])
        by mwinf5d18 with ME
        id tUr92400N21Fzsu03Ur9Kq; Fri, 16 Apr 2021 18:51:10 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 16 Apr 2021 18:51:10 +0200
X-ME-IP: 86.243.172.93
Subject: Re: [PATCH] checkpatch: Improve ALLOC_ARRAY_ARGS test
To:     Joe Perches <joe@perches.com>, apw@canonical.com,
        dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <a1ac975aaabc9f71397b75254f833920428411e0.1618588673.git.christophe.jaillet@wanadoo.fr>
 <decdb749f0192bd886faa7e8470795fb2644e4f8.camel@perches.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <ec273f46-6709-a1cd-7871-1e1d67fab7dd@wanadoo.fr>
Date:   Fri, 16 Apr 2021 18:51:09 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <decdb749f0192bd886faa7e8470795fb2644e4f8.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 16/04/2021 à 18:11, Joe Perches a écrit :
> On Fri, 2021-04-16 at 17:58 +0200, Christophe JAILLET wrote:
>> The devm_ variant of 'kcalloc()' and 'kmalloc_array()' are not tested
>> Add the corresponding check.
> []
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
>> @@ -7006,9 +7006,9 @@ sub process {
>>   		}
>>   
>>
>>   # check for alloc argument mismatch
>> -		if ($line =~ /\b(kcalloc|kmalloc_array)\s*\(\s*sizeof\b/) {
>> +		if ($line =~ /\b(devm_|)(kcalloc|kmalloc_array)\s*\(\s*sizeof\b/) {
> 
> Perhaps nicer using
Indeed, much better.
I'll send a V2.

Thx for the feedback.

CJ

> 
> 		if ($line =~ /\b((?:devm_)?(?:kcalloc|kmalloc_array))\s*\*\s*sizeof\b/) {
> 
>>   			WARN("ALLOC_ARRAY_ARGS",
>> -			     "$1 uses number as first arg, sizeof is generally wrong\n" . $herecurr);
>> +			     "$1$2 uses number as first arg, sizeof is generally wrong\n" . $herecurr);
> 
> So there's only one capture group and this line doesn't need to be changed.
> 
> 
> 

