Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 014D83FE7C1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 04:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243133AbhIBCjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 22:39:17 -0400
Received: from marcansoft.com ([212.63.210.85]:46340 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229679AbhIBCjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 22:39:17 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 2C5AC41EE3;
        Thu,  2 Sep 2021 02:38:15 +0000 (UTC)
Subject: Re: [PATCH] maintainers: Add Alyssa Rosenzweig as M1 reviewer
To:     Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sven Peter <sven@svenpeter.dev>,
        Arnd Bergmann <arnd@kernel.org>
References: <20210823151738.6273-1-alyssa@rosenzweig.io>
 <3112bc2c-7c6a-3190-26cd-a873b4029429@marcan.st> <YS/p7Omw+IeyHeaR@sunset>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <cd7a9bc2-4993-4a14-c17c-d838351f9396@marcan.st>
Date:   Thu, 2 Sep 2021 11:38:14 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YS/p7Omw+IeyHeaR@sunset>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/09/2021 06.00, Alyssa Rosenzweig wrote:
>>> Add myself as a reviewer for Asahi Linux (Apple M1) patches.
>>>
>>> I would like to be CC'ed on Asahi Linux patches for review and testing.
>>> I am also collecting Asahi Linux patches downstream, rebasing on
>>> linux-next periodically, and would like to be notified of what to
>>> cherry-pick from lists.
>>>
>>> Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
>>> Cc: Hector Martin <marcan@marcan.st>
>>> Cc: Sven Peter <sven@svenpeter.dev>
>>
>> Acked-by: Hector Martin <marcan@marcan.st>
> 
> Do you have commit rights to the kernel? If so, could you push it?
> Otherwise, could someone else?

You need an ack from Sven too, since he's the maintainer of DART.

After that, maybe this can go through Arnd's tree?

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
