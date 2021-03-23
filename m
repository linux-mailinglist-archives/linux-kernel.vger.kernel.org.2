Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9BA3466C4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 18:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbhCWRur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 13:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbhCWRug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 13:50:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8F2C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 10:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=cYs10JHyoH5yneJP4u6+GykhJn1wBKFRR7cwcnvw6Do=; b=GtuOKmEvP5K2FUuiOup0T3CKZ9
        24YJ2Qm/iMTdJSYxmWg/71DkEzbxagYXCwBYCW+u1e9msRuJ6m6eXfwGiFdfKACpa1bXCcQqx9/hQ
        n0/NcNjVcwvSHQBL7nVmyuPoQKdQGV9yG4EeAjeJnrcKG/+UX2H4Dfo01Eo+OFGVnjOBh4iERx0Ht
        KDMlYutRKY7gSLHic4unMobis2RnQqrg47iTrZ+wLIL0xWvkZ/YzL30VLZTUdMd/ZwFKh+xqO/Iey
        QMFJpwtspR0X1f2LVzDuWyrIN0wm7xhDFBIjYS1VG/0Nzkq0E4R2dr9IsOjwtrfF/6bVUaoB9Hs/O
        CFrlq1LA==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOlAE-00AMiA-V5; Tue, 23 Mar 2021 17:50:06 +0000
Subject: Re: [PATCH V2]staging: rtl8723bs: Trivial typo fix
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        gregkh@linuxfoundation.org, ross.schm.dev@gmail.com,
        yanaijie@huawei.com, amarjargal16@gmail.com,
        matthew.v.deangelis@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <20210323092300.1740913-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <118087c5-e4f5-37da-1302-ee8206e9519c@infradead.org>
Date:   Tue, 23 Mar 2021 10:49:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210323092300.1740913-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/21 2:23 AM, Bhaskar Chowdhury wrote:
> s/netowrk/network/
> 
> ..and an extra space has removed from the sentence.
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>   Changes from V1:
>   I have missed to remove an extra space in the sentence,
>   corrected,Greg pointed out,thanks.
> 
>  drivers/staging/rtl8723bs/core/rtw_mlme.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> index 2c9425e2a1e9..562bc929be4c 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> @@ -599,7 +599,7 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
>  		}
> 
>  		if (rtw_roam_flags(adapter)) {
> -			/* TODO: don't  select netowrk in the same ess as oldest if it's new enough*/
> +			/* TODO: don't select network in the same ess as oldest if it's new enough*/
>  		}
> 
>  		if (oldest == NULL || time_after(oldest->last_scanned, pnetwork->last_scanned))
> --


-- 
~Randy

