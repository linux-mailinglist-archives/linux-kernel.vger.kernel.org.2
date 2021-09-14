Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97DA440A6A0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 08:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240015AbhINGU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 02:20:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:45718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239868AbhINGU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 02:20:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 43CD0606A5;
        Tue, 14 Sep 2021 06:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631600382;
        bh=UpwBI+mSxlqYmMT51BQI5Iwo4wckiGUeFISj/DiPsrg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JhNPZOGtjHU71d9G0emRvbRb9m9kbWzBZFsLbRglrUQEG1Rt8Fhm8EEEPcXeAiEb8
         ovNFtLLFJ6gMsaqM2+Qu+mdAYK16Kd7lj3Ssq2E5kGb/BiXMkQgFRuNXgYfKod1SRH
         WL7SpHIPm1nv7IThkhYJxFDEmAF03tXDe4kCPcNU=
Date:   Tue, 14 Sep 2021 08:19:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Li Fei1 <fei1.li@intel.com>
Cc:     linux-kernel@vger.kernel.org, yu1.wang@intel.com,
        shuox.liu@gmail.com
Subject: Re: [RFC PATCH v3 0/2] Introduce some interfaces for ACRN hypervisor
 HSM driver
Message-ID: <YUA+6XutXRtOjm4u@kroah.com>
References: <20210914060141.16187-1-fei1.li@intel.com>
 <YUA8Bb7OGg59eEzE@kroah.com>
 <20210914061419.GA16275@louislifei-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914061419.GA16275@louislifei-OptiPlex-7050>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 02:14:19PM +0800, Li Fei1 wrote:
> On Tue, Sep 14, 2021 at 08:07:01AM +0200, Greg KH wrote:
> > On Tue, Sep 14, 2021 at 02:01:39PM +0800, Fei Li wrote:
> > > Add some new interfaces for ACRN hypervisor HSM driver:
> > >   - MMIO device passthrough
> > >   - virtual device creating/destroying
> > >   - platform information fetching from the hypervisor
> > 
> > "RFC" means that you do not feel good about having these merged.  What
> > needs to be finished before you send a "real" set of patches that you
> > want to have reviewed properly?
> 
> Hi Greg
> 
> Sorry, please ignore the "RFC".
> I feel good about these patches. Would you help to review these patches ?

They are gone from my queue, please resend without the "RFC".

thanks,

greg k-h
