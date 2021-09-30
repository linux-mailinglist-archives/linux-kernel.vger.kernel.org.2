Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8346A41DDF2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 17:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346301AbhI3PtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 11:49:20 -0400
Received: from mga09.intel.com ([134.134.136.24]:14013 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346273AbhI3PtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 11:49:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10123"; a="225256719"
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; 
   d="scan'208";a="225256719"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2021 08:47:36 -0700
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; 
   d="scan'208";a="655938105"
Received: from kjepstei-mobl.amr.corp.intel.com (HELO ldmartin-desk2) ([10.212.192.243])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2021 08:47:36 -0700
Date:   Thu, 30 Sep 2021 08:47:36 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     intel-gfx@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@intel.com>,
        dri-devel@lists.freedesktop.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] drm/i915: rename IS_ACTIVE
Message-ID: <20210930154736.3iunv53fko6oa6au@ldmartin-desk2>
X-Patchwork-Hint: comment
References: <20210929183357.1490204-1-lucas.demarchi@intel.com>
 <20210929183357.1490204-2-lucas.demarchi@intel.com>
 <87fstmuyrm.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87fstmuyrm.fsf@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 01:46:21PM +0300, Jani Nikula wrote:
>On Wed, 29 Sep 2021, Lucas De Marchi <lucas.demarchi@intel.com> wrote:
>> It took me some time to understand the need for IS_ACTIVE and why we
>> couldn't use kconfig.h.
>
>For anyone else wondering, the clues are in babaab2f4738 ("drm/i915:
>Encapsulate kconfig constant values inside boolean predicates").

yeah, I had added that info on the third patch when I try to move the
macro to kconfig.h since it would give information for kconfig
developers on why the macro is being used.

>
>But this series tries to take it further; we currently don't have a need
>for checking whether the config is defined or not. It always is. I mean
>it's probably a useful feature, but not the original problem we had.

yep, not trying to push hard on that direction... just tried to have the
same thing the other macros on kconfig.h have.

thanks
Lucas De Marchi
