Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB1AF38E580
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 13:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbhEXLdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 07:33:51 -0400
Received: from mga12.intel.com ([192.55.52.136]:32765 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232603AbhEXLds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 07:33:48 -0400
IronPort-SDR: if17SuN1z2QEqDLH3ZA+OWjMODMP2Mqadm5NYQFV8prBfH9NYMzfu4ZOGD9qzKKHjQwhZzN/3z
 VIDzp6spBL0w==
X-IronPort-AV: E=McAfee;i="6200,9189,9993"; a="181550920"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="gz'50?scan'50,208,50";a="181550920"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 04:32:18 -0700
IronPort-SDR: EdViFerUKHect3xypJupTvVbdr+/fYoE6xbTEA40cS9ZL0QGF4pH6cz7Uff2/cUciO21UXM97f
 DrnVfYql1rjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="gz'50?scan'50,208,50";a="413556799"
Received: from lkp-server02.sh.intel.com (HELO 1ec8406c5392) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 24 May 2021 04:32:16 -0700
Received: from kbuild by 1ec8406c5392 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ll8oh-0001CO-GQ; Mon, 24 May 2021 11:32:15 +0000
Date:   Mon, 24 May 2021 19:31:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Maxim Kochetkov <fido_max@inbox.ru>, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        Maxim Kochetkov <fido_max@inbox.ru>
Subject: Re: [PATCH v2 1/1] regmap-irq: Introduce inverted status registers
 support
Message-ID: <202105241903.cPlHYPIn-lkp@intel.com>
References: <20210524045837.8398-1-fido_max@inbox.ru>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
In-Reply-To: <20210524045837.8398-1-fido_max@inbox.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Maxim,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on regmap/for-next]
[also build test ERROR on linux/master linus/master v5.13-rc3 next-20210524]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Maxim-Kochetkov/regmap-irq-Introduce-inverted-status-registers-support/20210524-125907
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next
config: microblaze-randconfig-r016-20210524 (attached as .config)
compiler: microblaze-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/0592cd096312150d005b37a78a5a1fa1763561b5
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Maxim-Kochetkov/regmap-irq-Introduce-inverted-status-registers-support/20210524-125907
        git checkout 0592cd096312150d005b37a78a5a1fa1763561b5
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=microblaze 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/base/regmap/regmap-irq.c: In function 'regmap_add_irq_chip_fwnode':
>> drivers/base/regmap/regmap-irq.c:808:8: error: '*data' is a pointer; did you mean to use '->'?
     808 |    data->status_buf[i] = ~data->status_buf[i];
         |        ^~
         |        ->
   drivers/base/regmap/regmap-irq.c:808:31: error: '*data' is a pointer; did you mean to use '->'?
     808 |    data->status_buf[i] = ~data->status_buf[i];
         |                               ^~
         |                               ->


