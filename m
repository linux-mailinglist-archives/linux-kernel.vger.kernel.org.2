Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDFF3B9CF8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 09:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhGBHfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 03:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbhGBHfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 03:35:10 -0400
Received: from canardo.mork.no (canardo.mork.no [IPv6:2001:4641::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35882C061762;
        Fri,  2 Jul 2021 00:32:38 -0700 (PDT)
Received: from miraculix.mork.no (fwa219.mork.no [192.168.9.219])
        (authenticated bits=0)
        by canardo.mork.no (8.15.2/8.15.2) with ESMTPSA id 1627WTFM008403
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 2 Jul 2021 09:32:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
        t=1625211149; bh=4IcPPKCPtha5caFpsZbpIXIABLLgrcYiJzOTZgq2fqI=;
        h=From:To:Cc:Subject:References:Date:Message-ID:From;
        b=mbkGlWgP+f+Jtzg6EonrswIcr+5x61PhMzBMiQpBdbZB7dz5nJt1cCX3fbToaE6Wu
         9tHZjLKHB/uSGsdoC0iqs8AILR2Rp1lqSVjJsBL+VYtzexo1qe9FZR8rmYjpaDqDRl
         3US7PtdhvWQssy53NQ83xesqC/ay6G3c+zvWcWdE=
Received: from bjorn by miraculix.mork.no with local (Exim 4.94.2)
        (envelope-from <bjorn@mork.no>)
        id 1lzDf2-000BB9-Rw; Fri, 02 Jul 2021 09:32:28 +0200
From:   =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To:     Stefan =?utf-8?Q?Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Daniele Palmas <dnlplm@gmail.com>
Subject: Re: [PATCH v2] USB: serial: qcserial: Support for SDX55 based
 Sierra Wireless 5G modules
Organization: m
References: <20210611134507.8780-1-stefan.bruens@rwth-aachen.de>
        <YNQ0O0vhtpStp0n/@hovoldconsulting.com>
        <87tulnms3o.fsf@miraculix.mork.no> <1727850.UKLhYeRy6v@pebbles>
Date:   Fri, 02 Jul 2021 09:32:28 +0200
In-Reply-To: <1727850.UKLhYeRy6v@pebbles> ("Stefan =?utf-8?Q?Br=C3=BCns=22?=
 =?utf-8?Q?'s?= message of "Thu, 1
        Jul 2021 18:28:14 +0200")
Message-ID: <87y2apf9wz.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.2 at canardo
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Br=C3=BCns <stefan.bruens@rwth-aachen.de> writes:

> On Donnerstag, 24. Juni 2021 13:15:07 CEST Bj=C3=B8rn Mork wrote:
>> Johan Hovold <johan@kernel.org> writes:
>> > Could you please also post the output of usb-devices (or lsusb -v) for
>> > this device in MBIM mode?
>>=20
>> Yes, this would be nice to have.
>
> See below.
>=20=20
>> I suspect that this device is like other SDX55 devices we've seen, using
>> class/subclass/function to map the vendor specific functions
>> too. Dropping static interface numbers.  If correct, then the patch is
>> bogus and the interface numbers might change based on firmware version
>> and configuration.
>
> Do you really expect Sierra do to something sensible? According to their=
=20
> documentation functions are matched by interface numbers.

Well... I expect them to be as sensible as any other vendor.  And I
expect docs to be intendend as guidance only ;-)

> They still use broken interface descriptors with holes in interface numbe=
ring=20
> (i.e. interface number 2 does not exist, which violates the USB standard).

Right. Wrt the violation, I think that train left a decade ago.=20=20

>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        3
>       bAlternateSetting       0
>       bNumEndpoints           3
>       bInterfaceClass       255 Vendor Specific Class
>       bInterfaceSubClass      0=20
>       bInterfaceProtocol      0=20
[..]
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        4
>       bAlternateSetting       0
>       bNumEndpoints           2
>       bInterfaceClass       255 Vendor Specific Class
>       bInterfaceSubClass    255 Vendor Specific Subclass
>       bInterfaceProtocol     48=20


So Sierra do follow the same pattern we've seen on other X55 devices:

ff/00/00 - AT
ff/ff/30 - QCDM

See commits

 accf227de4d2 ("USB: serial: option: Add support for Quectel RM500Q")
 d6c1ddd938d8 ("USB: serial: option: add Quectel EM160R-GL")

for other examples.

This obviously doesn't make any difference if your configuration is the
only one.  But I believe that is unlikely.  There are probably ways the
layout can be changed, even if currenly not documented.  The advantage
of class/subclass/protocol matching to function is that it works
regardless of the number of functions and their interface number.


Bj=C3=B8rn
