Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5856D3DFF78
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 12:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237507AbhHDKmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 06:42:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:40456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237494AbhHDKlc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 06:41:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2B3B560231;
        Wed,  4 Aug 2021 10:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628073680;
        bh=KjB+PEpm30wFGKxTNZ21EeEU6m4LIBijCeE7w6Wsav4=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=fn6MBCP25I/nQaryiuNYIeHuL2jTFc4LxZ9cZ+jAp8s6WTD1tYcNZMuFsG0WGLvZR
         7DnbhgiPul+u/zM2BNm7JkJNoE806uHe0RT1GQVikIjuX0BF8vGEvGHK/a4Yngyh5f
         Y+bKll43GlYzDLlmnJgLdI20I0EzRYyJnX/xCeKs73aeuf9g+nXh/4iyVTUCKE3RRK
         OyDRor2uKM9/ynrHQBFUPB/ZfNzKjMRHbLLVzJGiC7xca6B/Pk2CTIIqIPvkMBouFU
         H5aKIjJ6fkYfd5YBKvia6iToNcBGeoVKfP1NJxsaK5LR5/iVQIxgo87x8I/jlSAkoZ
         vBsCEH4qOwkNQ==
References: <1628058245-30692-1-git-send-email-wcheng@codeaurora.org>
User-agent: mu4e 1.6.1; emacs 27.2
From:   Felipe Balbi <balbi@kernel.org>
To:     Wesley Cheng <wcheng@codeaurora.org>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, jackp@codeaurora.org
Subject: Re: [PATCH v2] usb: dwc3: gadget: Avoid runtime resume if disabling
 pullup
Date:   Wed, 04 Aug 2021 13:41:02 +0300
In-reply-to: <1628058245-30692-1-git-send-email-wcheng@codeaurora.org>
Message-ID: <87r1f95w6q.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Wesley Cheng <wcheng@codeaurora.org> writes:

> If the device is already in the runtime suspended state, any call to
> the pullup routine will issue a runtime resume on the DWC3 core
> device.  If the USB gadget is disabling the pullup, then avoid having
> to issue a runtime resume, as DWC3 gadget has already been
> halted/stopped.
>
> This fixes an issue where the following condition occurs:
>
> usb_gadget_remove_driver()
> -->usb_gadget_disconnect()
>  -->dwc3_gadget_pullup(0)
>   -->pm_runtime_get_sync() -> ret = 0
>   -->pm_runtime_put() [async]
> -->usb_gadget_udc_stop()
>  -->dwc3_gadget_stop()
>   -->dwc->gadget_driver = NULL
> ...
>
> dwc3_suspend_common()
> -->dwc3_gadget_suspend()
>  -->DWC3 halt/stop routine skipped, driver_data == NULL
>
> This leads to a situation where the DWC3 gadget is not properly
> stopped, as the runtime resume would have re-enabled EP0 and event
> interrupts, and since we avoided the DWC3 gadget suspend, these
> resources were never disabled.
>
> Fixes: 77adb8bdf422 ("usb: dwc3: gadget: Allow runtime suspend if UDC unbinded")
> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>

Acked-by: Felipe Balbi <balbi@kernel.org>

-- 
balbi
