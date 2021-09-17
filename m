Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9FC740F199
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 07:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244866AbhIQF1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 01:27:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:46398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229704AbhIQF1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 01:27:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 80134610D1;
        Fri, 17 Sep 2021 05:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631856349;
        bh=TALg6JvHavNoHAdcPmExgmEAS6Di8PdSRyieWhZbOE8=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=f6dGy72x6U5KO9aOvfBIgbBqusJDYBwW5Dkule8jM5yxTRfmDj5qWqqHIKrrHIqZT
         Xb9kLp7bgbWljLWp0IX/4Jg8EzlyaB31Ta4vaaEjNodBhmrzjCWZnvJOUaqO+8+Fyo
         BTQ1AFYmQRR2syQafsz37o5NlhrxXN2WuxSlHvTf8L01dGpd1HE8LAkCgdkcB0Y3bU
         pZtFL01flVwznkH4fPiEzU1/EZBWWSzMBPulXCsPPy4v0QLrlt26G/kAk0rUQvtEbh
         wIdJy0Lk4FNinQErJ2/h6zm1cwPcexVUaK1/ESto9MPnvO3yzIY9HGlm1FEljaE0PY
         +JVrOl4xQWrKQ==
References: <20210917021852.2037-1-wcheng@codeaurora.org>
User-agent: mu4e 1.6.5; emacs 27.2
From:   Felipe Balbi <balbi@kernel.org>
To:     Wesley Cheng <wcheng@codeaurora.org>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: gadget: Avoid starting DWC3 gadget during
 UDC unbind
Date:   Fri, 17 Sep 2021 08:17:03 +0300
In-reply-to: <20210917021852.2037-1-wcheng@codeaurora.org>
Message-ID: <87y27vai3p.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Wesley Cheng <wcheng@codeaurora.org> writes:

> There is a race present where the DWC3 runtime resume runs in parallel
> to the UDC unbind sequence.  This will eventually lead to a possible
> scenario where we are enabling the run/stop bit, without a valid
> composition defined.
>
> Thread#1 (handling UDC unbind):
> usb_gadget_remove_driver()
> -->usb_gadget_disconnect()
>   -->dwc3_gadget_pullup(0)
> --> continue UDC unbind sequence
> -->Thread#2 is running in parallel here
>
> Thread#2 (handing next cable connect)
> __dwc3_set_mode()
>   -->pm_runtime_get_sync()
>     -->dwc3_gadget_resume()
>       -->dwc->gadget_driver is NOT NULL yet
>       -->dwc3_gadget_run_stop(1)
>       --> _dwc3gadget_start()
> ...
>
> Fix this by tracking the pullup disable routine, and avoiding resuming
> of the DWC3 gadget.  Once the UDC is re-binded, that will trigger the
> pullup enable routine, which would handle enabling the DWC3 gadget.
>
> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>

This looks okay to me, but needs to be tested by a few folks ;-)

Acked-by: Felipe Balbi <balbi@kernel.org>

-- 
balbi
