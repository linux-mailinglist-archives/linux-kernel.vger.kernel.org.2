Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 404B934A976
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 15:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhCZOTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 10:19:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:45954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230135AbhCZOTF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 10:19:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D3A5760190;
        Fri, 26 Mar 2021 14:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616768345;
        bh=tfNIe4//8+r1CwXYQDUxEyprnoIfc5khzzoSiAZ9fbI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sV+2c+UoZkzTKM4GtvJVgpoR+tm+DNstT/pLPJaZjy02CvNoUB5WsIk4jPp9G+xIG
         dTssGtWfCz+5+GVa/JQuc7eydLDXf27e2KrP20Atw1OPv4WUbHAnj9zlQRkoQYdNET
         /67jNJ9Mvm46YEQ6+dvTibHfMsqnSpsCdAvXuYn8=
Date:   Fri, 26 Mar 2021 15:18:55 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Al Cooper <alcooperx@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v7 0/2] 8250: Add driver for Broadcom UART
Message-ID: <YF3tT7OrDeZEcO69@kroah.com>
References: <20210325185256.16156-1-alcooperx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325185256.16156-1-alcooperx@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 02:52:54PM -0400, Al Cooper wrote:
> v7 - Change Kconfig for SERIAL_8250_BCM7271 from "bool" to "tristate"
>      so the driver can be built as a module.

Much better, thanks for sticking with this, now queued up.

greg k-h
