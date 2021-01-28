Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACA5B307784
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 14:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhA1N5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 08:57:35 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:37692 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhA1N5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 08:57:30 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10SDjG5j032375;
        Thu, 28 Jan 2021 13:56:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=M4jFOKatFcyPcxDAz6eq3I+ChcfOoSisBUAd5ByvK2U=;
 b=C/ixitqLPwXxRFdoZjmnyyq1i0HUddLKsCS8MtE+7nlQJUInQGxq6Wn8kGs0PM3g08HA
 17s18a9BbqzEfnxPgJUxlrHtPd8BEOjQUuFT2BB/1RF0sV4QIMagPp5rqJFbSZ50au4g
 uThfY9yks1pxfOmo3IbJzdlJ7JPc/tAwzDuWdfhMY/0dlyc5zYlKiqvAx7/jvtR8xeXX
 iGhau5gaavP/h4B6BsCYpse0hVirew6rMpziMJbNCLST9ZRZaaqOqemxMVt2qIXHDKa1
 EC0zS0Wd44Fyk5BchlVyWcRB6i9vxN5wPUFN2wQpWPCa5XqucLYPAvCLSUms0pd9Tt4t uA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 3689aavdnr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jan 2021 13:56:48 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10SDrBaN131639;
        Thu, 28 Jan 2021 13:54:46 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 368wr0bwmm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jan 2021 13:54:46 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10SDsikX005028;
        Thu, 28 Jan 2021 13:54:45 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 28 Jan 2021 05:54:44 -0800
Date:   Thu, 28 Jan 2021 16:54:37 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     smatch@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: smatch v1.71 released
Message-ID: <20210128135437.GA8213@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9877 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101280069
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9877 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 phishscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101280069
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intro:

Smatch is a C static checker with a lot of kernel specific checks.  You
can download it from:  http://repo.or.cz/w/smatch.git.  Or if you prefer
a github mirror, then you can download it from
https://github.com/error27/smatch

The last time I made a release was in 2015. https://lwn.net/Articles/629250/
There have been over two thousand patches to Smatch in the past six
years but it's hard to point to any one thing as standing out.  One
thing I'm happy about is that Smatch is now much better at tracking
user controlled data.  Another thing which I can mention that I re-wrote
check_locking.c and wrote a blog entry about it:
https://blogs.oracle.com/linux/writing-the-ultimate-locking-check

The uninitialized variable warning that was mentioned in the relase
notes six years ago is more important than ever now that we have
disabled the GCC warning for uninitialized variables.  I really suggest
that people do add Smatch to their QC process.  You don't have to have
the full cross function database built.  Just do:

	~/path/to/smatch/smatch_scripts/kchecker drivers/file.c

You could also just build a sub directory:

	~/path/to/smatch/smatch_scripts/kchecker drivers/subdir/

If you don't use Smatch, that's fine as well because kbuild bot will
catch it or someone else will.  But probably it saves time for everyone
if developers run it themselves.

Building the cross function database is also really useful.  The
~/path/to/smatch/smatch_data/db/smdb.py script is helpful to understand
how function pointers are called or where struct members are set.
Building the database takes a long time to run but it's simple to do:
~/path/to/smatch/smatch_scripts/build_kernel_data.sh
And to test the whole kernel the command is:
~/path/to/smatch/smatch_scripts/test_kernel.sh

This is kind of a weird release because it's been so long since the
previous release.  I'm hoping to do more regular releases with better
release notes.  Releases are good because hopefully more people will do
a fresh pull and send me bug reports.  :)

regards,
dan carpenter
