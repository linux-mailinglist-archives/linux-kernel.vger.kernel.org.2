Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD643099E8
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 02:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbhAaBpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 20:45:46 -0500
Received: from mga17.intel.com ([192.55.52.151]:4997 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232297AbhAaBpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 20:45:39 -0500
IronPort-SDR: HRFH1JYflj+qudk8BXbp17k+phKS0VPvo+RQ7reG7IJvhC3aGe3TWlhuwCbhqcvi7/hSdIXd6n
 GER1b9W8+rog==
X-IronPort-AV: E=McAfee;i="6000,8403,9880"; a="160330937"
X-IronPort-AV: E=Sophos;i="5.79,389,1602572400"; 
   d="gz'50?scan'50,208,50";a="160330937"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2021 17:44:56 -0800
IronPort-SDR: mmJFqcoAVSvn44upc8sXroeRu7oVdtYmB7fVq9fLbUYOL0VxQROWwBiXlP3ObmqDS3L/U4VYbU
 3bVMfGf/5xtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,389,1602572400"; 
   d="gz'50?scan'50,208,50";a="506351339"
Received: from lkp-server02.sh.intel.com (HELO 625d3a354f04) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 30 Jan 2021 17:44:53 -0800
Received: from kbuild by 625d3a354f04 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l61nJ-00059E-4F; Sun, 31 Jan 2021 01:44:53 +0000
Date:   Sun, 31 Jan 2021 09:44:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: ERROR: ".snd_pcm_set_managed_buffer" undefined!
Message-ID: <202101310910.6VRMjPcm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Takashi,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0e9bcda5d286f4a26a5407bb38f55c55b453ecfb
commit: 57e960f0020ec46db277426762ba5ffe77e03e3c ASoC: SOF: Use managed buffer allocation
date:   1 year, 2 months ago
config: powerpc-randconfig-c003-20210130 (attached as .config)
compiler: powerpc64-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=57e960f0020ec46db277426762ba5ffe77e03e3c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 57e960f0020ec46db277426762ba5ffe77e03e3c
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=powerpc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ERROR: "._raw_spin_unlock" [sound/soc/sti/snd-soc-sti.ko] undefined!
   ERROR: ".memset" [sound/soc/sti/snd-soc-sti.ko] undefined!
   ERROR: "._dev_err" [sound/soc/sti/snd-soc-sti.ko] undefined!
   ERROR: ".platform_get_irq" [sound/soc/sti/snd-soc-sti.ko] undefined!
   ERROR: ".snd_interval_refine" [sound/soc/sti/snd-soc-sti.ko] undefined!
   ERROR: ".snd_soc_add_dai_controls" [sound/soc/sti/snd-soc-sti.ko] undefined!
   ERROR: ".syscon_regmap_lookup_by_phandle" [sound/soc/sti/snd-soc-sti.ko] undefined!
   ERROR: ".snd_pcm_stream_lock" [sound/soc/sti/snd-soc-sti.ko] undefined!
   ERROR: ".mutex_unlock" [sound/soc/sti/snd-soc-sti.ko] undefined!
   ERROR: ".sg_init_table" [sound/soc/sprd/snd-soc-sprd-platform.ko] undefined!
   ERROR: ".__warn_printk" [sound/soc/sprd/snd-soc-sprd-platform.ko] undefined!
   ERROR: ".devm_kmalloc" [sound/soc/sprd/snd-soc-sprd-platform.ko] undefined!
   ERROR: ".dma_set_coherent_mask" [sound/soc/sprd/snd-soc-sprd-platform.ko] undefined!
   ERROR: ".remap_pfn_range" [sound/soc/sprd/snd-soc-sprd-platform.ko] undefined!
   ERROR: ".devm_kfree" [sound/soc/sprd/snd-soc-sprd-platform.ko] undefined!
   ERROR: ".__platform_driver_register" [sound/soc/sprd/snd-soc-sprd-platform.ko] undefined!
   ERROR: ".snd_dma_alloc_pages" [sound/soc/sprd/snd-soc-sprd-platform.ko] undefined!
   ERROR: ".snd_soc_rtdcom_lookup" [sound/soc/sprd/snd-soc-sprd-platform.ko] undefined!
   ERROR: ".dma_request_slave_channel" [sound/soc/sprd/snd-soc-sprd-platform.ko] undefined!
   ERROR: ".snd_soc_set_runtime_hwparams" [sound/soc/sprd/snd-soc-sprd-platform.ko] undefined!
   ERROR: ".snd_dma_free_pages" [sound/soc/sprd/snd-soc-sprd-platform.ko] undefined!
   ERROR: ".dmam_alloc_attrs" [sound/soc/sprd/snd-soc-sprd-platform.ko] undefined!
   ERROR: ".dmam_free_coherent" [sound/soc/sprd/snd-soc-sprd-platform.ko] undefined!
   ERROR: ".snd_pcm_hw_constraint_integer" [sound/soc/sprd/snd-soc-sprd-platform.ko] undefined!
   ERROR: ".snd_pcm_hw_constraint_step" [sound/soc/sprd/snd-soc-sprd-platform.ko] undefined!
   ERROR: ".platform_driver_unregister" [sound/soc/sprd/snd-soc-sprd-platform.ko] undefined!
   ERROR: ".devm_snd_soc_register_component" [sound/soc/sprd/snd-soc-sprd-platform.ko] undefined!
   ERROR: ".__check_object_size" [sound/soc/sprd/snd-soc-sprd-platform.ko] undefined!
   ERROR: "._dev_warn" [sound/soc/sprd/snd-soc-sprd-platform.ko] undefined!
   ERROR: ".__wake_up" [sound/soc/sprd/snd-soc-sprd-platform.ko] undefined!
   ERROR: ".of_reserved_mem_device_init_by_idx" [sound/soc/sprd/snd-soc-sprd-platform.ko] undefined!
   ERROR: "._dev_err" [sound/soc/sprd/snd-soc-sprd-platform.ko] undefined!
   ERROR: ".dma_release_channel" [sound/soc/sprd/snd-soc-sprd-platform.ko] undefined!
   ERROR: "._copy_from_user" [sound/soc/sprd/snd-soc-sprd-platform.ko] undefined!
   ERROR: ".dma_set_mask" [sound/soc/sprd/snd-soc-sprd-platform.ko] undefined!
   ERROR: ".hex_dump_to_buffer" [sound/soc/sof/xtensa/snd-sof-xtensa-dsp.ko] undefined!
   ERROR: "._dev_err" [sound/soc/sof/xtensa/snd-sof-xtensa-dsp.ko] undefined!
   ERROR: ".devm_kmalloc" [sound/soc/sof/snd-sof-pci.ko] undefined!
   ERROR: ".pci_unregister_driver" [sound/soc/sof/snd-sof-pci.ko] undefined!
   ERROR: ".snd_intel_dsp_driver_probe" [sound/soc/sof/snd-sof-pci.ko] undefined!
   ERROR: ".__pci_register_driver" [sound/soc/sof/snd-sof-pci.ko] undefined!
   ERROR: ".pci_request_regions" [sound/soc/sof/snd-sof-pci.ko] undefined!
   ERROR: ".pcim_enable_device" [sound/soc/sof/snd-sof-pci.ko] undefined!
   ERROR: ".snd_sof_device_remove" [sound/soc/sof/snd-sof-pci.ko] undefined!
   ERROR: ".snd_sof_device_probe" [sound/soc/sof/snd-sof-pci.ko] undefined!
   ERROR: "._dev_err" [sound/soc/sof/snd-sof-pci.ko] undefined!
   ERROR: ".pci_release_regions" [sound/soc/sof/snd-sof-pci.ko] undefined!
   ERROR: ".devm_kmalloc" [sound/soc/sof/snd-sof-acpi.ko] undefined!
   ERROR: ".__platform_driver_register" [sound/soc/sof/snd-sof-acpi.ko] undefined!
   ERROR: ".snd_sof_device_remove" [sound/soc/sof/snd-sof-acpi.ko] undefined!
   ERROR: ".device_get_match_data" [sound/soc/sof/snd-sof-acpi.ko] undefined!
   ERROR: ".platform_driver_unregister" [sound/soc/sof/snd-sof-acpi.ko] undefined!
   ERROR: ".snd_sof_device_probe" [sound/soc/sof/snd-sof-acpi.ko] undefined!
   ERROR: "._dev_err" [sound/soc/sof/snd-sof-acpi.ko] undefined!
   ERROR: ".devm_kmalloc" [sound/soc/sof/snd-sof-nocodec.ko] undefined!
   ERROR: ".__platform_driver_register" [sound/soc/sof/snd-sof-nocodec.ko] undefined!
   ERROR: ".devm_snd_soc_register_card" [sound/soc/sof/snd-sof-nocodec.ko] undefined!
   ERROR: ".devm_kasprintf" [sound/soc/sof/snd-sof-nocodec.ko] undefined!
   ERROR: ".platform_driver_unregister" [sound/soc/sof/snd-sof-nocodec.ko] undefined!
   ERROR: "._raw_spin_unlock_irqrestore" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: ".kmem_cache_alloc_trace" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: ".devm_kmalloc" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: ".snd_soc_tplg_widget_bind_event" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: ".__mutex_init" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: ".platform_device_unregister" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: "._copy_to_user" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: "._memcpy_fromio" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: ".iowrite32" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: ".fortify_panic" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: ".schedule_timeout" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: "._dev_info" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: ".snd_dma_alloc_pages" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: ".cancel_work_sync" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: ".snd_soc_rtdcom_lookup" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: ".__init_waitqueue_head" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: ".strncmp" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: ".request_firmware" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: ".snd_dma_free_pages" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: ".debugfs_create_file" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: ".finish_wait" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: ".mutex_lock_nested" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: ".snd_pcm_format_physical_width" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: ".pci_write_config_dword" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: ".__msecs_to_jiffies" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: ".__kmalloc" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: ".prepare_to_wait_event" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: ".ktime_get" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: "._raw_spin_lock_irq" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: ".debugfs_remove_recursive" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: ".devm_kasprintf" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: ".__list_add_valid" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: ".snd_pcm_hw_constraint_step" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: ".kmemdup" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: ".__raw_spin_lock_init" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: ".platform_device_register_full" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: ".debugfs_create_dir" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: ".snd_soc_tplg_component_remove" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: ".devm_snd_soc_register_component" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: ".__iowrite32_copy" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: ".snd_pcm_stop_xrun" [sound/soc/sof/snd-sof.ko] undefined!
>> ERROR: ".snd_pcm_set_managed_buffer" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: ".snd_pcm_format_width" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: ".strnlen" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: "._raw_spin_lock_irqsave" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: ".__check_object_size" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: "._dev_warn" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: "._raw_spin_unlock_irq" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: ".pci_read_config_dword" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: ".init_wait_entry" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: ".ledtrig_audio_set" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: ".memcpy" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: ".queue_work_on" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: ".simple_write_to_buffer" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: ".add_wait_queue" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: ".__wake_up" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: ".snd_soc_find_dai" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: ".memset" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: ".ioread32" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: ".___ratelimit" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: "._dev_err" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: "._cond_resched" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: ".__list_del_entry_valid" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: ".remove_wait_queue" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: ".lockdep_init_map" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: "._memcpy_toio" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: ".mutex_unlock" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: ".snd_soc_tplg_component_load" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: ".strcmp" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: ".kasprintf" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: ".sof_nocodec_setup" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: "._copy_from_user" [sound/soc/sof/snd-sof.ko] undefined!
   ERROR: ".pci_irq_vector" [sound/soc/sof/intel/snd-sof-intel-hda-common.ko] undefined!
   ERROR: ".iounmap" [sound/soc/sof/intel/snd-sof-intel-hda-common.ko] undefined!
   ERROR: ".devm_kmalloc" [sound/soc/sof/intel/snd-sof-intel-hda-common.ko] undefined!
   ERROR: ".request_threaded_irq" [sound/soc/sof/intel/snd-sof-intel-hda-common.ko] undefined!
   ERROR: ".__mutex_init" [sound/soc/sof/intel/snd-sof-intel-hda-common.ko] undefined!
   ERROR: ".snd_sof_dsp_update_bits" [sound/soc/sof/intel/snd-sof-intel-hda-common.ko] undefined!
   ERROR: ".platform_device_unregister" [sound/soc/sof/intel/snd-sof-intel-hda-common.ko] undefined!
   ERROR: ".pci_restore_state" [sound/soc/sof/intel/snd-sof-intel-hda-common.ko] undefined!
   ERROR: ".dma_set_coherent_mask" [sound/soc/sof/intel/snd-sof-intel-hda-common.ko] undefined!
   ERROR: ".schedule_timeout" [sound/soc/sof/intel/snd-sof-intel-hda-common.ko] undefined!
   ERROR: ".pci_alloc_irq_vectors_affinity" [sound/soc/sof/intel/snd-sof-intel-hda-common.ko] undefined!
   ERROR: ".snd_sof_get_status" [sound/soc/sof/intel/snd-sof-intel-hda-common.ko] undefined!
   ERROR: ".devm_kfree" [sound/soc/sof/intel/snd-sof-intel-hda-common.ko] undefined!
   ERROR: "._dev_info" [sound/soc/sof/intel/snd-sof-intel-hda-common.ko] undefined!
   ERROR: ".snd_dma_alloc_pages" [sound/soc/sof/intel/snd-sof-intel-hda-common.ko] undefined!
   ERROR: ".free_irq" [sound/soc/sof/intel/snd-sof-intel-hda-common.ko] undefined!
   ERROR: ".pci_free_irq_vectors" [sound/soc/sof/intel/snd-sof-intel-hda-common.ko] undefined!
   ERROR: ".__init_waitqueue_head" [sound/soc/sof/intel/snd-sof-intel-hda-common.ko] undefined!
   ERROR: ".synchronize_irq" [sound/soc/sof/intel/snd-sof-intel-hda-common.ko] undefined!
   ERROR: ".snd_sof_ipc_msgs_rx" [sound/soc/sof/intel/snd-sof-intel-hda-common.ko] undefined!
   ERROR: ".snd_dma_free_pages" [sound/soc/sof/intel/snd-sof-intel-hda-common.ko] undefined!
   ERROR: ".finish_wait" [sound/soc/sof/intel/snd-sof-intel-hda-common.ko] undefined!
   ERROR: ".snd_sof_pcm_period_elapsed" [sound/soc/sof/intel/snd-sof-intel-hda-common.ko] undefined!
   ERROR: ".irq_set_irq_wake" [sound/soc/sof/intel/snd-sof-intel-hda-common.ko] undefined!
   ERROR: ".sof_mailbox_write" [sound/soc/sof/intel/snd-sof-intel-hda-common.ko] undefined!
   ERROR: ".ktime_get" [sound/soc/sof/intel/snd-sof-intel-hda-common.ko] undefined!
   ERROR: ".prepare_to_wait_event" [sound/soc/sof/intel/snd-sof-intel-hda-common.ko] undefined!
   ERROR: "._raw_spin_lock_irq" [sound/soc/sof/intel/snd-sof-intel-hda-common.ko] undefined!
   ERROR: ".__list_add_valid" [sound/soc/sof/intel/snd-sof-intel-hda-common.ko] undefined!
   ERROR: ".snd_sof_dsp_panic" [sound/soc/sof/intel/snd-sof-intel-hda-common.ko] undefined!
   ERROR: ".snd_sof_ipc_reply" [sound/soc/sof/intel/snd-sof-intel-hda-common.ko] undefined!
   ERROR: ".sof_mailbox_read" [sound/soc/sof/intel/snd-sof-intel-hda-common.ko] undefined!
   ERROR: ".__raw_spin_lock_init" [sound/soc/sof/intel/snd-sof-intel-hda-common.ko] undefined!
   ERROR: ".snd_sof_dsp_update_bits_forced" [sound/soc/sof/intel/snd-sof-intel-hda-common.ko] undefined!
   ERROR: ".platform_device_register_full" [sound/soc/sof/intel/snd-sof-intel-hda-common.ko] undefined!
   ERROR: ".usleep_range" [sound/soc/sof/intel/snd-sof-intel-hda-common.ko] undefined!
   ERROR: ".snd_pcm_format_width" [sound/soc/sof/intel/snd-sof-intel-hda-common.ko] undefined!
   ERROR: "._dev_warn" [sound/soc/sof/intel/snd-sof-intel-hda-common.ko] undefined!
   ERROR: "._raw_spin_unlock_irq" [sound/soc/sof/intel/snd-sof-intel-hda-common.ko] undefined!
   ERROR: ".udelay" [sound/soc/sof/intel/snd-sof-intel-hda-common.ko] undefined!
   ERROR: ".init_wait_entry" [sound/soc/sof/intel/snd-sof-intel-hda-common.ko] undefined!
   ERROR: ".pci_save_state" [sound/soc/sof/intel/snd-sof-intel-hda-common.ko] undefined!
   ERROR: ".memcpy" [sound/soc/sof/intel/snd-sof-intel-hda-common.ko] undefined!
   ERROR: ".__wake_up" [sound/soc/sof/intel/snd-sof-intel-hda-common.ko] undefined!
   ERROR: ".memset" [sound/soc/sof/intel/snd-sof-intel-hda-common.ko] undefined!
   ERROR: ".sof_ipc_tx_message" [sound/soc/sof/intel/snd-sof-intel-hda-common.ko] undefined!
   ERROR: ".___ratelimit" [sound/soc/sof/intel/snd-sof-intel-hda-common.ko] undefined!
   ERROR: "._dev_err" [sound/soc/sof/intel/snd-sof-intel-hda-common.ko] undefined!
   ERROR: "._cond_resched" [sound/soc/sof/intel/snd-sof-intel-hda-common.ko] undefined!
   ERROR: ".__list_del_entry_valid" [sound/soc/sof/intel/snd-sof-intel-hda-common.ko] undefined!
   ERROR: ".pci_set_master" [sound/soc/sof/intel/snd-sof-intel-hda-common.ko] undefined!
   ERROR: ".snd_sof_pci_update_bits" [sound/soc/sof/intel/snd-sof-intel-hda-common.ko] undefined!
   ERROR: ".pci_ioremap_bar" [sound/soc/sof/intel/snd-sof-intel-hda-common.ko] undefined!
   ERROR: ".snd_sof_dsp_update_bits_unlocked" [sound/soc/sof/intel/snd-sof-intel-hda-common.ko] undefined!
   ERROR: ".dma_set_mask" [sound/soc/sof/intel/snd-sof-intel-hda-common.ko] undefined!
   ERROR: ".kmem_cache_alloc_trace" [sound/soc/sof/intel/snd-sof-intel-ipc.ko] undefined!
   ERROR: ".sof_mailbox_read" [sound/soc/sof/intel/snd-sof-intel-ipc.ko] undefined!
   ERROR: ".devm_request_threaded_irq" [sound/soc/sof/intel/snd-sof-intel-bdw.ko] undefined!
   ERROR: ".snd_sof_dsp_update_bits" [sound/soc/sof/intel/snd-sof-intel-bdw.ko] undefined!
   ERROR: ".dma_set_coherent_mask" [sound/soc/sof/intel/snd-sof-intel-bdw.ko] undefined!
   ERROR: ".snd_sof_get_status" [sound/soc/sof/intel/snd-sof-intel-bdw.ko] undefined!
   ERROR: ".devm_ioremap" [sound/soc/sof/intel/snd-sof-intel-bdw.ko] undefined!
   ERROR: ".snd_sof_ipc_msgs_rx" [sound/soc/sof/intel/snd-sof-intel-bdw.ko] undefined!
   ERROR: ".snd_sof_dsp_mailbox_init" [sound/soc/sof/intel/snd-sof-intel-bdw.ko] undefined!
   ERROR: ".sof_mailbox_write" [sound/soc/sof/intel/snd-sof-intel-bdw.ko] undefined!
   ERROR: "._raw_spin_lock_irq" [sound/soc/sof/intel/snd-sof-intel-bdw.ko] undefined!
   ERROR: ".snd_sof_dsp_panic" [sound/soc/sof/intel/snd-sof-intel-bdw.ko] undefined!
   ERROR: ".snd_sof_ipc_reply" [sound/soc/sof/intel/snd-sof-intel-bdw.ko] undefined!
   ERROR: ".sof_mailbox_read" [sound/soc/sof/intel/snd-sof-intel-bdw.ko] undefined!
   ERROR: ".usleep_range" [sound/soc/sof/intel/snd-sof-intel-bdw.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--sm4nu43k4a2Rpi4c
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--sm4nu43k4a2Rpi4c--
