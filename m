Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A866230EA5C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 03:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbhBDCoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 21:44:00 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:51150 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229601AbhBDCn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 21:43:59 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1l7Uba-000072-C6; Thu, 04 Feb 2021 13:42:51 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 04 Feb 2021 13:42:50 +1100
Date:   Thu, 4 Feb 2021 13:42:50 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     kernel test robot <lkp@intel.com>
Cc:     Thara Gopinath <thara.gopinath@linaro.org>, davem@davemloft.net,
        bjorn.andersson@linaro.org, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com, ebiggers@google.com,
        ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/11] crypto: qce: sha: Restore/save ahash state with
 custom struct in export/import
Message-ID: <20210204024250.GA5482@gondor.apana.org.au>
References: <20210203143307.1351563-2-thara.gopinath@linaro.org>
 <202102040442.I3XzFSaf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202102040442.I3XzFSaf-lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 04:56:17AM +0800, kernel test robot wrote:
> 
> Thank you for the patch! Yet something to improve:

Please fix this before you resubmit again.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
