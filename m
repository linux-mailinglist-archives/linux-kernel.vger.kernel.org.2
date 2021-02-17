Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A1D31DD55
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 17:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbhBQQ3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 11:29:04 -0500
Received: from pv50p00im-hyfv10011601.me.com ([17.58.6.43]:54225 "EHLO
        pv50p00im-hyfv10011601.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234176AbhBQQ20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 11:28:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1613579250;
        bh=IbKyhojyJio149yJ9wHcjts+6gz8THb0g6hToz/sQdw=;
        h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type;
        b=j+3EAgShAuR9K5gZBG+wwjIYRQqF57MXaXDSWlaUkCWwC+Vr9xZzaaui24qRtSo9V
         m2W5mllQNgYG0vL+GoXkDWog8zC9aCmuWo89ZMvi45OmO/AfAZDxPvsHdJwkTMWc34
         SW7nIpyK/q8J/viKdK8hA9NK7iZJNWdEyEzUXL0jXcOiozdkGlLxPVY18wDGox5RDt
         1iNOogVFoihDHenPcOmap05/qNDKmq+T4G5PfdhE32UksAY1mPWv3Acm2iyqmGs0Qk
         99ptTUO/ZeK8+zY+U1yb+tYZxeNRl//eRF+1T78mDSt/2Aml7V6YZkoz0Wf1hCb4fU
         ++5XO37jc+mJQ==
Received: from [192.168.31.114] (unknown [45.250.51.33])
        by pv50p00im-hyfv10011601.me.com (Postfix) with ESMTPSA id 05DAE380617;
        Wed, 17 Feb 2021 16:27:28 +0000 (UTC)
Subject: Re: [PATCH] staging: wlan-ng: Fixed incorrect type warning in
 p80211netdev.c
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20210217154255.112115-1-pritthijit.nath@icloud.com>
 <YC08DBQuxmNA1EWh@kroah.com>
From:   Pritthijit Nath <pritthijit.nath@icloud.com>
Message-ID: <afaca83a-6ef5-6d48-3c0b-f4403ac86890@icloud.com>
Date:   Wed, 17 Feb 2021 21:57:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YC08DBQuxmNA1EWh@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-17_13:2021-02-16,2021-02-17 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2102170124
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/02/21 9:23 pm, Greg KH wrote:
> On Wed, Feb 17, 2021 at 09:12:55PM +0530, Pritthijit Nath wrote:
>> This change fixes a sparse warning "incorrect type in argument 1
>> (different address spaces)".
>>
>> Signed-off-by: Pritthijit Nath <pritthijit.nath@icloud.com>
>> ---
>>  drivers/staging/wlan-ng/p80211netdev.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/staging/wlan-ng/p80211netdev.c b/drivers/staging/wlan-ng/p80211netdev.c
>> index 6f9666dc0277..70570e8a5ad2 100644
>> --- a/drivers/staging/wlan-ng/p80211netdev.c
>> +++ b/drivers/staging/wlan-ng/p80211netdev.c
>> @@ -569,7 +569,7 @@ static int p80211knetdev_do_ioctl(struct net_device *dev,
>>  		goto bail;
>>  	}
>>  
>> -	msgbuf = memdup_user(req->data, req->len);
>> +	msgbuf = memdup_user((void __user *)req->data, req->len);
> 
> Odd.  Why isn't data tagged as a __user pointer to start with?
> 
> thanks,
> 
> greg k-h
> 

In lines 540-548 ->

...

static int p80211knetdev_do_ioctl(struct net_device *dev,
                                  struct ifreq *ifr, int cmd)
{
        int result = 0;
        struct p80211ioctl_req *req = (struct p80211ioctl_req *)ifr;
        struct wlandevice *wlandev = dev->ml_priv;
        u8 *msgbuf;

        netdev_dbg(dev, "rx'd ioctl, cmd=%d, len=%d\n", cmd, req->len);

...

it can be seen that *req is essentially coming from an explicit cast of *ifr. ifr->data itself is of char* type. So, imo, an explicit __user pointer cast is required. 

The patch above was based on the __user pointer cast done in lines 580-586 ->

...

if (result == 0) {
                if (copy_to_user
                    ((void __user *)req->data, msgbuf, req->len)) {
                        result = -EFAULT;
                }
        }
        kfree(msgbuf);

...

and lines 550-556 ->

#ifdef SIOCETHTOOL
        if (cmd == SIOCETHTOOL) {
                result =
                    p80211netdev_ethtool(wlandev, (void __user *)ifr->ifr_data);
                goto bail;
        }
#endif

