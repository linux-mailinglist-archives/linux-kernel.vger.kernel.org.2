Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34369410F22
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 06:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbhITE6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 00:58:40 -0400
Received: from mga05.intel.com ([192.55.52.43]:51037 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229695AbhITE6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 00:58:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10112"; a="308606107"
X-IronPort-AV: E=Sophos;i="5.85,307,1624345200"; 
   d="scan'208";a="308606107"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2021 21:57:11 -0700
X-IronPort-AV: E=Sophos;i="5.85,307,1624345200"; 
   d="scan'208";a="702257181"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2021 21:57:10 -0700
Date:   Sun, 19 Sep 2021 21:57:09 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] x86/mce: Get rid of machine_check_vector
Message-ID: <YUgUpXHciLMn4X20@agluck-desk2.amr.corp.intel.com>
References: <20210917105355.2368-1-bp@alien8.de>
 <20210917105355.2368-3-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210917105355.2368-3-bp@alien8.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 12:53:53PM +0200, Borislav Petkov wrote:
> @@ -126,7 +123,9 @@ struct mca_config {
>  	      ser			: 1,
>  	      recovery			: 1,
>  	      bios_cmci_threshold	: 1,
> -	      __reserved		: 59;
> +	      /* Proper #MC exception handler is set */
> +	      initialized		: 1,
> +	      __reserved		: 58;

Does this __reserved field do anything useful? It seems to
just be an annoyance that must be updated each time a new
bit is added. Surely the compiler will see that these bitfields
are in a "u64" and do the math and skip to the right boundary
without this.

-Tony
