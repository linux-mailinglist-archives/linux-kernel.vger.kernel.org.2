Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97E55367386
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 21:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243358AbhDUTj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 15:39:29 -0400
Received: from mga17.intel.com ([192.55.52.151]:62993 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236991AbhDUTj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 15:39:27 -0400
IronPort-SDR: 2RzQ7kAygxLkDPn9PtW28EAGpyJE0G1dbx8+ALmADAISVuPpMfTR+Djewql+4tO/f0mwm5BeoP
 i0eUitH4IOSQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9961"; a="175872745"
X-IronPort-AV: E=Sophos;i="5.82,240,1613462400"; 
   d="scan'208";a="175872745"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 12:38:49 -0700
IronPort-SDR: KGHKLzuMR4dZTseu16R9m6bhXiVTnn7mUYWw8A3XjgXu8YApQvdEj5VCfIq4+NU6VHLQNtnBq8
 fEvmPbP4Wd1Q==
X-IronPort-AV: E=Sophos;i="5.82,240,1613462400"; 
   d="scan'208";a="453035431"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 12:38:49 -0700
Date:   Wed, 21 Apr 2021 12:38:47 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Ray Kinsella <mdr@ashroe.eu>
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org,
        kan.liang@linux.intel.com
Subject: Re: [PATCH] perf tools: Update topdown documentation to permit rdpmc
 calls
Message-ID: <20210421193847.GG1401198@tassilo.jf.intel.com>
References: <20210421091009.1711565-1-mdr@ashroe.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421091009.1711565-1-mdr@ashroe.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 10:10:09AM +0100, Ray Kinsella wrote:
> Update Topdown documentation to permit calls to rdpmc, and describe
> interaction with system calls.
> 
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Ray Kinsella <mdr@ashroe.eu>

Looks good to me.

Reviewed-by: Andi Kleen <ak@linux.intel.com>

-Andi
