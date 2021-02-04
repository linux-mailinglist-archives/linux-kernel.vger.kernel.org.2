Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0E7E30F174
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 12:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235546AbhBDLBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 06:01:30 -0500
Received: from mga14.intel.com ([192.55.52.115]:7099 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235464AbhBDLBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 06:01:09 -0500
IronPort-SDR: GIDsenPvfP5l2qoMYEEn9+fSHIeRwHP85h2tQiHa1OmMiODT1H7jPXGcSH2u6ir7CDU7VNEKEN
 SU0a5LuTTb8w==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="180442338"
X-IronPort-AV: E=Sophos;i="5.79,400,1602572400"; 
   d="gz'50?scan'50,208,50";a="180442338"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 03:00:24 -0800
IronPort-SDR: Yozp0Bu4Q+qaqIfUCfm2Lv9tF55CxAbvnTHgj32/bKEI7tAXnSkzZzpN7vr+anpNz28AbzOYff
 sY3sw0Q6Qzwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,400,1602572400"; 
   d="gz'50?scan'50,208,50";a="359756413"
Received: from lkp-server02.sh.intel.com (HELO 8b832f01bb9c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 04 Feb 2021 03:00:20 -0800
Received: from kbuild by 8b832f01bb9c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l7cN1-0000ub-St; Thu, 04 Feb 2021 11:00:19 +0000
Date:   Thu, 4 Feb 2021 18:59:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: drivers/scsi/gdth_proc.c:249:42: warning: conversion from 'long
 unsigned int' to 'u16' {aka 'short unsigned int'} changes value from
 '196608' to '0'
Message-ID: <202102041834.pqiVcJxO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Christophe,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   61556703b610a104de324e4f061dc6cf7b218b46
commit: 03fd42d458fb9cb69e712600bd69ff77ff3a45a8 powerpc/fixmap: Fix FIX_EARLY_DEBUG_BASE when page size is 256k
date:   8 months ago
config: powerpc-randconfig-m031-20210204 (attached as .config)
compiler: powerpc-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=03fd42d458fb9cb69e712600bd69ff77ff3a45a8
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 03fd42d458fb9cb69e712600bd69ff77ff3a45a8
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=powerpc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/scsi/gdth.c:266:
   drivers/scsi/gdth_proc.c: In function 'gdth_show_info':
>> drivers/scsi/gdth_proc.c:249:42: warning: conversion from 'long unsigned int' to 'u16' {aka 'short unsigned int'} changes value from '196608' to '0' [-Woverflow]
     249 |             gdtcmd->u.ioctl.param_size = 3*GDTH_SCRATCH/4;
         |                                          ^
   drivers/scsi/gdth.c: In function 'gdth_async_event':
   drivers/scsi/gdth.c:3010:9: warning: variable 'cmd_index' set but not used [-Wunused-but-set-variable]
    3010 |     int cmd_index;
         |         ^~~~~~~~~
   drivers/scsi/gdth.c: At top level:
   drivers/scsi/gdth.c:3231:12: warning: no previous prototype for 'option_setup' [-Wmissing-prototypes]
    3231 | int __init option_setup(char *str)
         |            ^~~~~~~~~~~~
--
   In file included from arch/powerpc/include/asm/thread_info.h:13,
                    from include/linux/thread_info.h:38,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/powerpc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:51,
                    from include/linux/seqlock.h:36,
                    from include/linux/time.h:6,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:13,
                    from drivers/net/vmxnet3/vmxnet3_drv.c:27:
   drivers/net/vmxnet3/vmxnet3_drv.c: In function 'vmxnet3_rq_init':
>> arch/powerpc/include/asm/page.h:24:20: warning: conversion from 'long unsigned int' to 'u16' {aka 'short unsigned int'} changes value from '262144' to '0' [-Woverflow]
      24 | #define PAGE_SIZE  (ASM_CONST(1) << PAGE_SHIFT)
         |                    ^
   drivers/net/vmxnet3/vmxnet3_drv.c:1785:29: note: in expansion of macro 'PAGE_SIZE'
    1785 |    rq->buf_info[0][i].len = PAGE_SIZE;
         |                             ^~~~~~~~~
>> arch/powerpc/include/asm/page.h:24:20: warning: conversion from 'long unsigned int' to 'u16' {aka 'short unsigned int'} changes value from '262144' to '0' [-Woverflow]
      24 | #define PAGE_SIZE  (ASM_CONST(1) << PAGE_SHIFT)
         |                    ^
   drivers/net/vmxnet3/vmxnet3_drv.c:1790:28: note: in expansion of macro 'PAGE_SIZE'
    1790 |   rq->buf_info[1][i].len = PAGE_SIZE;
         |                            ^~~~~~~~~


vim +249 drivers/scsi/gdth_proc.c

^1da177e4c3f41 Linus Torvalds    2005-04-16  150  
3e0552eebdf621 Al Viro           2013-03-31  151  int gdth_show_info(struct seq_file *m, struct Scsi_Host *host)
^1da177e4c3f41 Linus Torvalds    2005-04-16  152  {
3e0552eebdf621 Al Viro           2013-03-31  153      gdth_ha_str *ha = shost_priv(host);
238ddbb98c327a Alan Cox          2009-06-09  154      int hlen;
^1da177e4c3f41 Linus Torvalds    2005-04-16  155      int id, i, j, k, sec, flag;
^1da177e4c3f41 Linus Torvalds    2005-04-16  156      int no_mdrv = 0, drv_no, is_mirr;
1fe6dbf4d0afba Dave Jones        2010-01-04  157      u32 cnt;
463563fa745ac7 Christoph Hellwig 2018-12-12  158      dma_addr_t paddr;
^1da177e4c3f41 Linus Torvalds    2005-04-16  159      int rc = -ENOMEM;
^1da177e4c3f41 Linus Torvalds    2005-04-16  160  
^1da177e4c3f41 Linus Torvalds    2005-04-16  161      gdth_cmd_str *gdtcmd;
^1da177e4c3f41 Linus Torvalds    2005-04-16  162      gdth_evt_str *estr;
345ebae7d0586d Arnd Bergmann     2017-07-14  163      char hrec[277];
^1da177e4c3f41 Linus Torvalds    2005-04-16  164  
^1da177e4c3f41 Linus Torvalds    2005-04-16  165      char *buf;
^1da177e4c3f41 Linus Torvalds    2005-04-16  166      gdth_dskstat_str *pds;
^1da177e4c3f41 Linus Torvalds    2005-04-16  167      gdth_diskinfo_str *pdi;
^1da177e4c3f41 Linus Torvalds    2005-04-16  168      gdth_arrayinf_str *pai;
^1da177e4c3f41 Linus Torvalds    2005-04-16  169      gdth_defcnt_str *pdef;
^1da177e4c3f41 Linus Torvalds    2005-04-16  170      gdth_cdrinfo_str *pcdi;
^1da177e4c3f41 Linus Torvalds    2005-04-16  171      gdth_hget_str *phg;
^1da177e4c3f41 Linus Torvalds    2005-04-16  172      char cmnd[MAX_COMMAND_SIZE];
^1da177e4c3f41 Linus Torvalds    2005-04-16  173  
^1da177e4c3f41 Linus Torvalds    2005-04-16  174      gdtcmd = kmalloc(sizeof(*gdtcmd), GFP_KERNEL);
^1da177e4c3f41 Linus Torvalds    2005-04-16  175      estr = kmalloc(sizeof(*estr), GFP_KERNEL);
^1da177e4c3f41 Linus Torvalds    2005-04-16  176      if (!gdtcmd || !estr)
^1da177e4c3f41 Linus Torvalds    2005-04-16  177          goto free_fail;
^1da177e4c3f41 Linus Torvalds    2005-04-16  178  
^1da177e4c3f41 Linus Torvalds    2005-04-16  179      memset(cmnd, 0xff, 12);
^1da177e4c3f41 Linus Torvalds    2005-04-16  180      memset(gdtcmd, 0, sizeof(gdth_cmd_str));
^1da177e4c3f41 Linus Torvalds    2005-04-16  181  
45f1a41b2b2e02 Boaz Harrosh      2007-10-02  182      TRACE2(("gdth_get_info() ha %d\n",ha->hanum));
^1da177e4c3f41 Linus Torvalds    2005-04-16  183  
^1da177e4c3f41 Linus Torvalds    2005-04-16  184      
^1da177e4c3f41 Linus Torvalds    2005-04-16  185      /* request is i.e. "cat /proc/scsi/gdth/0" */ 
^1da177e4c3f41 Linus Torvalds    2005-04-16  186      /* format: %-15s\t%-10s\t%-15s\t%s */
^1da177e4c3f41 Linus Torvalds    2005-04-16  187      /* driver parameters */
91c40f24faadd9 Rasmus Villemoes  2014-12-03  188      seq_puts(m, "Driver Parameters:\n");
^1da177e4c3f41 Linus Torvalds    2005-04-16  189      if (reserve_list[0] == 0xff)
^1da177e4c3f41 Linus Torvalds    2005-04-16  190          strcpy(hrec, "--");
^1da177e4c3f41 Linus Torvalds    2005-04-16  191      else {
238ddbb98c327a Alan Cox          2009-06-09  192          hlen = sprintf(hrec, "%d", reserve_list[0]);
^1da177e4c3f41 Linus Torvalds    2005-04-16  193          for (i = 1;  i < MAX_RES_ARGS; i++) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  194              if (reserve_list[i] == 0xff) 
^1da177e4c3f41 Linus Torvalds    2005-04-16  195                  break;
473e554d656eb6 Takashi Iwai      2020-03-15  196  	    hlen += scnprintf(hrec + hlen, 161 - hlen, ",%d", reserve_list[i]);
^1da177e4c3f41 Linus Torvalds    2005-04-16  197          }
^1da177e4c3f41 Linus Torvalds    2005-04-16  198      }
3e0552eebdf621 Al Viro           2013-03-31  199      seq_printf(m,
^1da177e4c3f41 Linus Torvalds    2005-04-16  200                     " reserve_mode: \t%d         \treserve_list:  \t%s\n",
^1da177e4c3f41 Linus Torvalds    2005-04-16  201                     reserve_mode, hrec);
3e0552eebdf621 Al Viro           2013-03-31  202      seq_printf(m,
^1da177e4c3f41 Linus Torvalds    2005-04-16  203                     " max_ids:      \t%-3d       \thdr_channel:   \t%d\n",
^1da177e4c3f41 Linus Torvalds    2005-04-16  204                     max_ids, hdr_channel);
^1da177e4c3f41 Linus Torvalds    2005-04-16  205  
^1da177e4c3f41 Linus Torvalds    2005-04-16  206      /* controller information */
91c40f24faadd9 Rasmus Villemoes  2014-12-03  207      seq_puts(m, "\nDisk Array Controller Information:\n");
3e0552eebdf621 Al Viro           2013-03-31  208      seq_printf(m,
^1da177e4c3f41 Linus Torvalds    2005-04-16  209                     " Number:       \t%d         \tName:          \t%s\n",
3e0552eebdf621 Al Viro           2013-03-31  210                     ha->hanum, ha->binfo.type_string);
^1da177e4c3f41 Linus Torvalds    2005-04-16  211  
3e0552eebdf621 Al Viro           2013-03-31  212      seq_printf(m,
3e0552eebdf621 Al Viro           2013-03-31  213                     " Driver Ver.:  \t%-10s\tFirmware Ver.: \t",
3e0552eebdf621 Al Viro           2013-03-31  214                     GDTH_VERSION_STR);
^1da177e4c3f41 Linus Torvalds    2005-04-16  215      if (ha->more_proc)
3e0552eebdf621 Al Viro           2013-03-31  216          seq_printf(m, "%d.%02d.%02d-%c%03X\n", 
1fe6dbf4d0afba Dave Jones        2010-01-04  217                  (u8)(ha->binfo.upd_fw_ver>>24),
1fe6dbf4d0afba Dave Jones        2010-01-04  218                  (u8)(ha->binfo.upd_fw_ver>>16),
1fe6dbf4d0afba Dave Jones        2010-01-04  219                  (u8)(ha->binfo.upd_fw_ver),
^1da177e4c3f41 Linus Torvalds    2005-04-16  220                  ha->bfeat.raid ? 'R':'N',
^1da177e4c3f41 Linus Torvalds    2005-04-16  221                  ha->binfo.upd_revision);
^1da177e4c3f41 Linus Torvalds    2005-04-16  222      else
3e0552eebdf621 Al Viro           2013-03-31  223          seq_printf(m, "%d.%02d\n", (u8)(ha->cpar.version>>8),
1fe6dbf4d0afba Dave Jones        2010-01-04  224                  (u8)(ha->cpar.version));
^1da177e4c3f41 Linus Torvalds    2005-04-16  225   
3e0552eebdf621 Al Viro           2013-03-31  226      if (ha->more_proc)
^1da177e4c3f41 Linus Torvalds    2005-04-16  227          /* more information: 1. about controller */
3e0552eebdf621 Al Viro           2013-03-31  228          seq_printf(m,
^1da177e4c3f41 Linus Torvalds    2005-04-16  229                         " Serial No.:   \t0x%8X\tCache RAM size:\t%d KB\n",
^1da177e4c3f41 Linus Torvalds    2005-04-16  230                         ha->binfo.ser_no, ha->binfo.memsize / 1024);
^1da177e4c3f41 Linus Torvalds    2005-04-16  231  
^1da177e4c3f41 Linus Torvalds    2005-04-16  232      if (ha->more_proc) {
8d22022c3a5631 Christoph Hellwig 2018-12-12  233          size_t size = max_t(size_t, GDTH_SCRATCH, sizeof(gdth_hget_str));
8d22022c3a5631 Christoph Hellwig 2018-12-12  234  
^1da177e4c3f41 Linus Torvalds    2005-04-16  235          /* more information: 2. about physical devices */
91c40f24faadd9 Rasmus Villemoes  2014-12-03  236          seq_puts(m, "\nPhysical Devices:");
^1da177e4c3f41 Linus Torvalds    2005-04-16  237          flag = FALSE;
^1da177e4c3f41 Linus Torvalds    2005-04-16  238              
bb327df8326eff Christoph Hellwig 2018-12-12  239          buf = dma_alloc_coherent(&ha->pdev->dev, size, &paddr, GFP_KERNEL);
^1da177e4c3f41 Linus Torvalds    2005-04-16  240          if (!buf) 
^1da177e4c3f41 Linus Torvalds    2005-04-16  241              goto stop_output;
^1da177e4c3f41 Linus Torvalds    2005-04-16  242          for (i = 0; i < ha->bus_cnt; ++i) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  243              /* 2.a statistics (and retries/reassigns) */
^1da177e4c3f41 Linus Torvalds    2005-04-16  244              TRACE2(("pdr_statistics() chn %d\n",i));                
^1da177e4c3f41 Linus Torvalds    2005-04-16  245              pds = (gdth_dskstat_str *)(buf + GDTH_SCRATCH/4);
^1da177e4c3f41 Linus Torvalds    2005-04-16  246              gdtcmd->Service = CACHESERVICE;
^1da177e4c3f41 Linus Torvalds    2005-04-16  247              gdtcmd->OpCode = GDT_IOCTL;
^1da177e4c3f41 Linus Torvalds    2005-04-16  248              gdtcmd->u.ioctl.p_param = paddr + GDTH_SCRATCH/4;
^1da177e4c3f41 Linus Torvalds    2005-04-16 @249              gdtcmd->u.ioctl.param_size = 3*GDTH_SCRATCH/4;
^1da177e4c3f41 Linus Torvalds    2005-04-16  250              gdtcmd->u.ioctl.subfunc = DSK_STATISTICS | L_CTRL_PATTERN;
^1da177e4c3f41 Linus Torvalds    2005-04-16  251              gdtcmd->u.ioctl.channel = ha->raw[i].address | INVALID_CHANNEL;
^1da177e4c3f41 Linus Torvalds    2005-04-16  252              pds->bid = ha->raw[i].local_no;
^1da177e4c3f41 Linus Torvalds    2005-04-16  253              pds->first = 0;
^1da177e4c3f41 Linus Torvalds    2005-04-16  254              pds->entries = ha->raw[i].pdev_cnt;
1fe6dbf4d0afba Dave Jones        2010-01-04  255              cnt = (3*GDTH_SCRATCH/4 - 5 * sizeof(u32)) /
^1da177e4c3f41 Linus Torvalds    2005-04-16  256                  sizeof(pds->list[0]);
^1da177e4c3f41 Linus Torvalds    2005-04-16  257              if (pds->entries > cnt)
^1da177e4c3f41 Linus Torvalds    2005-04-16  258                  pds->entries = cnt;
cbd5f69b98bb5d Leubner, Achim    2006-06-09  259  
cbd5f69b98bb5d Leubner, Achim    2006-06-09  260              if (gdth_execute(host, gdtcmd, cmnd, 30, NULL) != S_OK)
^1da177e4c3f41 Linus Torvalds    2005-04-16  261                  pds->count = 0;
^1da177e4c3f41 Linus Torvalds    2005-04-16  262  
^1da177e4c3f41 Linus Torvalds    2005-04-16  263              /* other IOCTLs must fit into area GDTH_SCRATCH/4 */
^1da177e4c3f41 Linus Torvalds    2005-04-16  264              for (j = 0; j < ha->raw[i].pdev_cnt; ++j) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  265                  /* 2.b drive info */
^1da177e4c3f41 Linus Torvalds    2005-04-16  266                  TRACE2(("scsi_drv_info() chn %d dev %d\n",
^1da177e4c3f41 Linus Torvalds    2005-04-16  267                      i, ha->raw[i].id_list[j]));             
^1da177e4c3f41 Linus Torvalds    2005-04-16  268                  pdi = (gdth_diskinfo_str *)buf;
^1da177e4c3f41 Linus Torvalds    2005-04-16  269                  gdtcmd->Service = CACHESERVICE;
^1da177e4c3f41 Linus Torvalds    2005-04-16  270                  gdtcmd->OpCode = GDT_IOCTL;
^1da177e4c3f41 Linus Torvalds    2005-04-16  271                  gdtcmd->u.ioctl.p_param = paddr;
^1da177e4c3f41 Linus Torvalds    2005-04-16  272                  gdtcmd->u.ioctl.param_size = sizeof(gdth_diskinfo_str);
^1da177e4c3f41 Linus Torvalds    2005-04-16  273                  gdtcmd->u.ioctl.subfunc = SCSI_DR_INFO | L_CTRL_PATTERN;
^1da177e4c3f41 Linus Torvalds    2005-04-16  274                  gdtcmd->u.ioctl.channel = 
^1da177e4c3f41 Linus Torvalds    2005-04-16  275                      ha->raw[i].address | ha->raw[i].id_list[j];
cbd5f69b98bb5d Leubner, Achim    2006-06-09  276  
cbd5f69b98bb5d Leubner, Achim    2006-06-09  277                  if (gdth_execute(host, gdtcmd, cmnd, 30, NULL) == S_OK) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  278                      strncpy(hrec,pdi->vendor,8);
^1da177e4c3f41 Linus Torvalds    2005-04-16  279                      strncpy(hrec+8,pdi->product,16);
^1da177e4c3f41 Linus Torvalds    2005-04-16  280                      strncpy(hrec+24,pdi->revision,4);
^1da177e4c3f41 Linus Torvalds    2005-04-16  281                      hrec[28] = 0;
3e0552eebdf621 Al Viro           2013-03-31  282                      seq_printf(m,
^1da177e4c3f41 Linus Torvalds    2005-04-16  283                                     "\n Chn/ID/LUN:   \t%c/%02d/%d    \tName:          \t%s\n",
^1da177e4c3f41 Linus Torvalds    2005-04-16  284                                     'A'+i,pdi->target_id,pdi->lun,hrec);
^1da177e4c3f41 Linus Torvalds    2005-04-16  285                      flag = TRUE;
^1da177e4c3f41 Linus Torvalds    2005-04-16  286                      pdi->no_ldrive &= 0xffff;
^1da177e4c3f41 Linus Torvalds    2005-04-16  287                      if (pdi->no_ldrive == 0xffff)
^1da177e4c3f41 Linus Torvalds    2005-04-16  288                          strcpy(hrec,"--");
^1da177e4c3f41 Linus Torvalds    2005-04-16  289                      else
^1da177e4c3f41 Linus Torvalds    2005-04-16  290                          sprintf(hrec,"%d",pdi->no_ldrive);
3e0552eebdf621 Al Viro           2013-03-31  291                      seq_printf(m,
^1da177e4c3f41 Linus Torvalds    2005-04-16  292                                     " Capacity [MB]:\t%-6d    \tTo Log. Drive: \t%s\n",
^1da177e4c3f41 Linus Torvalds    2005-04-16  293                                     pdi->blkcnt/(1024*1024/pdi->blksize),
^1da177e4c3f41 Linus Torvalds    2005-04-16  294                                     hrec);
^1da177e4c3f41 Linus Torvalds    2005-04-16  295                  } else {
^1da177e4c3f41 Linus Torvalds    2005-04-16  296                      pdi->devtype = 0xff;
^1da177e4c3f41 Linus Torvalds    2005-04-16  297                  }
^1da177e4c3f41 Linus Torvalds    2005-04-16  298                      
^1da177e4c3f41 Linus Torvalds    2005-04-16  299                  if (pdi->devtype == 0) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  300                      /* search retries/reassigns */
^1da177e4c3f41 Linus Torvalds    2005-04-16  301                      for (k = 0; k < pds->count; ++k) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  302                          if (pds->list[k].tid == pdi->target_id &&
^1da177e4c3f41 Linus Torvalds    2005-04-16  303                              pds->list[k].lun == pdi->lun) {
3e0552eebdf621 Al Viro           2013-03-31  304                              seq_printf(m,
^1da177e4c3f41 Linus Torvalds    2005-04-16  305                                             " Retries:      \t%-6d    \tReassigns:     \t%d\n",
^1da177e4c3f41 Linus Torvalds    2005-04-16  306                                             pds->list[k].retries,
^1da177e4c3f41 Linus Torvalds    2005-04-16  307                                             pds->list[k].reassigns);
^1da177e4c3f41 Linus Torvalds    2005-04-16  308                              break;
^1da177e4c3f41 Linus Torvalds    2005-04-16  309                          }
^1da177e4c3f41 Linus Torvalds    2005-04-16  310                      }
^1da177e4c3f41 Linus Torvalds    2005-04-16  311                      /* 2.c grown defects */
^1da177e4c3f41 Linus Torvalds    2005-04-16  312                      TRACE2(("scsi_drv_defcnt() chn %d dev %d\n",
^1da177e4c3f41 Linus Torvalds    2005-04-16  313                              i, ha->raw[i].id_list[j]));             
^1da177e4c3f41 Linus Torvalds    2005-04-16  314                      pdef = (gdth_defcnt_str *)buf;
^1da177e4c3f41 Linus Torvalds    2005-04-16  315                      gdtcmd->Service = CACHESERVICE;
^1da177e4c3f41 Linus Torvalds    2005-04-16  316                      gdtcmd->OpCode = GDT_IOCTL;
^1da177e4c3f41 Linus Torvalds    2005-04-16  317                      gdtcmd->u.ioctl.p_param = paddr;
^1da177e4c3f41 Linus Torvalds    2005-04-16  318                      gdtcmd->u.ioctl.param_size = sizeof(gdth_defcnt_str);
^1da177e4c3f41 Linus Torvalds    2005-04-16  319                      gdtcmd->u.ioctl.subfunc = SCSI_DEF_CNT | L_CTRL_PATTERN;
^1da177e4c3f41 Linus Torvalds    2005-04-16  320                      gdtcmd->u.ioctl.channel = 
^1da177e4c3f41 Linus Torvalds    2005-04-16  321                          ha->raw[i].address | ha->raw[i].id_list[j];
^1da177e4c3f41 Linus Torvalds    2005-04-16  322                      pdef->sddc_type = 0x08;
cbd5f69b98bb5d Leubner, Achim    2006-06-09  323  
cbd5f69b98bb5d Leubner, Achim    2006-06-09  324                      if (gdth_execute(host, gdtcmd, cmnd, 30, NULL) == S_OK) {
3e0552eebdf621 Al Viro           2013-03-31  325                          seq_printf(m,
^1da177e4c3f41 Linus Torvalds    2005-04-16  326                                         " Grown Defects:\t%d\n",
^1da177e4c3f41 Linus Torvalds    2005-04-16  327                                         pdef->sddc_cnt);
^1da177e4c3f41 Linus Torvalds    2005-04-16  328                      }
^1da177e4c3f41 Linus Torvalds    2005-04-16  329                  }
^1da177e4c3f41 Linus Torvalds    2005-04-16  330              }
5c10007560589a Julia Lawall      2010-12-29  331          }
^1da177e4c3f41 Linus Torvalds    2005-04-16  332  
3e0552eebdf621 Al Viro           2013-03-31  333          if (!flag)
91c40f24faadd9 Rasmus Villemoes  2014-12-03  334              seq_puts(m, "\n --\n");
^1da177e4c3f41 Linus Torvalds    2005-04-16  335  
^1da177e4c3f41 Linus Torvalds    2005-04-16  336          /* 3. about logical drives */
91c40f24faadd9 Rasmus Villemoes  2014-12-03  337          seq_puts(m, "\nLogical Drives:");
^1da177e4c3f41 Linus Torvalds    2005-04-16  338          flag = FALSE;
^1da177e4c3f41 Linus Torvalds    2005-04-16  339  
^1da177e4c3f41 Linus Torvalds    2005-04-16  340          for (i = 0; i < MAX_LDRIVES; ++i) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  341              if (!ha->hdr[i].is_logdrv)
^1da177e4c3f41 Linus Torvalds    2005-04-16  342                  continue;
^1da177e4c3f41 Linus Torvalds    2005-04-16  343              drv_no = i;
^1da177e4c3f41 Linus Torvalds    2005-04-16  344              j = k = 0;
^1da177e4c3f41 Linus Torvalds    2005-04-16  345              is_mirr = FALSE;
^1da177e4c3f41 Linus Torvalds    2005-04-16  346              do {
^1da177e4c3f41 Linus Torvalds    2005-04-16  347                  /* 3.a log. drive info */
^1da177e4c3f41 Linus Torvalds    2005-04-16  348                  TRACE2(("cache_drv_info() drive no %d\n",drv_no));
^1da177e4c3f41 Linus Torvalds    2005-04-16  349                  pcdi = (gdth_cdrinfo_str *)buf;
^1da177e4c3f41 Linus Torvalds    2005-04-16  350                  gdtcmd->Service = CACHESERVICE;
^1da177e4c3f41 Linus Torvalds    2005-04-16  351                  gdtcmd->OpCode = GDT_IOCTL;
^1da177e4c3f41 Linus Torvalds    2005-04-16  352                  gdtcmd->u.ioctl.p_param = paddr;
^1da177e4c3f41 Linus Torvalds    2005-04-16  353                  gdtcmd->u.ioctl.param_size = sizeof(gdth_cdrinfo_str);
^1da177e4c3f41 Linus Torvalds    2005-04-16  354                  gdtcmd->u.ioctl.subfunc = CACHE_DRV_INFO;
^1da177e4c3f41 Linus Torvalds    2005-04-16  355                  gdtcmd->u.ioctl.channel = drv_no;
cbd5f69b98bb5d Leubner, Achim    2006-06-09  356                  if (gdth_execute(host, gdtcmd, cmnd, 30, NULL) != S_OK)
^1da177e4c3f41 Linus Torvalds    2005-04-16  357                      break;
^1da177e4c3f41 Linus Torvalds    2005-04-16  358                  pcdi->ld_dtype >>= 16;
^1da177e4c3f41 Linus Torvalds    2005-04-16  359                  j++;
^1da177e4c3f41 Linus Torvalds    2005-04-16  360                  if (pcdi->ld_dtype > 2) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  361                      strcpy(hrec, "missing");
^1da177e4c3f41 Linus Torvalds    2005-04-16  362                  } else if (pcdi->ld_error & 1) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  363                      strcpy(hrec, "fault");
^1da177e4c3f41 Linus Torvalds    2005-04-16  364                  } else if (pcdi->ld_error & 2) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  365                      strcpy(hrec, "invalid");
^1da177e4c3f41 Linus Torvalds    2005-04-16  366                      k++; j--;
^1da177e4c3f41 Linus Torvalds    2005-04-16  367                  } else {
^1da177e4c3f41 Linus Torvalds    2005-04-16  368                      strcpy(hrec, "ok");
^1da177e4c3f41 Linus Torvalds    2005-04-16  369                  }
^1da177e4c3f41 Linus Torvalds    2005-04-16  370                      
^1da177e4c3f41 Linus Torvalds    2005-04-16  371                  if (drv_no == i) {
3e0552eebdf621 Al Viro           2013-03-31  372                      seq_printf(m,
^1da177e4c3f41 Linus Torvalds    2005-04-16  373                                     "\n Number:       \t%-2d        \tStatus:        \t%s\n",
^1da177e4c3f41 Linus Torvalds    2005-04-16  374                                     drv_no, hrec);
^1da177e4c3f41 Linus Torvalds    2005-04-16  375                      flag = TRUE;
^1da177e4c3f41 Linus Torvalds    2005-04-16  376                      no_mdrv = pcdi->cd_ldcnt;
^1da177e4c3f41 Linus Torvalds    2005-04-16  377                      if (no_mdrv > 1 || pcdi->ld_slave != -1) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  378                          is_mirr = TRUE;
^1da177e4c3f41 Linus Torvalds    2005-04-16  379                          strcpy(hrec, "RAID-1");
^1da177e4c3f41 Linus Torvalds    2005-04-16  380                      } else if (pcdi->ld_dtype == 0) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  381                          strcpy(hrec, "Disk");
^1da177e4c3f41 Linus Torvalds    2005-04-16  382                      } else if (pcdi->ld_dtype == 1) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  383                          strcpy(hrec, "RAID-0");
^1da177e4c3f41 Linus Torvalds    2005-04-16  384                      } else if (pcdi->ld_dtype == 2) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  385                          strcpy(hrec, "Chain");
^1da177e4c3f41 Linus Torvalds    2005-04-16  386                      } else {
^1da177e4c3f41 Linus Torvalds    2005-04-16  387                          strcpy(hrec, "???");
^1da177e4c3f41 Linus Torvalds    2005-04-16  388                      }
3e0552eebdf621 Al Viro           2013-03-31  389                      seq_printf(m,
^1da177e4c3f41 Linus Torvalds    2005-04-16  390                                     " Capacity [MB]:\t%-6d    \tType:          \t%s\n",
^1da177e4c3f41 Linus Torvalds    2005-04-16  391                                     pcdi->ld_blkcnt/(1024*1024/pcdi->ld_blksize),
^1da177e4c3f41 Linus Torvalds    2005-04-16  392                                     hrec);
^1da177e4c3f41 Linus Torvalds    2005-04-16  393                  } else {
3e0552eebdf621 Al Viro           2013-03-31  394                      seq_printf(m,
^1da177e4c3f41 Linus Torvalds    2005-04-16  395                                     " Slave Number: \t%-2d        \tStatus:        \t%s\n",
^1da177e4c3f41 Linus Torvalds    2005-04-16  396                                     drv_no & 0x7fff, hrec);
^1da177e4c3f41 Linus Torvalds    2005-04-16  397                  }
^1da177e4c3f41 Linus Torvalds    2005-04-16  398                  drv_no = pcdi->ld_slave;
^1da177e4c3f41 Linus Torvalds    2005-04-16  399              } while (drv_no != -1);
^1da177e4c3f41 Linus Torvalds    2005-04-16  400               
3e0552eebdf621 Al Viro           2013-03-31  401              if (is_mirr)
3e0552eebdf621 Al Viro           2013-03-31  402                  seq_printf(m,
^1da177e4c3f41 Linus Torvalds    2005-04-16  403                                 " Missing Drv.: \t%-2d        \tInvalid Drv.:  \t%d\n",
^1da177e4c3f41 Linus Torvalds    2005-04-16  404                                 no_mdrv - j - k, k);
^1da177e4c3f41 Linus Torvalds    2005-04-16  405  
^1da177e4c3f41 Linus Torvalds    2005-04-16  406              if (!ha->hdr[i].is_arraydrv)
^1da177e4c3f41 Linus Torvalds    2005-04-16  407                  strcpy(hrec, "--");
^1da177e4c3f41 Linus Torvalds    2005-04-16  408              else
^1da177e4c3f41 Linus Torvalds    2005-04-16  409                  sprintf(hrec, "%d", ha->hdr[i].master_no);
3e0552eebdf621 Al Viro           2013-03-31  410              seq_printf(m,
^1da177e4c3f41 Linus Torvalds    2005-04-16  411                             " To Array Drv.:\t%s\n", hrec);
5c10007560589a Julia Lawall      2010-12-29  412          }       
^1da177e4c3f41 Linus Torvalds    2005-04-16  413  
3e0552eebdf621 Al Viro           2013-03-31  414          if (!flag)
91c40f24faadd9 Rasmus Villemoes  2014-12-03  415              seq_puts(m, "\n --\n");
^1da177e4c3f41 Linus Torvalds    2005-04-16  416  
^1da177e4c3f41 Linus Torvalds    2005-04-16  417          /* 4. about array drives */
91c40f24faadd9 Rasmus Villemoes  2014-12-03  418          seq_puts(m, "\nArray Drives:");
^1da177e4c3f41 Linus Torvalds    2005-04-16  419          flag = FALSE;
^1da177e4c3f41 Linus Torvalds    2005-04-16  420  
^1da177e4c3f41 Linus Torvalds    2005-04-16  421          for (i = 0; i < MAX_LDRIVES; ++i) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  422              if (!(ha->hdr[i].is_arraydrv && ha->hdr[i].is_master))
^1da177e4c3f41 Linus Torvalds    2005-04-16  423                  continue;
^1da177e4c3f41 Linus Torvalds    2005-04-16  424              /* 4.a array drive info */
^1da177e4c3f41 Linus Torvalds    2005-04-16  425              TRACE2(("array_info() drive no %d\n",i));
^1da177e4c3f41 Linus Torvalds    2005-04-16  426              pai = (gdth_arrayinf_str *)buf;
^1da177e4c3f41 Linus Torvalds    2005-04-16  427              gdtcmd->Service = CACHESERVICE;
^1da177e4c3f41 Linus Torvalds    2005-04-16  428              gdtcmd->OpCode = GDT_IOCTL;
^1da177e4c3f41 Linus Torvalds    2005-04-16  429              gdtcmd->u.ioctl.p_param = paddr;
^1da177e4c3f41 Linus Torvalds    2005-04-16  430              gdtcmd->u.ioctl.param_size = sizeof(gdth_arrayinf_str);
^1da177e4c3f41 Linus Torvalds    2005-04-16  431              gdtcmd->u.ioctl.subfunc = ARRAY_INFO | LA_CTRL_PATTERN;
^1da177e4c3f41 Linus Torvalds    2005-04-16  432              gdtcmd->u.ioctl.channel = i;
cbd5f69b98bb5d Leubner, Achim    2006-06-09  433              if (gdth_execute(host, gdtcmd, cmnd, 30, NULL) == S_OK) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  434                  if (pai->ai_state == 0)
^1da177e4c3f41 Linus Torvalds    2005-04-16  435                      strcpy(hrec, "idle");
^1da177e4c3f41 Linus Torvalds    2005-04-16  436                  else if (pai->ai_state == 2)
^1da177e4c3f41 Linus Torvalds    2005-04-16  437                      strcpy(hrec, "build");
^1da177e4c3f41 Linus Torvalds    2005-04-16  438                  else if (pai->ai_state == 4)
^1da177e4c3f41 Linus Torvalds    2005-04-16  439                      strcpy(hrec, "ready");
^1da177e4c3f41 Linus Torvalds    2005-04-16  440                  else if (pai->ai_state == 6)
^1da177e4c3f41 Linus Torvalds    2005-04-16  441                      strcpy(hrec, "fail");
^1da177e4c3f41 Linus Torvalds    2005-04-16  442                  else if (pai->ai_state == 8 || pai->ai_state == 10)
^1da177e4c3f41 Linus Torvalds    2005-04-16  443                      strcpy(hrec, "rebuild");
^1da177e4c3f41 Linus Torvalds    2005-04-16  444                  else
^1da177e4c3f41 Linus Torvalds    2005-04-16  445                      strcpy(hrec, "error");
^1da177e4c3f41 Linus Torvalds    2005-04-16  446                  if (pai->ai_ext_state & 0x10)
^1da177e4c3f41 Linus Torvalds    2005-04-16  447                      strcat(hrec, "/expand");
^1da177e4c3f41 Linus Torvalds    2005-04-16  448                  else if (pai->ai_ext_state & 0x1)
^1da177e4c3f41 Linus Torvalds    2005-04-16  449                      strcat(hrec, "/patch");
3e0552eebdf621 Al Viro           2013-03-31  450                  seq_printf(m,
^1da177e4c3f41 Linus Torvalds    2005-04-16  451                                 "\n Number:       \t%-2d        \tStatus:        \t%s\n",
^1da177e4c3f41 Linus Torvalds    2005-04-16  452                                 i,hrec);
^1da177e4c3f41 Linus Torvalds    2005-04-16  453                  flag = TRUE;
^1da177e4c3f41 Linus Torvalds    2005-04-16  454  
^1da177e4c3f41 Linus Torvalds    2005-04-16  455                  if (pai->ai_type == 0)
^1da177e4c3f41 Linus Torvalds    2005-04-16  456                      strcpy(hrec, "RAID-0");
^1da177e4c3f41 Linus Torvalds    2005-04-16  457                  else if (pai->ai_type == 4)
^1da177e4c3f41 Linus Torvalds    2005-04-16  458                      strcpy(hrec, "RAID-4");
^1da177e4c3f41 Linus Torvalds    2005-04-16  459                  else if (pai->ai_type == 5)
^1da177e4c3f41 Linus Torvalds    2005-04-16  460                      strcpy(hrec, "RAID-5");
^1da177e4c3f41 Linus Torvalds    2005-04-16  461                  else 
^1da177e4c3f41 Linus Torvalds    2005-04-16  462                      strcpy(hrec, "RAID-10");
3e0552eebdf621 Al Viro           2013-03-31  463                  seq_printf(m,
^1da177e4c3f41 Linus Torvalds    2005-04-16  464                                 " Capacity [MB]:\t%-6d    \tType:          \t%s\n",
^1da177e4c3f41 Linus Torvalds    2005-04-16  465                                 pai->ai_size/(1024*1024/pai->ai_secsize),
^1da177e4c3f41 Linus Torvalds    2005-04-16  466                                 hrec);
^1da177e4c3f41 Linus Torvalds    2005-04-16  467              }
5c10007560589a Julia Lawall      2010-12-29  468          }
^1da177e4c3f41 Linus Torvalds    2005-04-16  469  
3e0552eebdf621 Al Viro           2013-03-31  470          if (!flag)
91c40f24faadd9 Rasmus Villemoes  2014-12-03  471              seq_puts(m, "\n --\n");
^1da177e4c3f41 Linus Torvalds    2005-04-16  472  
^1da177e4c3f41 Linus Torvalds    2005-04-16  473          /* 5. about host drives */
91c40f24faadd9 Rasmus Villemoes  2014-12-03  474          seq_puts(m, "\nHost Drives:");
^1da177e4c3f41 Linus Torvalds    2005-04-16  475          flag = FALSE;
^1da177e4c3f41 Linus Torvalds    2005-04-16  476  
^1da177e4c3f41 Linus Torvalds    2005-04-16  477          for (i = 0; i < MAX_LDRIVES; ++i) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  478              if (!ha->hdr[i].is_logdrv || 
^1da177e4c3f41 Linus Torvalds    2005-04-16  479                  (ha->hdr[i].is_arraydrv && !ha->hdr[i].is_master))
^1da177e4c3f41 Linus Torvalds    2005-04-16  480                  continue;
^1da177e4c3f41 Linus Torvalds    2005-04-16  481              /* 5.a get host drive list */
^1da177e4c3f41 Linus Torvalds    2005-04-16  482              TRACE2(("host_get() drv_no %d\n",i));           
^1da177e4c3f41 Linus Torvalds    2005-04-16  483              phg = (gdth_hget_str *)buf;
^1da177e4c3f41 Linus Torvalds    2005-04-16  484              gdtcmd->Service = CACHESERVICE;
^1da177e4c3f41 Linus Torvalds    2005-04-16  485              gdtcmd->OpCode = GDT_IOCTL;
^1da177e4c3f41 Linus Torvalds    2005-04-16  486              gdtcmd->u.ioctl.p_param = paddr;
^1da177e4c3f41 Linus Torvalds    2005-04-16  487              gdtcmd->u.ioctl.param_size = sizeof(gdth_hget_str);
^1da177e4c3f41 Linus Torvalds    2005-04-16  488              gdtcmd->u.ioctl.subfunc = HOST_GET | LA_CTRL_PATTERN;
^1da177e4c3f41 Linus Torvalds    2005-04-16  489              gdtcmd->u.ioctl.channel = i;
^1da177e4c3f41 Linus Torvalds    2005-04-16  490              phg->entries = MAX_HDRIVES;
^1da177e4c3f41 Linus Torvalds    2005-04-16  491              phg->offset = GDTOFFSOF(gdth_hget_str, entry[0]); 
cbd5f69b98bb5d Leubner, Achim    2006-06-09  492              if (gdth_execute(host, gdtcmd, cmnd, 30, NULL) == S_OK) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  493                  ha->hdr[i].ldr_no = i;
^1da177e4c3f41 Linus Torvalds    2005-04-16  494                  ha->hdr[i].rw_attribs = 0;
^1da177e4c3f41 Linus Torvalds    2005-04-16  495                  ha->hdr[i].start_sec = 0;
^1da177e4c3f41 Linus Torvalds    2005-04-16  496              } else {
^1da177e4c3f41 Linus Torvalds    2005-04-16  497                  for (j = 0; j < phg->entries; ++j) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  498                      k = phg->entry[j].host_drive;
^1da177e4c3f41 Linus Torvalds    2005-04-16  499                      if (k >= MAX_LDRIVES)
^1da177e4c3f41 Linus Torvalds    2005-04-16  500                          continue;
^1da177e4c3f41 Linus Torvalds    2005-04-16  501                      ha->hdr[k].ldr_no = phg->entry[j].log_drive;
^1da177e4c3f41 Linus Torvalds    2005-04-16  502                      ha->hdr[k].rw_attribs = phg->entry[j].rw_attribs;
^1da177e4c3f41 Linus Torvalds    2005-04-16  503                      ha->hdr[k].start_sec = phg->entry[j].start_sec;
^1da177e4c3f41 Linus Torvalds    2005-04-16  504                  }
^1da177e4c3f41 Linus Torvalds    2005-04-16  505              }
^1da177e4c3f41 Linus Torvalds    2005-04-16  506          }
bb327df8326eff Christoph Hellwig 2018-12-12  507  	dma_free_coherent(&ha->pdev->dev, size, buf, paddr);
^1da177e4c3f41 Linus Torvalds    2005-04-16  508  
^1da177e4c3f41 Linus Torvalds    2005-04-16  509          for (i = 0; i < MAX_HDRIVES; ++i) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  510              if (!(ha->hdr[i].present))
^1da177e4c3f41 Linus Torvalds    2005-04-16  511                  continue;
^1da177e4c3f41 Linus Torvalds    2005-04-16  512                
3e0552eebdf621 Al Viro           2013-03-31  513              seq_printf(m,
^1da177e4c3f41 Linus Torvalds    2005-04-16  514                             "\n Number:       \t%-2d        \tArr/Log. Drive:\t%d\n",
^1da177e4c3f41 Linus Torvalds    2005-04-16  515                             i, ha->hdr[i].ldr_no);
^1da177e4c3f41 Linus Torvalds    2005-04-16  516              flag = TRUE;
^1da177e4c3f41 Linus Torvalds    2005-04-16  517  
3e0552eebdf621 Al Viro           2013-03-31  518              seq_printf(m,
^1da177e4c3f41 Linus Torvalds    2005-04-16  519                             " Capacity [MB]:\t%-6d    \tStart Sector:  \t%d\n",
1fe6dbf4d0afba Dave Jones        2010-01-04  520                             (u32)(ha->hdr[i].size/2048), ha->hdr[i].start_sec);
^1da177e4c3f41 Linus Torvalds    2005-04-16  521          }
^1da177e4c3f41 Linus Torvalds    2005-04-16  522          
3e0552eebdf621 Al Viro           2013-03-31  523          if (!flag)
91c40f24faadd9 Rasmus Villemoes  2014-12-03  524              seq_puts(m, "\n --\n");
^1da177e4c3f41 Linus Torvalds    2005-04-16  525      }
^1da177e4c3f41 Linus Torvalds    2005-04-16  526  
^1da177e4c3f41 Linus Torvalds    2005-04-16  527      /* controller events */
91c40f24faadd9 Rasmus Villemoes  2014-12-03  528      seq_puts(m, "\nController Events:\n");
^1da177e4c3f41 Linus Torvalds    2005-04-16  529  
^1da177e4c3f41 Linus Torvalds    2005-04-16  530      for (id = -1;;) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  531          id = gdth_read_event(ha, id, estr);
^1da177e4c3f41 Linus Torvalds    2005-04-16  532          if (estr->event_source == 0)
^1da177e4c3f41 Linus Torvalds    2005-04-16  533              break;
45f1a41b2b2e02 Boaz Harrosh      2007-10-02  534          if (estr->event_data.eu.driver.ionode == ha->hanum &&
^1da177e4c3f41 Linus Torvalds    2005-04-16  535              estr->event_source == ES_ASYNC) { 
^1da177e4c3f41 Linus Torvalds    2005-04-16  536              gdth_log_event(&estr->event_data, hrec);
5a412c38bb5bb6 Alison Schofield  2016-02-17  537  
5a412c38bb5bb6 Alison Schofield  2016-02-17  538  	    /*
5a412c38bb5bb6 Alison Schofield  2016-02-17  539  	     * Elapsed seconds subtraction with unsigned operands is
5a412c38bb5bb6 Alison Schofield  2016-02-17  540  	     * safe from wrap around in year 2106.  Executes as:
5a412c38bb5bb6 Alison Schofield  2016-02-17  541  	     * operand a + (2's complement operand b) + 1
5a412c38bb5bb6 Alison Schofield  2016-02-17  542  	     */
5a412c38bb5bb6 Alison Schofield  2016-02-17  543  
5a412c38bb5bb6 Alison Schofield  2016-02-17  544  	    sec = (int)((u32)ktime_get_real_seconds() - estr->first_stamp);
^1da177e4c3f41 Linus Torvalds    2005-04-16  545              if (sec < 0) sec = 0;
3e0552eebdf621 Al Viro           2013-03-31  546              seq_printf(m," date- %02d:%02d:%02d\t%s\n",
^1da177e4c3f41 Linus Torvalds    2005-04-16  547                             sec/3600, sec%3600/60, sec%60, hrec);
^1da177e4c3f41 Linus Torvalds    2005-04-16  548          }
^1da177e4c3f41 Linus Torvalds    2005-04-16  549          if (id == -1)
^1da177e4c3f41 Linus Torvalds    2005-04-16  550              break;
^1da177e4c3f41 Linus Torvalds    2005-04-16  551      }
^1da177e4c3f41 Linus Torvalds    2005-04-16  552  stop_output:
3e0552eebdf621 Al Viro           2013-03-31  553      rc = 0;
^1da177e4c3f41 Linus Torvalds    2005-04-16  554  free_fail:
^1da177e4c3f41 Linus Torvalds    2005-04-16  555      kfree(gdtcmd);
^1da177e4c3f41 Linus Torvalds    2005-04-16  556      kfree(estr);
^1da177e4c3f41 Linus Torvalds    2005-04-16  557      return rc;
^1da177e4c3f41 Linus Torvalds    2005-04-16  558  }
^1da177e4c3f41 Linus Torvalds    2005-04-16  559  

