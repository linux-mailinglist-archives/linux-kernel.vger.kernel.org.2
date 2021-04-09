Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46FD3359833
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 10:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbhDIIqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 04:46:15 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40738 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbhDIIqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 04:46:14 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1398dhmP148550;
        Fri, 9 Apr 2021 08:45:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=T8cLQWWr3uj5LVRbuN8TiatnfbkM4HjOVHdla2Z8llM=;
 b=zoxhEr4/NYDLqucIMy2G5eKIu9G08+ymd1z0PTjCl3qq5D5KWjTuaG15TYjLEFU9aKXS
 ZGgS/dewCBDAjHJzMBaSptwk9qjO6a1izYO+WfVl51OBVYO6juawr0b9wxSxEJLOFzlK
 DpOIWSHcVNWiBP75YnrH976yGg8TEpIhzckqhNMzmIFgy7yPnRrdfrQoU8UhZSFyNDfN
 VAL9CPQ26VeghSma8h6a/nD7DK7M+hEwi147DEskRsArBhRrOXjJuNAJ1ADdFn9MC8GE
 tHyCKcyUSWFZq58p2dtEdrvzhwbiS3+TlASXZMDktfEBvAW88H4zo85PIUsGYqusU8I+ BA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 37rva68n9v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Apr 2021 08:45:57 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1398ZC3t034600;
        Fri, 9 Apr 2021 08:45:55 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 37rvb29ufg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Apr 2021 08:45:55 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 1398joQK024041;
        Fri, 9 Apr 2021 08:45:54 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 09 Apr 2021 01:45:50 -0700
Date:   Fri, 9 Apr 2021 11:45:41 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Rijo Thomas <Rijo-john.Thomas@amd.com>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Mythri Pandeshwara krishna <mythri.pandeshwarakrishna@amd.com>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tee: amdtee: unload TA only when its refcount becomes
 0
Message-ID: <20210409084541.GE6048@kadam>
References: <3150feb19421ca6b15202c853215f8b40fe35567.1617615067.git.Rijo-john.Thomas@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3150feb19421ca6b15202c853215f8b40fe35567.1617615067.git.Rijo-john.Thomas@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9948 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104090064
X-Proofpoint-GUID: zmtdy1PGfTgeyqRblg1ZqMCoqOPZZv9O
X-Proofpoint-ORIG-GUID: zmtdy1PGfTgeyqRblg1ZqMCoqOPZZv9O
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9948 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 clxscore=1011
 lowpriorityscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104090064
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2021 at 03:13:09PM +0530, Rijo Thomas wrote:
> @@ -340,7 +398,8 @@ int handle_open_session(struct tee_ioctl_open_session_arg *arg, u32 *info,
> 
>  int handle_load_ta(void *data, u32 size, struct tee_ioctl_open_session_arg *arg)
>  {
> -	struct tee_cmd_load_ta cmd = {0};
> +	struct tee_cmd_unload_ta unload_cmd = {0};
> +	struct tee_cmd_load_ta load_cmd = {0};

It's better style to write:

	struct tee_cmd_unload_ta unload_cmd = {};

It doesn't make a difference in this case, but if the first struct
member is a pointer then {0} can generate a Sparse warning.  Or
depending on which bugs your version of GCC has it can affect whether
struct holes are initialized.  But mostly it's just the prefered style.


regards,
dan carpenter

