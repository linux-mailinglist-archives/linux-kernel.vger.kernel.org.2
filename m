Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C7543D2A3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 22:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238789AbhJ0URG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 16:17:06 -0400
Received: from netrider.rowland.org ([192.131.102.5]:60193 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S235577AbhJ0URF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 16:17:05 -0400
Received: (qmail 1331371 invoked by uid 1000); 27 Oct 2021 16:14:38 -0400
Date:   Wed, 27 Oct 2021 16:14:38 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        jackp@codeaurora.org
Subject: Re: [PATCH v3 0/2] Disable mass storage endpoints during disconnect
Message-ID: <20211027201438.GB1326060@rowland.harvard.edu>
References: <1635365407-31337-1-git-send-email-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1635365407-31337-1-git-send-email-quic_wcheng@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 01:10:05PM -0700, Wesley Cheng wrote:
> Changes in v3:
>  - Modify statement for usb_ep_enable().
>  - Add explicit statement mentioning that APIs can be called in atomic context.
> 
> Changes in v2:
>  - Revised comments for usb_ep_disable() as it should be safe to be
>    executed in atomic contexts as well.  Other FDs are currently
>    calling ep disable during the disconnect event as well.
> 
> This series calls the usb_ep_disable() API directly from fsg_disable()
> as there is a possibility that UDCs that support runtime PM may
> already be in a suspended state, leading to HW access while resources
> are disabled.
> 
> Wesley Cheng (2):
>   usb: gadget: udc: core: Revise comments for USB ep enable/disable
>   usb: gadget: f_mass_storage: Disable eps during disconnect
> 
>  drivers/usb/gadget/function/f_mass_storage.c | 10 ++++++++++
>  drivers/usb/gadget/udc/core.c                |  4 ++--
>  2 files changed, 12 insertions(+), 2 deletions(-)

For both patches:

Acked-by: Alan Stern <stern@rowland.harvard.edu>