vim +808 drivers/base/regmap/regmap-irq.c

   610	
   611	/**
   612	 * regmap_add_irq_chip_fwnode() - Use standard regmap IRQ controller handling
   613	 *
   614	 * @fwnode: The firmware node where the IRQ domain should be added to.
   615	 * @map: The regmap for the device.
   616	 * @irq: The IRQ the device uses to signal interrupts.
   617	 * @irq_flags: The IRQF_ flags to use for the primary interrupt.
   618	 * @irq_base: Allocate at specific IRQ number if irq_base > 0.
   619	 * @chip: Configuration for the interrupt controller.
   620	 * @data: Runtime data structure for the controller, allocated on success.
   621	 *
   622	 * Returns 0 on success or an errno on failure.
   623	 *
   624	 * In order for this to be efficient the chip really should use a
   625	 * register cache.  The chip driver is responsible for restoring the
   626	 * register values used by the IRQ controller over suspend and resume.
   627	 */
   628	int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
   629				       struct regmap *map, int irq,
   630				       int irq_flags, int irq_base,
   631				       const struct regmap_irq_chip *chip,
   632				       struct regmap_irq_chip_data **data)
   633	{
   634		struct regmap_irq_chip_data *d;
   635		int i;
   636		int ret = -ENOMEM;
   637		int num_type_reg;
   638		u32 reg;
   639		u32 unmask_offset;
   640	
   641		if (chip->num_regs <= 0)
   642			return -EINVAL;
   643	
   644		if (chip->clear_on_unmask && (chip->ack_base || chip->use_ack))
   645			return -EINVAL;
   646	
   647		for (i = 0; i < chip->num_irqs; i++) {
   648			if (chip->irqs[i].reg_offset % map->reg_stride)
   649				return -EINVAL;
   650			if (chip->irqs[i].reg_offset / map->reg_stride >=
   651			    chip->num_regs)
   652				return -EINVAL;
   653		}
   654	
   655		if (chip->not_fixed_stride) {
   656			for (i = 0; i < chip->num_regs; i++)
   657				if (chip->sub_reg_offsets[i].num_regs != 1)
   658					return -EINVAL;
   659		}
   660	
   661		if (irq_base) {
   662			irq_base = irq_alloc_descs(irq_base, 0, chip->num_irqs, 0);
   663			if (irq_base < 0) {
   664				dev_warn(map->dev, "Failed to allocate IRQs: %d\n",
   665					 irq_base);
   666				return irq_base;
   667			}
   668		}
   669	
   670		d = kzalloc(sizeof(*d), GFP_KERNEL);
   671		if (!d)
   672			return -ENOMEM;
   673	
   674		if (chip->num_main_regs) {
   675			d->main_status_buf = kcalloc(chip->num_main_regs,
   676						     sizeof(unsigned int),
   677						     GFP_KERNEL);
   678	
   679			if (!d->main_status_buf)
   680				goto err_alloc;
   681		}
   682	
   683		d->status_buf = kcalloc(chip->num_regs, sizeof(unsigned int),
   684					GFP_KERNEL);
   685		if (!d->status_buf)
   686			goto err_alloc;
   687	
   688		d->mask_buf = kcalloc(chip->num_regs, sizeof(unsigned int),
   689				      GFP_KERNEL);
   690		if (!d->mask_buf)
   691			goto err_alloc;
   692	
   693		d->mask_buf_def = kcalloc(chip->num_regs, sizeof(unsigned int),
   694					  GFP_KERNEL);
   695		if (!d->mask_buf_def)
   696			goto err_alloc;
   697	
   698		if (chip->wake_base) {
   699			d->wake_buf = kcalloc(chip->num_regs, sizeof(unsigned int),
   700					      GFP_KERNEL);
   701			if (!d->wake_buf)
   702				goto err_alloc;
   703		}
   704	
   705		num_type_reg = chip->type_in_mask ? chip->num_regs : chip->num_type_reg;
   706		if (num_type_reg) {
   707			d->type_buf_def = kcalloc(num_type_reg,
   708						  sizeof(unsigned int), GFP_KERNEL);
   709			if (!d->type_buf_def)
   710				goto err_alloc;
   711	
   712			d->type_buf = kcalloc(num_type_reg, sizeof(unsigned int),
   713					      GFP_KERNEL);
   714			if (!d->type_buf)
   715				goto err_alloc;
   716		}
   717	
   718		if (chip->num_virt_regs) {
   719			/*
   720			 * Create virt_buf[chip->num_extra_config_regs][chip->num_regs]
   721			 */
   722			d->virt_buf = kcalloc(chip->num_virt_regs, sizeof(*d->virt_buf),
   723					      GFP_KERNEL);
   724			if (!d->virt_buf)
   725				goto err_alloc;
   726	
   727			for (i = 0; i < chip->num_virt_regs; i++) {
   728				d->virt_buf[i] = kcalloc(chip->num_regs,
   729							 sizeof(unsigned int),
   730							 GFP_KERNEL);
   731				if (!d->virt_buf[i])
   732					goto err_alloc;
   733			}
   734		}
   735	
   736		d->irq_chip = regmap_irq_chip;
   737		d->irq_chip.name = chip->name;
   738		d->irq = irq;
   739		d->map = map;
   740		d->chip = chip;
   741		d->irq_base = irq_base;
   742	
   743		if (chip->irq_reg_stride)
   744			d->irq_reg_stride = chip->irq_reg_stride;
   745		else
   746			d->irq_reg_stride = 1;
   747	
   748		if (chip->type_reg_stride)
   749			d->type_reg_stride = chip->type_reg_stride;
   750		else
   751			d->type_reg_stride = 1;
   752	
   753		if (!map->use_single_read && map->reg_stride == 1 &&
   754		    d->irq_reg_stride == 1) {
   755			d->status_reg_buf = kmalloc_array(chip->num_regs,
   756							  map->format.val_bytes,
   757							  GFP_KERNEL);
   758			if (!d->status_reg_buf)
   759				goto err_alloc;
   760		}
   761	
   762		mutex_init(&d->lock);
   763	
   764		for (i = 0; i < chip->num_irqs; i++)
   765			d->mask_buf_def[chip->irqs[i].reg_offset / map->reg_stride]
   766				|= chip->irqs[i].mask;
   767	
   768		/* Mask all the interrupts by default */
   769		for (i = 0; i < chip->num_regs; i++) {
   770			d->mask_buf[i] = d->mask_buf_def[i];
   771			if (!chip->mask_base)
   772				continue;
   773	
   774			reg = sub_irq_reg(d, d->chip->mask_base, i);
   775	
   776			if (chip->mask_invert)
   777				ret = regmap_irq_update_bits(d, reg,
   778						 d->mask_buf[i], ~d->mask_buf[i]);
   779			else if (d->chip->unmask_base) {
   780				unmask_offset = d->chip->unmask_base -
   781						d->chip->mask_base;
   782				ret = regmap_irq_update_bits(d,
   783						reg + unmask_offset,
   784						d->mask_buf[i],
   785						d->mask_buf[i]);
   786			} else
   787				ret = regmap_irq_update_bits(d, reg,
   788						 d->mask_buf[i], d->mask_buf[i]);
   789			if (ret != 0) {
   790				dev_err(map->dev, "Failed to set masks in 0x%x: %d\n",
   791					reg, ret);
   792				goto err_alloc;
   793			}
   794	
   795			if (!chip->init_ack_masked)
   796				continue;
   797	
   798			/* Ack masked but set interrupts */
   799			reg = sub_irq_reg(d, d->chip->status_base, i);
   800			ret = regmap_read(map, reg, &d->status_buf[i]);
   801			if (ret != 0) {
   802				dev_err(map->dev, "Failed to read IRQ status: %d\n",
   803					ret);
   804				goto err_alloc;
   805			}
   806	
   807			if (chip->status_invert)
 > 808				data->status_buf[i] = ~data->status_buf[i];
   809	
   810			if (d->status_buf[i] && (chip->ack_base || chip->use_ack)) {
   811				reg = sub_irq_reg(d, d->chip->ack_base, i);
   812				if (chip->ack_invert)
   813					ret = regmap_write(map, reg,
   814						~(d->status_buf[i] & d->mask_buf[i]));
   815				else
   816					ret = regmap_write(map, reg,
   817						d->status_buf[i] & d->mask_buf[i]);
   818				if (chip->clear_ack) {
   819					if (chip->ack_invert && !ret)
   820						ret = regmap_write(map, reg,
   821							(d->status_buf[i] &
   822							 d->mask_buf[i]));
   823					else if (!ret)
   824						ret = regmap_write(map, reg,
   825							~(d->status_buf[i] &
   826							  d->mask_buf[i]));
   827				}
   828				if (ret != 0) {
   829					dev_err(map->dev, "Failed to ack 0x%x: %d\n",
   830						reg, ret);
   831					goto err_alloc;
   832				}
   833			}
   834		}
   835	
   836		/* Wake is disabled by default */
   837		if (d->wake_buf) {
   838			for (i = 0; i < chip->num_regs; i++) {
   839				d->wake_buf[i] = d->mask_buf_def[i];
   840				reg = sub_irq_reg(d, d->chip->wake_base, i);
   841	
   842				if (chip->wake_invert)
   843					ret = regmap_irq_update_bits(d, reg,
   844								 d->mask_buf_def[i],
   845								 0);
   846				else
   847					ret = regmap_irq_update_bits(d, reg,
   848								 d->mask_buf_def[i],
   849								 d->wake_buf[i]);
   850				if (ret != 0) {
   851					dev_err(map->dev, "Failed to set masks in 0x%x: %d\n",
   852						reg, ret);
   853					goto err_alloc;
   854				}
   855			}
   856		}
   857	
   858		if (chip->num_type_reg && !chip->type_in_mask) {
   859			for (i = 0; i < chip->num_type_reg; ++i) {
   860				reg = sub_irq_reg(d, d->chip->type_base, i);
   861	
   862				ret = regmap_read(map, reg, &d->type_buf_def[i]);
   863	
   864				if (d->chip->type_invert)
   865					d->type_buf_def[i] = ~d->type_buf_def[i];
   866	
   867				if (ret) {
   868					dev_err(map->dev, "Failed to get type defaults at 0x%x: %d\n",
   869						reg, ret);
   870					goto err_alloc;
   871				}
   872			}
   873		}
   874	
   875		if (irq_base)
   876			d->domain = irq_domain_create_legacy(fwnode, chip->num_irqs,
   877							     irq_base, 0,
   878							     &regmap_domain_ops, d);
   879		else
   880			d->domain = irq_domain_create_linear(fwnode, chip->num_irqs,
   881							     &regmap_domain_ops, d);
   882		if (!d->domain) {
   883			dev_err(map->dev, "Failed to create IRQ domain\n");
   884			ret = -ENOMEM;
   885			goto err_alloc;
   886		}
   887	
   888		ret = request_threaded_irq(irq, NULL, regmap_irq_thread,
   889					   irq_flags | IRQF_ONESHOT,
   890					   chip->name, d);
   891		if (ret != 0) {
   892			dev_err(map->dev, "Failed to request IRQ %d for %s: %d\n",
   893				irq, chip->name, ret);
   894			goto err_domain;
   895		}
   896	
   897		*data = d;
   898	
   899		return 0;
   900	
   901	err_domain:
   902		/* Should really dispose of the domain but... */
   903	err_alloc:
   904		kfree(d->type_buf);
   905		kfree(d->type_buf_def);
   906		kfree(d->wake_buf);
   907		kfree(d->mask_buf_def);
   908		kfree(d->mask_buf);
   909		kfree(d->status_buf);
   910		kfree(d->status_reg_buf);
   911		if (d->virt_buf) {
   912			for (i = 0; i < chip->num_virt_regs; i++)
   913				kfree(d->virt_buf[i]);
   914			kfree(d->virt_buf);
   915		}
   916		kfree(d);
   917		return ret;
   918	}
   919	EXPORT_SYMBOL_GPL(regmap_add_irq_chip_fwnode);
   920	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--pf9I7BMVVzbSWLtt
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--pf9I7BMVVzbSWLtt--
