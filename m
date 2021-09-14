Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78C7240A678
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 08:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239813AbhINGIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 02:08:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:40632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238788AbhINGIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 02:08:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0EBE660EB4;
        Tue, 14 Sep 2021 06:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631599641;
        bh=0E+b9q6NU2EFfDBMlofZHdv0xH90MoQM52rsZZ1Yiz4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UFOOA5oMW/BX5DUQjfbjhim5Eo/N6co32z5DzQ9967NanM+nizwx10tUGpyj8wPFd
         LdH94u/211Uwd4YHHuHAi6RHzyaMknn/MpHQbau3EpXAWZmmJy1RkZJfTQg0KVRNoa
         8dx3Arzqj988inMgifdgU5ut1PLDT/PBlN3qjNgg=
Date:   Tue, 14 Sep 2021 08:07:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fei Li <fei1.li@intel.com>
Cc:     linux-kernel@vger.kernel.org, yu1.wang@intel.com,
        shuox.liu@gmail.com
Subject: Re: [RFC PATCH v3 0/2] Introduce some interfaces for ACRN hypervisor
 HSM driver
Message-ID: <YUA8Bb7OGg59eEzE@kroah.com>
References: <20210914060141.16187-1-fei1.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914060141.16187-1-fei1.li@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 02:01:39PM +0800, Fei Li wrote:
> Add some new interfaces for ACRN hypervisor HSM driver:
>   - MMIO device passthrough
>   - virtual device creating/destroying
>   - platform information fetching from the hypervisor

"RFC" means that you do not feel good about having these merged.  What
needs to be finished before you send a "real" set of patches that you
want to have reviewed properly?

thanks,

greg k-h
