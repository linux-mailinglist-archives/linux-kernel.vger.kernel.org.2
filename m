Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D2B353897
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 17:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhDDPUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 11:20:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:45092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229861AbhDDPUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 11:20:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 218F461168;
        Sun,  4 Apr 2021 15:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617549628;
        bh=fon5VpF7W4i/Q3VcfvR2vAk69Nk2HsItFV8D45jYR2s=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=h1X+Qw+EKIKcjrnkJI77Wz28jXNfr4D1V1voS0+SzZ614DAmPTRzWazpS4BU56qV6
         XGKffL3mePWSH0IGcU29pWsKbyT7FXgsloewXPlDJf0/Nl8psZrK1O2efLzRUJ8kSm
         GrquvaNz/+MZ+gVndEBJ2t7ncJk+2l3bMVl0NlHkdVZMVxHL/E6ae8DKxJ19FV5hAw
         WX2tSErrBiInH288/lIchnoXOd5uS5x02YpFKHSowaT0+iTfZRu6QUKPsBuxGSs0a7
         XHgUk0fgYnEddfqGsfoTIyr43LHFJmhJJPG1yOLWOSja3iFm4+LR+9WZvBsTqUy/Sr
         5sY4J+KcZ6eqg==
Subject: Re: [PATCHv2 RESEND] firmware: stratix10-svc: build only on 64-bit
 ARM
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        kernel test robot <lkp@intel.com>,
        Richard Gong <richard.gong@linux.intel.com>
References: <20210404124609.122377-1-dinguyen@kernel.org>
 <YGnIdZ5mbTJnREGB@kroah.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
Message-ID: <943c4179-409d-24f5-4324-7f2242920cc5@kernel.org>
Date:   Sun, 4 Apr 2021 10:20:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YGnIdZ5mbTJnREGB@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/4/21 9:08 AM, Greg KH wrote:
> On Sun, Apr 04, 2021 at 07:46:09AM -0500, Dinh Nguyen wrote:
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>>
>> The Stratix10 service layer and RCU drivers are useful only on
>> Stratix10, so on ARMv8.  Compile testing the RCU driver on 32-bit ARM
>> fails:
>>
>>    drivers/firmware/stratix10-rsu.c: In function 'rsu_status_callback':
>>    include/linux/compiler_types.h:320:38: error: call to '__compiletime_assert_179'
>>      declared with attribute error: FIELD_GET: type of reg too small for mask
>>      _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>>    ...
>>    drivers/firmware/stratix10-rsu.c:96:26: note: in expansion of macro 'FIELD_GET'
>>      priv->status.version = FIELD_GET(RSU_VERSION_MASK,
>>
>> Fixes: 4483397b0353 ("ARM: socfpga: drop ARCH_SOCFPGA")
> 
> Where is this commit id?  I don't see it in Linus's tree, is it
> somewhere else?
> 

It's in the for-next branch in the soc tree. This patch fixes a patch 
that was just recently submitted by Krzysztof.

Dinh
