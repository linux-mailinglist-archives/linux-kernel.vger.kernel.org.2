Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C42A346664
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 18:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhCWRag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 13:30:36 -0400
Received: from mga18.intel.com ([134.134.136.126]:35528 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230100AbhCWRaB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 13:30:01 -0400
IronPort-SDR: US9CPLsCfhn9B1Ott+uPBM68GVqlebU2CVH7lQFIX2u3pSPYMi0BmISZegezLgB8Ib3nIf9kLV
 EqRc9v8nSNtA==
X-IronPort-AV: E=McAfee;i="6000,8403,9932"; a="178093862"
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="178093862"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 10:30:00 -0700
IronPort-SDR: KUJwac/S3xmUbxV8v0k6vFjfYAUfW9A5HtKSSdDzbH5HXWIJxYcfpTX8RRVRiSOUsjm1cbS9WD
 D5HRWdTRlywQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="604375357"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 23 Mar 2021 10:29:59 -0700
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.54.75.159])
        by linux.intel.com (Postfix) with ESMTP id AEDF2580718;
        Tue, 23 Mar 2021 10:29:59 -0700 (PDT)
Message-ID: <425422a30006a869f8cbefce3ee6be8764b2b03c.camel@linux.intel.com>
Subject: Re: [PATCH 1/2] platform/x86: intel_pmt_class: Initial resource to 0
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     hdegoede@redhat.com, mgross@linux.intel.com
Cc:     lee.jones@linaro.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 23 Mar 2021 10:29:59 -0700
In-Reply-To: <20210317024455.3071477-1-david.e.box@linux.intel.com>
References: <20210317024455.3071477-1-david.e.box@linux.intel.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-03-16 at 19:44 -0700, David E. Box wrote:
> Initialize the struct resource in intel_pmt_dev_register to zero to
> avoid a
> fault should the char *name field be non-zero.

Hi Hans. Can these 2 patches be pulled as fixes for 5.12? Thanks.

David

> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
> 
> Base commit is v5.12-rc3.
> 
>  drivers/platform/x86/intel_pmt_class.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel_pmt_class.c
> b/drivers/platform/x86/intel_pmt_class.c
> index c8939fba4509..ee2b3bbeb83d 100644
> --- a/drivers/platform/x86/intel_pmt_class.c
> +++ b/drivers/platform/x86/intel_pmt_class.c
> @@ -173,7 +173,7 @@ static int intel_pmt_dev_register(struct
> intel_pmt_entry *entry,
>                                   struct intel_pmt_namespace *ns,
>                                   struct device *parent)
>  {
> -       struct resource res;
> +       struct resource res = {0};
>         struct device *dev;
>         int ret;
>  
> 
> base-commit: 1e28eed17697bcf343c6743f0028cc3b5dd88bf0


