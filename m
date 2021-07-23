Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E012F3D3FF0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 19:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbhGWRL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 13:11:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:51734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231126AbhGWRLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 13:11:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A2ED860EFD;
        Fri, 23 Jul 2021 17:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627062747;
        bh=KTtPF7pVEjcGtNW9vxAs2/t0droJ1W/qrMvVOnKu3bc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nycrF3qC2qe2/JDBW2O+py+deOvbOPME3QFfqlLaj5xNXKlAYzOmd4R9QWeDY+HOc
         MMWSltrM5P7mgdekszfuLRrnhBerJzf5Xvly2Xsee4DAOHe12aMgW+IT6c3kfI5h6O
         Oouygla1yL64jURFy08DKSrMAIH0TpAesHy9PZjLSF4KwWhor5J7IqcxWCSJgPSmDE
         2H5vmMGBmex25Ea0Vg78/hUYHV8pOzTP01Wx+zYk+usmyiQ8yEmUzUt8gztQGnHr38
         3+0W4yZxdjR1q3UVOXYwifD87Kd6B54VyZoWvkqG7ZSPwJNXqxP2urZT1A+vCrQHc/
         rXrDCIiwMUzwQ==
Date:   Fri, 23 Jul 2021 10:52:26 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyaprateek2357@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v4 0/9] ensure bios aren't split in middle of crypto data
 unit
Message-ID: <YPsB2vsJPobULxO0@gmail.com>
References: <20210707052943.3960-1-satyaprateek2357@gmail.com>
 <YPrzMI6P7MzO3V3K@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPrzMI6P7MzO3V3K@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2021 at 09:49:52AM -0700, Eric Biggers wrote:
> On Tue, Jul 06, 2021 at 10:29:34PM -0700, Satya Tangirala wrote:
> > 
> > Changes v3 => v4
> >  - Patch 4 in v3 has been removed (Eric points out it isn't required
> >    without some of the changes in the device mapper patchset at
> >    https://lore.kernel.org/linux-block/20210604210908.2105870-1-satyat@google.com/
> >   so I'll add this patch to that series instead.
> 
> Wouldn't it make more sense to have the blk-crypto-fallback change in this
> series?  My concern was just that it didn't make sense to have it split between
> the two patch series -- it seemed like one logical change.

This series also doesn't actually remove the data_unit_size bvec alignment
requirement from block/blk-crypto.c.  Isn't that the main goal here?  So I
expected that it would be included.

Unless there are special considerations here, I'd expect that all the block
layer changes needed for the fscrypt direct I/O support would be in one patch
series that could go in together, and then the patch series with the direct I/O
support would be only filesystem layer changes.

- Eric
