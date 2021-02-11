Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE73031949E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 21:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbhBKUjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 15:39:03 -0500
Received: from pv50p00im-zteg10021301.me.com ([17.58.6.46]:33844 "EHLO
        pv50p00im-zteg10021301.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229873AbhBKUi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 15:38:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1613075876;
        bh=+UqQfeVaYIVGyWxiq1h9v749UZHZAQFSnLtzkXJ9+PE=;
        h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type;
        b=WO21kUgZgUTk0G7hVFeat58bpckwW2lz+GmBh9Zbk8KKotz9b1pNm9CgtCnrb0kda
         tMdYdYcm0kp+b3VdqiGzW8zJDMrXF7+dqlmos+Gofv/xRaIQZMtlw/p2hurCaRD4Dc
         +T/5RIF9Drs2MdtXPPDTU2x9QjwL80fNxoRn7NARb+EANRrDy1Tv1gnf9CRz/h/VSm
         zuVlh3FbN7ig49oklLVjgBPu9/0/ycxbzaaS+aldYjpVaunm48MRYFXDQ/Wuseqh2b
         K8w9cPR3yANGI/mQa/o/fwYpKE55lQg6YRNNBfQtkRkS9WjAq8DyHCkGq8z0h3libT
         tOcnr730kaGvQ==
Received: from [192.168.31.114] (unknown [45.250.50.68])
        by pv50p00im-zteg10021301.me.com (Postfix) with ESMTPSA id 11AFACC0562;
        Thu, 11 Feb 2021 20:37:53 +0000 (UTC)
Subject: Re: [PATCH] staging: vt6656: Fixed issue with alignment in rf.c
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     forest@alittletooquiet.net, oscar.carter@gmx.com,
        tvboxspy@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <20210211152426.10008-1-pritthijit.nath@icloud.com>
 <YCWTlWj4KHT6Okq/@kroah.com>
From:   Pritthijit Nath <pritthijit.nath@icloud.com>
Message-ID: <141aa6fe-972c-a9a2-f321-65a98ebccc41@icloud.com>
Date:   Fri, 12 Feb 2021 02:07:50 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YCWTlWj4KHT6Okq/@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-11_07:2021-02-11,2021-02-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2102110162
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/02/21 1:59 am, Greg KH wrote:
> On Thu, Feb 11, 2021 at 08:54:26PM +0530, Pritthijit Nath wrote:
>> This change fixes a checkpatch CHECK style issue for "Alignment should match open parenthesis".
>>
>> Signed-off-by: Pritthijit Nath <pritthijit.nath@icloud.com>
>> ---
>>  drivers/staging/vt6656/rf.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/staging/vt6656/rf.c b/drivers/staging/vt6656/rf.c
>> index 5b8da06e3916..bcd4d467e03a 100644
>> --- a/drivers/staging/vt6656/rf.c
>> +++ b/drivers/staging/vt6656/rf.c
>> @@ -687,7 +687,7 @@ static int vnt_rf_set_txpower(struct vnt_private *priv, u8 power,
>>  
>>  			if (hw_value < ARRAY_SIZE(vt3226d0_lo_current_table)) {
>>  				ret = vnt_rf_write_embedded(priv,
>> -					vt3226d0_lo_current_table[hw_value]);
>> +							    vt3226d0_lo_current_table[hw_value]);
>>  				if (ret)
>>  					return ret;
>>  			}
>> -- 
>> 2.25.1
> 
> Please run this change, with the changelog above, through
> checkpatch.pl, fix that, and resend.
> 
> thanks,
> 
> greg k-h
> 

This change fixes a checkpatch CHECK style issue for "Alignment should 
match open parenthesis".

Signed-off-by: Pritthijit Nath <pritthijit.nath@icloud.com>
---
 drivers/staging/vt6656/rf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vt6656/rf.c b/drivers/staging/vt6656/rf.c
index 5b8da06e3916..bcd4d467e03a 100644
--- a/drivers/staging/vt6656/rf.c
+++ b/drivers/staging/vt6656/rf.c
@@ -687,7 +687,7 @@ static int vnt_rf_set_txpower(struct vnt_private *priv, u8 power,
 
 			if (hw_value < ARRAY_SIZE(vt3226d0_lo_current_table)) {
 				ret = vnt_rf_write_embedded(priv,
-					vt3226d0_lo_current_table[hw_value]);
+							    vt3226d0_lo_current_table[hw_value]);
 				if (ret)
 					return ret;
 			}
-- 
2.25.1