:::::: The code at line 249 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--YiEDa0DAkWCtVeE4
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICM7BG2AAAy5jb25maWcAlDzbcuM2su/7FarJy+5Dsr6NMzmn/ACBoISIJGgAlCW/oByP
ZuKKL7O2nJ35+9MN3gCyKftsVbZG3Y0G0Gj0DU3/9I+fZux1//Rws7+7vbm//zH7unvcPd/s
d59nX+7ud/87S9SsUHYmEml/AeLs7vH1+7+/Pf139/ztdvbxl0+/HP38fHsyW+2eH3f3M/70
+OXu6yswuHt6/MdP/+CqSOXCce7WQhupCmfFxl58aBj8fI/sfv56ezv754Lzf81+++X0l6MP
wTBpHCAufrSgRc/q4rej06OjFpElHfzk9OzI/6/jk7Fi0aGPAvZLZhwzuVsoq/pJAoQsMlmI
HiX1pbtSetVD5pXMEitz4SybZ8IZpW2PtUstWAJsUgX/ByQGh4JkfpotvKTvZy+7/eu3Xlay
kNaJYu2Yhl3JXNqL0xMgb9em8lLCNFYYO7t7mT0+7ZFDJwbFWdbu9MOHflyIcKyyihjst+IM
yywObYBLthZuJXQhMre4lmW/txCTXeeMxmyup0YEEo/5d4sOmIfLHeI314ewMBGx10SkrMqs
F3ew2xa8VMYWLBcXH/75+PS4+1cgSXPFSnI+szVrWXJislIZuXH5ZSWqQJdCKA7mNgs3f8Us
XzqPJafjWhnjcpErvXXMWsaXxNSVEZmc95OyCm7y4ESYhok8AlfBsmxA3kO94sIdmL28/vHy
42W/e+gVdyEKoSX3V8Qs1VVwaQcYl4m1yGh8LheaWdReEi2L3wWP0QhOVM4kCXNLKTRucDtm
mBuJlJMIkm2qNBdJc7FlseixpmTaCJqj5ybm1SI1/ox3j59nT18GohwO8lZlPTqTFs3hTq9A
koU1wYHhWaL1spKv3FwrlnBm7MHRB8lyZVxVJsyK9vzt3cPu+YVSAT+nKgQccqhj164EXiqR
PNTvQiFGJhmt3h5NKPRSLpZOC+OloyNpjhbWcyu1EHlpgWtBT9cSrFVWFZbpLXWNa5rgBjeD
uIIxI3CtpV5kvKz+bW9e/prtYYmzG1juy/5m/zK7ub19en3c3z1+7YW4lho4lpVj3POtdaxb
qJdxjCaWSjBxBdyrtQh5Gb70qix0zjJctjGVFpRnMAmgFQcC5BjsdYhx69PA+4G7M5aF+okg
uAkZ2w4YecSmgfW7RahUE5vtT8/IGN5oxDvkHhhUEJc0KvPmJ2Tnj1DzamYIlYezdoAbK0UN
7LjDTyc2cBEot20iDp7nAISS9Dyai0mgRqAqERTcasYHCGQMB5VlGF/koXVFTCFAS4xY8Hkm
jQ1vXCyUzkyu6n+E229hXlnIM5SrJVhUuNJkWIPRSQreQ6b24vjXEI7HlrNNiD/pz0IWdgUh
TSqGPE7rYzW3f+4+v97vnmdfdjf71+fdS3+2FQSOedkGbTFwXoH1BNNZX/2PvUgIhl1cudCq
KoPLULKFqDkI3UPBpfPArcyzVTMyiFD9b3elpRVzxlcjjL/ZPTRlUrsY06t9Cg6AFcmVTCwV
QYAhIXkG0nH08kqZmBFQJ2Gk2ABT0PjrUAZwqEZYE64TFQdZNjhipQ2zRKwlj+xcg4CBaF+m
R8LtTIlx8zKlI7B2PvDr1KVWfNXRMBvsGiNLiBbAaIazVaBOBaX9EFQCIiI1QtO0KKAikHoh
bPQbzpCvSgXXAp2oVToISGt3gMnB4DwhBAElSQSYNg6BQKQ+Q5xbn1BKhBY/1mk4Jh9960Cn
/G+WA0OjKoizohRGJz5BII8CcHPAkVMng+wEAGFS4vEqMtUIOaPcoFLo7Bvb1kqUOwXOPpfX
AoNDr0QKHGox0MEBmYF/UOENBuSQhSWYNnIFFhxVxwnMBIs2MO6zukOElEq2WUb0G/wSFz5e
qX1DcE5l2v+ovVdgpyBRkqiJkToshM3RJDRh61SmhEc8pmjN1RLsUTZKlbqIL7Luw9+uyGW4
osHl7OEMgvW0mlhiWlmxITGiVOSijVwULEujy+FXnCYEtY+8Y2KzBMtPTsmkol2mcpWeiolY
spZGtFKmbAVMN2day9DwrpB2m5sxxEVJSAf1YsTr3QSXvea4PnOJDJfPsEmhdMlLvzKHHNDF
RfYP8qxLSqj5XCRJ6KT8dcIb6YaJUsmPj87a+LwpX5W75y9Pzw83j7e7mfh79wiRIgOvzjFW
hMyijwxijp3vfyebLkjPax5tCBBtEQs9zEJqtqKvUMbmE4hqTmlnpoIqAI4GIWsIP5qKR6yI
VZpmog5PQPwKDLvStDmxIq8Nzxqi0lTykYkCt53KjM5SvLXxzigSY1wZ62Re8tOTiHPJzyMr
7Y+yfH663b28PD1DHvjt29Pzvk7AuiFoxFenxp1//06nEgHJ0fEkyaePB8Z/msCdHX0npHB2
9j3cljg5OiKouoS8DHMNmCwNAWffvwd3ELYRGlEr3PnZPCz/lMutGcGAZ55D1K/gJi6n4G5w
FoDwVp3SkjwIJQrt47eLs/64xyfWXZDEKD9PHxW6OYqoSCQLkpTTk2gHsMpBQSTPGUSeBQQJ
EoIsyBYujo8PEcgCQnoS317Lt/hEdCE7EIDUl+biY5+lgMOCGE8G19OCwavTNFOVZVxR9mBg
kWZsYcZ4LOtANDZGtAqEBHMt2GqMWl4JuVjGuhD4f6az7djpsqIpVakK0qpPXXm9jiZVLi2E
9xDwOn/RQ19TS4xtGysNqpzwWN+qZL5wx+cfPx6NF2vnZlsE9L5U6Xn2sLacW8kcbNmwSibn
QtehEgYYRs6zIYmpTAnKRqBxdQnXfVElho/4+MMwda7gDau3q1NkFVjNuTAxW3DozXgtFpM4
yTjeLhKXIO5kArc+gGPcaVaEEiwX9XOHL+XGA8EGwWFKjBexohQtFHG5kQOrYiReFLg6rT8u
72/26EIDG95plcqDSmrA5ezX0PSxHKxfFAZmFeY7E+U/MVfFlvanLD87OxITJX9xWSnJKNfG
pFmGNmrFYIPBxjWDZCeOna+YLieiolAXOCu2qsggRI4ChkXGODAkk6/kSqko1oR7HpN2mK0y
Au4sLSZpzNmEb+MVxGu24itiAakpI2/BVijviZiWk5kL6s7Zdwiy8zKL8qpGqRalpJ55/NEF
7vHsaKE38e/4pyl3we/zI7GJfprw56/naRmtpYY4ofXZOZXHz2tV8gSBW1tBILhA7QxsbclK
SCWZZljJDVxbGZb+8BfcnoW+6OvMs/R595/X3ePtj9nL7c19VFpG/5lqEbxPtBC3UGt8RIK8
VFgCjVXcKDptEa2FxfFB5kurCDlIXUHkCw7g/UMwifDlk/cPUUUiYGHJ+0cADqZZe/NOVYyo
Md7lVVZmEwKeKg1ENJQ8KMJOChcPE6zet+n/z2aHm+yU7stQ6Wafn+/+rnOmcMpaZDZeUV+s
J5S3nUJ+vt81TAHUTYzgWMFlVDloIX7pGYPsUE8gc1FUw1PpkFbQ1ioiWrLMDosDtTvDMy15
t+BZEginjYInaUL51NsNIKFY2m1dCm8OI+cgCqctJ+U+crZhSvz0DVs5omPEF7ipSsXy2h2T
6QsgTnwUF5KexqQDLjSbC2ATh5hLjW9iIeuc2aUTeTV+ygmjLVH4CKZ5QV8qW2ZVUNejaTT8
K4z3tPDpMYuCQ3zt9Y8pmOnEDCFqt8CtYRwMyTKxwEe4Okh2awbxysVREGrYZC4LvHeGlJkP
gVY+tJwmOD5/i+Kc4hHgTz62LOLoy9cKmqeVT10QVHe/NOAuBfL1giGtf1f3DznXEKQpjRe1
G8HzxPfh9I0aYgOJEERZeoHPBGGZuInZ6R3SWosZxWLrcpUIsrInOKZzRKWnvR3dKRrmkpw5
5rM5f2nmry/BJRrkMA19LEoJ2a0W3GIQHWX2+KLQA1KTuWzOw1WFc3XJJZh2cN4wWd0P066L
ff4bC1Sfh/1HEPWjf0p8tVqFTweZukLNxcI1lhYyEnNx9P30KG6/SrYFyzFQETmsREdxhFcb
laYQdXielNb1JMD8tmU+bPPxrKd4hDQhk3aK5dZIznqCo9Es/pmr2zoZ8DcE8SKbkxlIuytw
QHBXsUxes7BboK1/3Tzf/nm3393iK+LPn3ffgNfucT/WJp8+q7rQFpiUVZdEdrv4vcpL8IJz
Us09G5GmEtKIAnLmAha2KPBFiPMoj/OGDMIP3zBmZeHm2BMVTKyFHSawnrlUYD5ZiTXBYQ/S
ihwwyakhhxDHpYM3C49Pq8K3CWGorTTVNuTJ6qeCEOL35jkulSJKJAYE6B1+bduGJQVm0JBZ
mW7bF6yYwFeqUJvdqAnL5GiAmha94X4x43cQytWloeZEGjMT0Zkwuu+r33HFoIf7h8SaZ1Ll
w+Y+v+ReZ6IKm1swbBxpuh7xAZdEY//AGyS168CbMxRmfUL18z3Pyw1fDv3zlWAr9MECXyEY
v6ykHrK5YqDM0rsobM9qmyOJnTZ23sE1iupUU3A/0gsPFRoUTIWxZd1EGqN9/1FUao/QU5eS
bgmKbhZEHL5dbJICdKvZZSk4VuqDs1BJlcFlwiststS/5hD8xQZVt6jb+GzUddApvx8Oeqry
6Dx7GUeF1kNV2t75+8Fclds2nrDZUJf98GKtWQ52MCyVZCBvh89HV0yHzQgKG13lookVRnA2
MBZNNbe+vSjnwcprXwkOpHE0+mpDCMdYsCA2pgk0YYA89D7m6/ZWxbEDFnbDByXT+ROu1j//
cfMC7uevOm759vz05a6pDfQ5ApA18x+a25M1zsa1z3vty82BmaIDwz5uDLdlaOliYLCuFuz4
lvuzyFAXqRa9gBYCbRQF/KdBd6hZvKaC3KuwD41EjzL3wUvVG566Sxasy/FdOXRn/v3U5CjI
4/hCoiI6P6sd3dUhoAmfMxW6pAZVFQ24z4/CMTWaeh6mvNGkm2p4gu1wXPMxwmjetZ+HD8n9
XokVmjYxoJfXkkwwhByDHU9wBdTJyRmZDQyoPp6/g+r003t4fTymGlQCGv/i9uHlz5vjDwMs
an1TTR8yb1Gj7pgJMt/8MmSCzxFXLpfG1K2iTYOSk7l/kaA6ywvwF2Att/lcZaPzNnUXYwZB
VNhJNEcjFf6EmJkbCWpzGRdA+643sIVN9TFAYfPQ3CxIYNTv3ncaWbHQYDQOoJw9jioULQEm
pNQFafHglpS12aBRd4zFPGmCTZPg1jGKjtd4NbdDvo1kpPJGjtMvFxEhV8ZOUsEMLr+cRNeP
QOTbrj9AnyyyLF51/eUMmF+ut2XsTUm0S5tGj9ZrlTfP+zu0nzP741vYlgkystIPaXPVwDxx
pYueYhLheAXGnEWPEgMKIYwinfCATobGbohkSWoOTeKrfhD8vWMeLQ2XUcjA5KbHExyUSSNR
9ANzCHEODmWQCEt6cM74waG5SZShh2KzeCLNapSB9sxlAZsy1ZycoQ+WQPFBHm7z6ZxeS99w
BPwg9hP0vG3klOSUziDY636QCiwkRVllEL1tKIypCloWKwaO/aAgRUrOhZ8ZnX+iMIERCeZr
q7yD6xRexvwyrjU1MEw7pBqBmw7e+lsg1Tc8R0VioJOqrs9ihyKui9KVnmq1nYPhC54yWsQ8
HVim9tuZaOo+PimOg3MpGjtjSojnMNIZZS3dmzuzCqtUOg++XPLRWj0YbqC6KkLbDH4Ji140
0gfjE7gulC4QB1FRxsoS/QNLEu+h62edvtLXdUd7CYvvu9vX/c0f9zv/jebM95rtAwM5l0Wa
W8zFeh7wg0fNvg2R4VqWNpR7g4BQgO7TRzZYKyAPZWptfuH57uHp+ccsv3m8+bp7IEtZTXk8
2DsAQE6Jr8G7nA1LFCkz1i3CEMNLdyVE6bsI4xM3ZQYJXGn96XR9SGGSxyctiS9TaIHKQnez
EZ+u+TwNT9XZYZuVz+khhZuHTwR1f5WF9DzqyTSBQNr3Rp8sg7n07C/Ojn47D3aSCfCLDK4P
fYI51bFwXWJN96H7Oa+SUC2uT1NIjqlxPnlRPCJuYP7d+EAzW91S1JQFQ+voS2xe4liLW9EC
r9uK1m3hpT8pobFY4r88IgWwwKZ+CD2WOdNUv0KfZ1tR10tYlOZOK3LLoQhf0bEHH+6ML+oH
uria4yuGKNpEyt+RYrf/79PzX/iCSjy9gX6uBB3HoaMjEZbs/d2kOlAq/IVVyTh/9FCWLdQA
5Hu+g9P2QP9slU49ynsScOsQ8GSSU5m7p6ivUFQhq0fiC4axEGqR3FHAKzHJVaAdtjxSMJNT
MdcmKf1nGyKsTQVAiCJYEA3I6JhlWbfENx9S9rpc9o8qEI1bskcHiDwOP1aHHCwZMCgLKrPD
fcsy/Ca7hiww3hF5tRkinK2KIizkdvThefZMug9D6RXnzZIH34x1mOEmZG5ytz6mmTXYqFHI
bCFShxRSku+R9TrXVvZWC0FVQu8zVdH7fgPqpUJ+eoNUbBltBEGgUnT3Ur0mdCVT3LqlxYNQ
s+j7y0vsz+hf5qjHp5aGV/Owsts6ixZ/8eH29Y+72w/huDz5aMLvWUCi51EcBr8bvcVvG+lP
oTxR/X0LXlOXkBUl3Og5ivMhhoA0CVBnkMao0XWuMWPBxwvMZUn2ZSFOZmw4UXNSDxFdpG4e
YqQdQ9x59F0TQgtIQbiPZey2FAMkOVd9L0MI6nAM8SanzJo/P2HiK4drqeZYiaG/K8Px7U0d
AwneIRF1YespxeLcZVf1lqbm9UTggPlouC4zcnSfW5Rw+lOOAP86B77YTLh2vGqlLRszm24H
FsGPhqjNF/nB6+QlHXoA6fA1qAOFZYnaeT8979CxQ0S83z2P/khKOH/DASbFRODQxPgvSG1W
1AJSSPAhrmK6pLDNwMH312N8++cqiPW1JJk6KJyOTpnou8oiRWtU+NCOGp/WH/bWbuUhGocI
4JqINa0AaaOrB5e16fTZi3/jE5aX2e3Twx93j7vPs4cnzCqDtCQc6lCzhkP3N89fd/upEXWb
yvBvb1Ak/vNMU+WRRxtT0co7oksMnwgbRqTL7PDCfKh8eFUYs/sP3g6TZfH3oySJol0hRTu8
5weJi/QtjQ1pB3+vhSLCaDWqW1NEQHJYJNjjsNm+QaPrVs9DJLzMjRlEchQVOGp8box0I1Jn
yNlv/9y90MbJXwH82zSYeaIre0ugNXX0LSmBb75xp3fYkIBFEIU9TBN+DkXgE85Jq9gTiPXb
K8GbdZCL4MWkljcU5s27WRPio1D9h6AOrWiZvTHfZFRK0g4+9yBoshNbvjFlJopF/DcFDlLj
Ht+3vjpsOITXpGPsCXxkg99HHZJpkXofeYgEPdvUhWsosPj3XhlMpscU7cr6QPLw9JeVsvRf
zyKIG3P2vvm1YNmUo2opeH1dD81puJ0M5ka0arL+QVG3VYP37QdNIqRIhzbUWNjDWo8+8H0z
VqcnXjhtO/ehODHKpM2EEAC1NiOrLsv/ORB+9pETZIua+SD8LJBC2ki9hv8I4LXbGsMTfHEc
MsHADQPScTiHpHQUqAW27Q0mgD0CSpbjnAThjWcKU8wAPrDKIUqX9elMybUjtJbOaZBimBPU
0DZW8LsZL7hYRI3g4ZB6vRQGVjHcomZXQ2IQOC0m1m43zvQbVLMo+tnlgDI12vb3+SF9C4+/
1yy6ySJSskmSRt+o1D5SovORQo5rHeehck0I4ND+/AYTwR93+3cJAUj9n2hJIdlnc/xiQWly
2rd4Bg84hCb3J+zjn4dmnfDvGecyeZleYDPEIdnJ+G/dkHSn9A6mZuvX0rTVL29u/xo0p7Xs
iQWE7AcMgn2jmwmPGn87/LxYzX/nBW1Oa5qmhlbXIX3JAmtm1HcCU+TDPqRJwsk/T+dHvHMF
xMwNOmqBhB/1U24gFIRZMmdEzOAtHAIo3t8o/OVykUjmwv6bAFwlUbzoMf/H2ZMtN24r+yt6
upVUndxotaWH8wCRoIgxNxGUROeF5cw4ieuOZ6Zsz0ny9wcNgCQaaMqp+zCLupvYl+5GL9r6
g3Lc1FitbXeaxxrafwNYUWo0GodHPxhtyLhLahEfJiPwaI2sZIiH1IBnD6DO40O3nS8XRxrF
6t1qtaBx+zrKRy3HBMGVT6uaa+tVkuIgL6KiUZP94JOYvLnzXwh61J2kw6+6NGXEs3KCrRyI
jtFE5Rkrdqv5ikbKD2yxmG9opBKaReYqJM6qLDtdf4ew7nDGi8RB5WfSOduc3+439kSffOnJ
Mkd2UT+WY+tYwzJHyQLWY6yqMm7BzmEYx1Rj2uXGJctYRYWCqdISvVvdZOWlYkjRZkG9oz1R
SE9RpBH1oQKrj0lJwiUBfhNL9C42Laupsieue5ckL/ciA4M/smyYHsTtu0g4qYiKDwrFFfOe
xjW0jVz1Lu2JnCSXQkS5x4FQdb0zkC4pDGjYJ5fCqPvdxcQ5hyW+IZlw3gxx//R1fPz++P1R
Xa0/W9sb75q29F20p+Iz9di02eOTVQMTGeFdDNCqFmUI1eL7MSyjDnSLGiwTah+M2KN/tgG4
4Uf6+WEg2CdXSo32Mmy3EgHDRjdMdzKAHyZ6E8srbxtAoP51TWiG7+qaGMmjHeFw0O72gLrW
xRTFF+rBx4SYGYhQ52uoNCI5Gty1ehhVDVVLmhLjWwn/FaOvWGGuzvDVZxhTNnIZHqfZ18Ka
CTAcXyCfR58fXl+ffnv66IvkWtXvqxsABF4DU2oNjW8iUcS8xfMNCL3917jJAE8uIeyEYzxZ
kPaFIKru0YHuzdQrz5U/Jj2cFNz6dqkjLOyFHw91GBZPxzwUgQOt9Bgt0NMhCIGEazwukA+q
pegOAvOHKHWk+x21mGJ/30xohnoSoxEK4bniASZKhYwK1wuNWCFislhj+ueNCsMhmAHMwAUG
VJPT+wVIwG9qoimAzkUNR9pz+KFk4NNztWzV1Kv4gl3HV5DC4ioFxJa50np1HkIReLwAEcF7
HTFgqktTRweggbcMCzMrOGzb3T4vKZOKYXiSwIQHwOYVfcI4apy2JrT/SbiudPqmsRThBW0R
5BHURL3dG3GgiwTFrIgj6taOCwmRa0tIZuFYs0J0Je0QgExZB2j/X/rV2KXLKNtIhyDGgXAc
TEEdyA4+9w3D3FJDRnuS7D2iIA4fRQTPibRpQ6lkyrMSHs3RN3zrgIEzuf5hd27R6kYf84Kf
0Xo7W+s6eqFpAwKrCbBQ2Fl4/QBEibxo/WiY5fMn1nAhUR9TSQlsen3qtiuBDFebrdQdIkGn
j1DHuqnxr07miJfTMLU5Jw+kIsIh7S2qdr1b60TH3Hft3Frk/Wqcf6A4zGE6iNHc0Km8hmjq
8h6OfNer54gYOIjw+mHqwU5fujZ9DbZsnb09vr4RUkN116iVMaUiqMtKCXSFAEtf58UkKNND
uGa0zjSzvGYxydpGbsg29cMq1UceSIH2UU5/2R0u+OMPi91qN1gBsWIWP/7n6SMO/+OQn4GE
LvncBi1DKw4AEcsicJ0GIzzX/RtwScZ1Cc+oubUpFDXiAyt+UXIpK1bk2gSSuzODsAFVJDgZ
xlc3pguq0yDFMbMGnFpJXCQ8cHR7O/d6CSAInEJQuoWjFotEwL+Trc3D1uZXWmtwjfpr3W5a
DycjrEvRxUCYgqvjBWqs+XyOy+K5DMck2S5u5gsMG2cEw/t6J9tDXVmm321Ymm2jHXxUYI/q
x2uql2ViQxMMW0JW6pyDuMi/PXx0Ta6APBWrxcIf36habjRwfDcNixmKP8n9ZPFbULApgnDQ
Q6CMAbjEa/FgKP8mpsLA0Rjl0Z51uj30kMOcBBWf+i3q9NXrE67FRuzUORDoByziIHJOdepA
Z4m6Emo3FmwPsZFVuqxEAWJ6rPdiULd3KGRK0t1FjqJCNjVneeADm4h9V58829aLgKgfpGx+
ERCY9xn9tMNiEk8NMafq5E64N5z5DRZqONq4AYuiOlGjY9E65BpidneehLqrepc6j9nembQY
E5ffrvLHMWIicZeJSCgK+BguCbRVRTK1BHkFJjh7RG5h8NLQNPdTiS4GMgggQvPnRYJzPyXw
uHMQDSNlb4UtXH9ECwB/OgxMI+EXK9M4Q6eaZT4eXmbJ0+NnCMP+/Pz9i1W2zH5Q3/w4+6S3
A7Z3SyAeMSkQKkxVbFYrbMtggRPDO+LF0lVzKnBen7MQYo8CVIGGq+8nytdoGCNUmGzCwTSw
sCkWbsYZVV20FaAmnuDVl6vkUhcbv3UOQ/aPJqBvTGU0Anj/GBnXAnoLcbehPczP2GLRseqe
9opzXgXrUi3fzBcndOqWXHqqPbWZsMW1dlCrUCi0hImsREufN2mjSHpRZkSYuDaWje6vxIBD
dImRk66J3oFA/g+bwE5iIJGWAVgBsIZTXD/1YKSwTFa5/wXAKKWmTzKENCUL0Fhww70SBnYk
pkPMOmRd1eS4vzjetAGQ6f0ABxGkcK4JPY4TJ58ezubk3NkAYY034jxi/uB1ojxPFKhkNZ+4
YkpGI0fGhq0EquDQA9jHr1/eXr5+hnxUn/w1BSUnjfpbsW64wZD+MniZHhB9CrJnNO4tZHlo
x3X8+vT7l8vDy6NuhjZtk0RCBvgyvmi+URc+Nf1dru6UgjxarlVl/I6//qp6/vQZ0I9hU3qn
zmkq0+KHT4+Q0UOjx2F9JfNMQLciFvMCtijdt54be7fYwYOfns5hqvmXT9++Kr7QawhkS9BR
Rcnq0YdDUa9/Pr19/OPdxSMvVjHScBSH8noRYwkRq2O81PNI0MaqQOqdTra1P318ePk0+/Xl
6dPvLoN/z4sGxffQgK5cksUbpFrUJZUCzWAb5xixkFKmYu+mlmKViF020AI67frVJ0lYOXEl
ewIbaLZuu0ZJXn7InYAcgozy4iAmzIUGsolza6z1lJu3JGQFZLHgH00pJHq8Dg3URYbHNEkS
H749fYLADGbyiRjQ/beNFJtbKrzKUHklu7almgWf3mzf+VSdUUvq47rVONpCbaL5Y1DOp4/2
Zp6VfuSCk4m8lvKscm9/BFbneJOiYLVq7Jq8mlDXyoYVMcuupCzVZSeiznWIE52/OdghydPL
859wOH7+qo6aFyfWwkXHC0OiVg/SrE0M+RIdRkaH3O1rc2Lxjl/pcJL+EJBoN9zP0KORsg9W
RU6T36OxABPFCsR6KkrFMOZaQq7FGb8KDpJzPREf2RBA5m37dWeiQVPma0DEIEFJT6oDlo4H
g5POR2fcM+jxIOEHFOvC/NYMuw9DQpGFXRYBKM9dDXBfnpuruC8vihx+Bg4amar51osh8UZM
IRN9x2nvJHKyJvbNEBt5FL1soXnZNtiiKk9F5539KOSxLzyof4owKASkjzQpu8jJPRT+autr
byidXdw4M1GiN7sygWAMzUSGdoWFmCYNioaqgCYUBom6K/cfEMBGVEYwGzsGwdD0llohgH7n
sbsmSrCVhjQAaq5RDBaDAIkewUzkmnvcMrUiRsPWlNfcTYxsonxCiqEh5U/FapymaASMU2dA
HZ1b3SJZu93e7pAtVY9aLLeUbVOPLkooGj1tmNBtoRbhnHOHdexFQwXV5824a/rYb4BCQjyQ
Gt8jNuUYBSTpJSdDQmlkwvY1BB17RlBryosIo6Bu2rjXoLRjgVfE4JBZVjTGtyB2cQmpqHAI
mqhCrznu8BrO/en1Y3hCSF7IspZdJuQqO8+XiIdk8Wa5aTvF8lK7T10J+b3eF6PwkrKiKZ3l
3ogk9+ZTg27bdoEM5yK5Wy3lek4FtFCnYlZCNu0OdpSIUARrdfBmDpPIqljutvMlc9UQQmbL
3dy1ejWQpSOq9QPRKAzkyHLN2y1qny5ub6lMCj2Brnw3dxSmaR7drDaIe4rl4mZLc85wYKnu
KRm3WtncqFRtNfOk8l4q0VflWLmRIjsZJ9wRMCEYVad4YhT+rjpXkHuMUkgurWufiZfF1dmf
U2KawSh5fUmdDyMWWdVaMKRrmAi8aCly1t5sbykzfUuwW0XtjcNf9dC2Xd8QNYq46ba7tOKS
4pstEedKmF+7u8rr/jBG+9vF3FvmBuarkkeg4mjkKR/yAuihbB7/enidiS+vby/fn3Wuy9c/
FG/2afb28vDlFaqcfX768jj7pLby0zf4ryt0/z++Dtc4nAOdfgCaXOWaxHBPDrPYcMXQKi67
ClO2iC9vj59n6pKd/c/s5fHzwxvE7g9X0LmsJlmTa0U4kxul1EO0XvEsi8raavVGfqTfC77O
J8Cjt6mU7VnBOjcFGWTDRuGM0XGLNI8idl3UYt7vrerz48Pro6r+cRZ//ainUKt1f3769Ah/
/vfl9Q2CwM3+ePz87eenL799nX39MlMFGOHKOdQVrGsVf6mzcKC6OvOgLTGQNSj6/RDMVaEk
w5I/wA7XArgqAlWaG2sFaoWEDqJE+ZIBrhnJZFj/0JePfzx9U8X2s/vzr99//+3pL7d3fU3h
e7LTBs1rJ0lfMkyvU/prmAzP+TaI3wjwMkn2JXMD0fSYUYXnMz06is/NkrrTvKaSVTIe3Szb
Nuwfy8Ri066oGlke365b6lDrKaI8vlkThTa1AMuGEJFWzermJoR/UNuxxkFFhqkR4loTRLNd
3C6pDxVmuaCtJRDJtdILub1dLzZku+JoOVdD2tHh9wKygl+oYuT5cjcVwVfjhcmRGQyZzLbL
yHjYhIVm0W7Ob2jPzHGScsW3XCU5C6Yqaa+ugSba3kRz1/IBr8d+20A8aXuIUekjpYATxlXZ
iVhnvnPOF6DCv3CkfQ0Z33PGCwng9nwIbhTdLtug2dvf3x5nP6hb7f/+NXt7+Pb4r1kU/6Su
6R/DzS2dxkZpbWA4GV8PJR9ne2Tk+ETrhg4sqgePdMYglCxbw7PycECGRRoK5i5G04EmoOnv
71dv8NU9TQ23EhZIsNB/GwxupmSS/ALgmdirf4KpAZR+wZCkYsjQ1NVQ3XAx+l3yxuVi7Aoc
3h3gRrpBoH2pZE1tn+mPeXvYrwwRgVkPGNyffdEuDYreXXwZIL3Ftbp0ate1ehcEw5VWklbG
a6z6dEfv2B5tpsAFMq3xxx1kLNK1e1ARKXnLzaJhAHAVSHgGtCYujg1+TwFKDHiszdh9l8t/
b1Aep55I60oHZSZl82IJDePrp2vD2FyxCv+eh+04WMMJkzQ5GF8g3E2PoELv1t4QACCISa3P
tDOM9nMIG6hx3QYHPE42EUvCkp1ykq/WZ2LVKJ66DPsF8c/UKp8ultVRTtramoNJNW3pKJBz
JWrpY1pdbYpxIRC5w1CNQCayfYmeEAZcKL35FOHiVYLPihjkqlnCUIKRkVT352K5pb66hl+G
pYKLV1MdRTC2p0SmEcUH2B2rZLMq+EhJKOrwFnQ8Z9OK+3pPYtVJSqpxTCsLzEIOwGspA+x1
2q4Wu0XsXwL2Sf6ZgmKDRI05xE3qXxiVDJokCgiHPtUWhQXjRX8GGt6GF8h9vllFW7UHaWWI
bcHkyj7qaQCF5Dxo5DFjtMZswAaXwJHHk5szq5LI6xKAhpkJ+hZHq93mr8nDCDq+u10HzS5k
tboyGJf4drGjAxObWideKA0rlUf2YsLQLbCBGLhPYPQ84GBthy7UlGdSlIq65B59nIajknZ1
zCanRaHTqpMXr44Y0o/6w6+ALDuxgK/weNXhtG8cfS6ItJp1cW4DBTnzel9KbrLcYZQ2D0Ld
AWiVh0HfIsfo4M+ntz8U9stPSg6dfVGi/H8eR1NTh5ODsliK9iOAtM81Vwstt5Gsxltx+IQ0
0taIiJ8pG0iNO5a1QG66ujy1daOFkjfp9aVrBI5DF0FNoU5EKrIlWtYamNBxbnPaCqePy1jW
9FNtcpJeWHmjO+Cczxar3Xr2Q/L08nhRf34MZRbFpPCLyWs3FmhhXUn3bMDLfeV4FA5g9BI0
Qkt57y7Pq+0bbkxwJAJLCPvSiVMUsQgS8eblSfJ9Qz1pXEQRJ6zGcS6s+bJz0wvXgtEONXqy
KYuY9vPRKn/XHFjxZSfEhg4gn7PiR52c04vyis4ZkexRy7uGszyEaK3WGE57iqAuT0Vcq01U
TFLo5HpTWEhfcObwrH4KnFBHKnhj37NswohOTZl2TcSzeG4YGdG60iEyshUODoycvyBEN3NE
IeMbNppgBv5ge8WRe7ETxmdaMtKLaqDkkddj9T9ZZlQXa6EjYDzj32B5o9NQOiyaxdQhpjk5
fTD9G4+DU9Gd9SqtS6mkUaoNZ+6yLuam6lCrigyZ38lTceA5BCdGSuwaoo1Qcr+2Cg93pIaD
EC6zKWtLTZJOCJUaaZobnGfx0+vby9Ov30HTbW1omJMZLzQi22+c9y31QzfMWmYgeK6tmSgE
mCwMiHEJQVk121sUJQEDBa9j7oVpgNAx+yhXN8DS30GAgpdQ6lWzR7OiEcep4Dt5c7tZzali
8/N2y2/mN7SabKAC5WWUigqC7uzWt7f/nHp7u6NeonD9bdsSje5R3SEr1bGBYgKERBW5QXu6
IRxSUIKN43Pl22PEtmQUIghE2fA7JTRRV+FQQS6j6VBCLtazi6co8jj04gCis2i4hCyzMrpd
ta3/KvUuPeU/NRq6/sPtNVxfkF4X3fTY4AMacebqPqm7VeS+gJ/L2kg//Xl2X6WlF4p7/JbF
rKJTmLlEB+5mH+LNYrXwFltPmbGoVsPiRl6QipdEHkaIvuE40xsvXONk87src5269QAZ2xxi
8wbYyMABvi89Z79MJARCVFO++T2B4iTUycD8vdOj6/eGD6aydF2sGrwR1W/qyQbA3Kej9QAs
ozRRbhtOSsjAKfM0pCv2WyWRXf/YsD7uItuv1+iHMZ0/KU6SZyhOpsUBx3cN7wCiHJgKl6Ro
0WkeeXYD480NC2RFXReqBKRKkvey4doClqZ2LnL4ZaOQOEl2xrsK0IHFD7VM1CCCUfn1kbZm
586mZ9He4+aMq1Z60RkOaEEHiKophx+3trM4Ue6eLo2RuPGThRHCG2rRDsiV+/JhYU5U2RF2
TkKo8WUjWiNk5ByC3NNhuZQ61RclksYFD2Kk2I/i907CGHsBxdkSXWqKzYsnOHOnECVTZe4J
vedLxDua32ZVobVm4OofatX2yBXxiRYX6Oi4lkLe3afsMhmMf2j6L8CTvEcFOe/ATWk6KIwl
PJRlEKo2pEpP7MKnuANLI7bLTduSd4zYI/8d9RMi6Lwz0ZARy3kU4sjLhltv79EOBADUrIsD
8gNUP68cFgp7nsjQ0x4ov0QAu4YP8DNcNgYsKsnpY1Pjz5TPnVjPXWsOdnYMygGHfmOFVZIv
5vRqEge6GR/ydxdCzuozn4z41BMpClaUSP+bZ+26IwNUaAw2pNIgT5kwkBnfBBe+CT/f+JE9
NCypDsxrlPnWaxkmgK/CyRsp5KXDuSFH2LAUEMa3SNLAwPMTYY2fkKCWoEvQLv26IP1eU7sZ
URTcj1bWz5uSeNwxu5Pb7Wbh/1YFZO6OAulou54yp/KK1wKV23l11y63HyYEN4Vsl2uFpdFq
kd2uV7T20q9X8knppie7rx0mCH4t5q5BR6LEpKKduLYK1vg1kGRc8ctTGTIxXV0W5VQg/IHM
1eqJrj1wCD2uZAUICtrx6Vu2OItYTDnMW5ryzildyUJlRPIDJqei9aZCqpJUMf9quola7jk4
miS+mq4vkRcS1HTkGjVPQG41x4yt6If0YwaM6liM+e3vSVV4y4sOCT1HHDpS/XxnJkDTCQ6f
TmURu527V5YFYIeTY1Sau9DRpuWFn/3SVlLHqOP1zXw9rfDovzHC/ftkBTwbX+9kDXGmarJp
kuWgYHNETn3lGSUdVaHknM6Y7tJAmuokYxOvAi6lyNi7m0qK6fSXPUku3+FKZBmBTtMPwNZj
G33YOMPQ5FqH36SISTVQJYklYL5NPvMaktDgMb4APL5E3bGUtmCECtyL+6IiQW436WpiU1ZV
97laM77iFOtApRQFeZyKEz0u90VZKZHP4dtVB9rsgDLRjDAskDoFNTw9Nej2NJDrk+Z9IcDF
8aLz1EkycmoTxBa0BZ2xCkL97Op0yosUsIpZUgummQofaIu9iF+8s9pAustmQWoGBvTKfXi3
0P0JEq3abLl+iYAUhUGTrXboWPFOuwefdYuy3gdwnmXCzYpoEawV3mFnEVmm5hEhkjh2VkDM
E1e00D97l7xxV90llO5UMRzIxa9kcQ1hLpDCe4QqrqKGTNVgMk1xW8Yv+CyQigCAOBO1hkQ5
uLKhNW4Qotkz97TsC+hM0lnnvXSE6wg5Uy3qaWBMau7G+kNYm5CyxX6ImuZa6akAMxI8QRqB
NL0GUh3X88XO65qCbuc3aw+qDtsIniZzH35GcZw0rK1cly21db1QIgBwzPXlxXvoyXgM5s6H
A/iSpmhdG1cpIWYAt9YEwVOLTNATFYvBoCal9gfLY/vK1AOs8lJDR72qcbjbY1q1ZLTxmw/c
/pexa+luG1fS+/srvJxZ9G2CFB9a9IIiKZltQmREyKK90XHHnts5k8Q5iftO+t8PCuADBRTo
u8iJVV8RKLwLQKEqJYja8Z9V8umk0OGON2wTYBkg4U2WsZG6TPB1kZe5p3zjsQ5Ov8zliBgz
NR8+dVmUhaEnJUBFkTGGpVIfbTIrAyAmKcGZbDFxXw+V1QJ10TVyCCA2dbxwHS75g30n2IAN
nWABY4Ut+MIzCE+hxh0yzmwiyh2FBagtF5Z2uXhyWDVZMOID2H7gD+SeRKoquZU6eCIScFk0
dqilQ4osiKxO9mFO1dQ7x/siX92MuqSnfkCJNAq3zN5wP0R/0ouKBQOOflKdctn768KXzXQz
hIozrjYHOdjD0wEZRYwNIbe4221sGqt3jXkV2XVIDPnzuutLT2RAQOVS1eTmUgjEOc4VSoh3
ncdTQTeGRoc5j86nRRcwHX2L2De3xkok59jROahzyQ1QkQv6QALAu/xSeR7gAtxVh7y3n3UZ
+Ek0GYvpvcuCU2esgMK2PzOvWoEo/1kq1FQ+mGhZSp8SYJ7tlaUZtSue2IqyUJeCbiVK5FpV
HMs0AceCU4LpQ9WJY1U+4OG7mroomJuRb5OAUfn0p21KapEGQ2buVGe6HJJpjL2ImNg2Jrfd
E8uhScIgpyQ6wvSarYkE8/XOlYgXfZphE4AJOkF8cMdPEFGP/XnXqwMLbJLusmAsb+orj5Mo
tMjHMFVvipFAu6q5q+kNqfroxOVQPvsqr+r69hhmWWYne1eEbLtWbY/5+XTuiV44ZGHEArxd
nMC7vOF17tbEBzn1Xy7mTmhC5NoZs4HhT6Dixtg4VvPU3a01WxhgX1cnuAS161uJfbsNqY6Z
fygYQ2YQF2v/r3S6yyeeDzdgdvf55cePm93316fnP56+PrtP4rWTyzrcBIExhk0qdi2KEOwb
czY3eDf3OTFsLSZLogJ+UVuZskEnQPAbXCyTHW0Cr3TdK9i6zFO0/ckiwJo3vlcd/hnGv6q4
SNNLLJnw86cfEPb4GTm3ku0mN/1LSrKQAzo2VoT335F0hdziihZt9Pb5CR5MkaXe9831LLcV
thvLRSVtyHPqez7InhWhvraxDMqUYWVfW+aDs8tC47FSaZ75jz+X7RYQriUZv1hjDWvruc6/
AOnmz6fvz8ppD+EUSn90uy+8L5o1rHQIVxKJ0E43NZzf8/2pFo/uh31XVeU+p6YxzVDLv4/I
ukTTL0myDU3NVjF3KCrxPUc/rt2uQY8FJ5prAj8+QP/215v3HaPyRWvsD+Cn9lv7BdP2e/Dl
0lQ4aq3GwL275eYE4b3yxHvHTeNNjfBcbkWHO+2iSIl7/vHy/TNMDpSz5fEjMALWzsJIOjj9
PA92oWa0l/ptdbwOv7Eg3KzzPPyWJhlm+b19sHzhanp1v1YD1T1c4X0xW8TnoFN/cFc9WC+u
J4rccXdxbHrvwIhcLM07KYxtyZlgYRJ3O9owfWb5IBUWj8KKeNJ3eUKWUCv4zFGOARtOSRaT
RWru3pXWPsuhOVQHrijLq5lNFHmyYQlR6RLJNgxpKDOmu/daug3PojAikgUgijypDmkUb9eS
leohkSbvTixkBHCsLsKcnGYA4m3A9a0xHcyYc9OxIKK95BfTo9MCnY+y0ajUBO8q4oP6Q5+E
A/FBKyeNDdkvBA+voj0Xt3S0moXv0myCKCDSHoQW0k27yDs4MFhLdoc3OcbMQtsgTNMKBBj3
mCkoFhVKmNLpRxhKrOetpRoNIrwn76qTqM3nECael3JLsUnQ4QKC08xjKOywUX0TMZ3k3MvG
Q1M6GcGr5srJiFSI7yxHbz0UtaF1mPjuHLKARXSJFRhufSWGwxmpxV/r4phFjHIUibgfskLw
nG0Cb3qK48AYNe1hRiH6znYd5TKs1N/I4TMbdlk3zqMjgrXMt0G0oSsTMOzsCaEPx1x2wHfS
v81519/WpgmJCVeVqOkKqQ55Y/rqdzGw0a/zxidfNYB6/V7D7M+/16I/+xr40LZlTZ+voFLW
ZVVROq/JVDe17JwDXRF90j+kCfMV5nA+PtKTDSryndiHLEzfEaRCV4AYaWnxLjmcgF/w60qX
Ad2ZmLBc4BjLAm/55OoWv99YnPeMbTw5VM0e3lLXnac3c/WD/rjmQ3JurqIv6G+lpj/Unqrh
dynzDhK52Mp14khfR6KaL6VCLuIhoCIemozq7xM4SqTFUX9fak8DC3iuG0Xx4C/r2tx7KYW6
rVmZpi5SyyH92ZhM6kyl5V3bo6tU3CNYlGaRb2CqsyQ1DbxbterUNj/SAalsxoiv5Vh7oow7
konzaUerqTarM7I9fCUvoM1YQFeXku6ku/haAcoVmxlHNLC2yBtN/w9EPLSi7fzi/Q7h0Dyd
TlWab/JRYFj7wccHMCmr19IW4FJyE6OTV5tpGuT+Zs37B6cySG71dy0s508UY1+odcxTdAmH
QTBYRpguh2fO02DsmQsUmHqnriKnTbFNphO/kiY+aGmrmyovaRn6urd97yFYsDCi7kowE98L
jwY87UHo1M+nfV5UPgeBiHXIkthXyV2fxEHqWdgfK5GEoUddfXSe4qPKbW/5qNHSPsTQEvWh
t64s7P1KTdp/nXi9cZ5MKyIdTUZBKJKMpvCdRdkHRqEnit3XFT0sR2eMNj9jDiW0KVHgUDY2
JY6ns6jb6aix/rW9sX1QYdEIj8QWh/p5rbNgg9Z/Te7yk3WWgeGi7vrQTqupd0D9gqlWoEFN
HO97h66/yk/IdteM4zs2iwkL04dwfmrnK2vgqsWxk+x2a8npA5ge3SbhmjvkvBr9sFqU67GP
Y3TeNSPNhizljFf8zII7ts6051lgsYx3GlTXWPx1Eieu+pj6z6fvTx/fIIaFGyhKCNqKQG9c
lJctT1gdcApl3sU2nfK91jboth2fmHa8lj31WDbovB6oKsxIqV1fIjo4ydWez9H5xoL14kS7
TlA82lZMmZuomdTK1nRYpgm9GZxMkS4QbLpsD7bE8CKu3WPuHZXhcid0GT0gkFWedx08FKVB
mSyvvNCdhY3I8R45LobbKPsVOlykKXp13/8Wxsk/lkRtR+aikP86WgY51JsHnytZtwMuEkFt
XMXp3AvlXm4O6aDPrOX07l4emFEE5I+rOgCrj/sWk0F5x9GOFfVWMtNn5hIF+7/xvJz/9fnt
07fPLz+l2CBH8eenb6Qwcg7a6flERWOvjuarhTFRK7zeQtUZWuRGqoFRkLiA1He28Yb5gJ8E
UB8LcWpcQFspoqopK+MLfwXBC5aia/RJ5eR6d62yzO/H8BnwEBa3llycTQNOVa/Nod3VwiXK
0s63GjKzeVaEaApLC41eaG9kypL+5+uPt9WIQDrxmsVRbPcZRU5o/WbGB0qNVigv0zixK1tS
M8ao96OA1pl5iKEo2gMmSgN8vlKuvwE7KrUttIuiX57Ijnf2fCe13TjexnZWkpxE1NnHCG4T
qx/fmyYNI6E7tWa7/fj7x9vLl5s/IAaGbo2b//oim+nz3zcvX/54eX5+eb75deT65fXrL+BJ
+L9xgxVgWuuOrbLq68NRRZWx1UYLdtyI0GzzO4C/fQymwTxgFa/uQ0xScjqUqw43oSOR4qAf
qt13/FrXnneLEr+reNfQ91FqvJJRJwBp9Q0LkkcOLOLJAyCnu8hq4L7mU9wsg6pVPuc6uPop
Z/+vT5+h3X/VA/Lp+enbm28glnULjnnO9lQ/hdfAsrW7VuzPj4/XFhZv9IGojw/YdkT3xQ5c
j2k3SkrA9u1PPXWN0hmdEku2H33YTVqXb/6xho84k89XAWpyMzLJTBpd4ruTNFi7eF11LSww
Ub7D4nX9biy7xncR6UfONO5X/m8s956SpIPMo/0BULHKop3vyl0uf/oB/WLx6+beVisvvGrP
gBR/oA7aR68bXcxgcuz/FfEsQGNrHjB58kfwBZdxGvh2/uXlaoXCtWGfV4IRhhcEXnxPesMF
BMyKwZe40xx4cgRKw9Pg2jQdpoLhDjbhH4lOiq0eVZjYdcXm50+cZDfkoflsZKHh6RLok1ky
pvYFy+TCE4R2NctxXpPztupYA36hCLQBXgd6+OdnNOiLx4fjB95dDx88oRmgs/Fy0lRVxzWU
INd1Nwh2Hkz+7vvr2+vH189jj7f6t/wHeydLKnDgBA7Srp74TMAjmioJh8D+1LfU9XIzY/Le
kp2s63BY0a73Or88im5k1ypY1998/PxJh8ewqwXSKZoa3sveQYBBY2diQFRUpQW1zS3mXP8F
wbue3l6/u2qh6KRMrx//l5BISs/iLJOptyq+m17AvoKN3Y1+7XEDlkLHSlzakzLDV6ERlTMS
2Ii+vd5AQAm5oMg17vkTxJOQC5/K7cc/fflAeJQs7CLDt5PLMF7xT2EqnTLMX45K/3KWMYZr
GwGIG3zuzCiv9ZGbtksGPyj8+7P8bIyaYmQh/6KzQIBeahaRlhYchcn7KA3p06GZZejCgLre
nxjgGjhBs8SE8KILoz6g7tEnll62WlNRovUDiwPqomhmEHxv6EUTucsbbjpFnuinu8w86Z7I
bVE1raAEkC1/e8wPOeUCbi4h7JhzN9Wi36SN2sxQQOYDtoEPMNRZGHJotRgJUpntBQQHk2sJ
l1u3mM3+zdu9pQBPn9SnD3jm1z3GZR5dz2Pa9NwWU5WxUjDPtvzly+v3v2++PH37JvcUar5w
lDv1HQTysGINKrqrbOgNv1YO6OM8YCgvYKzrtp1W/AX8F5jXZWaRCE1cwye8pivibXMpLZJ6
qX/v1MwuS/p0cIrCq+MjfS2vqz7neVyGske0u7PzsXc5HtF2cFuyML1DKqL9nFXXPC+v+3Hr
Ox02+Ftz3lsq6svPb3Kmtqx1daraZtHfcHl5pGwldANAwOeS7HGBW69AD6k5RB9Bw8GNubUy
qTgC4ojsszhFyoqii64uwowFXn3eqhA9LPalW1FONYWBJV1+qh/bY25Rd2UaxGHmVICksyyk
5t8R3sYp45d7q6CzYY9DjJ3C/54fH69CUGdWCtd7ZHt4dFnqVDwQ48TNQc+xvvShjdMktutp
XAVwuU5FLGJsM6BHBNwC+vujvsDLKMuLBQ+VQahDzhJ7UCnylgVEN1IAdW+i8Q98yBKrnJNF
I85DG1lYrECM3UEiydvthuy7RB+dw0u9M8h3IiNtJseBVF9VSGWWOOKo+OcKJCPr6XYsiyhk
A1LIXJFmXX91mMlVhyUbq6pkp4IYA3YN6nmGuT20iKKMfNOli1T3bX+yJ9wTGA66fVHHsCWb
gyiLNqDvd+81x3LoQqZMpIBnncPhVB1yOCJz5tgWPEYTRTcDCV8YXE9NGgH75f8+jSc2y+5r
TlXy6jMLZUvdUp1oYSn7cLNFfRpjGTWaTBZ24fTXHp8AC0N/QIdRRKHMwvafn/79YpdTnzXB
q0r6Ymdm6ekrphmHogYxqm8DQJbqFgQvmkvY1K4LAMykrQpOLrHqcoE8FgomT4Zd+NLpkOfg
mIN5hYjeLUGU0ZUYm3aZJpBmgQ9gNJBVwcYnYVaxlByguBcZexXlGTS/p98ba1QFNaL2MArt
z11nnruZVPs8EWGWK6kOnCYAbrwUVKvQ1fUpPwKKnWoRtVCNqS12MRAX3aLBhSJ4tQBdKUiM
Ct/lcKD4AF7ts+0mRruHCSsuYcAor9ETA7RiEriJzs3uJKnb/Z0ks5CSpt9RF/1TASVq5qc9
nZ3sj5xEdx/C1BMabxII7LvpsiglcDV5yWI9ZbcYwKw3DTZk+iNGehM1WaaF3qqRuu/g85U6
k19n2yByewsommG69NOJPm7tnKzG2l7JqhFREjP624Ft4pTa200sZSXU7ZPmTeKEKu6k5q6X
V7JsiQKrmthmlHyyh2xYTNuFIR5PGEaTJ4zXigkcaRR7hIgz8nH33P/5LtoQTaZVc6wBICxk
lExTBzvk50MFV/7h1rzZn1I4CTl3kBKfi54FAdV35zK5W7IF2m63MdV1rTlV/ZS6G3LIp4nj
VZTlDleHmtexd1w3PlPY7jKNGI7GtCAbRsmFGDLTDmyic3jeY5qrmUDsA1BXxxD9bhHxRLQt
l8nDPO+XDJ5tuKF63sIh0oEFVJmFrEcycjpAG/s8gOSh1grEkYRU3UkgDei6A4jWo2aePloP
694XaUI25lBf9/kRVHmpmDcEg3oVTVSVGDpGiasMosAX+qrAZZ+EawJDiHlKXr2CyTopPFhM
yVTHd9ecUweHE8c+jaM07t1ED33hFn58qDCK4WS3F3I3cRa5VG9WK+HQxCzryWu0hSMMek5l
cpB6DHWCYuBEPxstJI4uclvfJsw8dZgrb8fzilNjQiJdRQasHBl+LzahW3tS4TuxMCSHWVMf
K7kwr6Q5H+FTlaKnfUoBxBypW8wRsE3TbfidwPLAtSWHMRihsXhtcgCOkJEdWEEhbX5rcGxi
t7YVkBCTnQaIMaYebjEPkAQJkYlCTDd5CEiI5QWALdEM6pgmDYmuq5GIrFyJJXSUcsQRbUlB
koTqpgqIiQGhAL/sW7Jj86KLglUJRYGeGyzTf2E6h5pbjycRRU0JgSU1IgcbT1eHCk9TsjPy
lDp+XuCMlCGLSCrd33lG6XgL7BljcuVfnXElA31oYTDEYbSmLymODTE6NEDoRUdR6AOhurcM
0maOQsjd59rwBo5tsHFb/NgpF4vELAs3G1u0gek4bXo+f3Lh9NrQ3wpGFEySqTVakqOfJLmg
uEcDSQeo5Cq7CciOK6FQ6oorRZEcCZwFuPUCnr42KWfbkEq5F6JPV2fpnvMkIbXfgoVZmWEn
Egvap/StDeJIKRVNFiULGbkAH3P6Ht9kQCZDCz0KQ6J2RJESc5C45UVMLCGCdywgpk5FJ6Yn
Rc+okkhkYz/SIFjWJ1DexYzI9b7OkyzJ3WLdC3Aj5tIvWZSm0YEGMkZowwDg+MUmEPqAiOoq
ClmblyVDk2axILRVDSXHAyGidX9k0mPs7QDmqpy6/ZtfbvxtUxy74Bk4tpf8oT1Tp5Uzj37C
oh4sjI7sSiILcGOiTINkar8FRFbKnsHZO1+e3j7++fz6r5vu+8vbpy8vr3+93Rxe5T7666u5
lZ5TgSDtOpProb0n5MAMsiItR2A025EOFehj73LkwZ9iKytt6ryw/22V2PFOtHS2di/mROkD
QX3YQTKNLONmzH3Po3diJjAnqyyLovdSTUKzr1mXm2tSg9lFkGzXmcaz6hUZxuNqt7+PT/Bc
4LGuT3Di7yKjUQtVTReylKdjLBK2WvPjFTGRGyinEDqQTLgS57VUe9HxumBku+VNzVMWMPAH
QJtBJ1EQVP3Oy6CtBmx46m1te1cBttTOTJo7+jT2o38srX3NQzZ+N91j//LH04+X52UUFE/f
n42BDs8wC2ImK4W2op3uX99JRnJQyfTgeaDt+xp54+zNN+jA0itbdPxVUYO7T/rrCcVE/fhs
DodHf4mZSAzbhu0KnhNpAdloHWDS8kIQ74V7mUBMDqrJZ7xvCyv3RWYL6PdN3t862UzlgFgL
BafCMiG2Dr/51xjpd0/ZIP/PX18/gtmp15s635d2zCRJmS+qzFseoPdRSp4STmBoqFQwIg1n
cTihXIRZGvh8/igW5YEJLNkLM070At02RVlgAJyrbwNzT6GormGRSgVMSQeKhh8WAn22rESl
0FTP03ODQT9AR58qO0ryvm9GTYPNmZhRRNNQcyEaBxGqKdTl2kAQ49BunnF5pE+MDAannuaD
TItmHujNtAg3k76/c0RpjtTuEqBDLiowvNZHnbi9CgahiEji+I4Bt+QIrTRlFybYVRdQb+tE
avaqKsmVQ24cpYLT1wW9dwdYZul7ttV0EiadmQDSm/6BQBjbVR3QlEFcwVsULxeA2RIOlSfL
Ok6HQF3Q2K4ERU5I62g9CPSlo1Pn6oaQPEtfYGwittBJ+7cFNu8dZ2q2iQgZsm1A38rMeOgb
pvomM3WyUtebmCiSKHGLIqnblcyr4z5kO051yepRPfXtrIGvSKgDGA/cECtoVHZtdMU+lsOS
Op1QnxiGbiZZxIH/m9nI0STeZUGGxRw1R8zXVwWxOPX1Jk1sJzMK4DE2h5uJ3pgqwHD3kMn+
GdqN44lAle+GOAis3PNdxHzEVlgtMnl50RaBgn/6+P315fPLx7fvr18/ffxxo+0/68n9LPHm
DRic035FdPztTcZ6/3k2SFRtnI1qGTnlsq6RAG+6aLvxdYf/Z+xJtiPHcfwVn7qr3ky/0r4c
5sCQFBEqa0tJIct1iefOjKryG6edYzunK+frB6A2LmC4D+m0AYgrCAIkCKCzQxRpBRblSYap
DrN4e25b/ihDfEu8CtUj2/DSZ3dZCqrum8sdvd6+yUOYAvuBTxaidlJzv12hsU01I7YdGqpO
vIQz79hAAoJdPDNaLDH1/INTzzh2Sg2PEIECs95d0+DuCtsJXbL8onR9l94TefWJ60exaUOZ
XY+VIocx8k2CWrx5E7W92X2dAuq6zYKQnkGu6pbjycC70scDRqWRCDVcxU9o3E+uo6mT2Bnp
WZbaCH5ypjWCHyKYdZ2ZQOvoeuCmwfTRmhy5VaE6BYnCdwCkH5hIMvurkB+rmNn81+TsflQb
cJekseuNpJC8ajEtJbfZ4VQw5TZkBRpfQm4UU1akoS56dhB2i41gyNv+xAoeQudUZoaKMEhR
17AkW+lIttk+AC3tAALoatvQ7otEgSajZpNQx6W+K2o8AobvgeIkCDjzaz+BiBtkVxstGH1E
ATMnXS9h5SmygNl6vFqEonkJDDFZXWTRulMjTeKbCg4cAxdy8+qjgh1x91QwNt3iPat81yfl
7EYkn8ls8LwrYtciOwOowAltkrtgrwjEzVfArGKdKBL1kNDQDY67PvDcLXOkC56fC5EFg0Zw
fXQWpcH4fXSdWYtpczR8D8ggpGyjjWa1x8gSEOuT1pVEo5lmEjYKPNpjTqEiA/DLNLFv4PHZ
+Pq4AFoyrXYiMcOTtSj7AwrYyYXqo/4BVRRf57EyaWwYRscwjo3v2R9MRBNFfmxoJuAC2pVW
JPoUxg6tkAhUYKeSx34bifrOWcBMVipRbLM//ZbRaVUFoiGKrIAUVBwlemwoqJhGyW9sNgTP
AI0hEK62ZzFoifYoZq2AUI1bAQU6Dd2czikbZl0fdaTpTLK688soDK4vEMH41XHFAZPekoOo
KVwCCkq0AlKSAypyPFKognni25jTi+zKYv59wKdI5rgfCJXJ9BNjnKq40CDcqZeXRjLSgVwh
sl1y4HUzVMORvDThPHKrXO1Pc89iMi+ARuQYip+sS6o76qNQQdWVg1NsiNVwITE+KQ5WA4jo
oP6sdCFJlDQHAJjyBG2nsHlLH+62GD0pqVNQxOmSpwCQwjEGwFifQ7vKuhdDA7bnYz76x9SR
YHkpPoyfATy+qhgJCreRjE4bleNzq7Rlvat80fVtxsrfGHWtj/Uc6rYpTgc5WhbCT0x87Q2g
vgciMQA7dHGJTCMRTlES8lZtCQ8uSl/LYqJ4g1WTnMddPZ7TgYpZm2TqpCKkqvt8nyv5ljG9
G8capngjwHdmdUtdAE80M16yN0XEnGr0yve7tB14OMQuK6aU4XPEii+PD4s1+v7jm5iPam4e
K/kt09yCHzIWZqyoD+d+MBGk+SHvMXC6kaJl+ALagOzS1oRawlaY8PwR3YYTwjpoXRaG4vPL
K5FIbMjTjOcDFw4BptGp+fuAQnyplw67hUOUSqXCeaXD45fLi1c8Pn//6+blGx4NvKm1Dl4h
rNwNJp+KCHCc7AwmW76ImghYOuinCArNdIZQ5hVqEKw6ZJQA4jXxS2eeczuB3wQFbcLeVSC+
xFGgeiuN/RqKbRsLdbWsA47jbGR4gazNPp2QFabxmJwhni4Pbxf8kvPAnw/vPIzShQdf+qK3
pr38z/fL2/sNmw5As7EBwVJmFTA2L0+ZZK0XnCh9/OPx/eHpph/0mUaWKUvxwgUhUrJMTsJG
mEHW9JjI1w4E7yFAYhIavHTlE0dNGSfisVe7jMdZAlna4cOBg1zLqcjW17Br34jWiwKEyFbI
54Gn/tSFm0KFrhJmETgJiLXfP2R4nzE/9GXVY5IouRfShzsr2pa2rilNKUKJjzZps3y3bCQ8
RqUMw5LKNrIsGZR2O3Ev482AKc35byqiO7L2lgQ6cqm3WVZlMqhlqARUtdIiFouOv8LwBR4x
fIyFoRVQ98PLl/sgkoNhTYjpZP7K0ixR06ibJdQX55rPL1+/4rkoZySDKNyd9o6y925wQkxy
eAkj0XQUJi0nOZEfyPJKVhR1YvqwE11JS3TXZhXMZtpL2RM3TEsdhwtCu28OkvjcGG5L3C19
lbB9dk6SXMo+s6C0cFHyJrC8XVO+K8lUxRNuDpr0lYIqjRcxQy+3DzoGE+LAv6VfpFhAMaQO
AOWYB9oBMU6TYCqTXzq8X8JtYg4CK15z4swgt4JeJA881xsMgz7kpcoR8BNfrVJAVO30EhCB
gpxHQg88dRKgCocOkbHg0SiQuIn3d//4esEsxDc/5VmW3dhu7P18w7R+48juc1Dce6HbAnDN
marqS2Lkqwn08Pz58enp4fUH4fg1KYd9z3gOnilcVssDRM0r/OH7+8s/3viVMey4//xx83cG
kAmgl/x3VSlCe4EnXuJFs+9fHl9Apfv8gvFc/vPm2+vL58vbGwZkxBCKXx//klo3FdEP/P5R
XwZ9ykKPTLWy4mMwBtUpB0kaeLZPrEeOIV1R5nXXNa5naQUmneuKRz4L1HfF92wbtHAdpjWq
GFzHYnniuDsVd0qZ7cr5OiYE2LOh4WHtRuDSZ7AzkzZO2JWNWZx0dXV/3vX7MxCJGuK/N5N8
0tu0WwlFxWOugLFAi7w2VyJ9uanhYmmq0hzakaUP1ISgtroN70Uj/WFARnTY8BE1NTMCJYvx
410f2bH+KYB96sB3xQaB/tFtZ9HR+mbOLaIAehKEKm+h9mDbGktPYG0b4ZcOsOZM8FmQqstq
aHzbM/MYx/vEtAEiVCIaqBR3TmTROVYWgjgmH1oJaGI4EU4ehC3LZnSnB8ACVyLfP0jLQuVP
PqqhNqrJ6PiTnJINMJL3L89Xynbo+ZUzFwtLwpAeWaS4Jl6QwvXoOxCBIr628GI3indE826j
iEzJN8/PsYscixiydXiEIXv8CtLpfy9fL8/vN5gzQBu7U5MGnuXamlSeEJGr16OXuW1wv0wk
oCl/ewWZiG4EZLUo+kLfOXaaYDWWMHmLpe3N+/dn2JyVYlHNAo3FgVkTi1TpJ9Xg8e3zBfbu
58sLZsO4PH0TylNXw7EL3SurqPSd6dWwvPU7mgrWYUqvJk/ny65FcTE3ZWrLw9fL6wNU+wz7
i5CzSGYYMFMqPGwq1EqPue8HWuNKGCaPhMYU1Nf2d4SGZAnEUJQYu4+C+sTSrAcn8K6tTCTw
r23rSBB9VEJ0bWkDQUjGIFnQfqBrVhyqqTwcqgmmegikCJkbbUhDyYHyA/Kl4YIOHd/WCwul
K/0VSnYoJJsThhRtFOl8Vg9x4BFbG8LJyEkL2nYjneeGLggcjefKPi4tOU+tgLiiICPetrUR
AnAj3eKs4N6ySLBtEyoQIAbLpt/EChTX2zfYNtGxrrVcq0ncayxe1XVl2RqVIrjKuuj08ttf
fa+iLl3n6v3bgGmbBYdqqhFAvSw5ELolYPwd21/pQlfmrKFuZyZ01kfZbUQVnIRu6ZIqNS1L
uZgtAKZbiMs+7UeOxvLsNnSpdZnexSEZs2lFR1Z4HpJS3AWk6idL+enh7U+jvE/Ra0IbbnQp
DbSGovOQF4i1yWWvYVmVfVAq5NDZQSBtXNoXgtGNON2qT8bUiSJrSu7RDvrNg/SZbKX3p4pH
Mpz2xO9v7y9fH//vgge9fHPXrHpOj2l5mkI4iBNxYCDbkSNKYQUbSXuZhhRVWb3c0DZi4ygK
DUh+zGn6kiMllyURXXa5RbpKSES9o3gJqljSc0AjcukmAs4JAiPOdg1d+9Tbkhu7iBsTx5J8
XSUc5iA34TxLdruUWjMW8KlPHdfpZGFv6FLieV1kmQYDdVEx3I7OJLahX/sEptIwVhznXMEZ
mjPXaPgy84wDuU9A/zPgyihquwA+NYxQf2KxtGvKi9OxfSM/531su7S3i0jWgmQ230ivs+ha
drs3VfWptFMbhs6jjW2NdAcdpuNzU4JJlFhvF37Qu399eX6HT96WDCzc7frtHYzoh9cvNz+9
PbyDSfD4fvn55neBdG4PnoN2/c6KYun8ZAYHijeZgh+s2PrLcO3GseI6nIGBbVt/UVBbrR/X
C+nVzpFRlHbuFFqE6vVnnlTmP25A+oPd9/76+PAk91++SGzHW0NFiwROnDTVRijHRWkcoLKK
Io90i92wa/sB9I/u35mtZHQ8Wx1YDnRcGVj2rrhEEfRbATPqBhRQn3//aHsGX8Zlhh3SuXbh
HkkMrJ9QnMbZ4honydJ3npjIIk8il2mzrCigvnICamtD7JB19hgrw7iIkNTW+jOhphlRv+IV
jVr9J6YuKm1uA2Ju7ZCacHV4gR/Fx9q8wg62PG3wYO1YV5Y2pjJhpK/sNrZcKVlZt7/5ybjU
xBY2oK+orUbYqHXPCdXRnoAOyaek7TMv7VQupgAbOrK12YIueUorqrEPLJ3zYF2RrwyWteT6
Ci+k+Q6Hu9xp0zAjqJPtGR8iXisOoQ1RWmwZeWvuYiSXxfaxpbJultjUwnUDjQdBBXesloB6
dqaA275wIteigA4JxDM4UuDSuWX44Kc27M3o8VFTfmxr6yJLZN1k3i2MTItSIVLX2jScDslH
qiCexF64VMr6DuqsXl7f/7xhYEQ+fn54/uX25fXy8HzTb4vol4TvYWk/GFsGDOpYlsK1devb
jr6dItg2LpNdAuaeuqsUh7R3XbX8GeqT0ICpYJgxbQXxJUuGK+M8eYp8R2GKCXbW7nBn+OAV
ypBjDfYqovIuvS6j5ObFDn3YMq+y6EPZ6Vh69CneBnmL/9vHDROZK8HnTcrAcDXCc9fk2ovX
klDgzcvz049Zg/ylKQq51OmcV9mkcFuDjoKUN4qTjSZel1OXJYsz2HIicPP7y+uk3BBKlxuP
978aKiiq3dFRmQxhsQZr1GXIYdpGgY+iPEMaihVPxpXbsMrKRrveVespDl10KKjT1BU7aooB
63eg05InbLNgCQJfUZzz0fEtX1kR3IxyNFUFBb2rNfVYt6fOpYIH82+6pO6dTC7omBWT99U0
n5MT0/bs/aes8i3HsX++mhJ8EcUWoQw2iuUkm0Oa1cOb0b+8PL1hfkjgusvTy7eb58u/TMso
PZXl/XlPOKvq7h288MPrw7c/8Ym/5iTLDtImPBwYpqynRlPMNQd/8Mubc7rLKWgnPBNGaNqA
mBt5gPkpb6mI45Hiu6zYoxOPXNpt2c1Z4XX4freghEvmrUCosuz6c183dVEf7s9ttif9K+GD
PXe9zUp8GZCLwQ02ZD1k7eRaBpujXN1EUGSMp/vstFw4EnFRs/QMBnSKrjslJgk2tAmaLzki
IazvlSkYWlaS4wOUJPyQlWceqWoZOGVMTTj8rjuiA9iKXbPpzbesNyAk6RNTLIDnYz+CzhfI
DZocMQspw9UCx7TFeD4YR+MVpC9d/F5r0KS5tKV+isy7X5dZysSyRFJ5FluWZnVlnGRWpofm
ZJjYqj4NGZPSJM4g4KEDS+7PST9ecaxdiCdnX58EL0Hm/svVK5kIyvKD9vGsOEV+OPYyJwyH
TGVCYBwZckoLGcDUdV0e2MGR5DuOasJaDCN4TMucwBRDqtTzaZT3fQDt6uRo8E7EpuZtjzka
jZPTsCorFuZOH9++PT38uGkeni9Psoa1kIKshFKztgPBUdAZ+gTa7tSdf7MsEEql3/jnCoww
P6bfjm1f7ersfMzx2aoTxqRNIJH2g23ZdyeYx0JZahONPooTXL0a2DBZkafsfJu6fm+LKYg3
in2Wj3l1vsWIinnp7Jhi4YqE96w6nPf3oJU5Xpo7AXOt653Ki7zPbuG/2HUMxa4keRxFNmmJ
brRVVRewFTVWGP+WMLrAX9P8XPTQxjKzfKOmvJLf5tUhzbumYPcwTlYcpgY3JGEaMpZim4v+
Fmo4urYX3F1tt/ABtOiYgjkXk/PIyu4EQ1ykseVZJAcAcgcW/icx2LGMPnh+SM50ha+mighs
8GMhnsgLFPXAsJ2cueXsIyQR2O7kIc1KWxd5mY3nIknx1+oEnFbTpdZt3mGqouO57jFkWUwq
hRt5l+I/YNre8aPw7Ls9uTLgJ+vqKk/OwzDa1t5yvcoydKxlXbPL2vYeM63XJ5BFSZtlVAhH
8Zv7NIcF25ZBaMfkoAokq6eTTlQnt7z3vx4tP6zQqCFVceGDalef2x3weeqSrLIwUxekdpB+
QJK5R0ZylEASuL9ao0WylkRVGvooEEURs2Cn7TzfyfaGaNv0h4x9tKC7LL+tz557N+xtMqrv
RgkabXMuPgEXtXY3WuT0zUSd5YZDmN7J3hkEmef2dpGRt5eiwO5hAnNQFfowNBYpEkXx8FG/
0cGXJaPneOyW8jXQSf3AZ7clXXvfoN+15UQ98OX13syknlv2GSMHkVM0B9skU/r2VNzPe2p4
vvs0Hq4v/yHvQNevR1xUsXqiv1KBtGky4JuxaSzfT5yQtuwUVUGsbdfmqRjVR9iuF4ykbWx2
6O718csfF03xSNIKUwpRMQk4+ggz3kPxqG6r+/WySwGo4jndZDQqB2f+UkFR11AxPeYNphRI
mxHDYh6y8y7yrcE97+9k4uqu2KxAZVBRa2/6yvWCa0sQ1etz00WBIRaQQkW6pqX81ReugBzK
UUQXAGPLGXWg43oqENWiZaqU3vTHvML0qEngwsjZFpkQmBPW3THfsdk1WrV1FGx4FRspWNhn
9o1nWxq4qwIfZiAK9A+a1HY6y/ZlzPQqGGQFq8ZAeq2gYsNoHA3YtJERaKqh369vaxJKQBk8
4znHUvbADOQW8ld9FepLSK456ys25GZhyNqkOZhMhHLs5MUMgP1Obl+Sty3o+p+y8qT2+lDa
zskl35X0eXWPJMcxcv1QuqpdUKjiOg59/ifSuB4lbkUKT75YXFBlDuLa/UQZngtJmzVMOlhY
ELDH+CK7CfDQ9Vt1JCZr1zDK2Ti9kMdgEVnXd5T8BH0PX/PyR7GfTnl7q6hvRY6PKquUxyaf
nMheH75ebv75/fffL69zPgHhFGC/Oydlikm7ttoAxqME3IsgsSfLMQ4/1CE6AwWkYkxqrGSP
D7eKosUn/SoiqZt7KI5pCDABD9kOLB0J0913dFmIIMtChFjW1pMdDneWH6pzVqU5o7TWpUbp
cSZ2MduD1pulZzHMFxIPBwbTINGWDIMPZ3IB22mDRAp084lTJ5WL1ja2H1jsQE7unw+vX/71
8HqhHjnjgPIFSnewKR2pEfA3DPG+xs1z3jeltiT3oPHLp9UilE+/SA9DIqeVB9hpyDpGrmpA
YqoQfEBLn2vgKNspj1VN96cacphNqXETSI5FsIGVpMobQjwSEutv88HY+Jz2HOd8gNnTFdZA
EAihosgqMHiUehb0fdfnn070cctGRinuG1Z6kIB94Ed6BEgbpRlsHIwJbYr6uMd7kntbdOFb
QdSZ24RU2AUg54SS0TPuMCqNQuBauJGNKE8UhLOBycrPClQjhhIULEkyKv0OUuSyEIC/z64c
r2eB2vSeh7yZ1SDNckp/AOztfVtLdbipHAF0Bl1rJserXDDUdVrXtlT20IOq6Sql96A6wjZl
mCwxWgCXNa4sRVhb5pU69jMUNjkGO+VAZjeSaJJT19fqauJhsA0TU3bJSRunU2oYoHwHes3Y
e74iA+ewpfISz9AirUu1T3jn7JhEWNehW0SosmAZ2rQ5Ru7zfAvYPXz+76fHP/58v/nbTZGk
S0SZ7VpsrQAPnHiAlDlmE9GydUVJhBubbPhDVmVtnlAoDD5HgNXUDDJGjoC44XjAursio5MH
bHRTMK2rXSLSdEjIKCJ9oxUa0VNqQ/H4nRajy+ZIyrFCIGkiX44eIuHoeJnCkKNS2DJqcKnQ
7xuWythNkKmh5alWDjC2YUHnFd7IdmlgG3IRCAPdJmNSkXlitvrm0BHzAvlgGSzfg6rSYebf
/6fsyZobt5n8K6rvKanabCTKkuXdygMJUhTGvEyQkjwvLMejTFzxtbZnv8y/326ARwNsarIv
M1Z3EzfQ3UAfwxxq7wdeLNNqWv8L1EErLQ3+bvT9bYNBTtguERotJDE9IiQiqStPx9juuzV6
5u4+U3mdWQqVyqwtojf+DgT40fv4TpIsCfCjT82OAdOyuLLS9wC+9A9s3+odqx5gid3h0Fmg
vJ7u0eQFPxhZHSC9f4HXvMOcaJgQtb5wdsFlfWRAzXbrtLvxi2LiBavHToRe03jFitMaVYMK
kjiDGCXXMqMTYqBVXkDTJmsJZBxEmUNB8GKHd+92f8VOwi8XmJfKl6XdKJHXVuDgnY75Ifwk
cb/WJvAODDpZyX3UqGC+sp38NPq2AAF+aohg1cR5hs8Xti1DB53ucYSGEKO5jBKff502yAi4
xBk0vzk17vN1dDuJjaM0kOXkKt+WqT3ecQIafF4reyB3eVJF19b4acj0GMTVerMs3TGAluoN
MfHR9W3kzlEt8A6LEyQRe/ATWJ3uN3sZHfTj0PSo3Jb6imKiWIlxf+wRkFXkduaTH5S8ioXY
6iCzHauvm4HIFKjJFdVuEJ6IIj9Ezno3ySqt0kEVy/fTawLHDM+jSQItnacwz5wIZQgSlAnt
xZH6t112NALVsSvjEa0UZY5JIB0w3oOXkbN50zqpZHdUWg3NKjnZiQzEeE6dQ1xemgVLQCBh
YOJRWODWcBLwuWMO9H0Yr4xX1AxB5Se3Ge8OpAngzEO+PomHA0K/DImpI6ko0ebAHX34Jhzt
mzIXwucUHETCMTsanfYxzl1o+KQ0VQrGvgK2f203SFWRn45AUYIhRHWQVbv8OiuSSTZVUulF
b1x8ufWVtGwEeuC5+VOpX1af8tsztQGryO1BgcNFmQBfFLiDnev0sNqVoM6lIJlF1p0qhU8f
ljVKKE2hlnZFB1/kTj0HKduYtFbnjhIW52TXP0dlfqbbn29DkD/c/Wuy9za7OnDWiYEb7bX9
5QgzSTGa5lQUnudaP3dOuoxs1aXI5OU/jMFnZEBng3F8riU2Jo59pW7ZveUcWyE+i3QVEqM2
i7ZDWKWSNuQ7IRu8Hk2i9i53GHAS3NEGmhB/NgyjhOLJR7uP8DopZOPkX7cI4M9sKsUW4kFn
2TU7XzU7EVpVujXx6TZ1EVkGh6SImiw6kLjKTEATnIBRcEId27HNxYqKjFSVW/d0cE6LLK/i
5rCDYy6BMs5SBYlWyFSFa32SEgZd6VGPo1JnZuUNAfUYYGzgGk7HDIRIkPpuf/Mo2kSLHhb4
y/vHTAw2zUwqZT1368vjfI4zM9nEIy6wcwTRjwjyY+0t5rviLJFUxWKxPp6l2cLAQkkuDR0F
/7jElIxmqdmt+FEztwwB3QeLpafLfbK2V7JZLFqwVVqPgJ7xZ6gOBLpBQ/mry7MNw0Iw1etZ
AqWmVxniddRE1OZHujAulzbhtni8e2diQejNWUoUsewz4xCm9nBUaZ/MOwOG8l8zPRRVDpJc
NPtyekX79tnL80wJJWe/f/uYBck1buhGhbOnu++dU/Dd4/vL7PfT7Pl0+nL68t/Q1pNV0u70
+KpdNZ4wYPPD8x8v7sLuKLnOyqe7rw/PX8e2wXoFhWIUF1YLnSja0M7LYpTbzED3P1hoQILZ
g8+gpwNA6z0bZuz1vW6pnu6wFPY8GbBJw9wGWL77gPF7msWP306z5O776a13yNbrAVbb08uX
kxUwWC8DmTd5lnDCmz5GD2JpV42QM1Wbc2mmOF6sP823nb2qW6w3hlgVxXdfvp4+fg2/3T3+
AqfgSXdo9nb6n28PbyfDKQxJx1fRI+P3Psr0qC0eCbrsYvaYZZPVenqSqgSGAEtJqQjl361i
CzIm2xi+Og9Z/bQ7Ky/XziJtgSMuOyAwZXWZJ70ZEo6A7je74WulLodQd0hrc1rmtVVzg1Su
Obe9Fuet3YPSD+uKjWurt3G0V1HsCipxXrXqrM1MJ8/u9koG/r8U61FMaXGLmlo6NdihVmjt
NmyrUOqrF3sO9NVZa3hFa9HwJt3KZgsyO7rGxFNrBYQT+G8f+3bJicN3YDWBPLSXQdlmo6Mt
zg9+CQuodD4xLjcO71ZRZXjDVh6rmvVRMYsI75ap/RdCb+GDo7uOo896hI68QZc+iWpcXoG3
Whw59yNNokAYgz+Wq7lzoHSYi/X8wq0a1cYGxj4ypiTs6V/8+f394R4UA33qTTC7HTECyfLC
CEIiknu7/zqtxT6orVBSlb/b5w2fk6Pbj8vWipOoDRPtsjsY+2EcsRY7twV1IdI/m0oUhD/3
MGHZ6hlwWS0uFwvuBs3gtzgX1IrcgHfhUikdEtOtWqeL2RzpWVN9fz39Ikzsi9fH09+nt1/D
E/k1U/9++Lj/c6wnmSIxMH4hl7ohq6Xnql3/39LdZvmPH6e357uP0yxFPjFaF6YR6N2WVChH
uT1uDSc67BPbuolK6PLAE7pRB1kJciGW0rDWxaFU0Q2cpqkVy7gFG27JTCSQg1aS08wsPajV
e37bUEx7YJBo3SZg9z/QLfDzaSkGsSrcCf4ODrGHQHFnOaL8RNCTTTdUblMo0AZi/lILIIJL
K9ISgPY6g4k1uBpcY6ADG1arnXAh4U6uYbocSnwCwUvsWlnWY7oJNztWx0XcTt04vWqtQZ39
iqi04gLApFGqKmnNbwvpJZc2UBmIzd/Vx8P9X1xk8PaTOlMYwR74Zp3aGXxVUeZm2XCNUP0i
G1U2vXDcyvWMUl+zHvNJC+NZs9wcGWy5uvI4sDUl3bkeHbT+TR4yURs3mVIYmMmmMnyvMUGJ
fDFD4WJ3QKfXLNbX6iayXsQ86+nPfL9aWDHWDDSDI3Z15btgtVxj7lUHevCsWBimOSJdL72N
03wNXW2sN1rdLczOx728amQ5n2NQggunsChZrLz5cm4b72iUzuvMWQoMWM9psI7QZz3B9+Ar
j5MKe/SchqnWUOjN1Wo5LqyFT91RaRo7a6mpBFOZX7jtBeDKG1GuVsdjd6vmfrBaUYf/Abgc
9xrArPDcYjer+bikNqW6W9KEzcYwILZRBYVPGzX0VOvl5Nx06aMrv6rVqGEmgdvUt326XBe4
ctdN6IuFd6Hmm5UzF5aNjYYMOZvd/gaht5lPj3e1XF0tncI6Uxm7NW1SUAdaCR/zCTolVIlY
XWHgIxvMZVUliCs+2nZHMZELtd93OhaD/dV1FXprNkWpRku1XGyT5eLKbWiL8I59EI/hmNN3
Mr8/Pjz/9dPiZy33lHEwa22Uvj2jpzZzLT/7aXj/+Nk5KAMU6dPRMlK3aJ871fY0OZZRPPoI
k2ZPjyKG5gxuK94uwsychLGs220+VXeXrHLc5DhdLmwD2X70qreHr1/HXKK9GHa5UXdfXEkn
P7iFzYEp7XL+mskiBH31+sdUu8gvqyBiH/8sQtZY1qIQrE+2ReKLSu5ldTvRc31aP7Go7p5/
uA5/eP3AC5332YcZ5WEtZqePPx5QIsfoH388fJ39hJPxcff29fThLsR+0EHxVuiMMNE0k45v
Aln4GbUMtHBZVFnxMpwP0RIpm8CO8qSghatSMkBvae6qTsK/GciWtqHUANVbBc4VTgZ3qUxd
E+VEx6ILdYBXZEoLXXWbpu0HBYP0NvSXILXFdYp/FX5snALGRH4YtnP1A3RjkFueLq12tuO4
i5s0/iaE4hgHRI4gGHkxl+RKBc6ti4m5AdSKoNj9SsdIlGHKOUUSmr1xZin2SDo0An815dF6
DNYwJTm3ddqbIqf+Hy6mEdY5PkL/g5FUZcGXr6hxC0GUVakmESDW643MT6+mgHL3bNrOCASQ
BoQKfDNUoqyDYflo1OjZtawEeinREUCQ1izY2YQhb186RywDUEG9Hb9zqttMoIuQpa6pg4Yz
fTDFNGm+jwbPJ1o/YrtgPWxAHUMCrKGgXlsEioy6ilJ6V+M0vvvKr4/dxSkxM724uKQpvmUa
Y5gnKfGu13qnrxbr6yWbF9AvtXtZocN9DHcorb+/Rv42d8BlrkdxRS5XNMLod3AyKeU8LvWE
eLmL9uRB0uSsZQYlyGgfCEJrmmxnrE60X5D7UarE1Drl7pbcWAKgwDSzcZTJ8samDDHiD4fw
qYcwAmBPiFwtbSrMEDkYtxIEsDX7hhhgW4WhRgIBfFyw1+5YYFlTNRxB6dZOgrCVltkx/oZ1
LHMn4I1NUEzcOmlkCjuOx8qyzznHNNgEm6EHSRt+Jo0yTtbZhwVNIwC/8NrOOoi2Ys+tnr1+
xZF5ldB0YeZpB3mhDXNJsDnDmBoYJjF1yJzmaRia3anWwqRl6YMFxv3by/vLHx+z3ffX09sv
+9lXnY2Velr0KV/Okw4DEJfRbcAaF4FmabN9geGcrDsyA5nkKD3aiIr6mJOfo+Y6+M2bX2zO
kIGqRSnnoypTqcSZhdJSSeU3owyGLa4QySWNt0LAdPVT8JrpOyLYu5gBv7Gzd1AEZ49P8Rv2
w3R5yfrFtwR+WiQwODL35nMcglFnDEEhvOW6xbt19BTrJVLwJ7Ahhf23YaOiUDw3AMC+J3KP
9QRqsU45f6qBYL6Z6IH++OynGzvqC/luMxGeaCBZX7D3GR1B5W3m46WFYGbFafAF1xREcAEj
Kf6SLY8GYujAabr0/GoE3yYrdn36yJNkvvAazvOHEElZ5g0NT91tPlyq0ptfixFKrI+YDz0f
IdJCGN4zak14s/B4y5uWIgOiqvG9BXvtZRONK9aI1OYtDmqx5tS0gSjxg0Kw+w12rB9y0NCn
odgHeMoMDYBrbsTQ9vpmOYKrlTeeEpQeuvPQxW281ap9A3GHHv45+JXYhXnMTg3+g0Uv+GRD
YzrLq5FBM6uJotfj85mg18fx4h/Q3nw5HnKC9s42bWlFVx+jV8y2J+gj27QEh33t0RSnNu7y
uJz8brNY8/tFY68WEwmiRmTnNnm4R6KF9azn4thx6XDj5Tng+Na3WPZu3SZqQnbXWkyQt3hl
uCG7/gkvPIeXHt+XHn1OTIBfVSRIfzhO57xQ9ue9G7Xfwd9m+nFzMWdWXwxi1K4Ix70CJeDI
dUeKwpw553jrTZD7ZejNWQ77qVyen5DrCP3GsoreNXTDpK2XNQOexjF1trjwrCRjiOBQPiNR
djTh+JRPnQw3PRgHhOcr6xWbU5YS2DGhCWY9556GCMHlfDzdPZvil1KmWUTIPt9ZJDynLKtw
NZEapONKa++MUJZK6hc7VAgaHvBKpkJtzvcjJQAY23ixILfjWSDDv6/N/1bUFeaYOSdn8zt6
LDMp37okdKZtej6nP6yY4wTAZV5XRpEl92QgNMz5RAomNsBq/KyiXk93f317xZv9dzT+fH89
ne7/pLroBAW5OTOKpsmCNKrAf/7y9vLwhVq9SDdQcBdduCUdF63PI2aJxKrZFrEf5DkRjOtM
qlulCt969DHPUY1IrptjkqGv9PXhc8nfEGOMii2bM0qr+Hla5FmU0diYBoEPEzbIujXQEO0u
7sBCSQPsaJAJxjLcayOMt5Ur5MWyTzgU373/dfogJtuDI7iN6b4+yqTxj1LpeD60xq2MkjCo
dQgHdpCuYWNMBYK9SSau/eI8CbeSvbTb+fsIZ4Vo+sm1jiOe59d1Qa47W8KmwLhbZWRdDbRz
zMHaJ3drUQB0p0LOQId8l/rHqwv6gk5w5fXGOQc6jJKr5cXCOfUocjWhGhMaalViYy5c5k5w
E2mrCZEIRXQ5nzjKKdGVx3db6GQEjSgmtpjy0kItftDBJBe7zLcczAm28JPUVzyKGi8Q+F7w
rQ3Cy8XGkZ463FYeo7DRKtuwwg6qkJk2z2rv7sTjy/1fM/Xy7e2es3nEF+Ym3xJbRw0pyjyI
rPWsSuHUpe20MJIkbORqfRHQNwC21v5DXyZBTswOisSvtjlGrNvVQ1fRoqv0mzSggaXab43p
4vBsgFfCoOpI6/1JA5ng63pcytPTy8fp9e3lnjN0LyN0l4RREOx5z3xsCn19ev86HuWySBW5
ztQ/9d2+C9MhX2LbN9bFIMB6ZNJ4cx3NN9ZqFGFRGEfjIMuxD42Cbv+kvr9/nJ5m+fNM/Pnw
+jNyz/uHPx7uiVGfYZNPjy9fAaxehDWSHWtk0OY7ZMdfJj8bY03Mn7eXuy/3L09T37F44650
LH7dvp1O7/d3IAvcvLzJG6eQjgXUUogmymITPLAv+kcFGFuE/0yPU20b4TTy5tvdIzR4skcs
ns4imseOpvD48Pjw/DffQeCcEuSIvahp97gveknqHy2Ifjtj2o79toxuukOo/TmLX4Dw+cXe
ay0SOOy+C9GaZ8YAgH83JfRFVOLBga4S3PMlpUSHEgUMmHIfSoAmCSB6iYnI/7QoXykQ/cev
tm0vR1avw4A00d6yLImOldCPhLqA6O8PkFU7X71RMYa42SofmPrcLaSzcOyb3IJBBlhcrC75
wEMDzXK54m58BwJto0YHj6I2F9zT7ECB5mujBrd8ctzkospW/G1qS1BWm6vLpc+0RqWr1cTl
fkvRuXXwpulw7pd8VBTJKqdZRQwD4AfmKrYBMiSCNAKM6X9FvTkQDHw7Buk8tqFVnlt5MTQl
LHq2iW39I9cYi0AbxbgscXjWTCPXF7xbxFR0gR/48m/7uCFw6kUOcX6VRkmzS0A806U9USQ+
GW8rByhvQG+f+zZQm6dqodaqWVVpwe9dxFYHLt5di2kjpRhf/vJGp5hhnPnLG5R2aL0+tFly
lhdo2gGyC76104Q2btl90QW6DjpuRlp1bCr9lMHthTJC1y74UZV5klDPXYMJSpEqmHD4JXTM
JiLdIF7qyOIxZ/NjCDDwtDbD7HS0Ync7U99+f9eMYBiY1izAdqoiwDaCuIUOBGbpyXztJqa/
HOYYvsBAOhgOoMrL0ljwMEi7RIpRMipLn/9K+QkN14EoXHsyPW7SG9uBwLT9GCVcDxBZHP3G
22Sp9lmjc2chsYv8wsTy/aLYgVLepGG6Xk9opUiYiyjJKzTOCCeixyJVlxthXGe7Bu057DuD
3FH4RFeVIfBhmX2yIuSmwrJvSsVUTAfEJEXvKl6c3tAj+O75Hp10nx8+Xt4444FzZGT1stek
6DDYVTfc3HT7NAvLnAZ/awFNIEHSKGH/CWtbW1g21ZhTQBey4l+/P6Dh6X/8+e/2j/99/mL+
+td01UO+NCKO9VdKnQDiEy0o21u2k/rn+DxuwUUK+zj005G8sjvMPt7u7tFTfnTYKXoUww/U
CKu8CXxnoQ8ojCXN3Twhhc5xZ5cH2kcp8L49UznNVURwvUWyW2GL36LHNSf3mZOtsoJCdbCJ
Bduj44p4APVQxUJhqzHQopIMdHAt7+K9jEe/+whvBm02ozXhAldLgzEJmA7gN00alz2xsh3k
XLzYW5ysR7fKgWIteHsqWOwXc10BV0bqi90x984V4mbSaFsFMnL0mUvR0DarwK0m8hqUBM5o
UxddRrGV+C/fWnB7RMJtMuoCwJptOjnIiPa39bgg/bYxxBVW9uCAXNYGt2kyJ0oHIWlDPtn2
7wSxqwO31Bbj67haE8UCF0+tpjUqiEYXpwDOBSvO4LsbjPlxyBZIHW/HPob1sfHD+PLKs2T0
FqwWF3Pu1RfRbcetT/DaieVlXBuIzpUXhJ8pSW+c8BfKW85Aq0SmAQ1iiABz9yKqMrG3dSnc
APKjx0MQaJub2g+tJCxp3rrpd/aytrpn4t8/4HuF5tFkWPc+pm+r4ORTaNmqqMwHIJmnlIOD
vuMBeKi4BTRHv6rKER3IAApTgohkjFKRqEvLWwMwS1M41a+WVjlTWtiSFskreRcNtddvAVYL
aYEXUwXaRFO6yacgtEIw4+/pmO+qSQMBBxw5vMoI7dMBYw9IDwZiwXvg9CR41YjG6bxaSiow
s8f1YlT/p6nJIHgys9Z3077d+ivM1IGet5xodBw1BCE3dV7xj+DHHzQT8aXlbISQPMPkHsY0
f+IjJ/cBgnwF41g1W7+yNaJ4q3ChMwXlwqCGbdRBmtwTlgN4j+ivkjCuMR7ObL97chxNXqI3
JG2WT19dJzk/J5SO7UVQjZdnBzs7+D2RXsP63Ivtk6CnKOsM1I8MkH2aF6euqT1lsGZuuIKj
LToXWYlbMpm080K5oac/4F9G0aWUDUk/cfLhFYl9CBlIG08ht4MVojsBPgth+ki+ElA+y9vC
zklsgUEGipWFw07Toe5Bo7QePSKoJbBqmAgZZz6Ge7FKZJxADIiViDVGL2ZShu+m0NEbmxap
Afh+rF8rNKfc8nK6Djn2f5UdyXLbyO5XXD69QzKxbNmxDz5QZEviiJu5SLIvLEXWOKrEskuS
aybv6x+A5tILWplXNTWOALD3RqPRWBr6hZcnmtG3BBsdlcASpMR+Pz6M47KeD0yA8i5NX/ml
Mr0Ya29cDLV9LWEaaFxhvGb1KQ8DBfWG89IHQGMOMA+YlI2HYczbENP71IEasJoj8KKFR9l5
oihdsKR4f1yymFhAd9Oss9/3V+vvWnKkwjjAGoDkRLp8KRFT4PbpJPc4Z46Wxgqe1SLSEWoR
ajOiYjukSIPbR6u4h7qN/HuSrnnaG6TstRyB4HOexl+CeUCilSVZhUV6d3NzoU3bn2kUCu3c
eQoxrBenfAjGLStqK+crlO8EafEFTqAvYon/T0q+SYDTmhMX8J0GmZsk+Lt1ZsDMfxmmehle
feXwYYoPkAV08Hx7eLu9vb77PDjnCKtyfKtyQbNSCWGK/Tj+dXuu6p4Z5tyKwKdGRGqQDpuP
57ezv7iRItnJUEUjaOa4KhMSNZtlZH2DQ4ahNsMy5YQsovGnYRTkQuHjM5En6lnRqmK6ewH+
6Q/gVt1l90m5+KCfCa1ucrDjDzVgsos0n7noWqpIaQv86DKKMzOP6Hbp1LB0NH2Sivt6xRkQ
6iRfr52f37LPOwbJ5YnPuccqg+Sr3usec6NZhxo4zvTDILk88TkfxsEg4nxoDJJrZ+NvnJg7
Z7vurvjU5DrR7+fkTrVh1zHDOwfm9utQxwAXxVVX3zqbO7i85hXhJpVrssiHlK91wIMv9VFt
wVc8taNH13whN2ZHWwT/KKtS3P2WYuBecR0Jn8FcI+FzciHJLA1va44ZdsjK7F/s+TUcf2wa
gxbvCxBUfX0cJRwkxipP9aEkTJ7CtVMNydhhHvMwikLf5BeIm3giCvmUDh0JyJP8/bylCH2M
BcnbI3Q0SRU6nl3VIeGTMbYkILLPQjUIFSL0IziI9BTNkfvVtUpCX4tk1wDqBI0movBJJtzs
3h+Uw0nTQEmroM36Y789/rLd0mfiUTt98TdIsg8Vhp0kMY07SmWcbphtpEffVvWyJW9FIuDK
roMp5lGUqThYB9JGqYE+zwW9ZpZ56Gui3EltUYt0XSXhHog3I/kMwT55QNN8ujlhqECZXUmR
Djg0RgCZ3p9/OXzb7r58HDZ7DGb7+fvm57vydtRKWX0HPTXaSBHfn6Ph3fPb37tPv1avq08/
31bP79vdp8Pqrw00cPv8abs7bl5wGj99e//rXM7sbLPfbX5Sns3NDh8k+hlWQrydbXfb43b1
c/vfFWIV4RmkJewU3IqTNNFiE0x8EKmiaoI30jKvQOIS3swdp4cnHz3mgjd4OEEPFyhOn0Ft
pbs2XNbVWDK/TAp8itAJer0zPx4t2j2cnT2VuZU6HVWaS/2CeufEnZB2d7n9r/fj29ka42K/
7c/kAunnQhKjKkFaQ3LgSxsuvIAF2qTFzA+zqbqcDYT9yVRL/aIAbdJcc/vuYCxhJ8a+mg13
tsRzNX6WZTb1TH0/aEtAG3qbFPg6SCR2uQ3c/kDXqujUGLDJG0XCzJbcUE3Gg8vbuIosRFJF
PFCToxt4Rn+5a7XE05/AHtuqnAJztuBqKNHs49vP7frzj82vszWt1hdM5fbLWqR54VnNDaZW
0cK3qxM+S5gHmhNN05Mqn4vL6+vBXWcf8HH8vtkdt+vVcfN8JnbUStiHZ39vj9/PvMPhbb0l
VLA6rqxm+35szwkDg4sw/Hd5kaXR4+Dq4prZYJOwGKjBHNutJB7UQMRd96YeMKd5O8wjsrHG
Y+Jgt3Hk2+0Zj2xYaa9Cn1lzwre/jfKFZskvoemYU8d3i45p15KpD075Re7Z2y+ZdqNprUwM
XFFWsT1uaK3ZDtp0dfjuGjOQv6yPp7HnM7tnCR1xd3MuP5LKnu3L5nC0K8v9q0tmjhBsNWK5
ZFnoKPJm4nJkkUu4dYJg4eXgIgjH9vJly3cu3DgYWoXHAUd3XWeZ3cs4hKVMVlU+s4LyOIBN
wTuC9BS8g26Hv7y+4Yu+ujzxYTH1BvZuBCDbDUBgNQwYAxsw4Ctr1IqYgaF6e5RObB47yQd3
dsGLTFYnxYPt+3ftKb7jNfYmA1hdMkJCUo1Ce/V4uW/POsgqi7F2XzEQjcMKMxcYRw/ubA7H
2JamKPmLqULAOgM1p4mw+zGmv8yenk29JzYgXjsvXlR4aiB0g88zbFzYByic+5lm0ditBHt0
S2EfkOUipQF3wNvxbpfD2+v7fnM4aPJ6NzjjyNPTE7ac/Yn1w5XI26HNoKInu/EAm9p75qko
O1PbfLV7fns9Sz5ev232Z5PNbrM3bhbdiizC2s844TDIRxMZ9cisnzAN++YwkuOZXSeczz6w
KxRWZX+GGL5RoClu9mhVKMMoMvJ4i+BF5A6ryNxmezuaPOGfhk06lOpPEVqP0bbYTnYKxn3k
5/bbfgV3ov3bx3G7Y07XKByxTIjgHGtBRHOS2YHHbBoWJ7emnbHbIuG/7gTH0yX08iVXCseD
EN6eriAGh0/ifnCK5FT1ToGo750ig3JEjnNsurB3jpjjSThUgxsrKGngLx2AXVgpzVvbrsNj
Yy6GXGRLhdSfiqgwIgFIUB1mhUBdHFqHnFrnWIztNGfTYIz8pS8iR6N9Hw7r39XjxZSMtp4s
OZWEVzzGsUANFSm3MNmE8lDdI7NqFDU0RTXSyZbXF3e1L1AvFfpoIWaah2Uzv7jFB/c5YrEM
juJrG/nQgaU8MjOhpb5BSwOBaUylDQQZamAbDF95ySw2+yO6jMHl6kChpA/bl93q+LHfnK2/
b9Y/trsXxYgwDSrMlBGS0u/+fA0fH77gF0BWw+3yj/fNa6cak89fdYl5M6XaMNfMCWx8cX9u
fi2WJZrG9uNofW9RUGC5++HF3Y2mP0yTwMsfzebw2kZZcp9PkCVu35X/xQi2TR6FCbaBrCzG
Lb+OnIw698Lgps60iCEtrB7BpR8O05xzOMet5uVAm0xUBo8+LdoUjEKQbDFkhjKsrZsICL2J
nz3W4zyNDeWIShKJxIFNBD5Vh5FuRZDmfJItzIgr6qSKR1pEKqlSVhOcd24sfmjaV8J1CrY/
HPwaaHCjU9g3LuBOZVXrX11dGj9VnbwOBx4gRo+3uiygYPi3nobEyxeeIwK6pBiFvE7Ivxlq
LdR/KbHg4ECx77a+ouPoLrPKIkuCNFb6zLQApE4KX5HLUNQKFO3BTfgTHmsgpUTaFn6Sx7EB
BWGXKRmhSskK9ZClBlm35qm5UlAKZsgJzNEvnxCsjpmE1Mtb7vbTIMmpR723NvDQuxkyZXls
hrQeWU5huzDfYbwSbo816JH/J/ORY5r7zsPYxcrtR0Esn1gwzJi9bUnNrydQK4GFFwJz1nKw
ehYrEagV+ChmweNCgZOt29yLpIGacoYXqR8Ca5kLGMdcC4Dskdm26swjQRTSWGM3CA/UIUkE
5hmkcMyY1x0dV3QcIqAIEunV5mC7ESdjpNc3Q9j0ypDGaHXnR16O3jlTutXoWIqVmxoRoely
YZmAaQhoLPdYNonkNCkMI6vqXOt88KDy5CjV1iH+PsU7kkg3eO8WB0X31hhb9FSXnqLqDPMH
FLCVyuMslFG+25aFsfYbfowDZcBSyrU+gXM9Vy0506TsQoi/atDbf9QjhECUGVhEmq9BgU57
aWRMKy6SDL2+tNtmhwJMLnBJ4K7BeJQRCG8MXSVj/tfjCLNi6baC9NAXiCxVGwMrSJsvYAmx
+lCfjv70Jsq1GR9kkwn78GwJKPoTZSskEvR9v90df5yt4Mvn183hxX6aJuFnRlFN7jVbLwL7
XsQ7EvnSLa0GuT0CkSXq3pq+OikeKrQWHHbrpBGkrRKGyu5oclK7nu81fN0ko+2kxniU4n1A
5DlQaZEqnMPS6YS2Pzefj9vXRmg8EOlawvfKIPYtpRaY/gkNUiT0WhVX+NqPZuLK8s2haWTb
qwVexunPgC+i02KsSWy58AIqDZCsmDIV6FqN1q+wENkn3obXwG5B24Y4LGJPS7VnYqh5lPNW
41zSmD5FR8MFvipndmKTXir/t0MqQ12hpmu7btd0sPn28UL5isPd4bj/eN3sjqovlYdXR7gk
qHHbFWD3Ri2n4f7in4FiRajQgdgceu4BUw0WKVCVPA4ngcLc7F/mG2UPwzd0Cm/G4RDRMIH7
8/lgPLi4UExFiXAWcA9JPYsaFV7jb4Dxur1Is+UkLDtV/2rw9ZFB604R2YsDTTStK25jG9CV
q7AiZAcgOYikCPXEAE1OYMDTQcjdV/DbdJHoOkCCZmlYpAnvdtAXjE4UdpXSMptT99EKaLoP
pwbaVdiftxj3JiSjkAoZofp1AVwiaJCY7d7yjzInW5Y2j+tsUtIi/6XXM4/txgE1vsM5rI86
mnxkFwbVwCVBtUdyN8BsI8hGlccslgbhbIqMPELWJ8zSkLwHpbnfTBYNKroCjDW3gZNI36cO
zDzcUZaqUYLp0/uBZQPTr3OjqqnMMyHfQJHoLH17P3w6i97WPz7eJXucrnYv2jGTYfokZBxp
ynZUw6M7ZCX61B5oNlNhbvUS1rQq8RfpuLSRvW8S8CKQV7xYJaSaOFclJ3HXHGXusLJ6ivEY
Ss+Rg2vx0IW4ZqojhZusRXcZPTWg0loPjqHnD0rCabMiuQEN3xoJbHT7+l5lPNRaSyamGn0l
oOg1EyLTVEHNsoZrUpx1+dyxJwpD/s/hfbtDGwfo5OvHcfPPBv6xOa7/+OMPNXdX2mY/pXib
fVoe1a5/zvpmdRRUBvbRuTvxMlbBtU9YPEGJt6fv547c2MuLhcTVBWxCNPpzV7ooRGxVSI01
LkwIA5HcrqxBsL2WFG2Ko0icJGuGTz5HncgYRK2DDYauZ0aQvr7jTLiL/2futZsIxYBQKkFZ
DkYHs9vCHRgWtNQuMYeXPPysA1zurR9SPHheHVdnKBesUcXKiMQOp6ZmfSPWWjATuy3kUxca
wYR7BoUndVIHXunhJSCvMlO5bjAGR+PNWv0cBigpQSi0M1DlfsUxDmNme7HdrygslUuvg3h+
VSAGjzaS5olZpFV5fznQy3ZF+kCceOhdffugh1r7rT340Ej2OSPTa5TS2ROkNnzIceRa9ECk
8x/LlMu0i7nlqfHKeUTH9bhK5DXkNHaSe9mUp2lvh2NjC8gCCFjHFJIAhD/UhBsk6AFFY46U
IEUmpXkD8JsPZSmKuiyXvs0a26ML/agaj9WGUrg7ojcS+iSoQ2tCoVnds+hbjY2D0E7GZo4J
Htu4tuyinfPwmymwRr83D28/bLKMcfoFKft2ZXbfgtAEcsW4wbDLrTk0T5HIk9wmaOd2AUvW
7q+c1WZVaAeXJK2LBMRPI+NoO77AZWEimx5bZuAt3EuA03n4ICY/cAWyaslhdXKEbaXRjJ5X
w7S2JmFGEWzl+uMrqVwU+niYO0h5tkvK6akK0Cm1y/DKUsga5B6RobbcZLRBTz7DKRuwpzM3
rUD1NGoAmyyCxuT3J7OBKD1g3pnBu/vdbVF0jVdpSJptF9hvesDX2Cz+kNQe6O3caQ/bWcHQ
9+xqUS5qFBcrLEiKWvSh/97f/t7s39faudevyczv7LIXIs9591Agkki1yThxcsODKFZO72+G
erEixvTV8kbsWEvktJPhPUFVm/KrFgNDw8BpUlaDxeCQUlXLlqG1CscY7zgUeOJEPJAlnytZ
iuQqgxlhGgZi+BprwAHw8ujxRBVjL4xqK+2fUkBWBlWcaSpQay5VNXK5ORxRzMQ7k48xaVcv
G3WyZ1XCvoO2clpNc9zsWTPYFLIKN7X6RlPKYFAc1at1DDmrbByvOUQYSeVPe13QRzT2ZqJ1
0zo17q1U5qDRaj8VhKTbgTM/VfIgN+qHAvh8Om84hR6PD+k5dgGMmc50aL9M46AmP4xmQam9
2RUyBAEsavXNheBxmFA6U+3QEw0t2215vhRqwBNedm+vKLTh3HT5CN8MT+DpsS+NUoz+7tj7
2vOjxYhBPEc52/Ft+xbGHAE0EFOxpC2mj1vzjCM92ArjE0AWvmoNKa2HAFyqobgI2tmoqMDu
UUmfEwBTigeXuqSqQi1lCwGX9PDKH6+Ib7VirkJzNFqQqj99CMiYQQeFgWd2z3gOk4txFlvN
hL7xmi/CzmO5kfVyyLSTwn3o8FE2NiFoYjTFVyst38c4TDAcZalJDXq7xmFOyaRdLWuiKRgN
oyPaWjLk/Ej2VzpmFqeBuS9F7IOomhnD2b0mGpu1JIsjlnO3xZn6VQDZe0734+MPC8vZTz5M
/g8ijH9lqh4CAA==

--YiEDa0DAkWCtVeE4--
