Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D15163F58AC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 09:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbhHXHG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 03:06:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:48796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231332AbhHXHGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 03:06:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5DD6361165;
        Tue, 24 Aug 2021 07:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629788771;
        bh=AUmPzVyVIdkBzP1TcX09gdv462g7bmFGWS7nBwof6EY=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=IGQJPw85gSh+CTYT8Iq/6WmQqE8as8nu9AgNDV442kPh9mlyisOw/vqetiGHFthbs
         1BqgqC/svEvMBXLM/o+i0hvNssDGmHrbKyitSuiGPXJDVjjIv2cFiiJiYEy0vCh6EW
         sRHuufcMwF+Zkio1l/wc7ywKj5/pBhUXi/TJPbK4CXymrROPhLA/ebFduhzsbnZ9XX
         nE9REMyuvVLiWI6fIyAqkq68fFw2eAO1MOLLkrNE3YjUQnphmZ8xJSRL9NPj06qJLD
         eBk2VxRzUU6ZMg4UOqCQYz6v1nCKCFr577uM9FPaDwoRDbnfQxRPWZiGcyduvjcwmD
         udePIG6JXBm0g==
References: <20210821134004.363217-1-mdevaev@gmail.com>
User-agent: mu4e 1.6.4; emacs 27.2
From:   Felipe Balbi <balbi@kernel.org>
To:     Maxim Devaev <mdevaev@gmail.com>
Cc:     gregkh@linuxfoundation.org, ruslan.bilovol@gmail.com,
        mika.westerberg@linux.intel.com, jj251510319013@gmail.com,
        maze@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] usb: gadget: f_hid: optional SETUP/SET_REPORT mode
Date:   Tue, 24 Aug 2021 10:05:52 +0300
In-reply-to: <20210821134004.363217-1-mdevaev@gmail.com>
Message-ID: <877dgb8gps.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Maxim Devaev <mdevaev@gmail.com> writes:

> f_hid provides the OUT Endpoint as only way for receiving reports
> from the host. SETUP/SET_REPORT method is not supported, and this causes
> a number of compatibility problems with various host drivers, especially
> in the case of keyboard emulation using f_hid.
>
>   - Some hosts do not support the OUT Endpoint and ignore it,
>     so it becomes impossible for the gadget to receive a report
>     from the host. In the case of a keyboard, the gadget loses
>     the ability to receive the status of the LEDs.
>
>   - Some BIOSes/UEFIs can't work with HID devices with the OUT Endpoint
>     at all. This may be due to their bugs or incomplete implementation
>     of the HID standard.
>     For example, absolutely all Apple UEFIs can't handle the OUT Endpoint
>     if it goes after IN Endpoint in the descriptor and require the reverse
>     order (OUT, IN) which is a violation of the standard.
>     Other hosts either do not initialize gadgets with a descriptor
>     containing the OUT Endpoint completely (like some HP and DELL BIOSes
>     and embedded firmwares like on KVM switches), or initialize them,
>     but will not poll the IN Endpoint.
>
> This patch adds configfs option no_out_endpoint=1 to disable
> the OUT Endpoint and allows f_hid to receive reports from the host
> via SETUP/SET_REPORT.
>
> Previously, there was such a feature in f_hid, but it was replaced
> by the OUT Endpoint [1] in the commit 99c515005857 ("usb: gadget: hidg:
> register OUT INT endpoint for SET_REPORT"). So this patch actually
> returns the removed functionality while making it optional.
> For backward compatibility reasons, the OUT Endpoint mode remains
> the default behaviour.
>
>   - The OUT Endpoint mode provides the report queue and reduces
>     USB overhead (eliminating SETUP routine) on transmitting a report
>     from the host.
>
>   - If the SETUP/SET_REPORT mode is used, there is no report queue,
>     so the userspace will only read last report. For classic HID devices
>     like keyboards this is not a problem, since it's intended to transmit
>     the status of the LEDs and only the last report is important.
>     This mode provides better compatibility with strange and buggy
>     host drivers.
>
> Both modes passed USBCV tests. Checking with the USB protocol analyzer
> also confirmed that everything is working as it should and the new mode
> ensures operability in all of the described cases.
>
> Signed-off-by: Maxim Devaev <mdevaev@gmail.com>
> Link: https://www.spinics.net/lists/linux-usb/msg65494.html [1]

Acked-by: Felipe Balbi <balbi@kernel.org>

-- 
balbi
