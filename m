Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 094FF391A08
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 16:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234669AbhEZOXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 10:23:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59789 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234554AbhEZOXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 10:23:15 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1lluPn-0007xi-2R; Wed, 26 May 2021 14:21:43 +0000
Subject: Re: [PATCH][next] fs: dlm: Fix memory leak of object mh
To:     Alexander Ahring Oder Aring <aahringo@redhat.com>
Cc:     Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>, cluster-devel@redhat.com,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210526134039.3448305-1-colin.king@canonical.com>
 <CAK-6q+jXZ2MGUw3QPKHwoNDMLdTookO7rq9LpGNx=ZGAn1pqOQ@mail.gmail.com>
From:   Colin Ian King <colin.king@canonical.com>
Message-ID: <88c69c56-7296-01a7-e283-26811a52243e@canonical.com>
Date:   Wed, 26 May 2021 15:21:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAK-6q+jXZ2MGUw3QPKHwoNDMLdTookO7rq9LpGNx=ZGAn1pqOQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/05/2021 15:19, Alexander Ahring Oder Aring wrote:
> Hi,
> 
> On Wed, May 26, 2021 at 9:40 AM Colin King <colin.king@canonical.com> wrote:
>>
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
>>         if (rc_in->rc_id == 0xFFFFFFFF) {
>>                 log_error(ls, "receive_rcom_lookup dump from %d", nodeid);
>>                 dlm_dump_rsb_name(ls, rc_in->rc_buf, len);
>> +               kfree(mh);
>>                 return;
> 
> This seems to be a bigger issue, we cannot revert the buffer
> allocation with a kfree, we cannot revert it at all. We should avoid
> any error handling between create_rcom() and send_rcom(). In general
> between get_buffer/commit_buffer.
> 
> I don't see a problem with moving the error handling before
> create_rcom(). That should fix the issue.

Good point, I'll send a V2 in a while

> 
> - Alex
> 

