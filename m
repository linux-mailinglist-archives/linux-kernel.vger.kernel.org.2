Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1155C4363B3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 16:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbhJUOEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 10:04:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:41350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231408AbhJUOEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 10:04:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D8E54611F2;
        Thu, 21 Oct 2021 14:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634824913;
        bh=1K4FOjuwHxKfG/gUkAo3YMLrnfArkKZtZD5p3SgiQqs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fRM+081jDXy0l57SodxJ1wJqcnn43yuaEBlbKYAPyRWoI1Uf8wMGXxXpmj92qU6V4
         YSxt4tF5/gFJ+FygCvlJCXySRz6Yz6LyxSJCpXOJbqOUhDFbLA1QcV6+fXakYlDeu0
         cUcwdW2hCiJM3pxhg9zNRqamqc9xg/k2qe2jSvtolbIiDW5HH158dd6jn6RL2QFU1h
         /MmQvIf5vS7RrHYyHMFyj9FZ1J17V2pShGKWzG7KcSVklqtngBC/BR4g77ypxFFxw9
         Eu573TkxXwbgB6ydyskiPpbxz08UErBV+f5qc3DNOYKAa5DhZiSm/KFINXvb8eAsX0
         hSJWixHzlC7Ew==
Subject: Re: [PATCH v2] nios2: Make NIOS2_DTB_SOURCE_BOOL depend on
 !COMPILE_TEST
To:     Randy Dunlap <rdunlap@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org
References: <20211020191116.2510450-1-linux@roeck-us.net>
 <4b747abf-73f1-fa97-cb2b-23d8c838426e@infradead.org>
From:   Dinh Nguyen <dinguyen@kernel.org>
Message-ID: <dc50a6de-da50-c09d-3490-754a638033dc@kernel.org>
Date:   Thu, 21 Oct 2021 09:01:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <4b747abf-73f1-fa97-cb2b-23d8c838426e@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/20/21 3:15 PM, Randy Dunlap wrote:
> On 10/20/21 12:11 PM, Guenter Roeck wrote:
>> nios2:allmodconfig builds fail with
>>
>> make[1]: *** No rule to make target 'arch/nios2/boot/dts/""',
>>     needed by 'arch/nios2/boot/dts/built-in.a'.  Stop.
>> make: [Makefile:1868: arch/nios2/boot/dts] Error 2 (ignored)
>>
>> This is seen with compile tests since those enable NIOS2_DTB_SOURCE_BOOL,
>> which in turn enables NIOS2_DTB_SOURCE. This causes the build error
>> because the default value for NIOS2_DTB_SOURCE is an empty string.
>> Disable NIOS2_DTB_SOURCE_BOOL for compile tests to avoid the error.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> 
> Thanks, I've seen this problem also.
> 
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> 

Does this need a Fixes tag?

Fixes: 2fc8483fdcde ("nios2: Build infrastructure")

Dinh
