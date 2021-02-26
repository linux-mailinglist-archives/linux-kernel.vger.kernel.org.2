Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4731F3263CF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 15:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbhBZOJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 09:09:56 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:40506 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbhBZOG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 09:06:29 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11QE5UNj177220;
        Fri, 26 Feb 2021 14:05:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=j+Ifm8mBCaJbotfcIkDqPoaPGimgkBKYVmP76uLbEFA=;
 b=eSZYGvlyPSdzGmsHYHXWIjZq3iIKLL2aLSSHQSKm8CmXL5wzCGkzsyWmzptfbYEhM2QB
 HvOOZfqy0qI22AiW3vf9B9JTQtmDAU5RmXvSbhPGnv4IO4h7QSNDZ60ZrEaLHM8qdrbf
 96uHsBnDoDCquDYyiIe+Xg1mAq4IZ3NcL+RWUWPBPd5QFKHsPHBsZxWvy7TcIoJEK+dF
 CQVsfmrODIrzN+yuFcJ9FqTHg4jwy88hBVfDorMNtBhskKReeS+EABrYxiBKy3ijZ519
 yzguUNig1Xj/i9qczb4+SAT9egulZrR5C26Ie0CICL0UqFAJmMGYS1ffxosmxnDiDWa9 QA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 36tsura1yc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Feb 2021 14:05:35 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11QE4io5131344;
        Fri, 26 Feb 2021 14:05:34 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 36v9m8nc2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Feb 2021 14:05:34 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 11QE5XjC016301;
        Fri, 26 Feb 2021 14:05:33 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 26 Feb 2021 06:05:33 -0800
Date:   Fri, 26 Feb 2021 17:05:26 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Lee Gibson <leegib@gmail.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192e: Fix possible buffer overflow in
 _rtl92e_wx_set_scan
Message-ID: <20210226140526.GG2222@kadam>
References: <20210226114829.316980-1-leegib@gmail.com>
 <20210226134333.GA2087@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226134333.GA2087@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9906 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102260109
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9906 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 clxscore=1015 phishscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102260109
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a v2 of my check.  I've changed it to mark all "->ssid" and
everything in "(struct ieee80211_network)" as protected.  I'm just
playing around with it at this point to explore what works best.  It's
impossible to know until after some results come back.

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
	struct expression *dest, *size_arg;
	struct range_list *rl;
	char *member_name;
	int dest_size = 0;
	int i;

	dest = get_argument_from_call_expr(expr->args, 0);
	size_arg = get_argument_from_call_expr(expr->args, 2);
	if (!dest || !size_arg)
		return;

	member_name = get_member_name(dest);
	if (!member_name)
		return;

	for (i = 0; i < ARRAY_SIZE(member_list); i++) {
		if (strcmp(member_name, member_list[i].type_name) == 0) {
			dest_size = member_list[i].len;
			goto check;
		}
	}

	if (strstr(member_name, "->ssid"))
		goto check;

	if (strncmp(member_name, "(struct ieee80211_network)", 26) == 0)
		goto check;

	goto free;

check:
	get_absolute_rl(size_arg, &rl);
	if (!dest_size)
		dest_size = get_array_size_bytes(dest);

	if (rl_max(rl).value <= dest_size)
		goto free;

	if (dest_size <= 0 && is_capped(size_arg))
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
