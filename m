Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F042F30D57C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 09:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbhBCImk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 03:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbhBCImX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 03:42:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0617C061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 00:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=m0J+u/j+uny4CEWAa03yCknMg8b0lzJj8IlB90UmRbQ=; b=Q7u/dXHa1/DQ0U/Lkpo1Tq6SSK
        QCaA+INY0ZIy4LWpqUddCz2I+dyNYlUYb4QtgdkjPwomlDcyVoTuWW+LZy1WBRYSIGOZdEm67pmKO
        KOw7uXDf5NkoHyI+f5MG2kmdAcWtgx5Dqi6wO5mV6d9ViomB+JDdDhATqlY0KLMz5fj+qXkpCuY5z
        LqWwERsqBvXPhvJIg1bWf0WNdwjTgV6jZ8bhCCPiaPg4MLZ1DjtVgXk2A3+y7uNyURN1dgW1oacik
        /j3XIqezFFCdZoUjAyPhyVwqueIDuuegeoASE32zG94oqyV81ips9qTDJbDRoeUGLYWo8yu0CGbQj
        V1W/fmvQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l7Dj6-00GSI9-6E; Wed, 03 Feb 2021 08:41:28 +0000
Date:   Wed, 3 Feb 2021 08:41:28 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org, Yian Chen <yian.chen@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] iommu/vt-d: Add support for ACPI/SATC table
Message-ID: <20210203084128.GA3916610@infradead.org>
References: <20210202044057.615277-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202044057.615277-1-baolu.lu@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021 at 12:40:54PM +0800, Lu Baolu wrote:
> Intel platform VT-d (v3.2) comes with a new type of DMAR subtable
> SATC. The SATC table includes a list of SoC integrated devices
> that require SATC. OS software can use this table to enable ATS
> only for the devices in the list.

This all sounds like gibberish. Please expand and if necessary explain
acronyms when first used in each commit log / cover letter.
