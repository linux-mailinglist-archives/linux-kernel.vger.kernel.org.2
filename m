Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4B8B36BDDA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 05:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234375AbhD0Drp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 23:47:45 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:43008 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbhD0Drn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 23:47:43 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 632AB21FEC;
        Mon, 26 Apr 2021 23:46:58 -0400 (EDT)
Date:   Tue, 27 Apr 2021 13:47:04 +1000 (AEST)
From:   Finn Thain <fthain@fastmail.com.au>
To:     Michael Schmitz <schmitzmic@gmail.com>
cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>,
        Joshua Thompson <funaho@jurai.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org
Subject: Re: [PATCH] m68k/mac: Replace macide driver with generic platform
 driver
In-Reply-To: <65f01f42-31d9-522a-e690-73d286405a01@gmail.com>
Message-ID: <9650358f-a789-7dbd-4495-1d39ff321ded@nippy.intranet>
References: <793432cca963b632709c4d1312baa9874d73e1d8.1619341585.git.fthain@telegraphics.com.au> <ba908b1d-eab5-a4e5-0c0a-2c745287d121@physik.fu-berlin.de> <10a08764-c138-9fe5-966c-ce68349b9b6@nippy.intranet>
 <65f01f42-31d9-522a-e690-73d286405a01@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Apr 2021, Michael Schmitz wrote:

> On 26/04/21 7:37 pm, Finn Thain wrote:
> > Was macide the only IDE driver in Debian/m68k kernels without a libata 
> > alternative? If so, this patch would allow you to finally drop 
> > CONFIG_IDE.
> > 
> There's still q40ide.c (ISA IDE interface, byte-swapped, so would need 
> treatment similar to Falcon IDE). Hasn't been updated to a platform 
> device yet.
> 

AIUI, q40 support is not included in Debian/m68k kernel builds.

I wonder whether q40 could re-use the pata_falcon driver . I suppose 
pata_falcon_set_mode() would be undesirable on q40 (?) It could be made 
optional using the data parameter passed to 
platform_device_register_resndata().
