Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08C7F338B88
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 12:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbhCLLcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 06:32:41 -0500
Received: from mga01.intel.com ([192.55.52.88]:5629 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233742AbhCLLcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 06:32:10 -0500
IronPort-SDR: PiyDYWHhTZfSn09pBaD8PQI+D8q7AhBz3uNCvpAyUVRxhywYJCBQX4J9ROT775ucV0PsnIx5cP
 pa2C2Pv/ZMnQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9920"; a="208658799"
X-IronPort-AV: E=Sophos;i="5.81,243,1610438400"; 
   d="scan'208";a="208658799"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 03:32:10 -0800
IronPort-SDR: GetBU+v9+PpTFxa0SNpQdMuINbqrpXRN7JVNCBQ+GF9128MpNFsLePtw7OM0ulZuO22cvIlqOw
 P1oBQNlcg/PQ==
X-IronPort-AV: E=Sophos;i="5.81,243,1610438400"; 
   d="scan'208";a="387326040"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 03:32:07 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lKg1U-00BpyJ-TL; Fri, 12 Mar 2021 13:32:04 +0200
Date:   Fri, 12 Mar 2021 13:32:04 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>,
        Fiona Trahe <fiona.trahe@intel.com>, qat-linux@intel.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] crypto: qat: fix couple crashes duing error handling
Message-ID: <YEtRNIFD3Ff8fq5O@smile.fi.intel.com>
References: <20210312074357.2384087-1-ztong0001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312074357.2384087-1-ztong0001@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 02:43:56AM -0500, Tong Zhang wrote:
> There are a couple of issues in qat error handling. Those drivers tries to
> release resources that is not initialized. This patch series tries to fix
> crashes caused by incorrect error handling.

Please, in this series and everywhere else use a common sense, when put
backtraces, oopses, etc in the commit message, i.e. leave only ~2-3
(significant) lines instead of 20-30.

-- 
With Best Regards,
Andy Shevchenko


