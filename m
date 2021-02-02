Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1AB030B445
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 01:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhBBAoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 19:44:38 -0500
Received: from mga03.intel.com ([134.134.136.65]:50492 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229556AbhBBAog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 19:44:36 -0500
IronPort-SDR: AINx8J18V+FZZL8TXJ4yCciyIz82TQOuFVoWSnPIYcG8HtSEu6jZC6iqyWFTI/wHi+qAPdCg5l
 z05WREqtI1sg==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="180852419"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="gz'50?scan'50,208,50";a="180852419"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 16:43:49 -0800
IronPort-SDR: mEur3AYb00aInJfUi3+o67vtAKYogR56i8oMmi1TaSEx3Buzt2CdWc5UJ6fWkgAlIdMvlnGVWu
 dAhX3MCSTR+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="gz'50?scan'50,208,50";a="371754431"
Received: from lkp-server02.sh.intel.com (HELO 625d3a354f04) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 01 Feb 2021 16:43:47 -0800
Received: from kbuild by 625d3a354f04 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l6jnG-0008OM-PE; Tue, 02 Feb 2021 00:43:46 +0000
Date:   Tue, 2 Feb 2021 08:43:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     James Smart <james.smart@broadcom.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: drivers/scsi/lpfc/lpfc_scsi.c:823:39: sparse: sparse: incorrect type
 in assignment (different base types)
Message-ID: <202102020833.XjgF7mpg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   88bb507a74ea7d75fa49edd421eaa710a7d80598
commit: da255e2e7cc889e10820bc89752466322426571f scsi: lpfc: Convert SCSI path to use common I/O submission path
date:   3 months ago
config: i386-randconfig-s031-20210202 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.3-215-g0fb77bb6-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=da255e2e7cc889e10820bc89752466322426571f
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout da255e2e7cc889e10820bc89752466322426571f
        # save the attached .config to linux build tree
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"sparse warnings: (new ones prefixed by >>)"
   drivers/scsi/lpfc/lpfc_scsi.c:129:30: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_scsi.c:131:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word2 @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:131:28: sparse:     expected unsigned int [usertype] word2
   drivers/scsi/lpfc/lpfc_scsi.c:131:28: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:397:35: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_scsi.c:398:34: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_scsi.c:401:32: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_scsi.c:404:35: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_scsi.c:405:34: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_scsi.c:408:32: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_scsi.c:693:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] addr_hi @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:693:22: sparse:     expected unsigned int [usertype] addr_hi
   drivers/scsi/lpfc/lpfc_scsi.c:693:22: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:694:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] addr_lo @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:694:22: sparse:     expected unsigned int [usertype] addr_lo
   drivers/scsi/lpfc/lpfc_scsi.c:694:22: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:695:22: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_scsi.c:697:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word2 @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:697:20: sparse:     expected unsigned int [usertype] word2
   drivers/scsi/lpfc/lpfc_scsi.c:697:20: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:698:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sge_len @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:698:22: sparse:     expected unsigned int [usertype] sge_len
   drivers/scsi/lpfc/lpfc_scsi.c:698:22: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:703:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] addr_hi @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:703:22: sparse:     expected unsigned int [usertype] addr_hi
   drivers/scsi/lpfc/lpfc_scsi.c:703:22: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:704:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] addr_lo @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:704:22: sparse:     expected unsigned int [usertype] addr_lo
   drivers/scsi/lpfc/lpfc_scsi.c:704:22: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:705:22: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_scsi.c:707:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word2 @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:707:20: sparse:     expected unsigned int [usertype] word2
   drivers/scsi/lpfc/lpfc_scsi.c:707:20: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:708:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sge_len @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:708:22: sparse:     expected unsigned int [usertype] sge_len
   drivers/scsi/lpfc/lpfc_scsi.c:708:22: sparse:     got restricted __le32 [usertype]
