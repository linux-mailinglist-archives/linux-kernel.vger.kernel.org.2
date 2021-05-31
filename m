Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E26013953ED
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 04:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbhEaChx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 22:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhEaChv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 22:37:51 -0400
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E602C061574
        for <linux-kernel@vger.kernel.org>; Sun, 30 May 2021 19:36:12 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 4CCB9425B5;
        Mon, 31 May 2021 02:36:06 +0000 (UTC)
Subject: Re: [PATCH 2/2] maintainers: Update freedesktop.org IRC channels
To:     Lukas Wunner <lukas@wunner.de>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
References: <20210529141638.5921-1-alyssa@rosenzweig.io>
 <20210529141638.5921-2-alyssa@rosenzweig.io>
 <20210530110139.GA2678@wunner.de>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <cc8fa191-a957-f6a1-7591-a5a29aec43d5@marcan.st>
Date:   Mon, 31 May 2021 11:36:04 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210530110139.GA2678@wunner.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/2021 20.01, Lukas Wunner wrote:
> On Sat, May 29, 2021 at 10:16:38AM -0400, Alyssa Rosenzweig wrote:
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1651,7 +1651,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>>   S:	Maintained
>>   W:	https://asahilinux.org
>>   B:	https://github.com/AsahiLinux/linux/issues
>> -C:	irc://chat.freenode.net/asahi-dev
>> +C:	irc://irc.oftc.net/asahi-dev
>>   T:	git https://github.com/AsahiLinux/linux.git
>>   F:	Documentation/devicetree/bindings/arm/apple.yaml
>>   F:	Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
> 
> This isn't a freedesktop.org project, so either needs to be dropped
> from the patch or the patch needs an ack from Hector Martin (+cc).

Heh, I totally forgot we had the IRC info in MAINTAINERS too when I did 
the move. Thanks :)

Acked-By: Hector Martin <marcan@marcan.st>

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
