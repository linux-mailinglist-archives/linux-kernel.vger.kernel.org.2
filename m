Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B106391B48
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 17:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235376AbhEZPMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 11:12:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33063 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235343AbhEZPMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 11:12:39 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1llvBb-00034X-Bk; Wed, 26 May 2021 15:11:07 +0000
Subject: Re: [PATCH][next] fs: dlm: Fix memory leak of object mh
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>,
        Alexander Aring <aahringo@redhat.com>,
        cluster-devel@redhat.com, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210526134039.3448305-1-colin.king@canonical.com>
 <20210526150133.GQ1955@kadam>
From:   Colin Ian King <colin.king@canonical.com>
Message-ID: <c5ea0085-969a-339f-fd92-6724cb1d928e@canonical.com>
Date:   Wed, 26 May 2021 16:11:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210526150133.GQ1955@kadam>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/05/2021 16:01, Dan Carpenter wrote:
> On Wed, May 26, 2021 at 02:40:39PM +0100, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> There is an error return path that is not kfree'ing mh after
>> it has been successfully allocates.  Fix this by free'ing it.
>>
>> Addresses-Coverity: ("Resource leak")
>> Fixes: a070a91cf140 ("fs: dlm: add more midcomms hooks")
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>> ---
>>  fs/dlm/rcom.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/fs/dlm/rcom.c b/fs/dlm/rcom.c
>> index 085f21966c72..19298edc1573 100644
>> --- a/fs/dlm/rcom.c
>> +++ b/fs/dlm/rcom.c
>> @@ -393,6 +393,7 @@ static void receive_rcom_lookup(struct dlm_ls *ls, struct dlm_rcom *rc_in)
>>  	if (rc_in->rc_id == 0xFFFFFFFF) {
>>  		log_error(ls, "receive_rcom_lookup dump from %d", nodeid);
>>  		dlm_dump_rsb_name(ls, rc_in->rc_buf, len);
>> +		kfree(mh);
> 
> Am I looking at the same code as you?  (I often am not able to review
> your patches because you're doing development on stuff that hasn't hit
> linux-next).  Anyway, to me this doesn't seem like the correct fix at
> all.  There are some other things to free and the "mh" pointer is on
> a bunch of lists so it leads to use after frees.

I've send a V2. It was indeed a brown-paper-bag bad fix.

> 
> regards,
> dan carpenter
> 

