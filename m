Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB234266B0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 11:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235467AbhJHJZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 05:25:38 -0400
Received: from mga09.intel.com ([134.134.136.24]:4224 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235969AbhJHJZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 05:25:32 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="226371404"
X-IronPort-AV: E=Sophos;i="5.85,357,1624345200"; 
   d="scan'208";a="226371404"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2021 02:23:37 -0700
X-IronPort-AV: E=Sophos;i="5.85,357,1624345200"; 
   d="scan'208";a="440583417"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2021 02:23:34 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 08 Oct 2021 12:23:31 +0300
Date:   Fri, 8 Oct 2021 12:23:31 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Werner Sembach <wse@tuxedocomputers.com>
Cc:     benoitg@coeus.ca, bhelgaas@google.com, bp@alien8.de, hpa@zytor.com,
        juhapekka.heikkila@gmail.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, x86@kernel.org
Subject: Re: [PATCH RESEND] x86/resource: Do not exclude regions that are
 marked as MMIO in EFI memmap
Message-ID: <YWAOE5yV9V0/HMET@lahna>
References: <20200617164734.84845-1-mika.westerberg@linux.intel.com>
 <1c225d72-44dc-1ddb-3284-a5d19e0db882@tuxedocomputers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c225d72-44dc-1ddb-3284-a5d19e0db882@tuxedocomputers.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Oct 08, 2021 at 10:55:49AM +0200, Werner Sembach wrote:
> Is there any update on this matter? Also happens on discrete Thunderbolt 4 chips:
> https://bugzilla.kernel.org/show_bug.cgi?id=214259

AFAICT no updates.

@Bjorn, x86 maintainers,

If there are no alternatives can we get this patch merged so that people
don't need to carry out-of-tree patches to get their systems working?
