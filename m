Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36663380550
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 10:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbhENIgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 04:36:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:49934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229704AbhENIgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 04:36:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C526561451;
        Fri, 14 May 2021 08:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620981299;
        bh=ZZijL+4w53z3Oyg5QFVGQzR6W72Z3123GD2IHs2q7XU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cS6wx7Q+o8UbLOCQdbm9cHqx5Zk/PyBhqOjGprpsB47KeeBEy7POxGT3256ZUEQOp
         krsj0hJa7aYIm0Y1U8ZXdZO2rfueBldBmJV/HPvexoGex/16BTtbol0IUWh6BWMxPv
         4SRfEU0dY6rum89fVtRVjmeKNVmsV4Kixc46vSOU=
Date:   Fri, 14 May 2021 10:33:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Guy Zadicario <guy.zadicario@intel.com>
Cc:     linux-kernel@vger.kernel.org, olof@lixom.net,
        alexander.shishkin@linux.intel.com, andriy.shevchenko@intel.com,
        yochai.shefi-simchon@intel.com
Subject: Re: [PATCH v2 00/15] misc: nnpi: New PCIe driver for Intel's NNP-I
 pcie device
Message-ID: <YJ4121X/fkSkeHaj@kroah.com>
References: <20210513085725.45528-1-guy.zadicario@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513085725.45528-1-guy.zadicario@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 11:57:10AM +0300, Guy Zadicario wrote:
> Hi,
> 
> The following series is a driver for a new PCIe device from Intel named NNP-I
> (Nirvana Neural Processor for Inference). NNP-I is a PCIe connected compute
> device used for acceleration of AI deep learning inference applications in the
> data-center.

How does this differ from the "intel_gna" driver being proposed here:
	https://lore.kernel.org/linux-doc/20210513110040.2268-1-maciej.kwapulinski@linux.intel.com/

Please work together to come up with a unified userspace api for these
devices, and hopefully, shared kernel code as well.

thanks,

greg k-h
