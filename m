Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45A69406812
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 09:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbhIJH7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 03:59:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:54540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231502AbhIJH7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 03:59:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA8A1611C0;
        Fri, 10 Sep 2021 07:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631260714;
        bh=qEW44e/rMBdOJkJMsqO9sPx/pzJrPokbyHv/GvUXr9I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q+RdmVL6DDC5GQOa7WJ8e485No4PakBBz7Rq5L6vSM/GvKfXPl12XIb6/tAJs1sTH
         I8WzUPr/oeXLLJjdiRA0Ewf3rfhqRagXplQx5ITTKAja1C0mdwViXkcYmoFmy9TC6m
         gZWOx1AKAc/zxd6YtdOchNOx77Y7f/p8h03YdASM=
Date:   Fri, 10 Sep 2021 09:58:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     mzuckerman@habana.ai, dsinger@habana.ai,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: Habanalabs Open-Source TPC LLVM compiler and SynapseAI Core
 library
Message-ID: <YTsQJ753sm701R/n@kroah.com>
References: <CAFCwf119s7iXk+qpwoVPnRtOGcxeuZb3rnihf6NWWoVT-4ODHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf119s7iXk+qpwoVPnRtOGcxeuZb3rnihf6NWWoVT-4ODHA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 10:26:56AM +0300, Oded Gabbay wrote:
> Hi Greg,
> 
> Following our conversations a couple of months ago, I'm happy to tell you that
> Habanalabs has open-sourced its TPC (Tensor Processing Core) LLVM compiler,
> which is a fork of the LLVM open-source project.
> 
> The project can be found on Habanalabs GitHub website at:
> https://github.com/HabanaAI/tpc_llvm
> 
> There is a companion guide on how to write TPC kernels at:
> https://docs.habana.ai/en/latest/TPC_User_Guide/TPC_User_Guide.html

That's great news, thanks for pushing for this and releasing it all!

greg k-h
