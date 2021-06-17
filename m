Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECF063ABD71
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 22:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbhFQUdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 16:33:02 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52348 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbhFQUc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 16:32:59 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A9B4521B1C;
        Thu, 17 Jun 2021 20:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623961850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7MrOSZdFOt9wTUVyZxzKZ+9qRk1GhEPDQuhCcMSdan0=;
        b=Nzml9LQc5a54Z6G6NC24xdoLvkPsFpO/is604opqVvgX7yV9TeF13FFC+5J8sv4fSo2JR8
        ZezTUrpJe6WMXC9X7cmUOKL12NEs7iEo5p/kYbX+gYyRfSITZoHufdpn9VkFd7ki/Sg96f
        MbB0pLsV6iBvUhdOca9xfx47z6t7ueI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623961850;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7MrOSZdFOt9wTUVyZxzKZ+9qRk1GhEPDQuhCcMSdan0=;
        b=AFKiXakYcmVG5XKv+m6WtjG96wImTTAwKdUtoWj6WX9fuBYwl/6wkJQnxqIqUOyKcjnnVV
        gwQh/Dw8CKd88WDA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 50E7A118DD;
        Thu, 17 Jun 2021 20:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623961850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7MrOSZdFOt9wTUVyZxzKZ+9qRk1GhEPDQuhCcMSdan0=;
        b=Nzml9LQc5a54Z6G6NC24xdoLvkPsFpO/is604opqVvgX7yV9TeF13FFC+5J8sv4fSo2JR8
        ZezTUrpJe6WMXC9X7cmUOKL12NEs7iEo5p/kYbX+gYyRfSITZoHufdpn9VkFd7ki/Sg96f
        MbB0pLsV6iBvUhdOca9xfx47z6t7ueI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623961850;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7MrOSZdFOt9wTUVyZxzKZ+9qRk1GhEPDQuhCcMSdan0=;
        b=AFKiXakYcmVG5XKv+m6WtjG96wImTTAwKdUtoWj6WX9fuBYwl/6wkJQnxqIqUOyKcjnnVV
        gwQh/Dw8CKd88WDA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id waNDEfqwy2ASDgAALh3uQQ
        (envelope-from <jroedel@suse.de>); Thu, 17 Jun 2021 20:30:50 +0000
Date:   Thu, 17 Jun 2021 22:30:48 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] iommu/vt-d: Fix W=1 clang warning in intel/perf.c
Message-ID: <YMuw+LtM/B1QTTJI@suse.de>
References: <20210617145339.2692-1-joro@8bytes.org>
 <CAKwvOd=8jUsRFKg6+sqq2-DakbRBGR6Z6mR_smuxp+cMEmCHLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=8jUsRFKg6+sqq2-DakbRBGR6Z6mR_smuxp+cMEmCHLw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 10:16:50AM -0700, Nick Desaulniers wrote:
> On Thu, Jun 17, 2021 at 7:54 AM Joerg Roedel <joro@8bytes.org> wrote:
> >
> > From: Joerg Roedel <jroedel@suse.de>
> >
> > Fix this warning when compiled with clang and W=1:
> >
> >         drivers/iommu/intel/perf.c:16: warning: Function parameter or member 'latency_lock' not described in 'DEFINE_SPINLOCK'
> >         drivers/iommu/intel/perf.c:16: warning: expecting prototype for perf.c(). Prototype was for DEFINE_SPINLOCK() instead
> 
> I think these warnings are actually produced by kernel-doc? (not clang)

Will kernel-doc check automatically when COMPILER=clang is set and W=1?
Because I did not explicitly enable any kernel-doc checks.

Regards,

	Joerg
