Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58E4634EC80
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 17:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbhC3Pbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 11:31:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:37860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232224AbhC3PbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 11:31:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6AB2E619A7;
        Tue, 30 Mar 2021 15:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617118269;
        bh=NtE7aeYpAIhUn0tc24UAQobx/yYBi5xZmalsJsMH4Dc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tTGTaCTHJ0XrdCjLcfU+o9chdyDWqDnmVlnbEuGom32oGmV+JhqPd5dBGP5P9D/xl
         n6Wq8R7xqtbCBrNMqvPoMo9IG6TEEHqT61YZKzKwF1+6MEyUDdJGNkKS1ftc+nI0pL
         J4uvSPGmDXKBnoL1g56r/KnrGhpmQ5E7BhjOqoenInO8qoDzOu12ORu8+AKO68bxVm
         VTJ1LzC7TLZxkGMz8OGkX+61n2sVx2C5+jeUn2y89faPLQbsi0fWIUdkgodRq7uCT7
         cNK3ZrMZ0GGpDlLTcV291cpIXmdb8SK+AGQnedN5C5QOuJGt1nqC4pxbLkbWXhv6C1
         iD8kdbSWDthLA==
Date:   Tue, 30 Mar 2021 16:31:04 +0100
From:   Will Deacon <will@kernel.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     Eric Anholt <eric@anholt.net>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Sean Paul <sean@poorly.run>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] iommu/arm-smmu-qcom: Skip the TTBR1 quirk for db820c.
Message-ID: <20210330153050.GB6567@willie-the-truck>
References: <20210326231303.3071950-1-eric@anholt.net>
 <20210329144729.GB4203@willie-the-truck>
 <CAF6AEGugpEk396DVtWX=W+uf3p-wcgBfCSpSLWGQJE1vKpJ4aw@mail.gmail.com>
 <20210330093432.GB5281@willie-the-truck>
 <CAF6AEGvCCWvmRBhzY4MsdzgwfJ+GF2AUOS-_NTyhM8wtnDzY2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF6AEGvCCWvmRBhzY4MsdzgwfJ+GF2AUOS-_NTyhM8wtnDzY2Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 08:03:36AM -0700, Rob Clark wrote:
> On Tue, Mar 30, 2021 at 2:34 AM Will Deacon <will@kernel.org> wrote:
> >
> > On Mon, Mar 29, 2021 at 09:02:50PM -0700, Rob Clark wrote:
> > > On Mon, Mar 29, 2021 at 7:47 AM Will Deacon <will@kernel.org> wrote:
> > > >
> > > > On Fri, Mar 26, 2021 at 04:13:02PM -0700, Eric Anholt wrote:
> > > > > db820c wants to use the qcom smmu path to get HUPCF set (which keeps
> > > > > the GPU from wedging and then sometimes wedging the kernel after a
> > > > > page fault), but it doesn't have separate pagetables support yet in
> > > > > drm/msm so we can't go all the way to the TTBR1 path.
> > > >
> > > > What do you mean by "doesn't have separate pagetables support yet"? The
> > > > compatible string doesn't feel like the right way to determine this.
> > >
> > > the compatible string identifies what it is, not what the sw
> > > limitations are, so in that regard it seems right to me..
> >
> > Well it depends on what "doesn't have separate pagetables support yet"
> > means. I can't tell if it's a hardware issue, a firmware issue or a driver
> > issue.
> 
> Just a driver issue (and the fact that currently we don't have
> physical access to a device... debugging a5xx per-process-pgtables by
> pushing untested things to the CI farm is kind of a difficult way to
> work)

But then in that case, this is using the compatible string to identify a
driver issue, no?

Will
