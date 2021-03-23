Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8C9345B28
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 10:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhCWJnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 05:43:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229728AbhCWJme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 05:42:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 122E9619B8;
        Tue, 23 Mar 2021 09:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616492554;
        bh=qtCot0i39hBZ+nrGjK9DgAurtMlhpSE9CuHUJ91HGS8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e2YAYnzmiidqkYDCWCXCnXLTObndQ+NnSnRIHuGZBf7flK2ucyeoqqEr5dr0Y1SWi
         aPebEEtlLlhYG+ydRXmYM7nzerrNoMLrTgmXHwjlf0NQo5KcMY+HQkfJblZss1oeL0
         kUG6WTPr1L7aZG5hb/lgOk4Br5GcfcVFhJ8L6Kwc=
Date:   Tue, 23 Mar 2021 10:42:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luiz Sampaio <sampaio.ime@gmail.com>
Cc:     zbr@ioremap.net, rikard.falkeborn@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] w1: ds2438: adding support for accessing page1
 registers
Message-ID: <YFm4CAvBcT3MN87T@kroah.com>
References: <20210323024410.temxutbcfdswctz4@LuizSampaio-PC.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323024410.temxutbcfdswctz4@LuizSampaio-PC.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 11:44:10PM -0300, Luiz Sampaio wrote:
> @@ -395,6 +483,8 @@ static BIN_ATTR_RO(vdd, 0/* real length varies */);
>  static struct bin_attribute *w1_ds2438_bin_attrs[] = {
>  	&bin_attr_iad,
>  	&bin_attr_page0,
> +	&bin_attr_page1,
> +	&bin_attr_offset,

You are adding new sysfs files, but no new Documentation/ABI entries :(

please fix that up for your next submission.

thanks,

greg k-h
