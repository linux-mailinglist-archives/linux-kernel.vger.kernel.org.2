Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 197E439DD44
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 15:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbhFGNHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 09:07:52 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:34371 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbhFGNHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 09:07:51 -0400
Received: from [192.168.1.155] ([77.9.164.246]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mk0BK-1l6Cos0qSG-00kOFv; Mon, 07 Jun 2021 15:05:14 +0200
Subject: Re: [PATCH v6 1/5] nvmem: eeprom: at25: prepare basics for FRAM
 support
To:     Jiri Prchal <jiri.prchal@aksignal.cz>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Christian Eggers <ceggers@arri.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20210607082638.52409-1-jiri.prchal@aksignal.cz>
 <20210607082638.52409-2-jiri.prchal@aksignal.cz>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <59450413-b370-3615-b2e7-18bee71e5e0d@metux.net>
Date:   Mon, 7 Jun 2021 15:05:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210607082638.52409-2-jiri.prchal@aksignal.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:C4DI4j+2XZmprH6eEeLXTDxufxiyJDaFdaxSKE0lUrfi4atUAi/
 +Z5qGcMTDN9MsY7/U4e4z4mi9PdisUL2Kb+srpp5y44wqDj1eD31PF72IoNhiHoauFpA9nH
 y+Jx1MGfSY+JntF0DBDAWDjxeIG12T/e5XQxgXe+6hFWBSR5WGmkZd3nYPgOYLTq3zwei2L
 l7an24ZNOpXRHobEmHKTA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+E9GHgJ0e1U=:ZBk8Db3Me8JrzMd7Z0/73s
 wEl5GM9ea/8QnUaT5Jkb/jU3kd0ERWnuNygilReKVyHRyECxUHw35geMHfIOqN7IDW7Oio8ns
 triqW8WoWia11tHuLD/nq0LqPcqBEd67xwrVPuPxKryqxcTHGZY9lL2syWw/yoUqvhElvWJfs
 C6ffFuAzY4bEc8Ii6A8ypNcF2wUMCF4ytYbr9MfnyqoQl8Fc7h7qnQFGZMPeqxh74oXRH18Lb
 6zaWcTRXvGQWS0Mscct4hSa2T50w5PuRexhxofSPGNWgVbkx4xVJD3DrC7WZkZEtZRysXjvYw
 yKN9W4gBId8LqhhXOCNVQOP/2/D8oW59DRfZKo7X34PnYNlE/PG1BJVvakjMkPDp4TaCe4iDw
 RhCmtEjSMwUxCqF4pB2qhponTDuLzrfei0ewogHUYlE+1tRMHx4o47ua+NV4q13LO7D2G2Wod
 gWkKBENfjas5U0h9Fg2ficAHlz/RkQvRo2LCSEzuThWrISxVn9Jya0M14Bw+IYN3CEeJBUGql
 DXjlrwouaLE5hfApq2gwxI=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.06.21 10:26, Jiri Prchal wrote:
> Added enum and string for FRAM to expose it as "fram".

Is "at25" in subject of this patch really correct ?
Seems that patch is against to nvmen core, not at25 driver.


--mtx

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
