Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4542D3DB118
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 04:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235697AbhG3CWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 22:22:35 -0400
Received: from mga01.intel.com ([192.55.52.88]:45563 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230200AbhG3CWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 22:22:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10060"; a="234917748"
X-IronPort-AV: E=Sophos;i="5.84,280,1620716400"; 
   d="scan'208";a="234917748"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2021 19:22:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,280,1620716400"; 
   d="scan'208";a="465295390"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by orsmga008.jf.intel.com with ESMTP; 29 Jul 2021 19:22:27 -0700
Cc:     baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v1 1/2] iommu/vt-d: Move intel_iommu_ops to header file
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20210729163538.40101-1-andriy.shevchenko@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <3c7663db-5b1e-3e00-3ff1-381c7a107ac9@linux.intel.com>
Date:   Fri, 30 Jul 2021 10:20:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210729163538.40101-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 7/30/21 12:35 AM, Andy Shevchenko wrote:
> Compiler is not happy about hidden declaration of intel_iommu_ops.
> 
> .../drivers/iommu/intel/iommu.c:414:24: warning: symbol 'intel_iommu_ops' was not declared. Should it be static?
> 
> Move declaration to header file to make compiler happy.

Thanks for the cleanup. Sharing data structures between different files
doesn't seem to be a good design. How about adding a helper so that the
intel_iommu_ops could be a static one?

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 05a65eb155f7..2258e69a93a3 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -757,6 +757,7 @@ int intel_iommu_enable_pasid(struct intel_iommu 
*iommu, struct device *dev);
  struct dmar_domain *find_domain(struct device *dev);
  struct device_domain_info *get_domain_info(struct device *dev);
  struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 
*devfn);
+int intel_iommu_register_device(struct intel_iommu *iommu);

  #ifdef CONFIG_INTEL_IOMMU_SVM
  extern void intel_svm_check(struct intel_iommu *iommu);
@@ -805,7 +806,6 @@ void intel_iommu_debugfs_init(void);
  static inline void intel_iommu_debugfs_init(void) {}
  #endif /* CONFIG_INTEL_IOMMU_DEBUGFS */

-extern const struct attribute_group *intel_iommu_groups[];
  bool context_present(struct context_entry *context);
  struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 
bus,
                                          u8 devfn, int alloc);
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 0ec5514c9980..deef4e77de73 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -66,8 +66,6 @@ static unsigned long 
dmar_seq_ids[BITS_TO_LONGS(DMAR_UNITS_SUPPORTED)];
  static int alloc_iommu(struct dmar_drhd_unit *drhd);
  static void free_iommu(struct intel_iommu *iommu);

-extern const struct iommu_ops intel_iommu_ops;
-
  static void dmar_register_drhd_unit(struct dmar_drhd_unit *drhd)
  {
         /*
@@ -1133,15 +1131,9 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
          * present at boot time, then sets intel_iommu_enabled.
          */
         if (intel_iommu_enabled && !drhd->ignored) {
-               err = iommu_device_sysfs_add(&iommu->iommu, NULL,
-                                            intel_iommu_groups,
-                                            "%s", iommu->name);
+               err = intel_iommu_register_device(iommu);
                 if (err)
                         goto err_unmap;
-
-               err = iommu_device_register(&iommu->iommu, 
&intel_iommu_ops, NULL);
-               if (err)
-                       goto err_sysfs;
         }

         drhd->iommu = iommu;
@@ -1149,8 +1141,6 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)

         return 0;

-err_sysfs:
-       iommu_device_sysfs_remove(&iommu->iommu);
  err_unmap:
         unmap_iommu(iommu);
  error_free_seq_id:
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 6df5fc5063e1..27ba3062bcac 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -388,7 +388,7 @@ int for_each_device_domain(int (*fn)(struct 
device_domain_info *info,
         return 0;
  }

-const struct iommu_ops intel_iommu_ops;
+static const struct iommu_ops intel_iommu_ops;

  static bool translation_pre_enabled(struct intel_iommu *iommu)
  {
@@ -4221,7 +4221,7 @@ static struct attribute_group intel_iommu_group = {
         .attrs = intel_iommu_attrs,
  };

-const struct attribute_group *intel_iommu_groups[] = {
+static const struct attribute_group *intel_iommu_groups[] = {
         &intel_iommu_group,
         NULL,
  };
@@ -4301,6 +4301,23 @@ static int __init probe_acpi_namespace_devices(void)
         return 0;
  }

+int intel_iommu_register_device(struct intel_iommu *iommu)
+{
+       int ret;
+
+       ret = iommu_device_sysfs_add(&iommu->iommu, NULL,
+                                    intel_iommu_groups,
+                                    "%s", iommu->name);
+       if (ret)
+               return ret;
+
+       ret = iommu_device_register(&iommu->iommu, &intel_iommu_ops, NULL);
+       if (ret)
+               iommu_device_sysfs_remove(&iommu->iommu);
+
+       return ret;
+}
+
  int __init intel_iommu_init(void)
  {
         int ret = -ENODEV;
@@ -4407,10 +4424,7 @@ int __init intel_iommu_init(void)
                         pr_info_once("IOMMU batching disallowed due to 
virtualization\n");
                         iommu_set_dma_strict();
                 }
-               iommu_device_sysfs_add(&iommu->iommu, NULL,
-                                      intel_iommu_groups,
-                                      "%s", iommu->name);
-               iommu_device_register(&iommu->iommu, &intel_iommu_ops, 
NULL);
+               intel_iommu_register_device(iommu);
         }
         up_read(&dmar_global_lock);

@@ -5589,7 +5603,7 @@ static void intel_iommu_iotlb_sync_map(struct 
iommu_domain *domain,
         }
  }

-const struct iommu_ops intel_iommu_ops = {
+static const struct iommu_ops intel_iommu_ops = {
         .capable                = intel_iommu_capable,
         .domain_alloc           = intel_iommu_domain_alloc,
         .domain_free            = intel_iommu_domain_free,

Best regards,
baolu

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/iommu/intel/dmar.c  | 2 --
>   include/linux/intel-iommu.h | 2 ++
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index d66f79acd14d..d2d974cf8322 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -66,8 +66,6 @@ static unsigned long dmar_seq_ids[BITS_TO_LONGS(DMAR_UNITS_SUPPORTED)];
>   static int alloc_iommu(struct dmar_drhd_unit *drhd);
>   static void free_iommu(struct intel_iommu *iommu);
>   
> -extern const struct iommu_ops intel_iommu_ops;
> -
>   static void dmar_register_drhd_unit(struct dmar_drhd_unit *drhd)
>   {
>   	/*
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index d0fa0b31994d..309c1e13183a 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -811,6 +811,8 @@ struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 bus,
>   					 u8 devfn, int alloc);
>   
>   #ifdef CONFIG_INTEL_IOMMU
> +extern const struct iommu_ops intel_iommu_ops;
> +
>   extern int iommu_calculate_agaw(struct intel_iommu *iommu);
>   extern int iommu_calculate_max_sagaw(struct intel_iommu *iommu);
>   extern int dmar_disabled;
> 
