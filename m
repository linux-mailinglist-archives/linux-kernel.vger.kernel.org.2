Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2DF3B7460
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 16:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbhF2OfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 10:35:22 -0400
Received: from netrider.rowland.org ([192.131.102.5]:34777 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S234285AbhF2OfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 10:35:19 -0400
Received: (qmail 699680 invoked by uid 1000); 29 Jun 2021 10:32:51 -0400
Date:   Tue, 29 Jun 2021 10:32:51 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Linyu Yuan <linyyuan@codeaurora.org>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jack Pham <jackp@codeaurora.org>
Subject: Re: [PATCH v2] usb: dwc3: avoid NULL access of usb_gadget_driver
Message-ID: <20210629143251.GA699290@rowland.harvard.edu>
References: <20210629015118.7944-1-linyyuan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210629015118.7944-1-linyyuan@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2021 at 09:51:18AM +0800, Linyu Yuan wrote:
> we found crash in dwc3_disconnect_gadget(),
> it is because dwc->gadget_driver become NULL before async access.
> 7dc0c55e9f30 ('USB: UDC core: Add udc_async_callbacks gadget op')
> suggest a common way to avoid such kind of issue.
> 
> this change implment the callback in dwc3 and
> change related functions which have callback to usb gadget driver.
> 
> Signed-off-by: Linyu Yuan <linyyuan@codeaurora.org>
> ---
> 
> v2: add missing check in dwc3_reset_gadget(), found by Alan Stern.

This is better.

Acked-by: Alan Stern <stern@rowland.harvard.edu>

