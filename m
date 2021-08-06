Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52B773E26F5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 11:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244303AbhHFJNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 05:13:16 -0400
Received: from mga14.intel.com ([192.55.52.115]:25818 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244163AbhHFJNN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 05:13:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10067"; a="214067929"
X-IronPort-AV: E=Sophos;i="5.84,300,1620716400"; 
   d="gz'50?scan'50,208,50";a="214067929"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2021 02:12:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,300,1620716400"; 
   d="gz'50?scan'50,208,50";a="503938798"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 06 Aug 2021 02:12:55 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mBvuR-000Gi4-0N; Fri, 06 Aug 2021 09:12:55 +0000
Date:   Fri, 6 Aug 2021 17:12:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [mkp-scsi:for-next 85/148] drivers/scsi/scsi_ioctl.c:206:28: sparse:
 sparse: incorrect type in initializer (different address spaces)
Message-ID: <202108061705.Uyfk6x5a-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
head:   f5efd4fe78de871515444b660029074be17ec11f
commit: f2542a3be3277a65c766fa6e86b930d3d839f79e [85/148] scsi: scsi_ioctl: Move the "block layer" SCSI ioctl handling to drivers/scsi
config: sh-randconfig-s032-20210728 (attached as .config)
compiler: sh4-linux-gcc (GCC) 10.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-348-gf0e6938b-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git/commit/?id=f2542a3be3277a65c766fa6e86b930d3d839f79e
        git remote add mkp-scsi https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git
        git fetch --no-tags mkp-scsi for-next
        git checkout f2542a3be3277a65c766fa6e86b930d3d839f79e
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=sh 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/scsi/scsi_ioctl.c:49:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/scsi/scsi_ioctl.c:49:21: sparse:     expected unsigned int const *__gu_addr
   drivers/scsi/scsi_ioctl.c:49:21: sparse:     got unsigned int [noderef] __user *
   drivers/scsi/scsi_ioctl.c:49:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/scsi/scsi_ioctl.c:49:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/scsi/scsi_ioctl.c:49:21: sparse:     got unsigned int const *__gu_addr
>> drivers/scsi/scsi_ioctl.c:206:28: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/scsi/scsi_ioctl.c:206:28: sparse:     expected int const *__gu_addr
   drivers/scsi/scsi_ioctl.c:206:28: sparse:     got int [noderef] __user *p
>> drivers/scsi/scsi_ioctl.c:206:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/scsi/scsi_ioctl.c:206:28: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/scsi/scsi_ioctl.c:206:28: sparse:     got int const *__gu_addr
   drivers/scsi/scsi_ioctl.c:223:25: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/scsi/scsi_ioctl.c:223:25: sparse:     expected int const *__gu_addr
   drivers/scsi/scsi_ioctl.c:223:25: sparse:     got int [noderef] __user *p
   drivers/scsi/scsi_ioctl.c:223:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/scsi/scsi_ioctl.c:223:25: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/scsi/scsi_ioctl.c:223:25: sparse:     got int const *__gu_addr
   drivers/scsi/scsi_ioctl.c:575:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/scsi/scsi_ioctl.c:575:13: sparse:     expected unsigned int const *__gu_addr
   drivers/scsi/scsi_ioctl.c:575:13: sparse:     got unsigned int [noderef] __user *
   drivers/scsi/scsi_ioctl.c:575:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/scsi/scsi_ioctl.c:575:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/scsi/scsi_ioctl.c:575:13: sparse:     got unsigned int const *__gu_addr
   drivers/scsi/scsi_ioctl.c:577:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/scsi/scsi_ioctl.c:577:13: sparse:     expected unsigned int const *__gu_addr
   drivers/scsi/scsi_ioctl.c:577:13: sparse:     got unsigned int [noderef] __user *
   drivers/scsi/scsi_ioctl.c:577:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/scsi/scsi_ioctl.c:577:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/scsi/scsi_ioctl.c:577:13: sparse:     got unsigned int const *__gu_addr
>> drivers/scsi/scsi_ioctl.c:581:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char const *__gu_addr @@     got unsigned char [noderef] __user * @@
   drivers/scsi/scsi_ioctl.c:581:13: sparse:     expected unsigned char const *__gu_addr
   drivers/scsi/scsi_ioctl.c:581:13: sparse:     got unsigned char [noderef] __user *
>> drivers/scsi/scsi_ioctl.c:581:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned char const *__gu_addr @@
   drivers/scsi/scsi_ioctl.c:581:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/scsi/scsi_ioctl.c:581:13: sparse:     got unsigned char const *__gu_addr

vim +206 drivers/scsi/scsi_ioctl.c

    34	
    35	/**
    36	 * ioctl_probe  --  return host identification
    37	 * @host:	host to identify
    38	 * @buffer:	userspace buffer for identification
    39	 *
    40	 * Return an identifying string at @buffer, if @buffer is non-NULL, filling
    41	 * to the length stored at * (int *) @buffer.
    42	 */
    43	static int ioctl_probe(struct Scsi_Host *host, void __user *buffer)
    44	{
    45		unsigned int len, slen;
    46		const char *string;
    47	
    48		if (buffer) {
  > 49			if (get_user(len, (unsigned int __user *) buffer))
    50				return -EFAULT;
    51	
    52			if (host->hostt->info)
    53				string = host->hostt->info(host);
    54			else
    55				string = host->hostt->name;
    56			if (string) {
    57				slen = strlen(string);
    58				if (len > slen)
    59					len = slen + 1;
    60				if (copy_to_user(buffer, string, len))
    61					return -EFAULT;
    62			}
    63		}
    64		return 1;
    65	}
    66	
    67	/*
    68	
    69	 * The SCSI_IOCTL_SEND_COMMAND ioctl sends a command out to the SCSI host.
    70	 * The IOCTL_NORMAL_TIMEOUT and NORMAL_RETRIES  variables are used.  
    71	 * 
    72	 * dev is the SCSI device struct ptr, *(int *) arg is the length of the
    73	 * input data, if any, not including the command string & counts, 
    74	 * *((int *)arg + 1) is the output buffer size in bytes.
    75	 * 
    76	 * *(char *) ((int *) arg)[2] the actual command byte.   
    77	 * 
    78	 * Note that if more than MAX_BUF bytes are requested to be transferred,
    79	 * the ioctl will fail with error EINVAL.
    80	 * 
    81	 * This size *does not* include the initial lengths that were passed.
    82	 * 
    83	 * The SCSI command is read from the memory location immediately after the
    84	 * length words, and the input data is right after the command.  The SCSI
    85	 * routines know the command size based on the opcode decode.  
    86	 * 
    87	 * The output area is then filled in starting from the command byte. 
    88	 */
    89	
    90	static int ioctl_internal_command(struct scsi_device *sdev, char *cmd,
    91					  int timeout, int retries)
    92	{
    93		int result;
    94		struct scsi_sense_hdr sshdr;
    95	
    96		SCSI_LOG_IOCTL(1, sdev_printk(KERN_INFO, sdev,
    97					      "Trying ioctl with scsi command %d\n", *cmd));
    98	
    99		result = scsi_execute_req(sdev, cmd, DMA_NONE, NULL, 0,
   100					  &sshdr, timeout, retries, NULL);
   101	
   102		SCSI_LOG_IOCTL(2, sdev_printk(KERN_INFO, sdev,
   103					      "Ioctl returned  0x%x\n", result));
   104	
   105		if (result < 0)
   106			goto out;
   107		if (scsi_sense_valid(&sshdr)) {
   108			switch (sshdr.sense_key) {
   109			case ILLEGAL_REQUEST:
   110				if (cmd[0] == ALLOW_MEDIUM_REMOVAL)
   111					sdev->lockable = 0;
   112				else
   113					sdev_printk(KERN_INFO, sdev,
   114						    "ioctl_internal_command: "
   115						    "ILLEGAL REQUEST "
   116						    "asc=0x%x ascq=0x%x\n",
   117						    sshdr.asc, sshdr.ascq);
   118				break;
   119			case NOT_READY:	/* This happens if there is no disc in drive */
   120				if (sdev->removable)
   121					break;
   122				fallthrough;
   123			case UNIT_ATTENTION:
   124				if (sdev->removable) {
   125					sdev->changed = 1;
   126					result = 0;	/* This is no longer considered an error */
   127					break;
   128				}
   129				fallthrough;	/* for non-removable media */
   130			default:
   131				sdev_printk(KERN_INFO, sdev,
   132					    "ioctl_internal_command return code = %x\n",
   133					    result);
   134				scsi_print_sense_hdr(sdev, NULL, &sshdr);
   135				break;
   136			}
   137		}
   138	out:
   139		SCSI_LOG_IOCTL(2, sdev_printk(KERN_INFO, sdev,
   140					      "IOCTL Releasing command\n"));
   141		return result;
   142	}
   143	
   144	int scsi_set_medium_removal(struct scsi_device *sdev, char state)
   145	{
   146		char scsi_cmd[MAX_COMMAND_SIZE];
   147		int ret;
   148	
   149		if (!sdev->removable || !sdev->lockable)
   150		       return 0;
   151	
   152		scsi_cmd[0] = ALLOW_MEDIUM_REMOVAL;
   153		scsi_cmd[1] = 0;
   154		scsi_cmd[2] = 0;
   155		scsi_cmd[3] = 0;
   156		scsi_cmd[4] = state;
   157		scsi_cmd[5] = 0;
   158	
   159		ret = ioctl_internal_command(sdev, scsi_cmd,
   160				IOCTL_NORMAL_TIMEOUT, NORMAL_RETRIES);
   161		if (ret == 0)
   162			sdev->locked = (state == SCSI_REMOVAL_PREVENT);
   163		return ret;
   164	}
   165	EXPORT_SYMBOL(scsi_set_medium_removal);
   166	
   167	/*
   168	 * The scsi_ioctl_get_pci() function places into arg the value
   169	 * pci_dev::slot_name (8 characters) for the PCI device (if any).
   170	 * Returns: 0 on success
   171	 *          -ENXIO if there isn't a PCI device pointer
   172	 *                 (could be because the SCSI driver hasn't been
   173	 *                  updated yet, or because it isn't a SCSI
   174	 *                  device)
   175	 *          any copy_to_user() error on failure there
   176	 */
   177	static int scsi_ioctl_get_pci(struct scsi_device *sdev, void __user *arg)
   178	{
   179		struct device *dev = scsi_get_device(sdev->host);
   180		const char *name;
   181	
   182	        if (!dev)
   183			return -ENXIO;
   184	
   185		name = dev_name(dev);
   186	
   187		/* compatibility with old ioctl which only returned
   188		 * 20 characters */
   189	        return copy_to_user(arg, name, min(strlen(name), (size_t)20))
   190			? -EFAULT: 0;
   191	}
   192	
   193	static int sg_get_version(int __user *p)
   194	{
   195		static const int sg_version_num = 30527;
   196		return put_user(sg_version_num, p);
   197	}
   198	
   199	static int sg_get_timeout(struct request_queue *q)
   200	{
   201		return jiffies_to_clock_t(q->sg_timeout);
   202	}
   203	
   204	static int sg_set_timeout(struct request_queue *q, int __user *p)
   205	{
 > 206		int timeout, err = get_user(timeout, p);
   207	
   208		if (!err)
   209			q->sg_timeout = clock_t_to_jiffies(timeout);
   210	
   211		return err;
   212	}
   213	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--ibTvN161/egqYuK8
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--ibTvN161/egqYuK8--
