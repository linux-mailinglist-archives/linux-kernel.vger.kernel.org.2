Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 640A94209C9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 13:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbhJDLRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 07:17:25 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:52398 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbhJDLRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 07:17:23 -0400
Date:   Mon, 04 Oct 2021 11:15:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1633346131;
        bh=MWuT8mIn2VJodxSXcssCZqS3+0I75k3kLJZh2U5Wl5I=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=hs8jv6oGpNOETf1LT6xqq7C7WfYiw6PM/fZhZ9iISVxZ9ZPkYGazyO2+t2wiRV9Sb
         j+dEgnQgjXyllQFLUfteUL9Zxpp9cs0xSD+ObQwTdOmr/dU7j95bWOfxle81P4K1cf
         I1ZduSlFJK7a4MrNb8e82et7o4jQl8lCflDPfc5c=
To:     Marcel Holtmann <marcel@holtmann.org>
From:   Orlando Chamberlain <redecorating@protonmail.com>
Cc:     danielwinkler@google.com, Johan Hedberg <johan.hedberg@intel.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev, sonnysasaka@chromium.org
Reply-To: Orlando Chamberlain <redecorating@protonmail.com>
Subject: Re: [PATCHv2] Bluetooth: quirk disabling LE Read Transmit Power
Message-ID: <20211004111518.0765650c@localhost>
In-Reply-To: <20211001132756.434e56bb@localhost>
References: <4970a940-211b-25d6-edab-21a815313954@protonmail.com> <20210930063106.19881-1-redecorating@protonmail.com> <20210930141256.19943-1-redecorating@protonmail.com> <FA02CDD7-CFEC-4481-9940-BA95D81FD3F3@holtmann.org> <275acce4-9eab-9cba-7145-5a75a69ca530@protonmail.com> <20211001083412.3078-1-redecorating@protonmail.com> <1D2217A9-EA73-4D93-8D0B-5BC2718D4788@holtmann.org> <20211001132756.434e56bb@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Oct 2021 23:28:03 +1000
"Orlando Chamberlain" <redecorating@protonmail.com> wrote:
> On Fri, 01 Oct 2021 19:35:16 +1000
> "Marcel Holtmann" <marcel@holtmann.org> wrote:
>=20
> > I would really prefer to do that via the ACPI table matching in
> > hci_bcm.c and not via some magic chip id check.
>=20
> Initially I thought we may be able to do this based off BCM2E7C (which
> is in the DSDT table which I'll attach), however it seems like many
> Macs also have that (i.e. MacBookPro14,1, MacBookAir8,1, MacBook9,1),
> so unless all these don't support LE Read Transmit Power, (which
> would be hard to determine), I don't know if BCM2E7C can be used to
> quirk it.

I think there aren't any Macs that support LE Read Transmit Power.

I checked the Bluetooth spec here
https://www.bluetooth.com/specifications/specs/core-specification-5-1/
and it seems like 5.1 is the first version that mentions LE Read
Transmit Power. It says 5.1 was adopted on 21 Jan 2019.

As far as I know, all of the models released after that date that have
ever had working Bluetooth were affected, while unaffected models were
released before that date (and thus shouldn't support LE Read Transmit
Power? This is at least true for the MacBookPro15,1, a 2018 model that
doesn't support the command).

I think this means that no Apple computer released so far supports the
command, so disabling LE Read Transmit Power for all Apple controllers
based off "apple-uart-blth" (probably a better choice than "BCM2E7C")
won't affect any controllers that actually support it.

Device (BLTH)
{
    Name (_HID, EisaId ("BCM2E7C"))  // _HID: Hardware ID
    Name (_CID, "apple-uart-blth")  // _CID: Compatible ID
    Name (_UID, One)  // _UID: Unique ID
    Name (_ADR, Zero)  // _ADR: Address

As to future Apple computers, they seem to no longer be using UART and
instead have a second Broadcom PCI device (the first being for WiFi)
that is for Bluetooth. 3 Intel Macs Models have this second device
(MacBookPro15,4, MacBookPro16,3 and MacBookAir9,1), and so do the M1
ones.

I can't say that they won't move back to UART at some point and then
support LE Read Transmit Power, but if they do, I don't think they
would move back to x86_64, so only having this quirk activated when
compiling for x86_64 might be an option if that's an issue.

> I'll try to see if I can find something else in the ACPI tables that
> can be used as a quirk. (I'll see if I can get the table of a similar
> model that wasn't affected and compare the BLTH sections)

The BLTH sections were the same for affected and unaffected macs.



Would disabling LE Read Transmit Power if the controller is
"apple-uart-blth" work for you?
--=20

