Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8571132E5C6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 11:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbhCEKJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 05:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbhCEKI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 05:08:57 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCE9C061574
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 02:08:57 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 23C083FA1B;
        Fri,  5 Mar 2021 10:08:52 +0000 (UTC)
To:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, james.morse@arm.com, maz@kernel.org,
        tglx@linutronix.de, will@kernel.org
References: <20210302101211.2328-1-mark.rutland@arm.com>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCHv2 0/8] arm64: Support FIQ controller registration
Message-ID: <04ab9271-db3c-e6b5-2464-12cb8662bb33@marcan.st>
Date:   Fri, 5 Mar 2021 19:08:50 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210302101211.2328-1-mark.rutland@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/2021 19.12, Mark Rutland wrote:
> I'm hoping that we can get the first 2 patches in as a preparatory cleanup for
> the next rc or so, and then the rest of the series can be rebased atop that.
> I've pushed the series out to my arm64/fiq branch [4] on kernel.org, also
> tagged as arm64-fiq-20210302, atop v5.12-rc1.

Just a reminder to everyone that filesystems under v5.12-rc1 go explodey 
if you use a swap file [1].

I don't care for the M1 bring-up series (we don't *have* storage), but 
it's worth pointing out for other people who might test this.

Modulo that,

Tested-by: Hector Martin <marcan@marcan.st>

[1] 
https://lore.kernel.org/lkml/CAHk-=wjnzdLSP3oDxhf9eMTYo7GF-QjaNLBUH1Zk3c4A7X75YA@mail.gmail.com/

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
