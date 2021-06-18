Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B4C3AC580
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 09:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbhFRH7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 03:59:35 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:54884 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbhFRH7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 03:59:34 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7B5AD1FDE7;
        Fri, 18 Jun 2021 07:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624003044; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=00PGLHSy+8q9cRmQ8fgZXfLgJHGTi7QAl5WB49PoiEY=;
        b=NlPIItnwAI7vEYQyT3Nf6AimO6jm0zVj46b/cqshLivcLlvrDhFn1TpBPyRB4cwwL/BRI7
        SrQLjSyqffKPvMgRaPwtP7YHRL/nf2rfQZMpyoq9L68ugkg8HeIL4kSnNWvmffzQS/Yln1
        hxvOWCC6jp5yTgkVoWer1VVCK+kp1/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624003044;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=00PGLHSy+8q9cRmQ8fgZXfLgJHGTi7QAl5WB49PoiEY=;
        b=BWmbx4uWUUSAHrzr4+MS4N6T7M2PNVfdBol3/YMZzHBXWQqKw/6q7LVz0R3JBs3mH/85nE
        Y/GtZbc80bG/CEDQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 1EB6E118DD;
        Fri, 18 Jun 2021 07:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624003044; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=00PGLHSy+8q9cRmQ8fgZXfLgJHGTi7QAl5WB49PoiEY=;
        b=NlPIItnwAI7vEYQyT3Nf6AimO6jm0zVj46b/cqshLivcLlvrDhFn1TpBPyRB4cwwL/BRI7
        SrQLjSyqffKPvMgRaPwtP7YHRL/nf2rfQZMpyoq9L68ugkg8HeIL4kSnNWvmffzQS/Yln1
        hxvOWCC6jp5yTgkVoWer1VVCK+kp1/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624003044;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=00PGLHSy+8q9cRmQ8fgZXfLgJHGTi7QAl5WB49PoiEY=;
        b=BWmbx4uWUUSAHrzr4+MS4N6T7M2PNVfdBol3/YMZzHBXWQqKw/6q7LVz0R3JBs3mH/85nE
        Y/GtZbc80bG/CEDQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id mCyyBeRRzGCGVAAALh3uQQ
        (envelope-from <jroedel@suse.de>); Fri, 18 Jun 2021 07:57:24 +0000
Date:   Fri, 18 Jun 2021 09:57:22 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] iommu/vt-d: Fix W=1 clang warning in intel/perf.c
Message-ID: <YMxR4ggRGZQZbiz1@suse.de>
References: <20210617145339.2692-1-joro@8bytes.org>
 <CAKwvOd=8jUsRFKg6+sqq2-DakbRBGR6Z6mR_smuxp+cMEmCHLw@mail.gmail.com>
 <YMuw+LtM/B1QTTJI@suse.de>
 <32f14288-315a-b75d-913b-2fc6a16cd748@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32f14288-315a-b75d-913b-2fc6a16cd748@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 01:51:24PM -0700, Nathan Chancellor wrote:
> kernel-doc is run automatically with W=1, regardless of gcc versus clang.

I see, thanks. Will update the commit message.

Thanks,

	Joerg
