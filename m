Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14CD243CEB3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 18:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238267AbhJ0Q2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 12:28:06 -0400
Received: from tartarus.angband.pl ([51.83.246.204]:49368 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234414AbhJ0Q2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 12:28:04 -0400
X-Greylist: delayed 2043 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Oct 2021 12:28:04 EDT
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.94.2)
        (envelope-from <kilobyte@angband.pl>)
        id 1mfl6c-0073uO-76; Wed, 27 Oct 2021 17:44:46 +0200
Date:   Wed, 27 Oct 2021 17:44:46 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     heinrich.schuchardt@canonical.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Anup Patel <Anup.Patel@wdc.com>,
        axboe@kernel.dk, sagar.kadam@sifive.com,
        Atish Patra <Atish.Patra@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] riscv: defconfig: enable DRM_NOUVEAU
Message-ID: <YXlz7oa9gQFGW0AQ@angband.pl>
References: <20211012164658.81894-1-heinrich.schuchardt@canonical.com>
 <mhng-5dc2aa26-9f1c-4764-9877-6d99569210b4@palmerdabbelt-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mhng-5dc2aa26-9f1c-4764-9877-6d99569210b4@palmerdabbelt-glaptop>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 04:57:08PM -0700, Palmer Dabbelt wrote:
> On Tue, 12 Oct 2021 09:46:58 PDT (-0700), heinrich.schuchardt@canonical.com wrote:
> > Both RADEON and NOUVEAU graphics cards are supported on RISC-V. Enabling
> > the one and not the other does not make sense.
> > 
> > As typically at most one of RADEON, NOUVEAU, or VIRTIO GPU support will be
> > needed DRM drivers should be compiled as modules.
> 
> Do you have an nVidia card that works on real hardware?  Last I checked was
> a while ago, but they weren't working at the time (IIRC it was something to
> do with PCIe addressing, but it was a hardware limitation so I don't
> remember exactly how it all fits together).

Not having read the docs (no one does! :p), I took a random old card from
the shelf, put it in, and it just worked:

07:00.0 VGA compatible controller: NVIDIA Corporation G98 [GeForce 8400 GS Rev. 2] (rev a1)


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀
⣾⠁⢠⠒⠀⣿⡁ Polexit is brewing?  Let's skip that smelly Polsha and reactivate
⢿⡄⠘⠷⠚⠋⠀ the Free City of Danzig and/or reapply to the Hansa.
⠈⠳⣄⠀⠀⠀⠀
