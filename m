Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8773B5EAD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 15:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbhF1NI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 09:08:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:59992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233102AbhF1NIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 09:08:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0AC9461C67;
        Mon, 28 Jun 2021 13:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624885558;
        bh=3kmPpdJJLBc82VUevNApL7kNOOs7bagNA6cKCpLTN+4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SOYpeJMc4MmWY+VJ9duNc6vhRNarkgT+bdkBsXgaWx+P7/yWia1VmGqlIK56Eirt/
         H/QfQtU9qOwuqPcfpp8gwM3E1ZKIdcoOokJHOmNAU2i9Nb3Jj9+S38ALZpol81B1RG
         h4XUwkg309HgtKX0zPe6IP/NMIVt22m2ZjLKWlZscjmJu14kNKzxWBDN038VCepw+3
         Rl0zehqj/gGwi55C88cB3eYpHrKSiULqGXpdpn/H4IiNl4hAWcHzd/177F2fHQqt3W
         gbtcDkCAjcAJGB5Rp8diNo/3dPJfgeS2c2Nm9cm+rOp5heRkXieaVMJlgqX0h5ZiTe
         BfsMb+1NOccwA==
Date:   Mon, 28 Jun 2021 15:05:53 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: armada-3720-turris-mox.dts: remove
 mrvl,i2c-fast-mode
Message-ID: <20210628150553.4e026d19@thinkpad>
In-Reply-To: <20210628121015.22660-1-pali@kernel.org>
References: <20210628121015.22660-1-pali@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jun 2021 14:10:15 +0200
Pali Roh=C3=A1r <pali@kernel.org> wrote:

> +	/delete-property/mrvl,i2c-fast-mode;

Can you add an additional space here?
  /delete-property/ mrvl,i2c-fast-mode;

Other than that

Reviewed-by: Marek Beh=C3=BAn <kabel@kernel.org>


BTW the i2c driver should me made to respect the `clock-frequency` DT
property, not the fast-mode nonsense.

The `mrvl,i2c-fast-mode` should be IMO completely removed and whether it
is enabled should be decided by the value of `clock-frequency`.

BTW there are clock generating registers in A3720 I2C controller that
can generate 100 kHz even in fast-mode. The driver does not use them,
though, it leaves them to their default values, which for normal mode
generate ~96 kHz and for fast mode ~258 kHz. Maybe we should implement
configuring these registers and make the driver choose
normal-mode / fast-mode / high-speed mode depending on
`clock-frequency` ?

Marek
