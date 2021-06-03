Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A53539A9F8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 20:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbhFCS1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 14:27:04 -0400
Received: from polaris.svanheule.net ([84.16.241.116]:42880 "EHLO
        polaris.svanheule.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbhFCS1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 14:27:02 -0400
Received: from terra.local.svanheule.net (unknown [IPv6:2a02:a03f:eafb:ee01:eb34:edf2:c0ff:9e88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 1BFE92082E0;
        Thu,  3 Jun 2021 20:25:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1622744716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UpmB9rFom+ld5ngaOj8d4z5WZvrPxb9ZTPOARgw0Too=;
        b=ITmLZqT7r31YIY9Hx6HWQwIcaVXwQ3BAU+KizVciLzEQ+u7iuVYct83ZF3Z3IpcZX6Xs9P
        5qs/XkRMqDPmhoOYfWQEZBCXiDVetM3v09qbgMuuNhdhdNmFoRIx9qeXWJDCjGgcSxmYYO
        8zIV+kqO8VoUoxwSGjRjGU4FMKGnj00phBrOuYcJIXZRiXyvvsV30ytgEenP6XHLaBLSQi
        qE5VLGGOox2eLYpkvNxx2x2eJHub/94iJTlxiD56aQhPOdJFYY88RO6Qbeanjk/KzsFiID
        ZSMOeK2HbBjeOl22bzXO4GwirjqdC11NBTkD/0p5j4X0ZPDQBCCQTVejCpLQCA==
From:   Sander Vanheule <sander@svanheule.net>
To:     Mark Brown <broonie@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Sander Vanheule <sander@svanheule.net>
Subject: [RFC PATCH 0/2] Clause-22/Clause-45 MDIO regmap support
Date:   Thu,  3 Jun 2021 20:25:08 +0200
Message-Id: <cover.1622743333.git.sander@svanheule.net>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The initial MDIO regmap implementation only supported (or claimed to
only support) clause-22 register access, with 5 bit register addresses.
However, this was not enforced sufficiently, and regnum values were
passed verbatim to the mdio bus subsystem.

These patches aim to enforce the register address width, and also add
clause-45 support for extended address spaces. A clause-45 address is
defined here as the composite of the device type (see MDIO_MMD_* in
include/uapi/linux/mdio.h) and the register number, for a total width of
21 bit.

I have zero experience with clause-45 devices, and no such devices
available for testing. As such, clause-45 code in the second patch is
entirely untested, although it isn't very complex.

Although these patches should eventually make it into regmap-mdio, I
would like to resolve some questions first.

1. I've opted to just ignore any bits that lie beyond the allowed address
   width. Would it be cleaner to raise an error instead?

2. Packing of the clause-45 register addresses (16 bit) and adressed device
   type (5 bit) is the same as in the mdio subsystem, resulting in a 21 bit
   address. Is this an appropriate way to pack this information into one
   address for the regmap interface?

The reasoning behind (1) is to allow the regmap user to use extra bits
as a way to virtually extend the address space. Note that this actually
results in aliasing. This can be useful if the data read from to a
register doesn't have the same meaning as the data written to it
(e.g. GPIO pin input and output data). An alternative solution to this
would be some concept of "aliased registers" in regmap -- like volatile or
precious registers.

Sander Vanheule (2):
  regmap: mdio: Clean up invalid clause-22 addresses
  regmap: mdio: Add clause-45 support

 drivers/base/regmap/regmap-mdio.c | 73 +++++++++++++++++++++++++------
 1 file changed, 59 insertions(+), 14 deletions(-)

-- 
2.31.1

