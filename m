Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6849360DF6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 17:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbhDOPHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 11:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234640AbhDOO7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 10:59:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A213DC061761
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 07:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5590gHpbK5FgZNV6w4mBWeptu22O3ONqcmsDN5oTQWM=; b=hwkUtgWDfy9MIDQrmjeIiVdmZB
        Ns1dR9E5us/LETy9j3UJv40A6Ya7U3V+rd0cs2BWa/WL3oxxi8ntp1x2xkyrHBGO4oNuzCDpFy0hP
        IdzmW09/Dc7K3keRdaxjs0RXjZOM5rOFazwBL/P15vzKTfOikcG6xe3R7YnYIpNIq08wyP+TBpjhA
        GNdg+NP2E7AW6hVii+xSMaCd5S1UqTZ2pwnGQV+hRSVfXgxu//wLLXLGAv9wEiho1OSa2l/5BUre7
        Khdujyc6QrBD4HcFEaF3EQcoSVZT5o0bUu0xNPNrhP6C5mm53pHX4dkrD6hVnEkJEix1Bv7C0v3O5
        qlY3gUMw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lX3R7-008hrh-2Z; Thu, 15 Apr 2021 14:57:46 +0000
Date:   Thu, 15 Apr 2021 15:57:41 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] iommu/fsl-pamu: Fix uninitialized variable warning
Message-ID: <20210415145741.GA2074523@infradead.org>
References: <20210415144442.25103-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415144442.25103-1-joro@8bytes.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 04:44:42PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> The variable 'i' in the function update_liodn_stash() is not
> initialized and only used in a debug printk(). So it has no
> meaning at all, remove it.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Sorry for introducing this.  The fix looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
