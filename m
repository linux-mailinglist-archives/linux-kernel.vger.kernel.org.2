Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E2431243D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 13:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbhBGMSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 07:18:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36998 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229536AbhBGMSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 07:18:40 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 117C33vL048620;
        Sun, 7 Feb 2021 07:17:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=QIlxd2fdXA5CfY+R6nqE4Bz4SBJ6hiiVZ3YbWcm6FRM=;
 b=q8JEV2C2kda0Hm0+sRbjayQp8Ep2NWdAXCzP/QCn5956roR5PjcA6Lg+g/klW7WX7FSD
 BPtA7cFUvshvyaI3W4wVouHqw2DjgNYvPSxoTSdGO1eZAjuxtaEsmnOcD0tj0IUVkJk+
 o/JsUNnOLfMOUWAMcCGpRN1ALupsnm27qQuOWmXfSDZfMatFbmDQ3ZwdqEI8ITzTksZF
 RFdZGADpQtASUD6G3BT7GHaYQAbiY0x8q+Oye7uWik+wd35iHmFJloSKBqZorilXFSu5
 +NkMETY5TVu3WYq84qemEatW1xTz2hQv/EUZLQCdrLdyI+o+xagGAe0NKGvJ3lQY5bS9 AA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36jaa6n4a3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 07 Feb 2021 07:17:55 -0500
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 117C3UsF049397;
        Sun, 7 Feb 2021 07:17:54 -0500
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36jaa6n49p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 07 Feb 2021 07:17:54 -0500
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 117CGhR2000973;
        Sun, 7 Feb 2021 12:17:52 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06fra.de.ibm.com with ESMTP id 36hjch0hhb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 07 Feb 2021 12:17:52 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 117CHnET42598816
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 7 Feb 2021 12:17:49 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46856A404D;
        Sun,  7 Feb 2021 12:17:49 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C8282A4040;
        Sun,  7 Feb 2021 12:17:48 +0000 (GMT)
Received: from osiris (unknown [9.171.9.57])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun,  7 Feb 2021 12:17:48 +0000 (GMT)
Date:   Sun, 7 Feb 2021 13:17:47 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Seth Forshee <seth.forshee@canonical.com>,
        Hugh Dickins <hughd@google.com>,
        Chris Down <chris@chrisdown.name>,
        Amir Goldstein <amir73il@gmail.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexander Egorenkov <egorenar@linux.vnet.ibm.com>
Subject: Re: [PATCH] tmpfs: Disallow CONFIG_TMPFS_INODE64 on s390
Message-ID: <20210207121747.GA15061@osiris>
References: <20210205230620.518245-1-seth.forshee@canonical.com>
 <20210205160551.cf57c4293ba5ccb8eb648c11@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205160551.cf57c4293ba5ccb8eb648c11@linux-foundation.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-07_06:2021-02-05,2021-02-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=966
 priorityscore=1501 suspectscore=0 clxscore=1011 malwarescore=0 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102070087
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 04:05:51PM -0800, Andrew Morton wrote:
> On Fri,  5 Feb 2021 17:06:20 -0600 Seth Forshee <seth.forshee@canonical.com> wrote:
> 
> > This feature requires ino_t be 64-bits, which is true for every
> > 64-bit architecture but s390, so prevent this option from being
> > selected there.
> > 
> 
> The previous patch nicely described the end-user impact of the bug. 
> This is especially important when requesting a -stable backport.
> 
> Here's what I ended up with:
> 
> 
> From: Seth Forshee <seth.forshee@canonical.com>
> Subject: tmpfs: disallow CONFIG_TMPFS_INODE64 on s390
> 
> Currently there is an assumption in tmpfs that 64-bit architectures also
> have a 64-bit ino_t.  This is not true on s390 which has a 32-bit ino_t. 
> With CONFIG_TMPFS_INODE64=y tmpfs mounts will get 64-bit inode numbers and
> display "inode64" in the mount options, but passing the "inode64" mount
> option will fail.  This leads to the following behavior:
> 
>  # mkdir mnt
>  # mount -t tmpfs nodev mnt
>  # mount -o remount,rw mnt
>  mount: /home/ubuntu/mnt: mount point not mounted or bad option.
> 
> As mount sees "inode64" in the mount options and thus passes it in the
> options for the remount.
> 
> 
> So prevent CONFIG_TMPFS_INODE64 from being selected on s390.
> 
> Link: https://lkml.kernel.org/r/20210205230620.518245-1-seth.forshee@canonical.com
> Fixes: ea3271f7196c ("tmpfs: support 64-bit inums per-sb")
> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
> Cc: Chris Down <chris@chrisdown.name>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: <stable@vger.kernel.org>	[5.9+]
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  fs/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/fs/Kconfig~tmpfs-disallow-config_tmpfs_inode64-on-s390
> +++ a/fs/Kconfig
> @@ -203,7 +203,7 @@ config TMPFS_XATTR
>  
>  config TMPFS_INODE64
>  	bool "Use 64-bit ino_t by default in tmpfs"
> -	depends on TMPFS && 64BIT
> +	depends on TMPFS && 64BIT && !S390

Heh, it's sort of funny that we have a similar patch, which
unfortunately was/is not yet on our external features branch,
which does exactly the same.

In any case:

Acked-by: Heiko Carstens <hca@linux.ibm.com>
