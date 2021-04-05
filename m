Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C34C354252
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 15:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235685AbhDENJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 09:09:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:47686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235568AbhDENJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 09:09:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 89F896139E;
        Mon,  5 Apr 2021 13:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617628144;
        bh=0/o1r7qzvMsvIJ/DrPM+ogHpHxdcaePjrlaMSyUSuZw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=sLnZUfA/qsHgP6wgslai5yLV+TQwTCPvv9GL83ieSFcRgqK3idaeBNlGO3NOdcK3a
         Fe8FREuOcIjT8u6a8p8KDugBF08IvkdX5WtHdxu5up5AIzRKwaoVUTB1De5VdS3vvw
         JdsvzEhiWk8KJxFkhKUIKJOvQvQynJDxPOjdncnxcGZ2qIYheZmWjhv0WLTLxgQvXd
         gpXCrYPzOczD9DsqtpYgGpXyHRuensHkH8O1TmZkd+eXD5mgxw9O5GGhTrYohulNNx
         Ny6nh1SETZGjNooMY6ZQP33VL4jXkAFSZaz6CTgj+QfQmoW6ZzIM41b+MvCvk9SfAr
         mQPSu24dN7pOQ==
Subject: Re: [PATCHv2 RESEND] firmware: stratix10-svc: build only on 64-bit
 ARM
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        kernel test robot <lkp@intel.com>,
        Richard Gong <richard.gong@linux.intel.com>
References: <20210404124609.122377-1-dinguyen@kernel.org>
 <YGnIdZ5mbTJnREGB@kroah.com>
 <943c4179-409d-24f5-4324-7f2242920cc5@kernel.org>
 <YGrm2GFdX/PMXiwk@kroah.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
Message-ID: <d944c802-00a3-30ba-6da8-f35b629bb5d3@kernel.org>
Date:   Mon, 5 Apr 2021 08:09:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YGrm2GFdX/PMXiwk@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/5/21 5:30 AM, Greg KH wrote:
> On Sun, Apr 04, 2021 at 10:20:26AM -0500, Dinh Nguyen wrote:
>>
>>
>> On 4/4/21 9:08 AM, Greg KH wrote:
>>> On Sun, Apr 04, 2021 at 07:46:09AM -0500, Dinh Nguyen wrote:
>>>> From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>>>>
>>>> The Stratix10 service layer and RCU drivers are useful only on
>>>> Stratix10, so on ARMv8.  Compile testing the RCU driver on 32-bit ARM
>>>> fails:
>>>>
>>>>     drivers/firmware/stratix10-rsu.c: In function 'rsu_status_callback':
>>>>     include/linux/compiler_types.h:320:38: error: call to '__compiletime_assert_179'
>>>>       declared with attribute error: FIELD_GET: type of reg too small for mask
>>>>       _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>>>>     ...
>>>>     drivers/firmware/stratix10-rsu.c:96:26: note: in expansion of macro 'FIELD_GET'
>>>>       priv->status.version = FIELD_GET(RSU_VERSION_MASK,
>>>>
>>>> Fixes: 4483397b0353 ("ARM: socfpga: drop ARCH_SOCFPGA")
>>>
>>> Where is this commit id?  I don't see it in Linus's tree, is it
>>> somewhere else?
>>>
>>
>> It's in the for-next branch in the soc tree. This patch fixes a patch that
>> was just recently submitted by Krzysztof.
> 
> Then it needs to go through that tree, while you sent it "To:" me, and I
> can't do anything with it at the moment :(
> 

Ah okay, got it, thanks!

Dinh
