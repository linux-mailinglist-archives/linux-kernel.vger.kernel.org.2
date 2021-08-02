Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D291A3DDB3B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 16:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbhHBOjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 10:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbhHBOjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 10:39:16 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A6DC06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 07:39:07 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 358D5806; Mon,  2 Aug 2021 16:39:05 +0200 (CEST)
Date:   Mon, 2 Aug 2021 16:38:52 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Luigi Rizzo <lrizzo@google.com>
Cc:     Will Deacon <will@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        David Rientjes <rientjes@google.com>,
        Luigi Rizzo <rizzo.unipi@gmail.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH] amd/iommu: fix logic bug in amd_iommu_report_page_fault()
Message-ID: <YQgDfIcFW5h9TH+n@8bytes.org>
References: <20210731192637.3653796-1-lrizzo@google.com>
 <YQf9h+qvWCx6D7XT@8bytes.org>
 <CAMOZA0LEr+xM6RrsJErPMqHP7-0GdLmNDqbGVKbKTn92=Ncejg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMOZA0LEr+xM6RrsJErPMqHP7-0GdLmNDqbGVKbKTn92=Ncejg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2021 at 04:30:50PM +0200, Luigi Rizzo wrote:
> Ah didn't realize that. Thank you!
> 
> Two questions on the topic:
> 1. how comes only the AMD driver is so verbose in reporting io page faults?
>    Neither intel nor other iommu drivers seem to log anything

What do you mean by 'verbose'? It is only a line per fault, and at least
the Intel driver also logs DMAR faults with one line per fault :)

> 2. Would it make sense to have a control to disable such logging,
>    either per-device or globally? Eg something like this (negative
>    logic so it must be set explicitly to disable logging).

Yes, we can talk about that. But only after the trace-event for it
landed in the code. There must be some way to report the faults and if
userspace prefers to catch them via trace-events than we can disable
printing them to the kernel log.

Regards,

	Joerg
