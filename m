Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D492839D77B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 10:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbhFGIff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 04:35:35 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:57392 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbhFGIfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 04:35:34 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1578TKx6047472;
        Mon, 7 Jun 2021 08:33:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=sjptcc6ddE7IbOrf/gIK4CmvjxMyt9MxAZ4Zcn5N0Tc=;
 b=y5YRZn5ycObCmYamg06IOboPg2daygOz2ZDGFRkNTF8bTtaN9Q3ntPvwOd2s8nxpcCo6
 xCxTavDjLbsEYmLtpO/J5XqwNwd9o6BoejrBv2wO6Ops5J4YnQq+hI6LRZ+MoTPVcq1c
 F0arB4KDDe4I9grKQE0hVrBM0rKE0f2Oq+yPWKClZupEKkC68B0aMfPpvnbgTUZ4ZW9x
 mps7gpXgGRDT+VFFuCE5L5RghkxYFTJcKau+vPRJn/Y6Xr5K5LxcTVst7BNSG/VvXyXt
 1RpechsO7XwhqPYqi6tADNXDCkoAnOPMtUhmjs5/ldXdfD1Pp2XZw06R4BVPGFJp94n5 JQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 38yxscab0c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Jun 2021 08:33:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1578Uvxf031802;
        Mon, 7 Jun 2021 08:33:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 390k1pve6e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Jun 2021 08:33:30 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 1578XTc1035193;
        Mon, 7 Jun 2021 08:33:29 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 390k1pve6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Jun 2021 08:33:29 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 1578XSFv000340;
        Mon, 7 Jun 2021 08:33:28 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 07 Jun 2021 01:33:24 -0700
Date:   Mon, 7 Jun 2021 11:33:17 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Wenli Looi <wlooi@ucalgary.ca>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: Fix uninitialized variable
Message-ID: <20210607083316.GO1955@kadam>
References: <20210606070021.116284-1-wlooi@ucalgary.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210606070021.116284-1-wlooi@ucalgary.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: rIaSwfS6bZJsMnvyKB1KooXLrUCtGmO_
X-Proofpoint-GUID: rIaSwfS6bZJsMnvyKB1KooXLrUCtGmO_
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10007 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 mlxscore=0 malwarescore=0 mlxlogscore=999 clxscore=1011 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106070066
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 06, 2021 at 12:00:21AM -0700, Wenli Looi wrote:
> Uninitialized struct with invalid pointer causes BUG and prevents access
> point from working. Access point works once I apply this patch.
> 
> https://forum.armbian.com/topic/14727-wifi-ap-kernel-bug-in-kernel-5444/
> has more details.
> 
> Signed-off-by: Wenli Looi <wlooi@ucalgary.ca>
> ---

This patch is correct but the commit message needs to be updated.  Your
version 2 patch is not correct.

We don't like "follow this link for all the information" type commit
messages.  Clicking on a link is annoying and links die after five
years.  The link can be there but the main information needs
to be in the commit message.  Generally it's good to put the stack trace
in the commit so that people can search for it.

As Greg pointed out, you need to add a Fixes tag.  So far as I can see
it's ->pertid and ->generation which are not initialized and the bugs
were introduced in two different commits so you need two Fixes tags.

Fixes: 8689c051a201 ("cfg80211: dynamically allocate per-tid stats for station info")
Fixes: f5ea9120be2e ("nl80211: add generation number to all dumps")

Adding a Fixes tag will mean the correct people are CC'd in the patch
and can review the fix.

Greg asked about struct holes and the answer is "= {}" will zero out
struct holes but it's not important in this case.  The "= {}" is a GCC
extension for zeroing structs and it's not part of the C standard.
The struct has a kernel pointer in it so we had better not be shairing
it to user space.

Here is a better commit message.  Please resend the commit with
something like the following.

staging: rtl8723bs: Fix uninitialized variables

The sinfo.pertid and sinfo.generation variables are not initialized
and it causes a crash when we use this as a wireless access point.

[  456.873025] ------------[ cut here ]------------
[  456.878198] kernel BUG at mm/slub.c:3968!
[  456.882680] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM

  [ snip ]

[  457.271004] Backtrace: 
[  457.273733] [<c02b7ee4>] (kfree) from [<c0e2a470>] (nl80211_send_station+0x954/0xfc4)
[  457.282481]  r9:eccca0c0 r8:e8edfec0 r7:00000000 r6:00000011 r5:e80a9480 r4:e8edfe00
[  457.291132] [<c0e29b1c>] (nl80211_send_station) from [<c0e2b18c>] (cfg80211_new_sta+0x90/0x1cc)
[  457.300850]  r10:e80a9480 r9:e8edfe00 r8:ea678cca r7:00000a20 r6:00000000 r5:ec46d000
[  457.309586]  r4:ec46d9e0
[  457.312433] [<c0e2b0fc>] (cfg80211_new_sta) from [<bf086684>] (rtw_cfg80211_indicate_sta_assoc+0x80/0x9c [r8723bs])
[  457.324095]  r10:00009930 r9:e85b9d80 r8:bf091050 r7:00000000 r6:00000000 r5:0000001c
[  457.332831]  r4:c1606788
[  457.335692] [<bf086604>] (rtw_cfg80211_indicate_sta_assoc [r8723bs]) from [<bf03df38>] (rtw_stassoc_event_callback+0x1c8/0x1d4 [r8723bs])
[  457.349489]  r7:ea678cc0 r6:000000a1 r5:f1225f84 r4:f086b000
[  457.355845] [<bf03dd70>] (rtw_stassoc_event_callback [r8723bs]) from [<bf048e4c>] (mlme_evt_hdl+0x8c/0xb4 [r8723bs])
[  457.367601]  r7:c1604900 r6:f086c4b8 r5:00000000 r4:f086c000
[  457.373959] [<bf048dc0>] (mlme_evt_hdl [r8723bs]) from [<bf03693c>] (rtw_cmd_thread+0x198/0x3d8 [r8723bs])
[  457.384744]  r5:f086e000 r4:f086c000
[  457.388754] [<bf0367a4>] (rtw_cmd_thread [r8723bs]) from [<c014a214>] (kthread+0x170/0x174)
[  457.398083]  r10:ed7a57e8 r9:bf0367a4 r8:f086b000 r7:e8ede000 r6:00000000 r5:e9975200
[  457.406828]  r4:e8369900
[  457.409653] [<c014a0a4>] (kthread) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
[  457.417718] Exception stack(0xe8edffb0 to 0xe8edfff8)
[  457.423356] ffa0:                                     00000000 00000000 00000000 00000000
[  457.432492] ffc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[  457.441618] ffe0: 00000000 00000000 00000000 00000000 00000013 00000000
[  457.449006]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c014a0a4
[  457.457750]  r4:e9975200
[  457.460574] Code: 1a000003 e5953004 e3130001 1a000000 (e7f001f2) 
[  457.467381] ---[ end trace 4acbc8c15e9e6aa7 ]---

Link: https://forum.armbian.com/topic/14727-wifi-ap-kernel-bug-in-kernel-5444/
Fixes: 8689c051a201 ("cfg80211: dynamically allocate per-tid stats for station info")
Fixes: f5ea9120be2e ("nl80211: add generation number to all dumps")
Signed-off-by:

regards,
dan carpenter
