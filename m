Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F796395972
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 13:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhEaLKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 07:10:20 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:55364 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230518AbhEaLKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 07:10:17 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14VB7sTS032461;
        Mon, 31 May 2021 11:07:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=lUuGq/C7sXzvXw1vUvzsTI9HcozZmqWeXik1xKmQ/Vw=;
 b=oVdQZePnwKr8RWTFBZNq2Tl1U3mtiJYKxISkSPrrwk22gEhpg5VJ5kxzrLZFUd3v5Ov0
 pi3mLRcBm/AX23q16Lu/jnM/tXi8IaQoRkpmckzcepB4HyM/XDHKgfgCGJ4OQbNyxfgD
 bXot10nFB7VGAPlSs9PmyML3tWwZeggkEley8G/fzIpEgMuk05ANCVzSQX6fhYGVF1YM
 oW8KgjNxf9J7pjAvlatX8KtGId7s3FkbZtMGjPfaLT4Rea11IlbJMY3XKsECQWxjfEph
 zQdCOtW206HLs85D8Y0mnNgpAz1nvz45ROtEiyNRrifv0JVOBU4Nf31kASqkOq0rbRS3 HQ== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 38vng405mp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 May 2021 11:07:53 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14VB7qPg066668;
        Mon, 31 May 2021 11:07:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 38uaqvaw53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 May 2021 11:07:52 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14VB7pK4066659;
        Mon, 31 May 2021 11:07:52 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 38uaqvaw4w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 May 2021 11:07:51 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 14VB7ovt026451;
        Mon, 31 May 2021 11:07:50 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 31 May 2021 04:07:49 -0700
Date:   Mon, 31 May 2021 14:07:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        syzbot+08a7d8b51ea048a74ffb@syzkaller.appspotmail.com
Subject: Re: [PATCH] ALSA: control led: fix memory leak in
 snd_ctl_led_register
Message-ID: <20210531110742.GB24442@kadam>
References: <20210528131757.2269989-1-mudongliangabcd@gmail.com>
 <20210531110144.GA24442@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210531110144.GA24442@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: a2BHVzqa7nGO7H_95w5TKUDFIxE2UFM2
X-Proofpoint-GUID: a2BHVzqa7nGO7H_95w5TKUDFIxE2UFM2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've also created a Smatch check for missing ->release() functions.  It
find one bug in that file.  There are other bugs, but the static checker
is not clever enough to find them.  I expect Smatch will get smarter
about this in the coming year.

sound/core/control_led.c:685 snd_ctl_led_sysfs_add() warn: calling put_device() with no ->release() function

So, yeay, I feel like this thread has been useful and I now understand
put_device() a little better.  Please review the email thread again and
send a v2 patch.  :)

regards,
dan carpenter

/*
 * Copyright (C) 2021 Oracle.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, see http://www.gnu.org/copyleft/gpl.txt
 */

#include "smatch.h"
#include "smatch_extra.h"

static int my_id;

static void match_put_device(struct expression *expr, const char *name, struct symbol *sym, void *data)
{
	struct smatch_state *state;

	state = get_state(SMATCH_EXTRA, name, sym);
	if (!state ||
	    estate_min(state).value != 0 ||
	    estate_max(state).value != 0)
		return;

	sm_warning("calling put_device() with no ->release() function");
}

void check_no_release(int id)
{
	my_id = id;

	if (option_project != PROJ_KERNEL)
		return;

	add_function_param_key_hook("put_device", &match_put_device, 0, "$->release", NULL);
	add_function_param_key_hook("device_unregister", &match_put_device, 0, "$->release", NULL);
}

