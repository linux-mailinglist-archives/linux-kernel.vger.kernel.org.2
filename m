Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1353422AC6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 16:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235845AbhJEOSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 10:18:45 -0400
Received: from mx.socionext.com ([202.248.49.38]:22635 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235518AbhJEOSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 10:18:40 -0400
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 05 Oct 2021 23:16:49 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id EA3BC2059034;
        Tue,  5 Oct 2021 23:16:48 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 5 Oct 2021 23:16:48 +0900
Received: from yuzu2.css.socionext.com (yuzu2 [172.31.9.57])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 90EB9B62B7;
        Tue,  5 Oct 2021 23:16:48 +0900 (JST)
Received: from [10.212.181.36] (unknown [10.212.181.36])
        by yuzu2.css.socionext.com (Postfix) with ESMTP id E5BF3B62B3;
        Tue,  5 Oct 2021 23:16:47 +0900 (JST)
Subject: Re: [PATCH 4/5] dt-bindings: clock: uniphier: Add clock binding for
 SoC-glue
To:     Rob Herring <robh@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
References: <1633399706-1251-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1633399706-1251-5-git-send-email-hayashi.kunihiko@socionext.com>
 <1633436798.596710.3226801.nullmailer@robh.at.kernel.org>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <4e6d39ec-4c49-9dfb-9428-901dca940989@socionext.com>
Date:   Tue, 5 Oct 2021 23:16:47 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1633436798.596710.3226801.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; delsp=yes
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/10/05 21:26, Rob Herring wrote:
> On Tue, 05 Oct 2021 11:08:25 +0900, Kunihiko Hayashi wrote:
>> Update binding document for clocks implemented in SoC-glue.
>>
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> ---
>>   .../bindings/clock/socionext,uniphier-clock.yaml         | 16
> ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/clock/socionext,uniphier-clock.yaml:51
> :1: [error] syntax error: found character '\t' that cannot start any token
> (syntax)
I made mistake. I'll fix it in next.

Thank you,

---
Best Regards
Kunihiko Hayashi
