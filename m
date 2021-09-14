Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3AD840A6FE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 09:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240186AbhINHB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 03:01:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:50436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240277AbhINHBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:01:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 62DEF610E6;
        Tue, 14 Sep 2021 07:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631602800;
        bh=djzB+0WNEFw/XlKEoitEKNRrGEZA+fAQHWWOkYAQAAg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BirwWaNeYinjT/DGaZCKkFT3GlTG72mHbt20dAv/NlrU36ll88HmacB8AipeIo8t2
         YA8yO8U199FiggXxfw5tnh5E7+1o3KrFK0aUF29thksOPjYtd1sp0f1YTkiF78oe6c
         U8ikF5hNIbSzdbcKLDwWuw2HPAuvoazBC8rBvu+w=
Date:   Tue, 14 Sep 2021 08:59:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fei Li <fei1.li@intel.com>
Cc:     linux-kernel@vger.kernel.org, yu1.wang@intel.com,
        shuox.liu@gmail.com
Subject: Re: [PATCH v4 0/2] Introduce some interfaces for ACRN hypervisor HSM
 driver
Message-ID: <YUBIbqeDyBELtR6H@kroah.com>
References: <20210914062627.16431-1-fei1.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914062627.16431-1-fei1.li@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 02:26:25PM +0800, Fei Li wrote:
> Add some new interfaces for ACRN hypervisor HSM driver:
>   - MMIO device passthrough
>   - virtual device creating/destroying
>   - platform information fetching from the hypervisor
> 
> ChangeLog:
> v4:
>  - remove "RFC" from Subject field.
> 
> v3:
>  - remove "platform information fetching from the hypervisor". What platform
>    information needs to be fetched has not been finally decided. Will send tis
>    patch out once that has been decided.
>  - add comments where is the userspace code that uses this new api:
>    - MMIO device passthrough
>      (a) assign a MMIO device to a User VM
>      https://github.com/projectacrn/acrn-hypervisor/blob/master/devicemodel/core/vmmapi.c#L562
>      (b) de-assign a MMIO device from a User VM
>      https://github.com/projectacrn/acrn-hypervisor/blob/master/devicemodel/core/vmmapi.c#L568
>    - virtual device creating/destroying
>      (a) create a virtual device for a User VM
>      https://github.com/projectacrn/acrn-hypervisor/blob/master/devicemodel/core/vmmapi.c#L606
>      (b) destroy a virtual device of a User VM
>      https://github.com/projectacrn/acrn-hypervisor/blob/master/devicemodel/core/vmmapi.c#L612

Can you put these comments in the changelog text?  Stuff in the 0/X
email never shows up in the changelog at all.

thanks,

greg k-h
