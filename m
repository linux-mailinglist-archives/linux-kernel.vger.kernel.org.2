Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49315391751
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 14:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbhEZMal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 08:30:41 -0400
Received: from ni.piap.pl ([195.187.100.5]:52350 "EHLO ni.piap.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232829AbhEZMaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 08:30:39 -0400
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ni.piap.pl (Postfix) with ESMTPSA id 7B9794441CC;
        Wed, 26 May 2021 14:29:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl 7B9794441CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=piap.pl; s=mail;
        t=1622032147; bh=gCJ0rIGLjNAWVrx9kpX2mzO+HVS/Mtj4phJXnJzE1og=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=K2cPDuyonovbOg74Sk9BWLn5l9jsYqv2Jq40kxJwaG/WoJ22a+s+S9aF43tuZk4d1
         m8A74B0JejkJjC6OvKXGxO0whj4x9mgV9zYGrl5PHrhw/s+FnafuGPMKZtkGfMfw3a
         m/5rml4r7zvVjE4e2AXCdbEXX3/CfWxjhhaWZP9s=
From:   =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Data corruption on i.MX6 IPU in arm_copy_from_user()
References: <m3y2c1uchh.fsf@t19.piap.pl>
        <20210526100843.GD30436@shell.armlinux.org.uk>
Sender: khalasa@piap.pl
Date:   Wed, 26 May 2021 14:29:07 +0200
In-Reply-To: <20210526100843.GD30436@shell.armlinux.org.uk> (Russell King's
        message of "Wed, 26 May 2021 11:08:44 +0100")
Message-ID: <m3r1htu19o.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-KLMS-Rule-ID: 4
X-KLMS-Message-Action: skipped
X-KLMS-AntiSpam-Status: not scanned, whitelist
X-KLMS-AntiPhishing: not scanned, whitelist
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, not scanned, whitelist
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Russell King (Oracle)" <linux@armlinux.org.uk> writes:

> Surely someone is not using copy_*_user() to copy data from userspace
> direct to MMIO space... that would be crazy.

No, it's the other way around: reading MMIO mapped to userspace (mmap
on /dev/mem) and copying it to simple kernel buffer (e.g. pipe buffer).
I.e., the MMIO is the userspace here (thus copy_from_user()).
--=20
Krzysztof Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa
