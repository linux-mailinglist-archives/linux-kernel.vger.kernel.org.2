Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 308E53AFE32
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 09:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbhFVHrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 03:47:51 -0400
Received: from mga06.intel.com ([134.134.136.31]:63821 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230272AbhFVHrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 03:47:48 -0400
IronPort-SDR: mQO4IfwIXcPGIk3wFu9OtsrOGorLMCcm84Of/iBBwqZzMJbS0tKOBJE/KC1yzPWE8h+ha4AZUz
 kep5z8TPE17g==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="268142112"
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="gz'50?scan'50,208,50";a="268142112"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 00:45:30 -0700
IronPort-SDR: FKBVSLTcTizwFOtcQJm7wbhV+nA7+utnDarZNcfzg0RFvd6nlD6eRloMiTEdclXlFdUgTpF9lx
 uamhrT3UVy+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="gz'50?scan'50,208,50";a="423226153"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 22 Jun 2021 00:45:27 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lvb66-000539-Gc; Tue, 22 Jun 2021 07:45:26 +0000
Date:   Tue, 22 Jun 2021 15:44:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Prchal <jiri.prchal@aksignal.cz>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Rob Herring <robh+dt@kernel.org>,
        Christian Eggers <ceggers@arri.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Prchal <jiri.prchal@aksignal.cz>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v10 2/4] nvmem: eeprom: at25: add support for FRAM
Message-ID: <202106221553.sYUB8q9D-lkp@intel.com>
References: <20210611094601.95131-3-jiri.prchal@aksignal.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <20210611094601.95131-3-jiri.prchal@aksignal.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jiri,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linux/master linus/master v5.13-rc7]
[cannot apply to char-misc/char-misc-testing next-20210621]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Jiri-Prchal/add-support-for-FRAM/20210616-203024
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: mips-randconfig-r035-20210622 (attached as .config)
compiler: mips64-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/663658b01091a6ef4239088cc41d96821ab6d43e
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jiri-Prchal/add-support-for-FRAM/20210616-203024
        git checkout 663658b01091a6ef4239088cc41d96821ab6d43e
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=mips 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/misc/eeprom/at25.c: In function 'at25_probe':
>> drivers/misc/eeprom/at25.c:367:13: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     367 |   is_fram = (int)match->data;
         |             ^


vim +367 drivers/misc/eeprom/at25.c

   354	
   355	static int at25_probe(struct spi_device *spi)
   356	{
   357		struct at25_data	*at25 = NULL;
   358		struct spi_eeprom	chip;
   359		int			err;
   360		int			sr;
   361		u8 id[FM25_ID_LEN];
   362		const struct of_device_id *match;
   363		int is_fram = 0;
   364	
   365		match = of_match_device(of_match_ptr(at25_of_match), &spi->dev);
   366		if (match)
 > 367			is_fram = (int)match->data;
   368	
   369		/* Chip description */
   370		if (!spi->dev.platform_data) {
   371			if (!is_fram) {
   372				err = at25_fw_to_chip(&spi->dev, &chip);
   373				if (err)
   374					return err;
   375			}
   376		} else
   377			chip = *(struct spi_eeprom *)spi->dev.platform_data;
   378	
   379		/* Ping the chip ... the status register is pretty portable,
   380		 * unlike probing manufacturer IDs.  We do expect that system
   381		 * firmware didn't write it in the past few milliseconds!
   382		 */
   383		sr = spi_w8r8(spi, AT25_RDSR);
   384		if (sr < 0 || sr & AT25_SR_nRDY) {
   385			dev_dbg(&spi->dev, "rdsr --> %d (%02x)\n", sr, sr);
   386			return -ENXIO;
   387		}
   388	
   389		at25 = devm_kzalloc(&spi->dev, sizeof(struct at25_data), GFP_KERNEL);
   390		if (!at25)
   391			return -ENOMEM;
   392	
   393		mutex_init(&at25->lock);
   394		at25->chip = chip;
   395		at25->spi = spi;
   396		spi_set_drvdata(spi, at25);
   397	
   398		if (is_fram) {
   399			/* Get ID of chip */
   400			fm25_aux_read(at25, id, FM25_RDID, FM25_ID_LEN);
   401			if (id[6] != 0xc2) {
   402				dev_err(&spi->dev,
   403					"Error: no Cypress FRAM (id %02x)\n", id[6]);
   404				return -ENODEV;
   405			}
   406			/* set size found in ID */
   407			if (id[7] < 0x21 || id[7] > 0x26) {
   408				dev_err(&spi->dev, "Error: unsupported size (id %02x)\n", id[7]);
   409				return -ENODEV;
   410			}
   411			chip.byte_len = int_pow(2, id[7] - 0x21 + 4) * 1024;
   412	
   413			if (at25->chip.byte_len > 64 * 1024)
   414				at25->chip.flags |= EE_ADDR3;
   415			else
   416				at25->chip.flags |= EE_ADDR2;
   417	
   418			at25->chip.page_size = PAGE_SIZE;
   419			strncpy(at25->chip.name, "fm25", sizeof(at25->chip.name));
   420		}
   421	
   422		/* For now we only support 8/16/24 bit addressing */
   423		if (at25->chip.flags & EE_ADDR1)
   424			at25->addrlen = 1;
   425		else if (at25->chip.flags & EE_ADDR2)
   426			at25->addrlen = 2;
   427		else if (at25->chip.flags & EE_ADDR3)
   428			at25->addrlen = 3;
   429		else {
   430			dev_dbg(&spi->dev, "unsupported address type\n");
   431			return -EINVAL;
   432		}
   433	
   434		at25->nvmem_config.type = is_fram ? NVMEM_TYPE_FRAM : NVMEM_TYPE_EEPROM;
   435		at25->nvmem_config.name = dev_name(&spi->dev);
   436		at25->nvmem_config.dev = &spi->dev;
   437		at25->nvmem_config.read_only = chip.flags & EE_READONLY;
   438		at25->nvmem_config.root_only = true;
   439		at25->nvmem_config.owner = THIS_MODULE;
   440		at25->nvmem_config.compat = true;
   441		at25->nvmem_config.base_dev = &spi->dev;
   442		at25->nvmem_config.reg_read = at25_ee_read;
   443		at25->nvmem_config.reg_write = at25_ee_write;
   444		at25->nvmem_config.priv = at25;
   445		at25->nvmem_config.stride = 1;
   446		at25->nvmem_config.word_size = 1;
   447		at25->nvmem_config.size = chip.byte_len;
   448	
   449		at25->nvmem = devm_nvmem_register(&spi->dev, &at25->nvmem_config);
   450		if (IS_ERR(at25->nvmem))
   451			return PTR_ERR(at25->nvmem);
   452	
   453		dev_info(&spi->dev, "%d %s %s %s%s, pagesize %u\n",
   454			 (chip.byte_len < 1024) ? chip.byte_len : (chip.byte_len / 1024),
   455			 (chip.byte_len < 1024) ? "Byte" : "KByte",
   456			 at25->chip.name, is_fram ? "fram" : "eeprom",
   457			 (chip.flags & EE_READONLY) ? " (readonly)" : "",
   458			 at25->chip.page_size);
   459		return 0;
   460	}
   461	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--LZvS9be/3tNcYl/X
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--LZvS9be/3tNcYl/X--
