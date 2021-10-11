Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0F94288CE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 10:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235036AbhJKId7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 04:33:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:53044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234932AbhJKId6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 04:33:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C3CE60EB1;
        Mon, 11 Oct 2021 08:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633941119;
        bh=rWIYz6HvGnzK13wjF7/2M8KNWndYaayhjKVmwsFuzzU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q2oSMzY7EjLkuqphAqKSwZKMkuL+XKMdqA2IamIhMZw7uQbAPTx2Y/bBi2TieaU3L
         n4VB1YPMqaNunzx6vZZFTDwHgenfk6yZynPlSRrzAk1weCgzXjWreaK7IpcByqOBcj
         ZxNzK9EjQQE5lHEhHYWVZVXLxUQ81FYmioOC0+eImwydN6rYKC6BPOyfhfkcAOiwKi
         /Uwj7D61cN0HFsphPetW9jeShZXK1tsIMFqbrUQqQLBrvp6gMvbiypA65dNLTWLddP
         oX2x2k2XHfMO3zCz1WVpPm9UfcR77jI+2jOjA4Kf9e1aUpwH/JKIJyUjZjioCKtfEm
         QXanbfzonIs/w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mZqis-0002KB-Qv; Mon, 11 Oct 2021 10:31:50 +0200
Date:   Mon, 11 Oct 2021 10:31:50 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Yu-Tung Chang <mtwget@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] USB: serial: option: add Quectel EC200S-CN module
 support
Message-ID: <YWP2dpna7WSGen76@hovoldconsulting.com>
References: <20210930021112.330396-1-mtwget@gmail.com>
 <YV6mD02BVLXXcTr8@hovoldconsulting.com>
 <YV6oTZae5zbgX8cV@hovoldconsulting.com>
 <CAHRgzyNcmhTJHC9vzS-1mbxMLVHw5bYWHVy1+KCvUF61tRnr=A@mail.gmail.com>
 <CAHRgzyO=VOCAV8oGSR15hiifp7NqHCu13KjcTrv3aA2QiURz_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHRgzyO=VOCAV8oGSR15hiifp7NqHCu13KjcTrv3aA2QiURz_g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Adding back the lists on CC so that this gets archived. ]

On Sat, Oct 09, 2021 at 01:50:40PM +0800, Yu-Tung Chang wrote:
> Yu-Tung Chang <mtwget@gmail.com> 于2021年10月9日周六 下午1:39写道：
> >
> > Johan Hovold <johan@kernel.org> 于2021年10月7日周四 下午3:57写道：
> > >
> > > On Thu, Oct 07, 2021 at 09:47:28AM +0200, Johan Hovold wrote:
> > > > On Thu, Sep 30, 2021 at 10:11:12AM +0800, Yu-Tung Chang wrote:
> > > > > Add usb product id of the Quectel EC200S-CN module.
> > > > >
> > > > > usb-devices output for 0x6002:
> > > > > T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  3 Spd=480 MxCh= 0
> > > > > D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
> > > > > P:  Vendor=2c7c ProdID=6002 Rev=03.18
> > > > > S:  Manufacturer=Android
> > > > > S:  Product=Android
> > > > > S:  SerialNumber=0000
> > > > > C:  #Ifs= 5 Cfg#= 1 Atr=e0 MxPwr=500mA
> > > > > I:  If#=0x0 Alt= 0 #EPs= 1 Cls=02(commc) Sub=06 Prot=00 Driver=cdc_ether
> > > > > I:  If#=0x1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
> > > > > I:  If#=0x2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)
> > > > > I:  If#=0x3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)
> > > > > I:  If#=0x4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)
> > > >
> > > > Looks good now, but for completeness, could you also mention here what
> > > > the three ports are used for (and which is which)?
> > >
> > > I've applied the patch now, so no need to resend, but please list the
> > > three ports in a reply if you have that information.
> >
> > ttyUSB0 used for debugging, ttyUSB1 used for AT commands,
> > ttyUSB2 used for PPP dialing.

> and lsusb.py -i -e output info:
>   1-1               2c7c:6002 ef 5IFs [USB 2.00,   480 Mbps, 500mA]
> (Android Android 0000)
>                       (EP) 00: Control attr 00 len 07 max 040
>     1-1:1.0           (IF) 02:06:00 1EP  (Communications) cdc_ether net/usb0
>                         (EP) 87: Interrupt (4096ms) attr 03 len 07 max 040
>     1-1:1.1           (IF) 0a:00:00 2EPs (CDC Data) cdc_ether
>                         (EP) 83: Bulk attr 02 len 07 max 200
>                         (EP) 0c: Bulk attr 02 len 07 max 200
>     1-1:1.2           (IF) ff:00:00 2EPs (Vendor Specific Class) option ttyUSB0
>                         (EP) 0b: Bulk attr 02 len 07 max 200
>                         (EP) 82: Bulk attr 02 len 07 max 200
>     1-1:1.3           (IF) ff:00:00 3EPs (Vendor Specific Class) option ttyUSB1
>                         (EP) 89: Interrupt (4096ms) attr 03 len 07 max 040
>                         (EP) 86: Bulk attr 02 len 07 max 200
>                         (EP) 0f: Bulk attr 02 len 07 max 200
>     1-1:1.4           (IF) ff:00:00 3EPs (Vendor Specific Class) option ttyUSB2
>                         (EP) 81: Bulk attr 02 len 07 max 200
>                         (EP) 0a: Bulk attr 02 len 07 max 200
>                         (EP) 88: Interrupt (4096ms) attr 03 len 07 max 040

Perfect, thanks for the details.

Johan
