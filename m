Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2336439180
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 10:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbhJYIiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 04:38:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:55374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232302AbhJYIhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 04:37:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CA69761050;
        Mon, 25 Oct 2021 08:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1635150894;
        bh=x/dztvnLwVUKBvTIRWreGwIR1xh7qkWv6Kx7wIIOfq0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mc6cpAl42u5OX7/1EehRG7NeAEFaeVeiI7m3/o0XaISNv0Jg0kP/W+Bt774uPpHaE
         17jY+6ZTWQ6hoRsXcSwGMkC8qshcxtcmzNhpF7YpxY4LPzAf9Z2TdkGLtl1a4k9f7y
         q2kj5J4xJw6CAWfEtV1rvpT3xGEGtF2LBWbr8TUI=
Date:   Mon, 25 Oct 2021 10:34:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
Cc:     michal.simek@xilinx.com, rajan.vaja@xilinx.com,
        manish.narani@xilinx.com, zou_wei@huawei.com,
        lakshmi.sai.krishna.potthuri@xilinx.com, wendy.liang@xilinx.com,
        jliang@xilinx.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Tejas Patel <tejas.patel@xilinx.com>
Subject: Re: [PATCH v6 1/6] firmware: xilinx: add register notifier in zynqmp
 firmware
Message-ID: <YXZsLJ3SfCjYr3gk@kroah.com>
References: <20211021134644.14407-1-abhyuday.godhasara@xilinx.com>
 <20211025082350.10881-2-abhyuday.godhasara@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025082350.10881-2-abhyuday.godhasara@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 01:23:45AM -0700, Abhyuday Godhasara wrote:
> In zynqmp-firmware, register notifier is not supported, add support of
> register notifier in zynqmp-firmware.
> 
> Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
> Signed-off-by: Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
> Acked-by: Michal Simek <michal.simek@xilinx.com>
> ---
> Changes in v6:
> - Minor fix


That is vague, what got "fixed" here?

thanks,

greg k-h
