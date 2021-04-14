Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15A0B35F024
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 10:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350185AbhDNIr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 04:47:57 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40084 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348601AbhDNIrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 04:47:55 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13E8jC7R064066;
        Wed, 14 Apr 2021 08:47:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=KBUtWLkz6XRdoml4a0gFH5qOESW29nMkRyr4i70ZaHw=;
 b=Ts0fZ9XtcK9/CZwY2z+R6x0nLNtVsuQ4lSHQBZdluGmfuqyo/VvqItKqah6a3V9EWx5N
 aBh8W6jwAKk+7YjrU8EJqIjaJeW7zhoXKn4KlHQCo/SwbAc/LW3La5mxt+g9NzQMIQ3D
 q81ISbeDpRD4OaBlOIyrFy819GXRyaOPhaoDziYtXVvhfMqYfQuCEkPEoARot++an+/2
 6IGGXIYnk7HBq0FkVzAmGFlGJ8z8TvE29LCDW6tO5p7GizGKilIj97QA5D8OGT3hIVFY
 NI4VgGlAf7qZOJpgY4ovrUfFLmwEKyBRir/HrGl15G88Wdo8yoImjgE7kx+iLiHLbwJ4 jA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 37u4nnhmty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Apr 2021 08:47:21 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13E8kP8W167607;
        Wed, 14 Apr 2021 08:47:19 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 37unxy31v7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Apr 2021 08:47:19 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 13E8lHPo015234;
        Wed, 14 Apr 2021 08:47:17 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Apr 2021 01:47:16 -0700
Date:   Wed, 14 Apr 2021 11:47:09 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Muhammad Usama Anjum <musamaanjum@gmail.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>, Borislav Petkov <bp@suse.de>,
        open list <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, colin.king@canonical.com
Subject: Re: [PATCH] objtool: prevent memory leak in error paths
Message-ID: <20210414084709.GT6021@kadam>
References: <20210413204511.GA664936@LEGION>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413204511.GA664936@LEGION>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9953 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 malwarescore=0
 spamscore=0 adultscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104140061
X-Proofpoint-ORIG-GUID: 5-2-_FWmQgB-o7GhZetwdKeiufcnwoB1
X-Proofpoint-GUID: 5-2-_FWmQgB-o7GhZetwdKeiufcnwoB1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9953 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 clxscore=1011 lowpriorityscore=0 spamscore=0 impostorscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104140061
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 01:45:11AM +0500, Muhammad Usama Anjum wrote:
> Memory allocated by sym and sym->name isn't being freed if some error
> occurs in elf_create_undef_symbol(). Free the sym and sym->name if error
> is detected before returning NULL.
> 
> Addresses-Coverity: ("Prevent memory leak")
> Fixes: 2f2f7e47f052 ("objtool: Add elf_create_undef_symbol()")
> Signed-off-by: Muhammad Usama Anjum <musamaanjum@gmail.com>
> ---
> Only build has been tested.
> 

Just ignore leaks from the tools/ directory.  These things run and then
exit and all the memory is freed.  #OldSchoolGarbageCollector

regards,
dan carpenter

