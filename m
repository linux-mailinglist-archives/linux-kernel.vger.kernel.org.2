Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5178D3AE6E2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 12:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbhFUKUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 06:20:55 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:45669 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhFUKUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 06:20:54 -0400
Received: from [192.168.1.155] ([95.118.106.223]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MKKIZ-1lhjOg32gp-00LjdJ; Mon, 21 Jun 2021 12:18:17 +0200
Subject: Re: [PATCH] drivers/nvme/host: Use kobj_to_dev() API
To:     Christoph Hellwig <hch@lst.de>,
        zhouchuangao <zhouchuangao@vivo.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1624025458-56465-1-git-send-email-zhouchuangao@vivo.com>
 <20210618141817.GA18781@lst.de>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <fd15a968-3d75-ba22-b0b0-4ed4d2a66372@metux.net>
Date:   Mon, 21 Jun 2021 12:18:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210618141817.GA18781@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:rnCQHJ4P3jPjEp+FPv2c+6ZrOb0YN2+ZVhSqLJgY6e76gRvpjJL
 sjIS8QrTWo+3stOtTgPsGVR6Y9jq9d5PlufWYhvkzdyqQ/tIz4XsDelUq92T7O6NozhWKcD
 rN2BTP5V9R+533WRcIH+yoLlf/E4PC85XE1eOx9HKyjSofGvmSmsQgfa0BHPAyPikZyCm7w
 yo04NAOAy8IHu/7VNvU2Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:FBmQwYU7PMA=:0sIW8ZRkWQ7m2wGPiKqs/J
 HKjG5Vr/D1ITsvGBImNzWN4EZ9BjQV7wElx1Pl3Itfsu2J1TKaWaSqcoXgf5IRamQy0Hf3b/f
 ORAVQlRVwOVgKSKiVcWc/mNXFWjBUB267ar/MY+NaNZTpMcVwy/087U9ACwU7DZq3IbfT52yt
 ihuH7uBR7CacmYO09CekGmw/coKqVeHXduni5HtzYMWM2d53hLZvzLuCKDW6B+NUGm8QAON+c
 xXORtgcEXLu8ADTSQ8vflGsLaoOhywFfE01Ay06xw7EnoslBah68ZrJEPrmyICocOHeaviF8g
 UNOJJNKCmRodbwe58JMSTT5KgTAUyoKMMxCCsPAlsKYk+wo5J1A/HU5sUODlGn3jZUopexjsI
 JLN7xG0TMsfPHmsROqBSMwSPcwwfmj5g46TZP/M8MODyQVHR3L8N1vfuRPZvJXBLkSGtAIyhg
 Vf0QbEWAcGkujjqOsqcz85VYki9bLnXyq4xRir6djokDwSLZjF/wOPTHfDvuyWrWelwfcphUL
 v3FvcQzyGYhAIPsE3LT9m8=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.06.21 16:18, Christoph Hellwig wrote:
> On Fri, Jun 18, 2021 at 07:10:58AM -0700, zhouchuangao wrote:
>> Use kobj_to_dev() API instead of container_of().
> 
> Why?  That just makes the code harder to read.

Why so ? Why to we have kobj_to_dev() at all ?
Do you suggest, we shall get rid of it (and all similar ones) ?

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
