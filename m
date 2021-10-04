Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC66421558
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 19:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235276AbhJDRtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 13:49:32 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:51603 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbhJDRtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 13:49:31 -0400
Date:   Mon, 04 Oct 2021 17:47:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1633369659;
        bh=yD2hgzbbiF1epuVx9Hsd1a+S8dzM0dhkyn+z5Mc27KY=;
        h=Date:To:From:Reply-To:Subject:From;
        b=THH5fbuU0De61uYJ+rJViu6Kq70WzzIpF70s6jmRgmXXOB6ba/sscz2V5RtfiWAto
         taswYHtsZm2TZOvxqE53B5LfftQPA8krflRHjHofEhn7jjdjrBS/lv3YADBGt/hJff
         reAY4cLmNZo+51ANT5IKxr3zvoJ5KUUJ/ps7M0kg=
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Ser Olmy <ser.olmy@protonmail.com>
Reply-To: Ser Olmy <ser.olmy@protonmail.com>
Subject: [x86] Kernel v5.14 series panic on Celeron Mendocino CPU
Message-ID: <CPeoI7yf4421QpWLM-CbgeDR17BBmhlLoixeYI3mu2WbDkgrZItfgImOO6BZez7CXQXXO9liq-rmZzgRVB95TP5MN0xUA8-d7-fSQZdyIZE=@protonmail.com>
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

Booting any 5.14 kernel on certain Celeron-based 32-bit machines results in=
 a panic:

[   22.546247] Run /init as init process
[   22.610556] init[1] bad frame in sigreturn frame:(ptrval) ip:b7d46be6 sp=
:bff3af30 orax:ffffffff in libc-2.33.so[b7c94000+156000]
[   22.749531] Kernel panic - not syncing: Attempted to kill init! exitcode=
=3D0x0000000b
[   22.750240] CPU: 0 PID: 1 Comm: init Not tainted 5.14.9 #1
[   22.750240] Hardware name: Hewlett-Packard HP PC/HP Board, BIOS  JD.00.0=
6 12/06/2001
[   22.750240] Call Trace:
[   22.750240]  ? dump_stack_lvl+0x32/0x41
[   22.750240]  ? dump_stack+0xa/0xc
[   22.750240]  ? panic+0xa2/0x23f
[   22.750240]  ? do_exit.cold+0x94/0x94
[   22.750240]  ? do_group_exit+0x2a/0x80
[   22.750240]  ? get_signal+0x142/0x7a0
[   22.750240]  ? arch_do_signal_or_restart+0xb1/0x570
[   22.750240]  ? force_sig_info_to_task+0x65/0xf0
[   22.750240]  ? vprintk_emit+0x150/0x190
[   22.750240]  ? exit_to_user_mode_prepare+0x145/0x1e0
[   22.750240]  ? syscall_exit_to_user_mode+0x18/0x40
[   22.750240]  ? do_int80_syscall_32+0x3d/0x80
[   22.750240]  ? entry_INT80_32+0xf0/0xf0

I've bisected it to this commit:

6f9866a166cd1ad3ebb2dcdb3874aa8fee8dea2f [x86/fpu/signal: Let xrstor handle=
 the features to init]

Reverting it results in a working system.

Regards,

Olmy
