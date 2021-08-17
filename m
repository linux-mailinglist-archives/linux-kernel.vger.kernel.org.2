Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5A13EE944
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 11:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235637AbhHQJQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 05:16:39 -0400
Received: from mga02.intel.com ([134.134.136.20]:43009 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234347AbhHQJQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 05:16:39 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10078"; a="203228154"
X-IronPort-AV: E=Sophos;i="5.84,328,1620716400"; 
   d="scan'208";a="203228154"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 02:16:06 -0700
X-IronPort-AV: E=Sophos;i="5.84,328,1620716400"; 
   d="scan'208";a="572825561"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 02:16:01 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 17 Aug 2021 12:15:58 +0300
Date:   Tue, 17 Aug 2021 12:15:58 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Kate Hsuan <hpa@redhat.com>
Cc:     Alex Hung <alex.hung@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        AceLan Kao <acelan.kao@canonical.com>,
        Jithu Joseph <jithu.joseph@intel.com>,
        Maurice Ma <maurice.ma@intel.com>,
        Sujith Thomas <sujith.thomas@intel.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        Zha Qipeng <qipeng.zha@intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        linux-kernel@vger.kernel.org, Dell.Client.Kernel@dell.com,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 06/20] platform/x86: intel_scu: Move to intel
 sub-directory
Message-ID: <YRt+Tnt4tvULM4MP@lahna>
References: <20210816105119.704302-1-hpa@redhat.com>
 <20210816105119.704302-7-hpa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816105119.704302-7-hpa@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 06:51:05PM +0800, Kate Hsuan wrote:
> Move intel_scu to intel sub-directory to improve readability.
> 
> Signed-off-by: Kate Hsuan <hpa@redhat.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
