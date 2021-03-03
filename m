Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0326232BD1F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383629AbhCCPXS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 3 Mar 2021 10:23:18 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:47595 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234757AbhCCKbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:31:09 -0500
Received: from relay1-d.mail.gandi.net (unknown [217.70.183.193])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 0E2593A45C7
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 08:49:06 +0000 (UTC)
X-Originating-IP: 86.206.8.148
Received: from xps13 (lfbn-tou-1-491-148.w86-206.abo.wanadoo.fr [86.206.8.148])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id DECE3240011;
        Wed,  3 Mar 2021 08:48:40 +0000 (UTC)
Date:   Wed, 3 Mar 2021 09:48:40 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: drivers/mtd/parsers/qcomsmempart.c:109 parse_qcomsmem_part()
 warn: passing zero to 'PTR_ERR'
Message-ID: <20210303094840.0e30392c@xps13>
In-Reply-To: <20210303054918.GX2087@kadam>
References: <20210303054918.GX2087@kadam>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Dan Carpenter <dan.carpenter@oracle.com> wrote on Wed, 3 Mar 2021
08:49:18 +0300:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   7a7fd0de4a9804299793e564a555a49c1fc924cb
> commit: 803eb124e1a64e42888542c3444bfe6dac412c7f mtd: parsers: Add Qcom SMEM parser
> config: nds32-randconfig-m031-20210302 (attached as .config)
> compiler: nds32le-linux-gcc (GCC) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> smatch warnings:
> drivers/mtd/parsers/qcomsmempart.c:109 parse_qcomsmem_part() warn: passing zero to 'PTR_ERR'
> 
> vim +/PTR_ERR +109 drivers/mtd/parsers/qcomsmempart.c
> 
> 803eb124e1a64e Manivannan Sadhasivam 2021-01-04   57  static int parse_qcomsmem_part(struct mtd_info *mtd,
> 803eb124e1a64e Manivannan Sadhasivam 2021-01-04   58  			       const struct mtd_partition **pparts,
> 803eb124e1a64e Manivannan Sadhasivam 2021-01-04   59  			       struct mtd_part_parser_data *data)
> 803eb124e1a64e Manivannan Sadhasivam 2021-01-04   60  {
> 803eb124e1a64e Manivannan Sadhasivam 2021-01-04   61  	struct smem_flash_pentry *pentry;
> 803eb124e1a64e Manivannan Sadhasivam 2021-01-04   62  	struct smem_flash_ptable *ptable;
> 803eb124e1a64e Manivannan Sadhasivam 2021-01-04   63  	size_t len = SMEM_FLASH_PTABLE_HDR_LEN;
> 803eb124e1a64e Manivannan Sadhasivam 2021-01-04   64  	struct mtd_partition *parts;
> 803eb124e1a64e Manivannan Sadhasivam 2021-01-04   65  	int ret, i, numparts;
> 803eb124e1a64e Manivannan Sadhasivam 2021-01-04   66  	char *name, *c;
> 803eb124e1a64e Manivannan Sadhasivam 2021-01-04   67  
> 803eb124e1a64e Manivannan Sadhasivam 2021-01-04   68  	pr_debug("Parsing partition table info from SMEM\n");
> 803eb124e1a64e Manivannan Sadhasivam 2021-01-04   69  	ptable = qcom_smem_get(SMEM_APPS, SMEM_AARM_PARTITION_TABLE, &len);
> 803eb124e1a64e Manivannan Sadhasivam 2021-01-04   70  	if (IS_ERR(ptable)) {
> 803eb124e1a64e Manivannan Sadhasivam 2021-01-04   71  		pr_err("Error reading partition table header\n");
> 803eb124e1a64e Manivannan Sadhasivam 2021-01-04   72  		return PTR_ERR(ptable);
> 803eb124e1a64e Manivannan Sadhasivam 2021-01-04   73  	}
> 803eb124e1a64e Manivannan Sadhasivam 2021-01-04   74  
> 803eb124e1a64e Manivannan Sadhasivam 2021-01-04   75  	/* Verify ptable magic */
> 803eb124e1a64e Manivannan Sadhasivam 2021-01-04   76  	if (le32_to_cpu(ptable->magic1) != SMEM_FLASH_PART_MAGIC1 ||
> 803eb124e1a64e Manivannan Sadhasivam 2021-01-04   77  	    le32_to_cpu(ptable->magic2) != SMEM_FLASH_PART_MAGIC2) {
> 803eb124e1a64e Manivannan Sadhasivam 2021-01-04   78  		pr_err("Partition table magic verification failed\n");
> 803eb124e1a64e Manivannan Sadhasivam 2021-01-04   79  		return -EINVAL;
> 803eb124e1a64e Manivannan Sadhasivam 2021-01-04   80  	}
> 803eb124e1a64e Manivannan Sadhasivam 2021-01-04   81  
> 803eb124e1a64e Manivannan Sadhasivam 2021-01-04   82  	/* Ensure that # of partitions is less than the max we have allocated */
> 803eb124e1a64e Manivannan Sadhasivam 2021-01-04   83  	numparts = le32_to_cpu(ptable->numparts);
> 803eb124e1a64e Manivannan Sadhasivam 2021-01-04   84  	if (numparts > SMEM_FLASH_PTABLE_MAX_PARTS_V4) {
> 803eb124e1a64e Manivannan Sadhasivam 2021-01-04   85  		pr_err("Partition numbers exceed the max limit\n");
> 803eb124e1a64e Manivannan Sadhasivam 2021-01-04   86  		return -EINVAL;
> 803eb124e1a64e Manivannan Sadhasivam 2021-01-04   87  	}
> 803eb124e1a64e Manivannan Sadhasivam 2021-01-04   88  
> 803eb124e1a64e Manivannan Sadhasivam 2021-01-04   89  	/* Find out length of partition data based on table version */
> 803eb124e1a64e Manivannan Sadhasivam 2021-01-04   90  	if (le32_to_cpu(ptable->version) <= SMEM_FLASH_PTABLE_V3) {
> 803eb124e1a64e Manivannan Sadhasivam 2021-01-04   91  		len = SMEM_FLASH_PTABLE_HDR_LEN + SMEM_FLASH_PTABLE_MAX_PARTS_V3 *
> 803eb124e1a64e Manivannan Sadhasivam 2021-01-04   92  			sizeof(struct smem_flash_pentry);
> 803eb124e1a64e Manivannan Sadhasivam 2021-01-04   93  	} else if (le32_to_cpu(ptable->version) == SMEM_FLASH_PTABLE_V4) {
> 803eb124e1a64e Manivannan Sadhasivam 2021-01-04   94  		len = SMEM_FLASH_PTABLE_HDR_LEN + SMEM_FLASH_PTABLE_MAX_PARTS_V4 *
> 803eb124e1a64e Manivannan Sadhasivam 2021-01-04   95  			sizeof(struct smem_flash_pentry);
> 803eb124e1a64e Manivannan Sadhasivam 2021-01-04   96  	} else {
> 803eb124e1a64e Manivannan Sadhasivam 2021-01-04   97  		pr_err("Unknown ptable version (%d)", le32_to_cpu(ptable->version));
> 803eb124e1a64e Manivannan Sadhasivam 2021-01-04   98  		return -EINVAL;
> 803eb124e1a64e Manivannan Sadhasivam 2021-01-04   99  	}
> 803eb124e1a64e Manivannan Sadhasivam 2021-01-04  100  
> 803eb124e1a64e Manivannan Sadhasivam 2021-01-04  101  	/*
> 803eb124e1a64e Manivannan Sadhasivam 2021-01-04  102  	 * Now that the partition table header has been parsed, verified
> 803eb124e1a64e Manivannan Sadhasivam 2021-01-04  103  	 * and the length of the partition table calculated, read the
> 803eb124e1a64e Manivannan Sadhasivam 2021-01-04  104  	 * complete partition table
> 803eb124e1a64e Manivannan Sadhasivam 2021-01-04  105  	 */
> 803eb124e1a64e Manivannan Sadhasivam 2021-01-04  106  	ptable = qcom_smem_get(SMEM_APPS, SMEM_AARM_PARTITION_TABLE, &len);
> 803eb124e1a64e Manivannan Sadhasivam 2021-01-04  107  	if (IS_ERR_OR_NULL(ptable)) {
>                                                             ^^^^^^^^^^^^^^^^^^^^^^
> This should be IS_ERR().  The qcom_smem_get() function doesn't return
> NULL.
> 
> 803eb124e1a64e Manivannan Sadhasivam 2021-01-04  108  		pr_err("Error reading partition table\n");
> 
> When a function returns both error pointers and NULL, the NULL return
> is a special case of success where the feature isn't able because it
> has be deliberately disabled.  The NULL return should not generate an
> error message.
> 
> 803eb124e1a64e Manivannan Sadhasivam 2021-01-04 @109  		return PTR_ERR(ptable);
> 
> PTR_ERR(NULL) is success.  But let's just fix the IS_ERR_OR_NULL() check
> to IS_ERR() so we don't have to wonder if returning success is
> intentional.

Thanks for the report, I've just sent the fix.

@Manni, I thought you would be added in Cc automatically as you're the
author of the fixed commit, but I was wrong, sorry for the mistake.

Thanks,
Miquèl
