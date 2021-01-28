Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E46B3073C9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 11:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbhA1Kb1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 28 Jan 2021 05:31:27 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:38335 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbhA1KbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 05:31:17 -0500
Received: from xps13 (lfbn-tou-1-972-150.w86-210.abo.wanadoo.fr [86.210.203.150])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 9520110000F;
        Thu, 28 Jan 2021 10:30:27 +0000 (UTC)
Date:   Thu, 28 Jan 2021 11:30:26 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>
Cc:     miklos@szeredi.hu, vigneshr@ti.com, boris.brezillon@collabora.com,
        rminnich@google.com, sven@narfation.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        fuse-devel@lists.sourceforge.net
Subject: Re: [PATCH 0/8] MUSE: Userspace backed MTD v3
Message-ID: <20210128113026.094b07b0@xps13>
In-Reply-To: <20210124232007.21639-1-richard@nod.at>
References: <20210124232007.21639-1-richard@nod.at>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

Richard Weinberger <richard@nod.at> wrote on Mon, 25 Jan 2021 00:19:59
+0100:

> I'm happy to announce the first non-RFC version of this patch set.
> Over the xmas holidays I found some time to experiment with various userspace
> implementations of MTDs and gave the kernel side more fine-tuning.
> 
> Rationale:
> ----------
> 
> When working with flash devices a common task is emulating them to run various
> tests or inspect dumps from real hardware. To achieve that we have plenty of
> emulators in the MTD subsystem: mtdram, block2mtd, nandsim.
> 
> Each of them implements an ad-hoc MTD and have various drawbacks.
> Over the last years some developers tried to extend them but these attempts
> often got rejected because they added just more adhoc feature instead of
> addressing overall problems.
> 
> MUSE is a novel approach to address the need of advanced MTD emulators.
> Advanced means in this context supporting different (vendor specific) image
> formats, different ways for fault injection (fuzzing) and recoding/replaying
> IOs to emulate power cuts.
> 
> The core goal of MUSE is having the complexity on the userspace side and
> only a small MTD driver in kernelspace.
> While playing with different approaches I realized that FUSE offers everything
> we need. So MUSE is a little like CUSE except that it does not implement a
> bare character device but an MTD.

I can't tell if your MUSE implementation is right but it looks fine
on the MTD side.

This is following the right path, I look forward to merging it soon!

Thanks for your contribution,
Miquèl
