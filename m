Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14D8F36F1EB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 23:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236907AbhD2VWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 17:22:30 -0400
Received: from mga17.intel.com ([192.55.52.151]:30823 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234795AbhD2VW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 17:22:28 -0400
IronPort-SDR: 6yLbeJ9PqLM/81TaiHfznGJ49l9i/q2LEqV3wb1FSEXQgVoLgGNlBhjf68ff8QY8LwknqNIvt/
 gZMhxMQpQtxQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9969"; a="177257019"
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="scan'208";a="177257019"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 14:21:41 -0700
IronPort-SDR: cQqnHvVZFpTXdDQYf2MPWQn1oXfX6CP+/5Zz+xHh0hS3KRlvf+dI0Ps7INhCh3SDsSpZO+nT+L
 LrJ+JgUTm2lQ==
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="scan'208";a="466506429"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 14:21:41 -0700
Date:   Thu, 29 Apr 2021 14:21:40 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/12] perf intel-pt: Add VM Time Correlation to decoder
Message-ID: <20210429212140.GE4032392@tassilo.jf.intel.com>
References: <20210429125854.13905-1-adrian.hunter@intel.com>
 <20210429125854.13905-12-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429125854.13905-12-adrian.hunter@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> unchanging (during perf record) VMX TSC Offset and no VMX TSC scaling.

For TSC scaling we would need to add side band to KVM, correct?

I suppose it shouldn't be that hard to do that.
