Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D805A345B22
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 10:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbhCWJmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 05:42:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:52576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229944AbhCWJl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 05:41:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7EE67619B8;
        Tue, 23 Mar 2021 09:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616492518;
        bh=s2CJGA8QNQ5lPaTTrmTHlWQBHP89QJSTaompEhRfkNQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FTVR7dfJffHuSMO3ERgUVXuZT+HDdtssPajaF6xXpdeNC71BHki0oAtg3b19nV0UY
         udEErJKDSAtnTHtA7p3qnbyyE5NdOHaQSTpj3+TTAqsMf7CjDAUrpVFE1CQotLDbEX
         8H0bNfDUN4y/+S7IrqTLWLzOJKYqrgKThcF1qOxM=
Date:   Tue, 23 Mar 2021 10:41:55 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luiz Sampaio <sampaio.ime@gmail.com>
Cc:     zbr@ioremap.net, rikard.falkeborn@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] w1: ds2438: adding support for calibration of
 current measurements
Message-ID: <YFm344PkR+zXItxF@kroah.com>
References: <20210323024037.qe6ooze4ncusnh7u@LuizSampaio-PC.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323024037.qe6ooze4ncusnh7u@LuizSampaio-PC.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 11:40:37PM -0300, Luiz Sampaio wrote:
> The following patches aim to make a user able to calibrate the current measurement of the ds2438. This chip uses a offset register in page1, which is added to the current register to give the user the current measurement. If this value is wrong, the user will get an offset current value, even if the current is zero, for instance. This patch gives support to read the page1 registers (including the offset register) and to write to the offset register. The ds2438 datasheet shows a calibration routine, and with this patch, the user can to this quickly by write the correct value to the offset register.
> This patch was tested on real hardware using a power supply and an electronic load.
> Please help to review this series of patches.

Please properly wrap your email lines :(

Also, this was not sent threaded, so I missing some of the patches, how
did you send them?  Tools like 'git send-email' should do this
automatically.

Can you fix up and resend all 3.

thanks,

greg k-h
