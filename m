Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBB9939F188
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 10:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhFHJB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 05:01:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:58594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229548AbhFHJBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 05:01:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D16C61153;
        Tue,  8 Jun 2021 08:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623142758;
        bh=jqgzjC2ldarnTGQEvWbargyiISLRl5LvHbedzo0nB0A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FrgeXw3i0dDuqtcvKr3FiDk4xqPy/vxmHQTDRDQpiZZ8B2y/1Tdezqvs6eSHjIM3e
         LWRZ5EgGieHFzE5ei4ONB6JF4PA9CqmW+9hDE7gxWW9/+SU9vXKFBeqOThdueayjdV
         g0JHt3rQPvr1DG8+wKiQGHgtPgoCypfacbVOKQus=
Date:   Tue, 8 Jun 2021 10:59:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chris Chiu <chris.chiu@canonical.com>
Cc:     Ricky WU <ricky_wu@realtek.com>, arnd@arndb.de,
        Bjorn Helgaas <bhelgaas@google.com>, ulf.hansson@linaro.org,
        rui_feng@realsil.com.cn, vaibhavgupta40@gmail.com,
        yang.lee@linux.alibaba.com,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] misc: rtsx: separate aspm mode into MODE_REG and
 MODE_CFG
Message-ID: <YL8xYRwKfA5EtSqT@kroah.com>
References: <20210607101634.4948-1-ricky_wu@realtek.com>
 <CABTNMG1yoYPgs0gr1bHsrxCmpNM8fUB+3S5E+HS7c9pPGiFxrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABTNMG1yoYPgs0gr1bHsrxCmpNM8fUB+3S5E+HS7c9pPGiFxrQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 11:43:03AM +0800, Chris Chiu wrote:
> On Mon, Jun 7, 2021 at 6:16 PM <ricky_wu@realtek.com> wrote:
> >
> > From: Ricky Wu <ricky_wu@realtek.com>
> >
> > aspm (Active State Power Management)
> > rtsx_comm_set_aspm: this function is for driver to make sure
> > not enter power saving when processing of init and card_detcct
> > ASPM_MODE_CFG: 8411 5209 5227 5229 5249 5250
> > Change back to use original way to control aspm
> > ASPM_MODE_REG: 5227A 524A 5250A 5260 5261 5228
> > Keep the new way to control aspm
> >
> > Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
> > ---
> Reported-by: Chris Chiu <chris.chiu@canonical.com>

Can you test this to verify it works?

thanks,

greg k-h
