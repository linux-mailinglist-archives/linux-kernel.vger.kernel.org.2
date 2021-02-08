Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80418312881
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 01:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhBHAFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 19:05:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:38508 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229522AbhBHAFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 19:05:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0996EAB98;
        Mon,  8 Feb 2021 00:04:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 76B90DA80F; Mon,  8 Feb 2021 01:02:41 +0100 (CET)
Date:   Mon, 8 Feb 2021 01:02:41 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Amy Parker <enbyamy@gmail.com>
Cc:     schnelle@linux.ibm.com, corbet@lwn.net, mchehab+huawei@kernel.org,
        tsbogend@alpha.franken.de, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ia64: Fix style guide breakage
Message-ID: <20210208000241.GN1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Amy Parker <enbyamy@gmail.com>,
        schnelle@linux.ibm.com, corbet@lwn.net, mchehab+huawei@kernel.org,
        tsbogend@alpha.franken.de, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210205220618.611388-1-enbyamy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205220618.611388-1-enbyamy@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 02:06:18PM -0800, Amy Parker wrote:
> Some statements do not have proper spacing between their C
> keywords (commonly if and for) throughout files in the ia64 tree.
> This patch corrects this to follow the kernel code style guide.
> 
> Signed-off-by: Amy Parker <enbyamy@gmail.com>
> ---
>  arch/ia64/hp/common/sba_iommu.c  | 6 +++---
>  arch/ia64/kernel/machine_kexec.c | 2 +-
>  arch/ia64/kernel/palinfo.c       | 6 +++---

ia64 got orphaned and not maintained in 96ec72a3425d1515b6, it's just
not really worth the time to spend the time cleaning up the code base.
