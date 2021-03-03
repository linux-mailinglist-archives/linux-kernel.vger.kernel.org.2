Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E310432BD07
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444253AbhCCPQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 10:16:02 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:58334 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240329AbhCCK1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:27:53 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lHOij-000445-Ev; Wed, 03 Mar 2021 10:27:09 +0000
Subject: Re: [PATCH][next] mtd: nand: Fix error handling in nand_prog_page_op
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-mtd@lists.infradead.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210303094246.5724-1-colin.king@canonical.com>
 <20210303104651.2d49fb2c@xps13>
From:   Colin Ian King <colin.king@canonical.com>
Message-ID: <e7893539-9510-e149-f02b-f88c33f8175b@canonical.com>
Date:   Wed, 3 Mar 2021 10:27:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210303104651.2d49fb2c@xps13>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/2021 09:46, Miquel Raynal wrote:
> Hi Colin,
> 
> Colin King <colin.king@canonical.com> wrote on Wed,  3 Mar 2021
> 09:42:46 +0000:
> 
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> The less than zero comparison with status is always false because status
>> is a u8. Fix this by using ret as the return check for the call to
>> chip->legacy.waitfunc() and checking on this and assigning status to ret
>> if it is OK.
>>
>> Addresses-Coverity: ("Unsigned compared against 0")
>> Fixes: 52f67def97f1 ("mtd: nand: fix error handling in nand_prog_page_op() #1")
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> 
> Thanks for the fix, but this has been handled just an hour ago :)

Ah, missed that. Glad to know it's fixed.

> 
> Cheers,
> Miquèl
> 

