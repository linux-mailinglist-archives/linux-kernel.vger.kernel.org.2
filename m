Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93B6F39E422
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 18:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233783AbhFGQby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 12:31:54 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:49677 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbhFGQXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 12:23:12 -0400
Received: from MacBook-AirM1.fshome ([92.117.144.110]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mzy6q-1lSijQ3HuQ-00x1SO; Mon, 07 Jun 2021 18:21:10 +0200
Subject: Re: [PATCH 1/4] platform/x86: hdaps: Constify static attribute_group
 struct
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "David E. Box" <david.e.box@linux.intel.com>,
        Justin Ernst <justin.ernst@hpe.com>,
        Frank Seidel <frank@f-seidel.de>
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Travis <mike.travis@hpe.com>
References: <20210605203807.60547-1-rikard.falkeborn@gmail.com>
 <20210605203807.60547-2-rikard.falkeborn@gmail.com>
From:   Frank Seidel <frank@f-seidel.de>
Message-ID: <5f39a247-25ce-03b0-21f2-506bae576117@f-seidel.de>
Date:   Mon, 7 Jun 2021 18:21:09 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210605203807.60547-2-rikard.falkeborn@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
X-Provags-ID: V03:K1:ji5HeJeUwPzkBHckWfIOBoZAIiKvAwWr+0bWxMdxTk0DGV193K9
 4GJVbuOXhMFWjZ19mVOM8KQGt8FKQ7ZVEvnK9HoDwYkCMsWhHb4JS8R/t8/pcsbjGNHMdAy
 SrEApo40udNRWtCzN4m0Thsrm4JjeolWd8l6XsJeBoXLHVdG0aglLKMllGMfhZ/dSYwedDJ
 DADpaUmEj42Ec54HYB77A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:pqcBjBtAtv4=:2rFKCoRTIO1S/rLCt5lHSr
 NOGIf8aWc2qmtamnVP6IROpRvr9WZIPJ1k+kU44wCO13q+ocP86tdgNepW2MeGnJsyRks4iS7
 TIVDZ8CFCfzXwKwSJbSBFj8yChROwbXHi9tPp71FPnUguK0uvNrXPqW9+6ommNXZHpVGM6a8S
 tjjM5zXnBcDqlGRtOU3iprWB7OXWyeyHlhSFuT+ov0xFRSfkGhSgTbG55lnxPvLhVdFvtm/ls
 SDcpLC78ic9HKNrJ+VAmcGxyDl3lcwYFBYfeLhkLPtqvboaxUFiUeA5SQnboddf6+bBdc2QPR
 FlS0Ggl+bvXdPHTq6ToxGQgr1NA2G++2AM3ys/DZAT0JUJG4Dd0ddhlTl8Br+2Lfr8EcLwB5b
 8X5tBtgpKg7By0PG69o8NbpT1RU/0bac4kfuVvdfh7HlSKnZIC7NK9x7ggU+IPwUQd9fuuH1E
 oWF4L9uDmWrl1p33QzkkaUc2a4SzANDbFKf3z7kQPIfKqVw5se7cdVutVYvv/Zw5Vf/mbD2Ox
 zuDkyYruK9gBmVLwzRU/S0=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The only use of hdaps_attribute_group is to pass its address to
> sysfs_create_group() and sysfs_remove_group(), both which takes pointers
> to const attribute_group structs. Make it const to allow the compiler to
> put it in read-only memory.
>
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>

Thanks for the patch and keeping me informed.

Reviewed-by: Frank Seidel <frank@f-seidel.de>

> ---
>   drivers/platform/x86/hdaps.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/platform/x86/hdaps.c b/drivers/platform/x86/hdaps.c
> index a72270932ec3..9996485f5295 100644
> --- a/drivers/platform/x86/hdaps.c
> +++ b/drivers/platform/x86/hdaps.c
> @@ -462,7 +462,7 @@ static struct attribute *hdaps_attributes[] = {
>   	NULL,
>   };
>   
> -static struct attribute_group hdaps_attribute_group = {
> +static const struct attribute_group hdaps_attribute_group = {
>   	.attrs = hdaps_attributes,
>   };
>   
>
