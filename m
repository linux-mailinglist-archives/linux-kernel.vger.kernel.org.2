Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD24357E42
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 10:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhDHIia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 04:38:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:43504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229539AbhDHIi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 04:38:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2325E61164;
        Thu,  8 Apr 2021 08:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617871097;
        bh=EKla77SyEE6T1IP9Pxi4AGFbASgxAkPmq1KCXqQuZno=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=goWJm9RhgyKuNh03lo5q4cSfTABSVGna27lFbZWGokfszw7t0e5WeAEFWQK/imU8e
         v0wxWyEpSXKOlEGZUV1GfkPNkg30uBwtt3UTxEq5WDSsFtUNQcPzC1evE08JVnkI5O
         /hp0t2+PxYRrDBA8F+sS8crSgm6LQO3/YHELIcQE=
Date:   Thu, 8 Apr 2021 10:38:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-usb <linux-usb@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 1/1] usb: typec: tcpm: remove unused static variable
 'tcpm_altmode_ops'
Message-ID: <YG7A94eekRgvskUg@kroah.com>
References: <20210407091540.2815-1-thunder.leizhen@huawei.com>
 <YG6+mfqIc15rc9H1@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YG6+mfqIc15rc9H1@kuha.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 11:28:09AM +0300, Heikki Krogerus wrote:
> On Wed, Apr 07, 2021 at 05:15:40PM +0800, Zhen Lei wrote:
> > Fixes the following W=1 kernel build warning:
> > 
> > drivers/usb/typec/tcpm/tcpm.c:2107:39: warning: ‘tcpm_altmode_ops’ defined but not used [-Wunused-const-variable=]
> > 
> > The reference to the variable 'tcpm_altmode_ops' is deleted by the
> > commit a079973f462a ("usb: typec: tcpm: Remove tcpc_config configuration
> > mechanism").
> > 
> > By the way, the static functions referenced only by the variable
> > 'tcpm_altmode_ops' are deleted accordingly.
> > 
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> 
> Oh, I thought this was already fixed. Should this go into the stable
> trees as well?

We do not build kernels by default with "W=1" yet, so it's not needed
in stable kernels.

thanks,

greg k-h
