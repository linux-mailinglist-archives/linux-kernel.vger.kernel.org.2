Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDF0743907A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 09:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbhJYHlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 03:41:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:38544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229491AbhJYHlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 03:41:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0FACC60C4B;
        Mon, 25 Oct 2021 07:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635147536;
        bh=dty2dq8BdxajJV1ueGQBfAuUUbcbhBs8LnLx3npEKXI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=E2bdQiR0LuTc2LVSuNDgj4jG5NwpcV7Xm4McTvmQi90723IplQH+mfJxZTkpgPL6W
         p7YHv4+Ymy+rqbBbFB2ZuhKE+K3juUeLioIz8LQk7WgEEpKQeIMUb9brKysOhVu6Ge
         lIFDu8tpfK3pANLQog1V3lQz816Y//P9bfbrAWczPyXWsjMVk7CYRcDSqkrqo5jhSp
         q1f5Id93GcEW9tHueRGFSFWQ2teBxuMMO/673d16MaqRRGTYxs+Z9f+xhdD8rT0uy+
         SeD/Zwu8wfYnm6bK1GtsIQhYmG1ibeZiwSORQbGa30EPpoNa2jaieBKnV1o8lqWiZx
         98ME99r7D/M4Q==
Subject: Re: [PATCH v2 0/2] ARM: dts: keystone-k2*-evm: Fix mdio and dss node
 status
To:     ssantosh@kernel.org
Cc:     lokeshvutla@ti.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nishanth Menon <nm@ti.com>
References: <20210824105858.19496-1-rogerq@kernel.org>
 <20210825161736.ikx344bxfl5eqzgt@celibate>
From:   Roger Quadros <rogerq@kernel.org>
Message-ID: <ad7eb56d-f901-407d-5091-7e41a9d28fd3@kernel.org>
Date:   Mon, 25 Oct 2021 10:38:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210825161736.ikx344bxfl5eqzgt@celibate>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Santosh

On 25/08/2021 19:17, Nishanth Menon wrote:
> On 13:58-20210824, Roger Quadros wrote:
>> Hi Santosh,
>>
>> This series fixes mdio and dss status nodes from "ok" to "okay"
>>
>> As per Device Tree Specification [1], the status parameter of nodes can
>> be "okay", "disabled", etc. "ok" is not a valid parameter.
>>
>> U-boot Driver Model does not recognize status="ok" either and treats
>> the node as disabled.
> 
> ^^ I suspect the above comment in the patches is to indicate side effect
> of non-compliance.
> 
>>
>> [1] https://github.com/devicetree-org/devicetree-specification/releases/tag/v0.3
>>
>> cheers,
>> -roger
>>
>> Roger Quadros (2):
>>   ARM: dts: keystone-k2*-evm: Fix mdio node status to "okay"
>>   ARM: dts: keystone-k2g-evm: Fix dss node status to "okay"
> 
> 
> Reviewed-by: Nishanth Menon <nm@ti.com>
> 

Is there a chance to still pull these in for -next? Thanks.

cheers,
-roger
