Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A865B3974E1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 16:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234281AbhFAOFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 10:05:12 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48948 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234074AbhFAOFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 10:05:11 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 38CDD21915;
        Tue,  1 Jun 2021 14:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622556209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pA/k3YdGmgOZom7OBwq+qx+OBhw/xvqeZ7Bq0AxBTxc=;
        b=zcePxBDATvHoSRTHXK92KNDVj/eg6jO3AFn1x42vKtpXsyMQQ+L3Ec8geQLqHc/uIZwlrZ
        upuJ0yIYKgsvfzejpuc0grVgToJJXPm43VmJtJfxmsXbIApikVGAPDLDVq8FvPvbHgPysN
        f6Um2BnnDILXY0KaeZSTMmfseNEk/xM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622556209;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pA/k3YdGmgOZom7OBwq+qx+OBhw/xvqeZ7Bq0AxBTxc=;
        b=DTzt2ps4UdbWPNZe1UJJQzKHGXR8HBk58bliBjw//ak54gNGByO7VO3j6AoU+vI05u3OWw
        tjPyaAaOPo/3P4AQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 3B6A0118DD;
        Tue,  1 Jun 2021 14:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622556209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pA/k3YdGmgOZom7OBwq+qx+OBhw/xvqeZ7Bq0AxBTxc=;
        b=zcePxBDATvHoSRTHXK92KNDVj/eg6jO3AFn1x42vKtpXsyMQQ+L3Ec8geQLqHc/uIZwlrZ
        upuJ0yIYKgsvfzejpuc0grVgToJJXPm43VmJtJfxmsXbIApikVGAPDLDVq8FvPvbHgPysN
        f6Um2BnnDILXY0KaeZSTMmfseNEk/xM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622556209;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pA/k3YdGmgOZom7OBwq+qx+OBhw/xvqeZ7Bq0AxBTxc=;
        b=DTzt2ps4UdbWPNZe1UJJQzKHGXR8HBk58bliBjw//ak54gNGByO7VO3j6AoU+vI05u3OWw
        tjPyaAaOPo/3P4AQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id VYvwAzA+tmAuHAAALh3uQQ
        (envelope-from <colyli@suse.de>); Tue, 01 Jun 2021 14:03:28 +0000
Subject: Re: [PATCH -next] lib: crc64: Fix kernel-doc warning
To:     YueHaibing <yuehaibing@huawei.com>, akpm@linux-foundation.org,
        grandmaster@al2klimov.de
Cc:     linux-kernel@vger.kernel.org
References: <20210601135851.15444-1-yuehaibing@huawei.com>
From:   Coly Li <colyli@suse.de>
Message-ID: <e76b42f9-e5b0-f5f3-9776-b322c1aa3be3@suse.de>
Date:   Tue, 1 Jun 2021 22:03:26 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210601135851.15444-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/21 9:58 PM, YueHaibing wrote:
> Fix W=1 kernel build warning:
>
> lib/crc64.c:40: warning:
>  bad line:         or the previous crc64 value if computing incrementally.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Coly Li <colyli@suse.de>


Thanks.

Coly Li

> ---
>  lib/crc64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/crc64.c b/lib/crc64.c
> index 47cfa054827f..9f852a89ee2a 100644
> --- a/lib/crc64.c
> +++ b/lib/crc64.c
> @@ -37,7 +37,7 @@ MODULE_LICENSE("GPL v2");
>  /**
>   * crc64_be - Calculate bitwise big-endian ECMA-182 CRC64
>   * @crc: seed value for computation. 0 or (u64)~0 for a new CRC calculation,
> -	or the previous crc64 value if computing incrementally.
> + *       or the previous crc64 value if computing incrementally.
>   * @p: pointer to buffer over which CRC64 is run
>   * @len: length of buffer @p
>   */

