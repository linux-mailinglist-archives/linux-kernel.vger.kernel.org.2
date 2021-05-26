Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48E2F391012
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 07:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbhEZFnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 01:43:00 -0400
Received: from mga09.intel.com ([134.134.136.24]:14678 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231210AbhEZFm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 01:42:59 -0400
IronPort-SDR: LXYq6jCiA5QQ+IOxyiA3ruYG7lyeu8+dSI5P37N4OdtUzNdyBaYIFhNlx5kzXonK5pnSwFCuL9
 Ii7e0W5WfZEw==
X-IronPort-AV: E=McAfee;i="6200,9189,9995"; a="202400207"
X-IronPort-AV: E=Sophos;i="5.82,330,1613462400"; 
   d="gz'50?scan'50,208,50";a="202400207"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 22:41:24 -0700
IronPort-SDR: epcE2hajHIPOPOXgdFkBfhGWj5c+5hQfAcuOLi7okrH9HpAgqroKZGT9PlggbJGYJxo9ykTVrn
 aE7Gzu6OMHcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,330,1613462400"; 
   d="gz'50?scan'50,208,50";a="471661454"
Received: from lkp-server02.sh.intel.com (HELO 1ec8406c5392) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 25 May 2021 22:41:21 -0700
Received: from kbuild by 1ec8406c5392 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1llmIC-000214-VQ; Wed, 26 May 2021 05:41:20 +0000
Date:   Wed, 26 May 2021 13:40:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stephen Boyd <swboyd@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Petr Mladek <pmladek@suse.com>, Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 4/4] slub: Force on no_hash_pointers when slub_debug
 is enabled
Message-ID: <202105261354.dnH8ijYS-lkp@intel.com>
References: <20210526025625.601023-5-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
In-Reply-To: <20210526025625.601023-5-swboyd@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Stephen,

I love your patch! Perhaps something to improve:

[auto build test WARNING on d07f6ca923ea0927a1024dfccafc5b53b61cfecc]

url:    https://github.com/0day-ci/linux/commits/Stephen-Boyd/slub-Print-non-hashed-pointers-in-slub-debugging/20210526-105816
base:   d07f6ca923ea0927a1024dfccafc5b53b61cfecc
config: i386-tinyconfig (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/1e3e0117436276faacd0217d89715df61021b4d2
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Stephen-Boyd/slub-Print-non-hashed-pointers-in-slub-debugging/20210526-105816
        git checkout 1e3e0117436276faacd0217d89715df61021b4d2
        # save the attached .config to linux build tree
        make W=1 ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   lib/vsprintf.c: In function 'va_format':
   lib/vsprintf.c:1663:2: warning: function 'va_format' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    1663 |  buf += vsnprintf(buf, end > buf ? end - buf : 0, va_fmt->fmt, va);
         |  ^~~
   lib/vsprintf.c: At top level:
>> lib/vsprintf.c:2189:12: warning: no previous prototype for 'no_hash_pointers_enable' [-Wmissing-prototypes]
    2189 | int __init no_hash_pointers_enable(char *str)
         |            ^~~~~~~~~~~~~~~~~~~~~~~


vim +/no_hash_pointers_enable +2189 lib/vsprintf.c

  2188	
> 2189	int __init no_hash_pointers_enable(char *str)
  2190	{
  2191		if (no_hash_pointers)
  2192			return 0;
  2193	
  2194		no_hash_pointers = true;
  2195	
  2196		pr_warn("**********************************************************\n");
  2197		pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
  2198		pr_warn("**                                                      **\n");
  2199		pr_warn("** This system shows unhashed kernel memory addresses   **\n");
  2200		pr_warn("** via the console, logs, and other interfaces. This    **\n");
  2201		pr_warn("** might reduce the security of your system.            **\n");
  2202		pr_warn("**                                                      **\n");
  2203		pr_warn("** If you see this message and you are not debugging    **\n");
  2204		pr_warn("** the kernel, report this immediately to your system   **\n");
  2205		pr_warn("** administrator!                                       **\n");
  2206		pr_warn("**                                                      **\n");
  2207		pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
  2208		pr_warn("**********************************************************\n");
  2209	
  2210		return 0;
  2211	}
  2212	early_param("no_hash_pointers", no_hash_pointers_enable);
  2213	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--Nq2Wo0NMKNjxTN9z
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
3ia/3pj7D1XxRKY4awAA

--Nq2Wo0NMKNjxTN9z--
