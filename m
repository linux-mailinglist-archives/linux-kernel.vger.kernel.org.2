Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCEE30830A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 02:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbhA2BLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 20:11:49 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:45870 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbhA2BLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 20:11:41 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10SIwejp017991;
        Thu, 28 Jan 2021 19:00:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=ARuVZRVBMulfTjpLhliQ4uYuHe+bV4yYF0SvG++FAkU=;
 b=zwZuqL1NWibRuhRjy6d095QAAVfcZfeHOv9vqGN4AkScRu3jNnx9vHoE6xcLeBhVqCPN
 zlO6oBTL11zeQ5D15WbtPUOEmuEJT6SoKLJ0DRdgCaxIzIoQvnnaxiRhJMGFXMUAWOb1
 OcAQ8vtUDB6qQIrxa5OYm8uTSxY8gWjp2Z3G2jZNsx7MV4Mob7xIvZRYVrxIMRnkn36k
 A4pt/shiCiiJpofSG7y1+/meGf4XLxyxBB2UmorQyDNoUysONz9m4fjNFDLPF0JQvPpx
 bli4DQ+AnMXSlPyRjtg2mXiSBIOfEP2EuXjUMhiAZWl0oU/TdXsnDJleLn5IqXwAbp4q xA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 368brkwnfu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jan 2021 19:00:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10SIYeWP062863;
        Thu, 28 Jan 2021 19:00:23 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 368wq23pda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jan 2021 19:00:23 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10SJ0LsE012504;
        Thu, 28 Jan 2021 19:00:22 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 28 Jan 2021 11:00:20 -0800
Date:   Thu, 28 Jan 2021 22:00:13 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [kbuild] drivers/accessibility/speakup/speakup_audptr.c:138:20:
 warning: Array index 'test' is used before limits check.
Message-ID: <20210128190013.GV20820@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID-Hash: UE5FXQIB2RJ5EVHOFKXQQHRSK7G3QUDX
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9878 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101280089
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9878 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101280090
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master
head:   76c057c84d286140c6c416c3b4ba832cd1d8984e
commit: 2067fd92d75b6d9085a43caf050bca5d88c491b8 staging/speakup: Move out of staging
compiler: ia64-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

>> drivers/accessibility/speakup/speakup_audptr.c:138:20: warning: Array index 'test' is used before limits check. [arrayIndexThenCheck]
     } while (synth_id[test] != 'n' && test < 32);
                      ^

vim +/test +138 drivers/accessibility/speakup/speakup_audptr.c

c6e3fd22cd5383 drivers/staging/speakup/speakup_audptr.c William Hubbs 2010-10-07  127  static void synth_version(struct spk_synth *synth)
c6e3fd22cd5383 drivers/staging/speakup/speakup_audptr.c William Hubbs 2010-10-07  128  {
c6e3fd22cd5383 drivers/staging/speakup/speakup_audptr.c William Hubbs 2010-10-07  129  	unsigned char test = 0;

"test" is a weird name for an index, and the type should be int.

c6e3fd22cd5383 drivers/staging/speakup/speakup_audptr.c William Hubbs 2010-10-07  130  	char synth_id[40] = "";
                                                                                        ^^^^^^^^^^^^^^^^^^^^^^^

8e69a811068657 drivers/staging/speakup/speakup_audptr.c Domagoj Trsan 2014-09-09  131  
98c1fda752b604 drivers/staging/speakup/speakup_audptr.c Okash Khawaja 2017-03-16  132  	synth->synth_immediate(synth, "\x05[Q]");
ca693dcd5c0264 drivers/staging/speakup/speakup_audptr.c Okash Khawaja 2017-04-29  133  	synth_id[test] = synth->io_ops->synth_in();
c6e3fd22cd5383 drivers/staging/speakup/speakup_audptr.c William Hubbs 2010-10-07  134  	if (synth_id[test] == 'A') {
c6e3fd22cd5383 drivers/staging/speakup/speakup_audptr.c William Hubbs 2010-10-07  135  		do {
c6e3fd22cd5383 drivers/staging/speakup/speakup_audptr.c William Hubbs 2010-10-07  136  			/* read version string from synth */
ca693dcd5c0264 drivers/staging/speakup/speakup_audptr.c Okash Khawaja 2017-04-29  137  			synth_id[++test] = synth->io_ops->synth_in();
c6e3fd22cd5383 drivers/staging/speakup/speakup_audptr.c William Hubbs 2010-10-07 @138  		} while (synth_id[test] != '\n' && test < 32);
                                                                                                                                   ^^^^^^^^^
This is a limit check but it's 32 instead of 40 so the array can't
actually overflow.

c6e3fd22cd5383 drivers/staging/speakup/speakup_audptr.c William Hubbs 2010-10-07  139  		synth_id[++test] = 0x00;
c6e3fd22cd5383 drivers/staging/speakup/speakup_audptr.c William Hubbs 2010-10-07  140  	}
c6e3fd22cd5383 drivers/staging/speakup/speakup_audptr.c William Hubbs 2010-10-07  141  	if (synth_id[0] == 'A')
c6e3fd22cd5383 drivers/staging/speakup/speakup_audptr.c William Hubbs 2010-10-07  142  		pr_info("%s version: %s", synth->long_name, synth_id);
c6e3fd22cd5383 drivers/staging/speakup/speakup_audptr.c William Hubbs 2010-10-07  143  }


This if statement could be merge together with the previous one.  Also
we could reverse the previous if statement:

	synth_id[0] = synth->io_ops->synth_in();
	if (synth_id[0] != 'A')
		return;

	for (i = 1; i < sizeof(synth_id) - 1; i++) {
		/* read version string from synth */
		synth_id[i] = synth->io_ops->synth_in();
		if (synth_id[i] == '\n')
			break;
	}
	synth_id[i] = '\0';
	pr_info("%s version: %s", synth->long_name, synth_id);
}

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org 
_______________________________________________
kbuild mailing list -- kbuild@lists.01.org
To unsubscribe send an email to kbuild-leave@lists.01.org
