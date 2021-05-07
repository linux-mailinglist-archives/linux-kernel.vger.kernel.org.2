Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6906A375FAB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 07:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbhEGFWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 01:22:53 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52810 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbhEGFWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 01:22:51 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1475IeFq009406;
        Fri, 7 May 2021 05:21:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2020-01-29; bh=m82Tiv3N8EyLayqOU7hdwku4RkRAu25qOSv0k1M7AEg=;
 b=fBe3qzh1ZTH7lIHkvNdevlu3sSq1gqVCaYoK+3Xsu0w/5E2d5tnQTf/it1cg6UMj9ZQv
 B6sXxaQJ+CbvwbRlLgQTyTpAQb8oDXaFMywtOwLd47TDiY0IVmjF0V2SNmnbIGoMV8ni
 VRK70eankEcPQipBSN3XoSNFCiDhr7BlbZuXrlNJxmOIk0cz6yJpRLj/5BRdU2L3rDk0
 ST3PFHUeJ+A8h+JawsA/oxxYNao2bRDUFzkcoLG9lCArg8zYWyVN9m8nmQifYYySNwLX
 6RCwNM5Kj+YMNzY/NRsIbm5f7u9yE8k8noRLHrhGt5rmNznxXvscz8RL5LHYMB9vtbvj kA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 38csqvgdch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 May 2021 05:21:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1475LMUu109621;
        Fri, 7 May 2021 05:21:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 38css8567s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 May 2021 05:21:32 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 1475LVbG111523;
        Fri, 7 May 2021 05:21:31 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 38css85674-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 May 2021 05:21:31 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 1475LSpa010458;
        Fri, 7 May 2021 05:21:29 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 May 2021 22:21:28 -0700
Date:   Fri, 7 May 2021 08:21:20 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Faiyaz Mohammed <faiyazm@codeaurora.org>,
        cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, glittao@gmail.com
Cc:     lkp@intel.com, kbuild-all@lists.01.org, vinmenon@codeaurora.org
Subject: Re: [PATCH v5] mm: slub: move sysfs slab alloc/free interfaces to
 debugfs
Message-ID: <202105070253.GuJL1RPR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620296523-21922-1-git-send-email-faiyazm@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: HMNtw0v1W_3vSp9qDEmtn0meStVYKtoz
X-Proofpoint-GUID: HMNtw0v1W_3vSp9qDEmtn0meStVYKtoz
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9976 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0
 impostorscore=0 phishscore=0 clxscore=1011 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105070038
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Faiyaz,

url:    https://github.com/0day-ci/linux/commits/Faiyaz-Mohammed/mm-slub-move-sysfs-slab-alloc-free-interfaces-to-debugfs/20210506-182420
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 8404c9fbc84b741f66cff7d4934a25dd2c344452
config: i386-randconfig-m021-20210506 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
mm/slub.c:5891 slab_debugfs_start() warn: possible memory leak of 'spos'

vim +/spos +5891 mm/slub.c

