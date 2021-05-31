Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEB63959C9
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 13:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbhEaLhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 07:37:32 -0400
Received: from mga01.intel.com ([192.55.52.88]:30574 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230521AbhEaLha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 07:37:30 -0400
IronPort-SDR: YJIWo4sXxqWLREc2qR/X5uCNCXH+ieF4Vwln73qvwKBsuNZEhS/nrUPJTrGLYvrlhGsBdcegmK
 PQ+YUwmde0Ow==
X-IronPort-AV: E=McAfee;i="6200,9189,10000"; a="224611864"
X-IronPort-AV: E=Sophos;i="5.83,237,1616482800"; 
   d="scan'208";a="224611864"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2021 04:35:50 -0700
IronPort-SDR: EwhPpeYF8JhDXtvE8JZoIrPXCFPww37l/oXMh7xqDCa0MVLoMWqmCmU3DGrgm4eWvhOw7cC0eD
 83hosS9TlagQ==
X-IronPort-AV: E=Sophos;i="5.83,237,1616482800"; 
   d="scan'208";a="482063020"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2021 04:35:46 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 31 May 2021 14:35:44 +0300
Date:   Mon, 31 May 2021 14:35:44 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Crag Wang <crag0715@gmail.com>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        mario.limonciello@outlook.com, crag.wang@dell.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] thunderbolt: add self-authenticate support for new
 dock
Message-ID: <YLTKEE86Dxu1LeYE@lahna.fi.intel.com>
References: <crag.wang@dell.com>
 <20210527084504.7310-1-crag.wang@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210527084504.7310-1-crag.wang@dell.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 04:45:03PM +0800, Crag Wang wrote:
> Add new device known to support self-authenticate on disconnect.
> 
> Signed-off-by: Crag Wang <crag.wang@dell.com>

I changed "From: " to match your SoB address and applied to
thunderbolt.git/next with Mario's tag, thanks!
