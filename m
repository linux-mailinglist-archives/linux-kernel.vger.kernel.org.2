Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9EAC3B94AB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 18:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbhGAQbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 12:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbhGAQbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 12:31:02 -0400
Received: from mail-out-2.itc.rwth-aachen.de (mail-out-2.itc.rwth-aachen.de [IPv6:2a00:8a60:1:e501::5:47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971A9C061762;
        Thu,  1 Jul 2021 09:28:31 -0700 (PDT)
IronPort-SDR: B1DT+5Hddtx9k1MoaPHtuA3VZwiuwpoMIdFYOK3ooEsogMI+ajDW/axwjoNqlVlWz1h0STGziS
 RhPrR/p+pWig==
X-IPAS-Result: =?us-ascii?q?A2DNBADH691g/5wagoZagQmBWYFTgidqljuQVox5CwEBA?=
 =?us-ascii?q?QEBAQEBAQQEAT8CBAEBhFICgnMCJTcGDgIEAQEBAQMCAwEBAQEFAQEGAQEBA?=
 =?us-ascii?q?QEBBQSBBIUvRoZFAQEBAQIBeQULCxgJJQ8BRwYBCQQFgnKCZiEBqA54gTSBA?=
 =?us-ascii?q?YpCEAkBgTCBU4Qjg3qDeieCKYEVgnUvPoo/BIMZgkAvgQmSDoJFikmLR5IMB?=
 =?us-ascii?q?4F9gSeeTRCDUYtBhgOKTYYvlXKkbwIEAgQFAhaCPYF+cYM4UBcCDo4oGRWOG?=
 =?us-ascii?q?UAxOAIGAQkBAQMJWCSKeQEB?=
IronPort-HdrOrdr: A9a23:uk318a4h4HEBKJDbfgPXwK3XdLJyesId70hD6qkRc203TiX2ra
 qTdZgguCMc6wxwZJhDo7690cC7KBu2yXcS2+Us1NyZPTUO1lHGEL1f
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.83,314,1616454000"; 
   d="asc'?scan'208";a="150217551"
Received: from rwthex-w1-a.rwth-ad.de ([134.130.26.156])
  by mail-in-2.itc.rwth-aachen.de with ESMTP; 01 Jul 2021 18:28:20 +0200
Received: from pebbles.localnet (2a01:c22:b5df:f100:8632:645c:3e39:ad8f) by
 rwthex-w1-a.rwth-ad.de (2a00:8a60:1:e500::26:156) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.858.12; Thu, 1 Jul 2021 18:28:19 +0200
From:   Stefan =?ISO-8859-1?Q?Br=FCns?= <stefan.bruens@rwth-aachen.de>
To:     Johan Hovold <johan@kernel.org>,
        =?ISO-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Daniele Palmas <dnlplm@gmail.com>
Subject: Re: [PATCH v2] USB: serial: qcserial: Support for SDX55 based Sierra Wireless 5G modules
Date:   Thu, 1 Jul 2021 18:28:14 +0200
Message-ID: <1727850.UKLhYeRy6v@pebbles>
In-Reply-To: <87tulnms3o.fsf@miraculix.mork.no>
References: <20210611134507.8780-1-stefan.bruens@rwth-aachen.de> <YNQ0O0vhtpStp0n/@hovoldconsulting.com> <87tulnms3o.fsf@miraculix.mork.no>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1733362.ex2yW7nU1P";
        micalg=pgp-sha1; protocol="application/pgp-signature"
X-Originating-IP: [2a01:c22:b5df:f100:8632:645c:3e39:ad8f]
X-ClientProxiedBy: rwthex-w1-b.rwth-ad.de (2a00:8a60:1:e500::26:157) To
 rwthex-w1-a.rwth-ad.de (2a00:8a60:1:e500::26:156)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1733362.ex2yW7nU1P
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; protected-headers="v1"
From: Stefan =?ISO-8859-1?Q?Br=FCns?= <stefan.bruens@rwth-aachen.de>
To: Johan Hovold <johan@kernel.org>, =?ISO-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Daniele Palmas <dnlplm@gmail.com>
Subject: Re: [PATCH v2] USB: serial: qcserial: Support for SDX55 based Sierra Wireless 5G modules
Date: Thu, 01 Jul 2021 18:28:14 +0200
Message-ID: <1727850.UKLhYeRy6v@pebbles>
In-Reply-To: <87tulnms3o.fsf@miraculix.mork.no>
References: <20210611134507.8780-1-stefan.bruens@rwth-aachen.de> <YNQ0O0vhtpStp0n/@hovoldconsulting.com> <87tulnms3o.fsf@miraculix.mork.no>

On Donnerstag, 24. Juni 2021 13:15:07 CEST Bj=F8rn Mork wrote:
> Johan Hovold <johan@kernel.org> writes:
> > Could you please also post the output of usb-devices (or lsusb -v) for
> > this device in MBIM mode?
>=20
> Yes, this would be nice to have.

See below.
=20
> I suspect that this device is like other SDX55 devices we've seen, using
> class/subclass/function to map the vendor specific functions
> too. Dropping static interface numbers.  If correct, then the patch is
> bogus and the interface numbers might change based on firmware version
> and configuration.

Do you really expect Sierra do to something sensible? According to their=20
documentation functions are matched by interface numbers.

They still use broken interface descriptors with holes in interface numberi=
ng=20
(i.e. interface number 2 does not exist, which violates the USB standard).

Regards, Stefan


lsusb -v -d 1199:


Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.10
  bDeviceClass            0=20
  bDeviceSubClass         0=20
  bDeviceProtocol         0=20
  bMaxPacketSize0        64
  idVendor           0x1199 Sierra Wireless, Inc.
  idProduct          0x90d3=20
  bcdDevice            0.06
  iManufacturer           1 Sierra Wireless, Incorporated
  iProduct                2 Sierra Wireless EM9191
  iSerial                 3 8W<nnnnnnnnnnnnn>
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x00a7
    bNumInterfaces          4
    bConfigurationValue     1
    iConfiguration          4=20
    bmAttributes         0xa0
      (Bus Powered)
      Remote Wakeup
    MaxPower              500mA
    Interface Association:
      bLength                 8
      bDescriptorType        11
      bFirstInterface         0
      bInterfaceCount         2
      bFunctionClass          2 Communications
      bFunctionSubClass      14=20
      bFunctionProtocol       0=20
      iFunction               0=20
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         2 Communications
      bInterfaceSubClass     14=20
      bInterfaceProtocol      0=20
      iInterface              0=20
      CDC Header:
        bcdCDC               1.10
      CDC Union:
        bMasterInterface        0
        bSlaveInterface         1=20
      CDC MBIM:
        bcdMBIMVersion       1.00
        wMaxControlMessage   4096
        bNumberFilters       32
        bMaxFilterSize       128
        wMaxSegmentSize      2048
        bmNetworkCapabilities 0x20
          8-byte ntb input size
      CDC MBIM Extended:
        bcdMBIMExtendedVersion           1.00
        bMaxOutstandingCommandMessages     64
        wMTU                             1500
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               9
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass        10 CDC Data
      bInterfaceSubClass      0=20
      bInterfaceProtocol      2=20
      iInterface              0=20
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           2
      bInterfaceClass        10 CDC Data
      bInterfaceSubClass      0=20
      bInterfaceProtocol      2=20
      iInterface              0=20
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x8e  EP 14 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x0f  EP 15 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        3
      bAlternateSetting       0
      bNumEndpoints           3
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      0=20
      bInterfaceProtocol      0=20
      iInterface              0=20
      ** UNRECOGNIZED:  05 24 00 10 01
      ** UNRECOGNIZED:  05 24 01 00 00
      ** UNRECOGNIZED:  04 24 02 02
      ** UNRECOGNIZED:  05 24 06 00 00
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x000a  1x 10 bytes
        bInterval               9
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        4
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass    255 Vendor Specific Subclass
      bInterfaceProtocol     48=20
      iInterface              0=20
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x84  EP 4 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0




=2D-=20
Stefan Br=FCns  /  Bergstra=DFe 21  /  52062 Aachen
home: +49 241 53809034     mobile: +49 151 50412019
--nextPart1733362.ex2yW7nU1P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSwWRWIpJbl0W4DemNvf0o9jP6qUwUCYN3tHgAKCRBvf0o9jP6q
U1tlAKCCXZqbC4n9AsvLYyyKw7c2NJIrhwCfSUJaDw5xKPKfEcLDkb1OPPC4RnU=
=lS7s
-----END PGP SIGNATURE-----

--nextPart1733362.ex2yW7nU1P--
