Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF05034F8A6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 08:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233595AbhCaGWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 02:22:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:54436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233720AbhCaGVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 02:21:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D07DF619B1;
        Wed, 31 Mar 2021 06:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617171709;
        bh=z20supYcVL/LvSq/d8Ls3AOwnRy5Vs7C0oP/A17PU6Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hJTg3C/n66D6a1OsOxkc8zngBVxFPzUrbHsSDgfYvOSAYLK1anUzaE74l935wEfcK
         OcbbaFo7jJ3sk4WJCeoMuaPHJJhEMXi8AW1lKaLJZk/PHfTZXMgtfS4KZSPBBLqTm9
         D+rZlr33CVzaXIl1Eq8wllmdcq6OL7wZNyrfvN/w=
Date:   Wed, 31 Mar 2021 08:21:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     cristian.birsan@microchip.com
Cc:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        robh+dt@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/2] usb: typec: Add driver for Microchip sama7g5
 tcpc
Message-ID: <YGQU+g8J6gZhn13X@kroah.com>
References: <20210330205442.981649-1-cristian.birsan@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330205442.981649-1-cristian.birsan@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 11:54:40PM +0300, cristian.birsan@microchip.com wrote:
> From: Cristian Birsan <cristian.birsan@microchip.com>
> 
> This patch set adds initial driver support for Microchip USB Type-C Port
> Controller (TCPC) embedded in sama7g5 SoC.
> 
> The controller does not implement power delivery and the driver uses dummy
> functions to register the port with TCPM. The current silicon version is
> not able to trigger interrupts so the driver will poll for changes on
> CC1/CC2 lines.
> 
> Support for sink is implemented and tested with an USB device. The plan is
> to extend the driver and add source support.

Why are these marked "RFC"?

Do you really not think they should be accepted?  Why not, what is left
to do with them?

I do not normally review "RFC" patches as the authors do not think they
should be merged, and we have plenty of patches that are being asked to
be merged already :)

thanks,

greg k-h
