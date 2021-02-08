Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 515DF314397
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 00:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbhBHXRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 18:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbhBHXRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 18:17:51 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35CCC061786;
        Mon,  8 Feb 2021 15:17:10 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 562004207F;
        Mon,  8 Feb 2021 23:17:06 +0000 (UTC)
Subject: Re: [PATCH 01/18] dt-bindings: vendor-prefixes: add AAPL prefix
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh@kernel.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, devicetree@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        soc@kernel.org, Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org
References: <20210204203951.52105-1-marcan@marcan.st>
 <20210204203951.52105-2-marcan@marcan.st>
 <20210208102730.p4nhsl35oowsklv2@kozik-lap>
 <20210208173215.GA1567700@robh.at.kernel.org>
 <20210208181248.tbgffdwghlseawic@kozik-lap>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <0cbe3536-2415-a2a4-75e6-0e1c6deffd42@marcan.st>
Date:   Tue, 9 Feb 2021 08:17:03 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210208181248.tbgffdwghlseawic@kozik-lap>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/2021 03.12, Krzysztof Kozlowski wrote:
> Mentioned grep brings only one result:
> arch/powerpc/platforms/powermac/pic.c:   * cases where the APPL,interrupts property is completely

You want to grep for 'AAPL', not 'APPL' :-)

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
