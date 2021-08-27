Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5030C3F965D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 10:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244666AbhH0Iod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 04:44:33 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:54420 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231824AbhH0Ioc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 04:44:32 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1mJXSW-0007ir-Ft; Fri, 27 Aug 2021 16:43:32 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1mJXSA-00061V-Nq; Fri, 27 Aug 2021 16:43:10 +0800
Date:   Fri, 27 Aug 2021 16:43:10 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     kernel test robot <lkp@intel.com>
Cc:     Kai Ye <yekai13@huawei.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: crypto: hisilicon - Fix sscanf format signedness
Message-ID: <20210827084310.GA21801@gondor.apana.org.au>
References: <202108220901.8r4gf0hB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202108220901.8r4gf0hB-lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 22, 2021 at 09:18:20AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   9ff50bf2f2ff5fab01cac26d8eed21a89308e6ef
> commit: 3bbf0783636be8fd672907df25904288f14566f2 crypto: hisilicon/qm - supports to inquiry each function's QoS
> date:   9 weeks ago
> compiler: ia64-linux-gcc (GCC) 11.2.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>

---8<---
The function qm_qos_value_init expects an unsigned integer but
is incorrectly supplying a signed format to sscanf.  This patch
fixes it.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 55be00374468..2e9bbec7d1f5 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -4191,7 +4191,7 @@ static ssize_t qm_qos_value_init(const char *buf, unsigned long *val)
 			return -EINVAL;
 	}
 
-	ret = sscanf(buf, "%ld", val);
+	ret = sscanf(buf, "%lu", val);
 	if (ret != QM_QOS_VAL_NUM)
 		return -EINVAL;
 
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
