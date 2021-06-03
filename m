Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A73C5399F38
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 12:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbhFCKqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 06:46:32 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34256 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhFCKqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 06:46:31 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1lokqD-0000F1-Fr; Thu, 03 Jun 2021 10:44:45 +0000
Subject: Re: [PATCH][next] ASoC: rsnd: check for zero node count
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210602103722.12128-1-colin.king@canonical.com>
 <20210602112135.GF1955@kadam>
From:   Colin Ian King <colin.king@canonical.com>
Message-ID: <569dcd35-8bd5-91eb-1d6a-e0ac6506586d@canonical.com>
Date:   Thu, 3 Jun 2021 11:44:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210602112135.GF1955@kadam>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/2021 12:21, Dan Carpenter wrote:
> On Wed, Jun 02, 2021 at 11:37:22AM +0100, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> The call to rsnd_node_count can potentially return a zero node count
>> so add a check for this corner case. (Note that the two other calls
>> to rsnd_node_count in the kernel perform this check, so I think it
>> justifies adding this). This avoids using a zero nr in a devm_kcalloc
>> call.
> 
> I don't have a problem with the patch, but really the code works fine
> as is.  A better commit message is:
> 
>   Most callers of_get_child_count() check that "nr" is non-zero so it
>   causes a static checker warning when we don't do that here.  This
>   doesn't cause a problem or a crash, but having zero SSUIes (What's
>   plural of ssui?) doesn't make sense either so let's add a check.

Good idea. I'll send a V2. Thanks Dan.

> 
> regards,
> dan carpenter
> 