>> drivers/scsi/lpfc/lpfc_scsi.c:823:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:823:39: sparse:     expected unsigned int [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:823:39: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:911:46: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_scsi.c:913:41: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_scsi.c:915:41: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_scsi.c:956:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] fcpDl @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:956:25: sparse:     expected unsigned int [usertype] fcpDl
   drivers/scsi/lpfc/lpfc_scsi.c:956:25: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:1088:69: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] prot_data @@     got restricted __be32 [usertype] ref_tag @@
   drivers/scsi/lpfc/lpfc_scsi.c:1088:69: sparse:     expected unsigned int [usertype] prot_data
   drivers/scsi/lpfc/lpfc_scsi.c:1088:69: sparse:     got restricted __be32 [usertype] ref_tag
   drivers/scsi/lpfc/lpfc_scsi.c:1209:69: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] prot_data @@     got restricted __be16 [usertype] app_tag @@
   drivers/scsi/lpfc/lpfc_scsi.c:1209:69: sparse:     expected unsigned int [usertype] prot_data
   drivers/scsi/lpfc/lpfc_scsi.c:1209:69: sparse:     got restricted __be16 [usertype] app_tag
   drivers/scsi/lpfc/lpfc_scsi.c:1610:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word0 @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:1610:21: sparse:     expected unsigned int [usertype] word0
   drivers/scsi/lpfc/lpfc_scsi.c:1610:21: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:1611:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] reftag @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:1611:22: sparse:     expected unsigned int [usertype] reftag
   drivers/scsi/lpfc/lpfc_scsi.c:1611:22: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:1644:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word0 @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:1644:21: sparse:     expected unsigned int [usertype] word0
   drivers/scsi/lpfc/lpfc_scsi.c:1644:21: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:1645:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word1 @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:1645:21: sparse:     expected unsigned int [usertype] word1
   drivers/scsi/lpfc/lpfc_scsi.c:1645:21: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:1646:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word2 @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:1646:21: sparse:     expected unsigned int [usertype] word2
   drivers/scsi/lpfc/lpfc_scsi.c:1646:21: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:1655:32: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_scsi.c:1656:33: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_scsi.c:1662:30: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_scsi.c:1777:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word0 @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:1777:29: sparse:     expected unsigned int [usertype] word0
   drivers/scsi/lpfc/lpfc_scsi.c:1777:29: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:1778:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] reftag @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:1778:30: sparse:     expected unsigned int [usertype] reftag
   drivers/scsi/lpfc/lpfc_scsi.c:1778:30: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:1806:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word0 @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:1806:29: sparse:     expected unsigned int [usertype] word0
   drivers/scsi/lpfc/lpfc_scsi.c:1806:29: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:1807:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word1 @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:1807:29: sparse:     expected unsigned int [usertype] word1
   drivers/scsi/lpfc/lpfc_scsi.c:1807:29: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:1808:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word2 @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:1808:29: sparse:     expected unsigned int [usertype] word2
   drivers/scsi/lpfc/lpfc_scsi.c:1808:29: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:1825:34: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_scsi.c:1826:33: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_scsi.c:1860:40: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_scsi.c:1861:41: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_scsi.c:1884:38: sparse: sparse: cast to restricted __le32
   drivers/scsi/lpfc/lpfc_scsi.c:2000:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] ref_tag @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:2000:25: sparse:     expected unsigned int [usertype] ref_tag
   drivers/scsi/lpfc/lpfc_scsi.c:2000:25: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:2027:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word2 @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:2027:23: sparse:     expected unsigned int [usertype] word2
   drivers/scsi/lpfc/lpfc_scsi.c:2027:23: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:2028:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word3 @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:2028:23: sparse:     expected unsigned int [usertype] word3
   drivers/scsi/lpfc/lpfc_scsi.c:2028:23: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:2053:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] addr_lo @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:2053:38: sparse:     expected unsigned int [usertype] addr_lo
   drivers/scsi/lpfc/lpfc_scsi.c:2053:38: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:2055:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] addr_hi @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:2055:38: sparse:     expected unsigned int [usertype] addr_hi
   drivers/scsi/lpfc/lpfc_scsi.c:2055:38: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:2067:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] addr_lo @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:2067:38: sparse:     expected unsigned int [usertype] addr_lo
   drivers/scsi/lpfc/lpfc_scsi.c:2067:38: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:2068:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] addr_hi @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:2068:38: sparse:     expected unsigned int [usertype] addr_hi
   drivers/scsi/lpfc/lpfc_scsi.c:2068:38: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:2071:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word2 @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:2071:36: sparse:     expected unsigned int [usertype] word2
   drivers/scsi/lpfc/lpfc_scsi.c:2071:36: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:2072:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sge_len @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:2072:38: sparse:     expected unsigned int [usertype] sge_len
   drivers/scsi/lpfc/lpfc_scsi.c:2072:38: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:2082:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word2 @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:2082:36: sparse:     expected unsigned int [usertype] word2
   drivers/scsi/lpfc/lpfc_scsi.c:2082:36: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:2083:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sge_len @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:2083:38: sparse:     expected unsigned int [usertype] sge_len
   drivers/scsi/lpfc/lpfc_scsi.c:2083:38: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:2214:46: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] addr_lo @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:2214:46: sparse:     expected unsigned int [usertype] addr_lo
   drivers/scsi/lpfc/lpfc_scsi.c:2214:46: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:2216:46: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] addr_hi @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:2216:46: sparse:     expected unsigned int [usertype] addr_hi
   drivers/scsi/lpfc/lpfc_scsi.c:2216:46: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:2220:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word2 @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:2220:36: sparse:     expected unsigned int [usertype] word2
   drivers/scsi/lpfc/lpfc_scsi.c:2220:36: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:2221:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sge_len @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:2221:38: sparse:     expected unsigned int [usertype] sge_len
   drivers/scsi/lpfc/lpfc_scsi.c:2221:38: sparse:     got restricted __le32 [usertype]
   drivers/scsi/lpfc/lpfc_scsi.c:2233:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] ref_tag @@     got restricted __le32 [usertype] @@
   drivers/scsi/lpfc/lpfc_scsi.c:2233:33: sparse:     expected unsigned int [usertype] ref_tag
   drivers/scsi/lpfc/lpfc_scsi.c:2233:33: sparse:     got restricted __le32 [usertype]

