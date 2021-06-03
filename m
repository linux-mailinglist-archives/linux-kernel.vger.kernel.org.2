Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE10399CF1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 10:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhFCIqo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 3 Jun 2021 04:46:44 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:34400 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229486AbhFCIqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 04:46:43 -0400
Received: from [77.244.183.192] (port=63380 helo=[192.168.178.41])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <luca@lucaceresoli.net>)
        id 1loiyH-000Csm-Ra; Thu, 03 Jun 2021 10:44:57 +0200
Subject: Re: [PATCH RESEND] clk: vc5: fix output disabling when enabling a FOD
To:     Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, Adam Ford <aford173@gmail.com>
References: <20210527211647.1520720-1-luca@lucaceresoli.net>
 <162262084596.4130789.198191855440093780@swboyd.mtv.corp.google.com>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <8b763492-b2b3-93d3-9801-2f2f0ec90241@lucaceresoli.net>
Date:   Thu, 3 Jun 2021 10:44:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <162262084596.4130789.198191855440093780@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca@lucaceresoli.net
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 02/06/21 10:00, Stephen Boyd wrote:
> Quoting Luca Ceresoli (2021-05-27 14:16:47)
>> On 5P49V6965, when an output is enabled we enable the corresponding
>> FOD. When this happens for the first time, and specifically when writing
>> register VC5_OUT_DIV_CONTROL in vc5_clk_out_prepare(), all other outputs
>> are stopped for a short time and then restarted.
>>
>> According to Renesas support this is intended: "The reason for that is VC6E
>> has synced up all output function".
>>
>> This behaviour can be disabled at least on VersaClock 6E devices, of which
>> only the 5P49V6965 is currently implemented by this driver. This requires
>> writing bit 7 (bypass_sync{1..4}) in register 0x20..0x50.  Those registers
>> are named "Unused Factory Reserved Register", and the bits are documented
>> as "Skip VDDO<N> verification", which does not clearly explain the relation
>> to FOD sync. However according to Renesas support as well as my testing
>> setting this bit does prevent disabling of all clock outputs when enabling
>> a FOD.
>>
>> See "VersaClock ® 6E Family Register Descriptions and Programming Guide"
>> (August 30, 2018), Table 116 "Power Up VDD check", page 58:
>> https://www.renesas.com/us/en/document/mau/versaclock-6e-family-register-descriptions-and-programming-guide
>>
>> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
>> Reviewed-by: Adam Ford <aford173@gmail.com>
>>
>> ---
> 
> Any Fixes tag for this patch?

I didn't add any as there is no commit that is clearly introducing the
problem. This patch fixes a behavior of the chip, which is there by
design by causes problems in some use cases.

If a Fixes tag is required than I guess it should be the commit adding
support for the 5P49V6965, which is the only supported variant of VC[56]
having having the problematic behavior _and_ the reserved register bits
to prevent it. However I hardly could blame the author of that code for
such a "peculiar" chip behaviour. Do you still want me to add such a tag?

-- 
Luca

