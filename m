Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 408B43AA318
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 20:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbhFPSX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 14:23:56 -0400
Received: from mga06.intel.com ([134.134.136.31]:3914 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231613AbhFPSXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 14:23:54 -0400
IronPort-SDR: CveIIHcCkEQJVX2ITtxgZjyCDeCp7fGJHaqucpfiwXDZlepVjkYn5HrIs97zVLVSYYCFnF80re
 zKg0hOZFzZ/w==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="267381688"
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="267381688"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 11:21:44 -0700
IronPort-SDR: TAXASZ2wg6GqcmMAMM6k+m6GCy2E/zxTT94IQJ1jJxrBOBT+m/pykiLwDUCEdctXbMFkdMS20j
 nzhCXc9r+fZg==
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="554902820"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 11:21:44 -0700
Received: from mtg-dev.jf.intel.com (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id 15DC1636F;
        Wed, 16 Jun 2021 11:21:44 -0700 (PDT)
Received: by mtg-dev.jf.intel.com (Postfix, from userid 1000)
        id 0C92336133F; Wed, 16 Jun 2021 11:21:28 -0700 (PDT)
Date:   Wed, 16 Jun 2021 11:21:28 -0700
From:   mark gross <mgross@linux.intel.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Mark Gross <mgross@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/29] docs: admin-guide: hw-vuln: avoid using ReST
 :doc:`foo` markup
Message-ID: <20210616182128.GJ70758@linux.intel.com>
Reply-To: mgross@linux.intel.com
References: <cover.1623824363.git.mchehab+huawei@kernel.org>
 <4e378517761f3df07165d5ecdac5a0a81577e68f.1623824363.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e378517761f3df07165d5ecdac5a0a81577e68f.1623824363.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 08:27:19AM +0200, Mauro Carvalho Chehab wrote:
> The :doc:`foo` tag is auto-generated via automarkup.py.
and that is not good why?

> So, use the filename at the sources, instead of :doc:`foo`.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../hw-vuln/special-register-buffer-data-sampling.rst          | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/hw-vuln/special-register-buffer-data-sampling.rst b/Documentation/admin-guide/hw-vuln/special-register-buffer-data-sampling.rst
> index 3b1ce68d2456..966c9b3296ea 100644
> --- a/Documentation/admin-guide/hw-vuln/special-register-buffer-data-sampling.rst
> +++ b/Documentation/admin-guide/hw-vuln/special-register-buffer-data-sampling.rst
> @@ -3,7 +3,8 @@
>  SRBDS - Special Register Buffer Data Sampling
>  =============================================
>  
> -SRBDS is a hardware vulnerability that allows MDS :doc:`mds` techniques to
I thought the point of :doc:`mds` was to insert a tag or link to the mds
document.

> +SRBDS is a hardware vulnerability that allows MDS
> +Documentation/admin-guide/hw-vuln/mds.rst techniques to
will this make a hyper-link in generated HTML docs?

FWIW I'm ok with this change either way.  I just wanted to understand a little
better.

--mark

>  infer values returned from special register accesses.  Special register
>  accesses are accesses to off core registers.  According to Intel's evaluation,
>  the special register reads that have a security expectation of privacy are
> -- 
> 2.31.1
> 