vim +823 drivers/scsi/lpfc/lpfc_scsi.c

   579	
   580	/**
   581	 * lpfc_get_scsi_buf_s3 - Get a scsi buffer from lpfc_scsi_buf_list of the HBA
   582	 * @phba: The HBA for which this call is being executed.
   583	 * @ndlp: pointer to a node-list data structure.
   584	 * @cmnd: Pointer to scsi_cmnd data structure.
   585	 *
   586	 * This routine removes a scsi buffer from head of @phba lpfc_scsi_buf_list list
   587	 * and returns to caller.
   588	 *
   589	 * Return codes:
   590	 *   NULL - Error
   591	 *   Pointer to lpfc_scsi_buf - Success
   592	 **/
   593	static struct lpfc_io_buf *
   594	lpfc_get_scsi_buf_s3(struct lpfc_hba *phba, struct lpfc_nodelist *ndlp,
   595			     struct scsi_cmnd *cmnd)
   596	{
   597		struct lpfc_io_buf *lpfc_cmd = NULL;
   598		struct list_head *scsi_buf_list_get = &phba->lpfc_scsi_buf_list_get;
   599		unsigned long iflag = 0;
   600	
   601		spin_lock_irqsave(&phba->scsi_buf_list_get_lock, iflag);
   602		list_remove_head(scsi_buf_list_get, lpfc_cmd, struct lpfc_io_buf,
   603				 list);
   604		if (!lpfc_cmd) {
   605			spin_lock(&phba->scsi_buf_list_put_lock);
   606			list_splice(&phba->lpfc_scsi_buf_list_put,
   607				    &phba->lpfc_scsi_buf_list_get);
   608			INIT_LIST_HEAD(&phba->lpfc_scsi_buf_list_put);
   609			list_remove_head(scsi_buf_list_get, lpfc_cmd,
   610					 struct lpfc_io_buf, list);
   611			spin_unlock(&phba->scsi_buf_list_put_lock);
   612		}
   613		spin_unlock_irqrestore(&phba->scsi_buf_list_get_lock, iflag);
   614	
   615		if (lpfc_ndlp_check_qdepth(phba, ndlp) && lpfc_cmd) {
   616			atomic_inc(&ndlp->cmd_pending);
   617			lpfc_cmd->flags |= LPFC_SBUF_BUMP_QDEPTH;
   618		}
   619		return  lpfc_cmd;
   620	}
   621	/**
   622	 * lpfc_get_scsi_buf_s4 - Get a scsi buffer from io_buf_list of the HBA
   623	 * @phba: The HBA for which this call is being executed.
   624	 * @ndlp: pointer to a node-list data structure.
   625	 * @cmnd: Pointer to scsi_cmnd data structure.
   626	 *
   627	 * This routine removes a scsi buffer from head of @hdwq io_buf_list
   628	 * and returns to caller.
   629	 *
   630	 * Return codes:
   631	 *   NULL - Error
   632	 *   Pointer to lpfc_scsi_buf - Success
   633	 **/
   634	static struct lpfc_io_buf *
   635	lpfc_get_scsi_buf_s4(struct lpfc_hba *phba, struct lpfc_nodelist *ndlp,
   636			     struct scsi_cmnd *cmnd)
   637	{
   638		struct lpfc_io_buf *lpfc_cmd;
   639		struct lpfc_sli4_hdw_queue *qp;
   640		struct sli4_sge *sgl;
   641		dma_addr_t pdma_phys_fcp_rsp;
   642		dma_addr_t pdma_phys_fcp_cmd;
   643		uint32_t cpu, idx;
   644		int tag;
   645		struct fcp_cmd_rsp_buf *tmp = NULL;
   646	
   647		cpu = raw_smp_processor_id();
   648		if (cmnd && phba->cfg_fcp_io_sched == LPFC_FCP_SCHED_BY_HDWQ) {
   649			tag = blk_mq_unique_tag(cmnd->request);
   650			idx = blk_mq_unique_tag_to_hwq(tag);
   651		} else {
   652			idx = phba->sli4_hba.cpu_map[cpu].hdwq;
   653		}
   654	
   655		lpfc_cmd = lpfc_get_io_buf(phba, ndlp, idx,
   656					   !phba->cfg_xri_rebalancing);
   657		if (!lpfc_cmd) {
   658			qp = &phba->sli4_hba.hdwq[idx];
   659			qp->empty_io_bufs++;
   660			return NULL;
   661		}
   662	
   663		/* Setup key fields in buffer that may have been changed
   664		 * if other protocols used this buffer.
   665		 */
   666		lpfc_cmd->cur_iocbq.iocb_flag = LPFC_IO_FCP;
   667		lpfc_cmd->prot_seg_cnt = 0;
   668		lpfc_cmd->seg_cnt = 0;
   669		lpfc_cmd->timeout = 0;
   670		lpfc_cmd->flags = 0;
   671		lpfc_cmd->start_time = jiffies;
   672		lpfc_cmd->waitq = NULL;
   673		lpfc_cmd->cpu = cpu;
   674	#ifdef CONFIG_SCSI_LPFC_DEBUG_FS
   675		lpfc_cmd->prot_data_type = 0;
   676	#endif
   677		tmp = lpfc_get_cmd_rsp_buf_per_hdwq(phba, lpfc_cmd);
   678		if (!tmp) {
   679			lpfc_release_io_buf(phba, lpfc_cmd, lpfc_cmd->hdwq);
   680			return NULL;
   681		}
   682	
   683		lpfc_cmd->fcp_cmnd = tmp->fcp_cmnd;
   684		lpfc_cmd->fcp_rsp = tmp->fcp_rsp;
   685	
   686		/*
   687		 * The first two SGEs are the FCP_CMD and FCP_RSP.
   688		 * The balance are sg list bdes. Initialize the
   689		 * first two and leave the rest for queuecommand.
   690		 */
   691		sgl = (struct sli4_sge *)lpfc_cmd->dma_sgl;
   692		pdma_phys_fcp_cmd = tmp->fcp_cmd_rsp_dma_handle;
   693		sgl->addr_hi = cpu_to_le32(putPaddrHigh(pdma_phys_fcp_cmd));
   694		sgl->addr_lo = cpu_to_le32(putPaddrLow(pdma_phys_fcp_cmd));
   695		sgl->word2 = le32_to_cpu(sgl->word2);
   696		bf_set(lpfc_sli4_sge_last, sgl, 0);
   697		sgl->word2 = cpu_to_le32(sgl->word2);
   698		sgl->sge_len = cpu_to_le32(sizeof(struct fcp_cmnd));
   699		sgl++;
   700	
   701		/* Setup the physical region for the FCP RSP */
   702		pdma_phys_fcp_rsp = pdma_phys_fcp_cmd + sizeof(struct fcp_cmnd);
   703		sgl->addr_hi = cpu_to_le32(putPaddrHigh(pdma_phys_fcp_rsp));
 > 704		sgl->addr_lo = cpu_to_le32(putPaddrLow(pdma_phys_fcp_rsp));
   705		sgl->word2 = le32_to_cpu(sgl->word2);
   706		bf_set(lpfc_sli4_sge_last, sgl, 1);
   707		sgl->word2 = cpu_to_le32(sgl->word2);
   708		sgl->sge_len = cpu_to_le32(sizeof(struct fcp_rsp));
   709	
   710		if (lpfc_ndlp_check_qdepth(phba, ndlp)) {
   711			atomic_inc(&ndlp->cmd_pending);
   712			lpfc_cmd->flags |= LPFC_SBUF_BUMP_QDEPTH;
   713		}
   714		return  lpfc_cmd;
   715	}
   716	/**
   717	 * lpfc_get_scsi_buf - Get a scsi buffer from lpfc_scsi_buf_list of the HBA
   718	 * @phba: The HBA for which this call is being executed.
   719	 * @ndlp: pointer to a node-list data structure.
   720	 * @cmnd: Pointer to scsi_cmnd data structure.
   721	 *
   722	 * This routine removes a scsi buffer from head of @phba lpfc_scsi_buf_list list
   723	 * and returns to caller.
   724	 *
   725	 * Return codes:
   726	 *   NULL - Error
   727	 *   Pointer to lpfc_scsi_buf - Success
   728	 **/
   729	static struct lpfc_io_buf*
   730	lpfc_get_scsi_buf(struct lpfc_hba *phba, struct lpfc_nodelist *ndlp,
   731			  struct scsi_cmnd *cmnd)
   732	{
   733		return  phba->lpfc_get_scsi_buf(phba, ndlp, cmnd);
   734	}
   735	
   736	/**
   737	 * lpfc_release_scsi_buf - Return a scsi buffer back to hba scsi buf list
   738	 * @phba: The Hba for which this call is being executed.
   739	 * @psb: The scsi buffer which is being released.
   740	 *
   741	 * This routine releases @psb scsi buffer by adding it to tail of @phba
   742	 * lpfc_scsi_buf_list list.
   743	 **/
   744	static void
   745	lpfc_release_scsi_buf_s3(struct lpfc_hba *phba, struct lpfc_io_buf *psb)
   746	{
   747		unsigned long iflag = 0;
   748	
   749		psb->seg_cnt = 0;
   750		psb->prot_seg_cnt = 0;
   751	
   752		spin_lock_irqsave(&phba->scsi_buf_list_put_lock, iflag);
   753		psb->pCmd = NULL;
   754		psb->cur_iocbq.iocb_flag = LPFC_IO_FCP;
   755		list_add_tail(&psb->list, &phba->lpfc_scsi_buf_list_put);
   756		spin_unlock_irqrestore(&phba->scsi_buf_list_put_lock, iflag);
   757	}
   758	
   759	/**
   760	 * lpfc_release_scsi_buf_s4: Return a scsi buffer back to hba scsi buf list.
   761	 * @phba: The Hba for which this call is being executed.
   762	 * @psb: The scsi buffer which is being released.
   763	 *
   764	 * This routine releases @psb scsi buffer by adding it to tail of @hdwq
   765	 * io_buf_list list. For SLI4 XRI's are tied to the scsi buffer
   766	 * and cannot be reused for at least RA_TOV amount of time if it was
   767	 * aborted.
   768	 **/
   769	static void
   770	lpfc_release_scsi_buf_s4(struct lpfc_hba *phba, struct lpfc_io_buf *psb)
   771	{
   772		struct lpfc_sli4_hdw_queue *qp;
   773		unsigned long iflag = 0;
   774	
   775		psb->seg_cnt = 0;
   776		psb->prot_seg_cnt = 0;
   777	
   778		qp = psb->hdwq;
   779		if (psb->flags & LPFC_SBUF_XBUSY) {
   780			spin_lock_irqsave(&qp->abts_io_buf_list_lock, iflag);
   781			psb->pCmd = NULL;
   782			list_add_tail(&psb->list, &qp->lpfc_abts_io_buf_list);
   783			qp->abts_scsi_io_bufs++;
   784			spin_unlock_irqrestore(&qp->abts_io_buf_list_lock, iflag);
   785		} else {
   786			lpfc_release_io_buf(phba, (struct lpfc_io_buf *)psb, qp);
   787		}
   788	}
   789	
   790	/**
   791	 * lpfc_release_scsi_buf: Return a scsi buffer back to hba scsi buf list.
   792	 * @phba: The Hba for which this call is being executed.
   793	 * @psb: The scsi buffer which is being released.
   794	 *
   795	 * This routine releases @psb scsi buffer by adding it to tail of @phba
   796	 * lpfc_scsi_buf_list list.
   797	 **/
   798	static void
   799	lpfc_release_scsi_buf(struct lpfc_hba *phba, struct lpfc_io_buf *psb)
   800	{
   801		if ((psb->flags & LPFC_SBUF_BUMP_QDEPTH) && psb->ndlp)
   802			atomic_dec(&psb->ndlp->cmd_pending);
   803	
   804		psb->flags &= ~LPFC_SBUF_BUMP_QDEPTH;
   805		phba->lpfc_release_scsi_buf(phba, psb);
   806	}
   807	
   808	/**
   809	 * lpfc_fcpcmd_to_iocb - copy the fcp_cmd data into the IOCB
   810	 * @data: A pointer to the immediate command data portion of the IOCB.
   811	 * @fcp_cmnd: The FCP Command that is provided by the SCSI layer.
   812	 *
   813	 * The routine copies the entire FCP command from @fcp_cmnd to @data while
   814	 * byte swapping the data to big endian format for transmission on the wire.
   815	 **/
   816	static void
   817	lpfc_fcpcmd_to_iocb(u8 *data, struct fcp_cmnd *fcp_cmnd)
   818	{
   819		int i, j;
   820	
   821		for (i = 0, j = 0; i < sizeof(struct fcp_cmnd);
   822		     i += sizeof(uint32_t), j++) {
 > 823			((uint32_t *)data)[j] = cpu_to_be32(((uint32_t *)fcp_cmnd)[j]);
   824		}
   825	}
   826	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--HlL+5n6rz5pIUxbD
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
/x+x0p8tRGYCAA==

--HlL+5n6rz5pIUxbD--
