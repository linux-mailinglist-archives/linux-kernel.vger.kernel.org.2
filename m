Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1133E9001
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237361AbhHKMCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbhHKMCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:02:52 -0400
Received: from canardo.mork.no (canardo.mork.no [IPv6:2001:4641::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C944C061765;
        Wed, 11 Aug 2021 05:02:28 -0700 (PDT)
Received: from miraculix.mork.no (miraculix.mork.no [IPv6:2001:4641:0:2:7627:374e:db74:e353])
        (authenticated bits=0)
        by canardo.mork.no (8.15.2/8.15.2) with ESMTPSA id 17BC1vRT024740
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 11 Aug 2021 14:01:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
        t=1628683318; bh=ZMAPDJRikzYs/k+y/xgS9A/z7vNWC6FiVDP1jJK1Frc=;
        h=From:To:Cc:Subject:References:Date:Message-ID:From;
        b=Drk0DmlQNrR6MVvx8eIXJOsvyZOG/WuthaMyQwpmbTXMs34DxAWc03v0zmQRq6StQ
         EcjkN5AeMHYkzivMACMXI1vHXk+GV9Q7pYGhjC91Ja+cKQRGuVOmfXlFuG+2PU8Zt8
         SfJVvry5wUzpKU6B1f5W55iCSAvZN4ktqX5UYeYo=
Received: from bjorn by miraculix.mork.no with local (Exim 4.94.2)
        (envelope-from <bjorn@mork.no>)
        id 1mDmvl-000IMy-IV; Wed, 11 Aug 2021 14:01:57 +0200
From:   =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To:     Slark Xiao <slark_xiao@163.com>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2,1/1] This aims to support Foxconn SDX55
Organization: m
References: <20210811085635.4699-1-slark_xiao@163.com>
Date:   Wed, 11 Aug 2021 14:01:57 +0200
In-Reply-To: <20210811085635.4699-1-slark_xiao@163.com> (Slark Xiao's message
        of "Wed, 11 Aug 2021 16:56:35 +0800")
Message-ID: <875ywcfave.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.2 at canardo
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Slark Xiao <slark_xiao@163.com> writes:

> diff --git a/drivers/usb/serial/qcserial.c b/drivers/usb/serial/qcserial.c
> index 83da8236e3c8..d8b58aea3c60 100644
> --- a/drivers/usb/serial/qcserial.c
> +++ b/drivers/usb/serial/qcserial.c
> @@ -111,6 +111,7 @@ static const struct usb_device_id id_table[] =3D {
>  	{USB_DEVICE(0x16d8, 0x8002)},	/* CMDTech Gobi 2000 Modem device (VU922)=
 */
>  	{USB_DEVICE(0x05c6, 0x9204)},	/* Gobi 2000 QDL device */
>  	{USB_DEVICE(0x05c6, 0x9205)},	/* Gobi 2000 Modem device */
> +	{USB_DEVICE(0x05c6, 0x901d)},	/* Foxconn SDX55 QDL */

I assume this device will expose other serial functions when booted in
application USB mode?  But probably not with a Gobi 2k layout... Maybe
add the application device ID to some USB serial driver too, and include
the QDL device ID there as well to reduce confusion?

Could you provide a view of the default USB descriptors in both QDL and
application mode?  E.g from lsusb -v or  /sys/kernel/debug/usb/devices?


Bj=C3=B8rn

