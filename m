Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98A4432637A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 14:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhBZNoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 08:44:32 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:39654 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhBZNo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 08:44:28 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11QDcu3w161909;
        Fri, 26 Feb 2021 13:43:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=G+DgAze3w+Tbq+Aon1ADcm+cJk9dTPRMgXOqHQYMSas=;
 b=HHKaOwEG3QlQYoZSFPtzVWZ3jOOZIF3P7cfPjiFBZC+LqxI0djCmKV1OZx6K4vPmjkSd
 KWxvhGElWRwSPhkc9gypzLIM95gF3faidsFCEuEhNx+lwalcqkXlqoHVnhg2aAoZbcGM
 abJxVZvpxJLvFgeUeKXrccT1XAsN7uKM0lr9LsJFlba+ktMx9arcZNaIivr0dJSZ0Ed6
 0XNKb1dKPnuCsOlscXx3grjUVBieytZ+FP4Pj9QIeQOvtRraPadvaV6W0qy68sM7z7L1
 vja/XsV563AV/jFgXqfCQG/Y+gQePsxC4jh4xcZ1AY25If1SgZWP3UCiBjXdUTSKU/Tg bw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 36ugq3ru4t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Feb 2021 13:43:43 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11QDeIFG035663;
        Fri, 26 Feb 2021 13:43:42 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 36uc6vw20c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Feb 2021 13:43:42 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 11QDhfXS017563;
        Fri, 26 Feb 2021 13:43:41 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 26 Feb 2021 05:43:40 -0800
Date:   Fri, 26 Feb 2021 16:43:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Lee Gibson <leegib@gmail.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192e: Fix possible buffer overflow in
 _rtl92e_wx_set_scan
Message-ID: <20210226134333.GA2087@kadam>
References: <20210226114829.316980-1-leegib@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226114829.316980-1-leegib@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9906 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102260105
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9906 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102260105
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 11:48:29AM +0000, Lee Gibson wrote:
> Function _rtl92e_wx_set_scan calls memcpy without checking the length.
> A user could control that length and trigger a buffer overflow.
> Fix by checking the length is within the maximum allowed size.
> 
> Signed-off-by: Lee Gibson <leegib@gmail.com>
> ---
>  drivers/staging/rtl8192e/rtl8192e/rtl_wx.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
> index 16bcee13f64b..2acc4f314732 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
> @@ -406,6 +406,9 @@ static int _rtl92e_wx_set_scan(struct net_device *dev,
>  		struct iw_scan_req *req = (struct iw_scan_req *)b;
>  
>  		if (req->essid_len) {
> +			if (req->essid_len > IW_ESSID_MAX_SIZE)
> +				req->essid_len = IW_ESSID_MAX_SIZE;
> +
>  			ieee->current_network.ssid_len = req->essid_len;
>  			memcpy(ieee->current_network.ssid, req->essid,
>  			       req->essid_len);
> -- 

Well done.  You can add a Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
to your final patch.  How did you spot this bug?  It's so ancient that
the Fixes tag would look messed up.

commit 94a799425eee8225a1e3fbe5f473d2ef04002577
Author: Larry Finger <Larry.Finger@lwfinger.net>
Date:   Tue Aug 23 19:00:42 2011 -0500

    From: wlanfae <wlanfae@realtek.com>
    [PATCH 1/8] rtl8192e: Import new version of driver from realtek


Smatch isn't smart enough to track how this function is called.  Smatch
tries to track the names of the pointers that a function can be.  For
example, the pointer is stored in r8192_wx_handlers[] and it's returned
from get_handler().  Here is that list.

$ smdb.py function_ptr _rtl92e_wx_set_scan
_rtl92e_wx_set_scan = ['_rtl92e_wx_set_scan', 'r8192_wx_handlers[]', '(struct iw_handler_def)->standard', 'r get_handler()', 'wireless_process_ioctl ptr handler', 'standard param 4', 'private param 4']

But Smatch gets confused when we do:

net/wireless/wext-core.c
   951          handler = get_handler(dev, cmd);
   952          if (handler) {
   953                  /* Standard and private are not the same */
   954                  if (cmd < SIOCIWFIRSTPRIV)
   955                          return standard(dev, iwr, cmd, info, handler);

Passing the handler pointer to the standard() pointer...

   956                  else if (private)
   957                          return private(dev, iwr, cmd, info, handler);
   958          }

I can hard code the correct function pointer by adding some insert
commands into the smatch_data/db/fixup_kernel.sh file.

insert into function_ptr values ("fixup_kernel.sh", "r get_handler()", "ioctl_standard_call ptr param 4", 1);
insert into function_ptr values ("fixup_kernel.sh", "r get_handler()", "ioctl_standard_iw_point param 3", 1);

And now it generates the warning....

But I wonder if probably another idea is to just create a new warning
that any time we memcpy() to a (struct ieee80211_network)->ssid and the
length is not known to be less than IW_ESSID_MAX_SIZE then print a
warning.

It turns out this process was slightly more unwieldy than I expected.
Adding the types manually seems like it might be a lot of work.  Someone
could probably go through the list of CVEs from last year and see which
types were overflowed.  Anyway, I'll test out what I have and post my
results next week.

regards,
dan carpenter

#include "smatch.h"
#include "smatch_slist.h"
#include "smatch_extra.h"

static int my_id;

static struct {
	const char *type_name;
	int len;
} member_list[] = {
	{ "(struct ieee80211_network)->ssid", 32 },
	{ "(struct rtllib_network)->ssid", 32 },
};

static void match_memset(const char *fn, struct expression *expr, void *_unused)
{
	struct expression *dest, *size_expr;
	struct range_list *rl;
	char *member_name;
	int size;
	int i;

	dest = get_argument_from_call_expr(expr->args, 0);
	size_expr = get_argument_from_call_expr(expr->args, 2);
	if (!dest || !size_expr)
		return;

	member_name = get_member_name(dest);
	if (!member_name)
		return;

	for (i = 0; i < ARRAY_SIZE(member_list); i++) {
		if (strcmp(member_name, member_list[i].type_name) == 0)
			break;
	}
	if (i == ARRAY_SIZE(member_list))
		goto free;

	if (member_list[i].len)
		size = member_list[i].len;
	else
		size = get_array_size_bytes(dest);
	get_absolute_rl(size_expr, &rl);

	if (rl_max(rl).value <= size)
		goto free;

	sm_msg("protected struct member '%s' overflow: rl='%s'", member_name, show_rl(rl));
free:
	free_string(member_name);
}

void check_protected_member(int id)
{
	if (option_project != PROJ_KERNEL)
		return;

	my_id = id;

	add_function_hook("memcpy", &match_memset, NULL);
	add_function_hook("__memcpy", &match_memset, NULL);
}


