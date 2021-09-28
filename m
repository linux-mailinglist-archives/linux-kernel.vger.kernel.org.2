Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D65F341B2CA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 17:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241473AbhI1PTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 11:19:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:48096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241350AbhI1PTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 11:19:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9D4646120D;
        Tue, 28 Sep 2021 15:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632842264;
        bh=JTwi0y+kGzO/CZQFpN6CoyMNwE8s4U+X9YE370SODyw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nuGDTiTGeigNdFo4qIzHOcMMdtR32KzzLA4ngFhnH/jG5w38pw7dekM2nzypjlqBX
         mNMBQ4WZSu9BhYo1IVK442cRZPJKzlWDmELjZGdZPWJlkLS0g7r//iKfw7KgAdAaMu
         6oDhIhYSvQ/nxd/WswXpyJNDfr+Y7FAIiYQzbbmzh1JYw25kbMQukxfgvh44BrD8Di
         m+RCXOke6e6N1gElMPUy0YCYfaUXnTIiB3/uIHLPmCARWg0OhtbMY5rPcpBGw3jhnj
         lHZSk7sRRV+HOntWX/cuD1ZccdGn2/B+Iv/2tD9fVET9F9icIIND/+/YT8u6M7ScM/
         Ufv+7FmNFXo2w==
Date:   Tue, 28 Sep 2021 20:47:37 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Md Sadre Alam <mdalam@codeaurora.org>
Cc:     miquel.raynal@bootlin.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, sricharan@codeaurora.org
Subject: Re: [PATCH 0/3] Add support for page scope read
Message-ID: <20210928151737.GA12183@thinkpad>
References: <1631699851-12172-1-git-send-email-mdalam@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1631699851-12172-1-git-send-email-mdalam@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Sep 15, 2021 at 03:27:28PM +0530, Md Sadre Alam wrote:
> These series of patches to support page scope read.
> 
> In QPIC v1, SW is needed to write EXEC_CMD register
> for each Code word and collect any Status related to
> that CW before issueing EXEC_CMD for next CW.
> 
> Page scope command, currently supported only for read
> commands in bam mode, is truly a page mode command where
> SW is required to issue EXEC_CMD only once for a page.
> Controller HW takes care of Codeword specific details
> and automatically returns status associated with each
> CW to BAM pipe, dedicated for status deposition.
> 

This description doesn't clearly convey the intention of the patches. Please
take time to write the cover letter describing what the patches do and how
they solve a problem.

If possible, do mention the platform on which the patches were tested.

And please avoid using Qualcomm specific acronymns such as CW as it only makes
sense to limited amount of people who has access to technical documents.

Thanks,
Mani

> Md Sadre Alam (3):
>   mtd: rawnand: qcom: Add support for status pipe
>   mtd: rawnand: qcom: Add sg list to handle status pipe request
>   mtd: rawnand: qcom: Add support for page scope read
> 
>  drivers/mtd/nand/raw/qcom_nandc.c | 125 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 119 insertions(+), 6 deletions(-)
> 
> -- 
> 2.7.4
> 
