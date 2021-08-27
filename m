Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0CD3F95BF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 10:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbhH0IG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 04:06:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:40278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231282AbhH0IGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 04:06:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 25B5560EAF;
        Fri, 27 Aug 2021 08:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630051566;
        bh=govqLpCEeDm/vKXgVynJIqYNcr6eEN48VUkx2hxwQbQ=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=OW5t2stTo7Kjqe+w2vWPxJA5ik1I73MyLUqdgPeCxMhuwZIekTdD2kjU0V2qodr/D
         kVWmR+Cg+dQ7PAytTcbcfOWGIGLRTfBhmGkbiuxO2YGiB9FxxoY/YHP/esvbltCLkA
         HTupgcqtbKC+cH+vJG+X4l/A8+sTUYnzf+rPaE9hUwLIcDrYSl9vmIKYvblVaJMew9
         DlMQBm9a/nxtqw7R/JQiXPHzB14e6oDcBZ2hygu57UWbPqoD0F/SRHnrbHgFEOzi83
         M5wdCVof31O3FY1NTLHp2EKl0WlVSqniUCdnkaTJ5uLA5cFIRcb5Osis+InIKE1L92
         H9lq7Ni/5h43g==
References: <20210827075853.266912-1-jbrunet@baylibre.com>
User-agent: mu4e 1.6.4; emacs 27.2
From:   Felipe Balbi <balbi@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Pavel Hofman <pavel.hofman@ivitera.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jack Pham <jackp@codeaurora.org>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Ferry Toth <ftoth@exalondelft.nl>
Subject: Re: [PATCH] usb: gadget: f_uac2: fixup feedback endpoint stop
Date:   Fri, 27 Aug 2021 11:05:38 +0300
In-reply-to: <20210827075853.266912-1-jbrunet@baylibre.com>
Message-ID: <87a6l39us6.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Jerome Brunet <jbrunet@baylibre.com> writes:

> When the uac2 function is stopped, there seems to be an issue reported on
> some platforms (Intel Merrifield at least)
>
> BUG: kernel NULL pointer dereference, address: 0000000000000008
> ...
> RIP: 0010:dwc3_gadget_del_and_unmap_request+0x19/0xe0
> ...
> Call Trace:
>  dwc3_remove_requests.constprop.0+0x12f/0x170
>  __dwc3_gadget_ep_disable+0x7a/0x160
>  dwc3_gadget_ep_disable+0x3d/0xd0
>  usb_ep_disable+0x1c/0x70
>  u_audio_stop_capture+0x79/0x120 [u_audio]
>  afunc_set_alt+0x73/0x80 [usb_f_uac2]
>  composite_setup+0x224/0x1b90 [libcomposite]
>
> The issue happens only when the gadget is using the sync type "async", not
> "adaptive". This indicates that problem is coming from the feedback
> endpoint, which is only used with async synchronization mode.
>
> The problem is that request is freed regardless of usb_ep_dequeue(), which
> ends up badly if the request is not actually dequeued yet.
>
> Update the feedback endpoint free function to release the endpoint the same
> way it is done for the data endpoint, which takes care of the problem.
>
> Reported-by: Ferry Toth <ftoth@exalondelft.nl>
> Tested-by: Ferry Toth <ftoth@exalondelft.nl>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  Hi Felipe,
>
>  This solves the issue reported here [0] and makes revert [1]
>  unnecessary.

awesome work! Thanks

Acked-by: Felipe Balbi <balbi@kernel.org>

-- 
balbi
