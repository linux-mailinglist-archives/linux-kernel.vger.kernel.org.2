Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C92B30588B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 11:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235686AbhA0Kfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 05:35:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:41342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S314064AbhAZW7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 17:59:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 83EB12065C;
        Tue, 26 Jan 2021 22:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611701934;
        bh=DPI1qcDmMX4hrFSfvmzwSwmCA1l7WPwRHTNDlPNQToA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mm0Z1SIWS0N3Akfjt8Mq6O80Iz+Rq4ii5XVvJCJJt2NBJ1Cw/rLDnwirFK3ASNH9f
         VB1uOAHH9kkDCM7N25x7l5YY3PTLX00gmQbIE7Y3RQSAOZrdbTucXyDXF3+AukQ5K9
         mHrGg6IMQJxAMYYEfR1JzDBWYkpFYk7AT+38KH7/dRcCzQCUNbXC9CDUeF86Gs+VNB
         EfBLudpXvHS606RRZ98yGG5cbgqGQw/j5LQ6CEWZ0dVpGD/07nCd3O8xUjq50d4U+P
         clX+jbM3a9/uv73FE88+7HANYoRNxI1tRUbrLjSq/oE2LY0V24LVPryJBHWDX3QYE6
         jmyr6+v2mRZTQ==
Date:   Tue, 26 Jan 2021 22:58:48 +0000
From:   Will Deacon <will@kernel.org>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, linux-mm@kvack.org, mark.rutland@arm.com,
        steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de,
        selindag@gmail.com, tyhicks@linux.microsoft.com
Subject: Re: [PATCH v10 00/18] arm64: MMU enabled kexec relocation
Message-ID: <20210126225847.GC30941@willie-the-truck>
References: <20210125191923.1060122-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210125191923.1060122-1-pasha.tatashin@soleen.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On Mon, Jan 25, 2021 at 02:19:05PM -0500, Pavel Tatashin wrote:
> Changelog:
> v10:
> 	- Addressed a lot of comments form James Morse and from  Marc Zyngier
> 	- Added review-by's
> 	- Synchronized with mainline

This series has been doing the rounds for a while, but still isn't fully
reviewed. Would it help if I merged, e.g. the first 12 patches to reduce the
amount you have to repost?

Will
