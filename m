Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0532639D7DA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 10:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhFGIsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 04:48:51 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:53638 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229545AbhFGIsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 04:48:51 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1578i21f006103;
        Mon, 7 Jun 2021 08:46:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=YO1KyDgwmoCOfijsXXHdGrniO0QBDt0CvCmNNgk5reU=;
 b=lDhnmB5OAE+5K4gWYnMMNi96yDF+MQ/5StyU412FQJoqATCXasAvwFEUAEEHewbUYTsv
 0yqY2d/wEi9BYRWMvqvYXnNjv9z5xidevGif16aBMxEe/hmScAUGjohUOSQSXJdA3Sxm
 Lpmp41J4RC242SuOb+6uL7DppZmEm+Kgluwn1S1fm0vOrxVt5/8w1zvgaAUX86n/W0S9
 1QHDcHjs67PDoCad9YkuQI8VguvumrDKgU3xBqzdpg8cJFfxzDXhXEThijMpmV6e9Od5
 NFYrBRqh8XDcIbVjsRujhm/qkga8NMPx1IGlPnXovbnqMW4aRtJJ9+E1ZTZXKZuljrcu bQ== 
Received: from oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3917d4g510-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Jun 2021 08:46:50 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 1578kngg042631;
        Mon, 7 Jun 2021 08:46:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 3906sp46hg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Jun 2021 08:46:49 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 1578knF4042578;
        Mon, 7 Jun 2021 08:46:49 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 3906sp46gs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Jun 2021 08:46:49 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 1578kmFS006862;
        Mon, 7 Jun 2021 08:46:48 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 07 Jun 2021 01:46:48 -0700
Date:   Mon, 7 Jun 2021 11:46:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Wenli Looi <wlooi@ucalgary.ca>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: Re: [PATCH v2] staging: rtl8723bs: Fix uninitialized variable
Message-ID: <20210607084642.GQ1955@kadam>
References: <7256195.zb9d8qvCYo@linux.local>
 <20210606184638.13650-1-wlooi@ucalgary.ca>
 <20210607083542.GP1955@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607083542.GP1955@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: sHs7rSsHiiZ4mhMJzE_e5_LHGBIWGv88
X-Proofpoint-GUID: sHs7rSsHiiZ4mhMJzE_e5_LHGBIWGv88
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 11:35:42AM +0300, Dan Carpenter wrote:
> On Sun, Jun 06, 2021 at 11:46:38AM -0700, Wenli Looi wrote:
> > Uninitialized struct with invalid pointer causes BUG and prevents access
> > point from working. Access point works once I apply this patch.
> > 
> > This problem seems to have been present from the time the driver was
> > added to staging. Most users probably do not use access point so they
> > will not encounter this bug.
> > 
> > https://forum.armbian.com/topic/14727-wifi-ap-kernel-bug-in-kernel-5444/
> > has more details.
> > 
> > kzalloc() seems to be what other drivers are doing in the same situation
> > of creating struct station_info and calling cfg80211_new_sta.  In
> > particular, other drivers like ath6kl and mwifiex will silently return
> > when kzalloc fails, so this seems like the right behavior. (mwifiex
> > returns -ENOMEM from the place kzalloc is called, but if you follow the
> > chain of calls, the return value is ultimately ignored)
> > 
> > Links to same situation in other drivers:
> > https://github.com/torvalds/linux/blob/f5b6eb1e018203913dfefcf6fa988649ad11ad6e/drivers/net/wireless/ath/ath6kl/main.c#L488
> > https://github.com/torvalds/linux/blob/f5b6eb1e018203913dfefcf6fa988649ad11ad6e/drivers/net/wireless/marvell/mwifiex/uap_event.c#L120
> > 
> > Signed-off-by: Wenli Looi <wlooi@ucalgary.ca>
> > ---
> > 
> > v1 -> v2: Switched from large stack variable to kzalloc
> 
> 
> Nah, v1 was better, it just needs an updated commit message.  See my
> other email for more details.

I read this again and I thought I should provide some more information.

This sinfo struct used to be huge and that's why people used to allocate
it if kzalloc() but now it's only 224 bytes so it's okay to put it on
the stack.

And the problem was never whether the variable was on the stack vs on
the heap so changing that wasn't part of the "a patch should do one
thing."  If you want to change it to kzalloc you have to do that in a
separate patch (don't do that).

And you were reading Greg's questions as saying the patch was wrong, but
actually they were just questions.

regards,
dan carpenter

