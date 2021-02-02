Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEF930C556
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 17:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236207AbhBBQTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 11:19:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:51200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234277AbhBBOPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 09:15:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ADCFF65055;
        Tue,  2 Feb 2021 13:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612274027;
        bh=iPWZ1a3GkBhhRcShqTp5ZRZgLWTVYizimDRPKo1F5vE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=djcoWc+AVlGkEO7ARJv0skxY6a4S2x4ZqbYna+fHmImYOY2bu81rQvD3Dhdj3Byeg
         fV0NaSQghBkXstj9/GJn/PRNCY7eSA5GZdPmYi1Iojkns3YeRac/Z5STEoT3OE6Eke
         kqtznJv2R4F0bZxZPvOr7GlAENose8caFcjSrPabrz7psZXwy75XuIwXNPF0tQIBcE
         roGP5p9X7yL4PcxzCkNfsOFd2tO9dsS94x+LR6M4edHLkXYaTlO/uA14vHeWvRePDR
         e6X+sswn61SmmqYlqMdMJib9FFscH7QjX8pJ3ibnhWVyDrfN1dizctTBhW2zlhGCAW
         zasSdszXjylag==
Date:   Tue, 2 Feb 2021 13:53:41 +0000
From:   Will Deacon <will@kernel.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, jean-philippe@linaro.org,
        kernel-team@android.com, yong.wu@mediatek.com
Subject: Re: [GIT PULL] iommu/arm-smmu: Updates for 5.12
Message-ID: <20210202135339.GC17070@willie-the-truck>
References: <20210201154633.GC15263@willie-the-truck>
 <20210202133456.GT32671@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202133456.GT32671@8bytes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021 at 02:34:56PM +0100, Joerg Roedel wrote:
> On Mon, Feb 01, 2021 at 03:46:33PM +0000, Will Deacon wrote:
> >   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates
> 
> Pulled, thanks Will.

Cheers, Joerg. Doug spotted a thinko in one of the patches, so you'll want
to apply this guy on top:

https://lore.kernel.org/r/20210201170611.1.I64a7b62579287d668d7c89e105dcedf45d641063@changeid

Will
