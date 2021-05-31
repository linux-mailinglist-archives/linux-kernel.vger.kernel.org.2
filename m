Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBFA039555B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 08:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbhEaGWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 02:22:42 -0400
Received: from ni.piap.pl ([195.187.100.5]:46514 "EHLO ni.piap.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229752AbhEaGWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 02:22:40 -0400
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ni.piap.pl (Postfix) with ESMTPSA id D04974441F6;
        Mon, 31 May 2021 08:20:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl D04974441F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=piap.pl; s=mail;
        t=1622442059; bh=pSKdUQ/SHtMFltluDtQtsnviwfqIGj8DHN4OUQFCP/s=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=aJL8+oiGYQcTlYl0LdNbRZz63YBR+LqWa7xlq3YUcCPzX7/nO3TTmwlYqEzqwf23b
         JKN2N0viGCn5tVYh4jSZ2gYCi6zPOVMyo3TSWhaW7b++gVpLcqPwg88Z2ZclLtjH8H
         X3MqDfqQIVcd1NPakSNOpFAA55c0pa7MNnYdYaLg=
From:   =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Data corruption on i.MX6 IPU in arm_copy_from_user()
References: <m3y2c1uchh.fsf@t19.piap.pl>
        <20210526100843.GD30436@shell.armlinux.org.uk>
        <m3r1htu19o.fsf@t19.piap.pl>
        <20210526131853.GE30436@shell.armlinux.org.uk>
        <m3h7intbub.fsf@t19.piap.pl>
        <20210528143544.GQ30436@shell.armlinux.org.uk>
Sender: khalasa@piap.pl
Date:   Mon, 31 May 2021 08:20:59 +0200
In-Reply-To: <20210528143544.GQ30436@shell.armlinux.org.uk> (Russell King's
        message of "Fri, 28 May 2021 15:35:44 +0100")
Message-ID: <m3y2bvs9tg.fsf@t19.piap.pl>
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

BTW writes (STMIA) to IPU registers are apparently not corrupted, only
LDMIAs are affected - in pure userspace as well.
--=20
Krzysztof Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa
