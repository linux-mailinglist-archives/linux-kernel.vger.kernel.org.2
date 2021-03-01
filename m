Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A1C328016
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 14:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235969AbhCANzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 08:55:49 -0500
Received: from foss.arm.com ([217.140.110.172]:58380 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235930AbhCANzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 08:55:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C12081042;
        Mon,  1 Mar 2021 05:54:59 -0800 (PST)
Received: from [10.57.48.41] (unknown [10.57.48.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2DF833F70D;
        Mon,  1 Mar 2021 05:54:58 -0800 (PST)
Subject: Re: [PATCH v4 17/19] coresight: core: Add support for dedicated
 percpu sinks
To:     kernel test robot <lkp@intel.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, anshuman.khandual@arm.com,
        leo.yan@linaro.org
References: <20210225193543.2920532-18-suzuki.poulose@arm.com>
 <202102261412.zCSQLdKB-lkp@intel.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <5fad098f-8cdd-e56d-3812-d85720b1768c@arm.com>
Date:   Mon, 1 Mar 2021 13:54:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <202102261412.zCSQLdKB-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/21 6:34 AM, kernel test robot wrote:
> Hi Suzuki,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on next-20210226]
> [cannot apply to kvmarm/next arm64/for-next/core tip/perf/core v5.11]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Suzuki-K-Poulose/arm64-coresight-Add-support-for-ETE-and-TRBE/20210226-035447
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 6fbd6cf85a3be127454a1ad58525a3adcf8612ab
> config: arm-randconfig-r024-20210225 (attached as .config)
> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project a921aaf789912d981cbb2036bdc91ad7289e1523)
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # install arm cross compiling tool for clang build
>          # apt-get install binutils-arm-linux-gnueabi
>          # https://github.com/0day-ci/linux/commit/c37564326cdf11e0839eae06c1bfead47d3e5775
>          git remote add linux-review https://github.com/0day-ci/linux
>          git fetch --no-tags linux-review Suzuki-K-Poulose/arm64-coresight-Add-support-for-ETE-and-TRBE/20210226-035447
>          git checkout c37564326cdf11e0839eae06c1bfead47d3e5775
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>

Thanks for the report. The following fixup should clear this :


---8>---



diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 8a3a3c199087..85008a65e21f 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -429,6 +429,33 @@ static inline void csdev_access_write64(struct csdev_access *csa, u64 val, u32 o
  		csa->write(val, offset, false, true);
  }

+#else	/* !CONFIG_64BIT */
+
+static inline u64 csdev_access_relaxed_read64(struct csdev_access *csa,
+					      u32 offset)
+{
+	WARN_ON(1);
+	return 0;
+}
+
+static inline u64 csdev_access_read64(struct csdev_access *csa, u32 offset)
+{
+	WARN_ON(1);
+	return 0;
+}
+
+static inline void csdev_access_relaxed_write64(struct csdev_access *csa,
+						u64 val, u32 offset)
+{
+	WARN_ON(1);
+}
+
+static inline void csdev_access_write64(struct csdev_access *csa, u64 val, u32 offset)
+{
+	WARN_ON(1);
+}
+#endif	/* CONFIG_64BIT */
+
  static inline bool coresight_is_percpu_source(struct coresight_device *csdev)
  {
  	return csdev && (csdev->type == CORESIGHT_DEV_TYPE_SOURCE) &&
@@ -440,32 +467,6 @@ static inline bool coresight_is_percpu_sink(struct coresight_device *csdev)
  	return csdev && (csdev->type == CORESIGHT_DEV_TYPE_SINK) &&
  	       (csdev->subtype.sink_subtype == CORESIGHT_DEV_SUBTYPE_SINK_PERCPU_SYSMEM);
  }
-#else	/* !CONFIG_64BIT */
-
-static inline u64 csdev_access_relaxed_read64(struct csdev_access *csa,
-					      u32 offset)
-{
-	WARN_ON(1);
-	return 0;
-}
-
-static inline u64 csdev_access_read64(struct csdev_access *csa, u32 offset)
-{
-	WARN_ON(1);
-	return 0;
-}
-
-static inline void csdev_access_relaxed_write64(struct csdev_access *csa,
-						u64 val, u32 offset)
-{
-	WARN_ON(1);
-}
-
-static inline void csdev_access_write64(struct csdev_access *csa, u64 val, u32 offset)
-{
-	WARN_ON(1);
-}
-#endif	/* CONFIG_64BIT */

  extern struct coresight_device *
  coresight_register(struct coresight_desc *desc);