88e180b99466c1 Faiyaz Mohammed 2021-05-06  5877  static void *slab_debugfs_start(struct seq_file *seq, loff_t *ppos)
88e180b99466c1 Faiyaz Mohammed 2021-05-06  5878  {
88e180b99466c1 Faiyaz Mohammed 2021-05-06  5879  	struct kmem_cache_node *n;
88e180b99466c1 Faiyaz Mohammed 2021-05-06  5880  	struct kmem_cache *s;
88e180b99466c1 Faiyaz Mohammed 2021-05-06  5881  	enum track_item alloc;
88e180b99466c1 Faiyaz Mohammed 2021-05-06  5882  	int node;
88e180b99466c1 Faiyaz Mohammed 2021-05-06  5883  	loff_t *spos = kmalloc(sizeof(loff_t), GFP_KERNEL);
                                                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Generally avoid putting functions which can fail in the declaration
block.  Allocations inside the declaration block are a tiny percent of
declarations over all but they are an outsize source of static checker
bugs.

88e180b99466c1 Faiyaz Mohammed 2021-05-06  5884  
88e180b99466c1 Faiyaz Mohammed 2021-05-06  5885  	s = seq->file->f_inode->i_private;
88e180b99466c1 Faiyaz Mohammed 2021-05-06  5886  
88e180b99466c1 Faiyaz Mohammed 2021-05-06  5887  	if (!spos)
88e180b99466c1 Faiyaz Mohammed 2021-05-06  5888  		return NULL;
88e180b99466c1 Faiyaz Mohammed 2021-05-06  5889  
88e180b99466c1 Faiyaz Mohammed 2021-05-06  5890  	if (!(s->flags & SLAB_STORE_USER))
88e180b99466c1 Faiyaz Mohammed 2021-05-06 @5891  		return ERR_PTR(-EOPNOTSUPP);

"spos" is leaked.

88e180b99466c1 Faiyaz Mohammed 2021-05-06  5892  
88e180b99466c1 Faiyaz Mohammed 2021-05-06  5893  	if (*ppos == 0) {
88e180b99466c1 Faiyaz Mohammed 2021-05-06  5894  
88e180b99466c1 Faiyaz Mohammed 2021-05-06  5895  		t.count = 0;
88e180b99466c1 Faiyaz Mohammed 2021-05-06  5896  		t.max = 0;
88e180b99466c1 Faiyaz Mohammed 2021-05-06  5897  		t.loc = NULL;
88e180b99466c1 Faiyaz Mohammed 2021-05-06  5898  		if (strcmp(seq->file->f_path.dentry->d_name.name, "alloc_traces") == 0)
88e180b99466c1 Faiyaz Mohammed 2021-05-06  5899  			alloc =  TRACK_ALLOC;
88e180b99466c1 Faiyaz Mohammed 2021-05-06  5900  		else
88e180b99466c1 Faiyaz Mohammed 2021-05-06  5901  			alloc =  TRACK_FREE;
88e180b99466c1 Faiyaz Mohammed 2021-05-06  5902  
88e180b99466c1 Faiyaz Mohammed 2021-05-06  5903  		if (!alloc_loc_track(&t, PAGE_SIZE / sizeof(struct location),
88e180b99466c1 Faiyaz Mohammed 2021-05-06  5904  			     GFP_KERNEL)) {
88e180b99466c1 Faiyaz Mohammed 2021-05-06  5905  			seq_puts(seq, "Out of memory\n");
88e180b99466c1 Faiyaz Mohammed 2021-05-06  5906  			return ERR_PTR(-ENOMEM);
88e180b99466c1 Faiyaz Mohammed 2021-05-06  5907  		}
88e180b99466c1 Faiyaz Mohammed 2021-05-06  5908  		/* Push back cpu slabs */
88e180b99466c1 Faiyaz Mohammed 2021-05-06  5909  		flush_all(s);
88e180b99466c1 Faiyaz Mohammed 2021-05-06  5910  
88e180b99466c1 Faiyaz Mohammed 2021-05-06  5911  		for_each_kmem_cache_node(s, node, n) {
88e180b99466c1 Faiyaz Mohammed 2021-05-06  5912  			unsigned long flags;
88e180b99466c1 Faiyaz Mohammed 2021-05-06  5913  			struct page *page;
88e180b99466c1 Faiyaz Mohammed 2021-05-06  5914  
88e180b99466c1 Faiyaz Mohammed 2021-05-06  5915  			if (!atomic_long_read(&n->nr_slabs))
88e180b99466c1 Faiyaz Mohammed 2021-05-06  5916  				continue;
88e180b99466c1 Faiyaz Mohammed 2021-05-06  5917  
88e180b99466c1 Faiyaz Mohammed 2021-05-06  5918  			spin_lock_irqsave(&n->list_lock, flags);
88e180b99466c1 Faiyaz Mohammed 2021-05-06  5919  			list_for_each_entry(page, &n->partial, slab_list)
88e180b99466c1 Faiyaz Mohammed 2021-05-06  5920  				process_slab(&t, s, page, alloc);
88e180b99466c1 Faiyaz Mohammed 2021-05-06  5921  			list_for_each_entry(page, &n->full, slab_list)
88e180b99466c1 Faiyaz Mohammed 2021-05-06  5922  				process_slab(&t, s, page, alloc);
88e180b99466c1 Faiyaz Mohammed 2021-05-06  5923  			spin_unlock_irqrestore(&n->list_lock, flags);
88e180b99466c1 Faiyaz Mohammed 2021-05-06  5924  		}
88e180b99466c1 Faiyaz Mohammed 2021-05-06  5925  	}
88e180b99466c1 Faiyaz Mohammed 2021-05-06  5926  
88e180b99466c1 Faiyaz Mohammed 2021-05-06  5927  	if (*ppos < t.count) {
88e180b99466c1 Faiyaz Mohammed 2021-05-06  5928  		*spos = *ppos;
88e180b99466c1 Faiyaz Mohammed 2021-05-06  5929  		return spos;
88e180b99466c1 Faiyaz Mohammed 2021-05-06  5930  	}
88e180b99466c1 Faiyaz Mohammed 2021-05-06  5931  
88e180b99466c1 Faiyaz Mohammed 2021-05-06  5932  	kfree(spos);
88e180b99466c1 Faiyaz Mohammed 2021-05-06  5933  	return NULL;
88e180b99466c1 Faiyaz Mohammed 2021-05-06  5934  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

