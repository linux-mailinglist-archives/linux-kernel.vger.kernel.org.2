Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 529F136F1F3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 23:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237128AbhD2VZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 17:25:38 -0400
Received: from mga12.intel.com ([192.55.52.136]:10844 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234795AbhD2VZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 17:25:37 -0400
IronPort-SDR: kHULhD7NfTto3ey2ESbfsRuA444w3yw56yOxxKpJGE01TcPosw1icXP+2MzBjjOkFAxhSm4YcW
 yDXMHFvuFtXA==
X-IronPort-AV: E=McAfee;i="6200,9189,9969"; a="176604964"
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="scan'208";a="176604964"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 14:24:50 -0700
IronPort-SDR: pIExdMjsRZ6/PowoBVCe6xoJ8UV7lYzAYb1HogPS/8EHIvzA/amU80PQvJpUmZ7461e/9WSlHp
 7/fG+J0KamjA==
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="scan'208";a="426174323"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 14:24:50 -0700
Date:   Thu, 29 Apr 2021 14:24:48 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/12] perf intel-pt: Parse VM Time Correlation options
 and set up decoding
Message-ID: <20210429212448.GF4032392@tassilo.jf.intel.com>
References: <20210429125854.13905-1-adrian.hunter@intel.com>
 <20210429125854.13905-13-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429125854.13905-13-adrian.hunter@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +Note the options for 'perf inject' --vm-time-correlation are:
> +
> + [ dry-run ] [ <TSC Offset> [ : <VMCS> [ , <VMCS> ]... ]  ]...

Can you describe what dry-run does?

