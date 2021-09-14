Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43BE740A279
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 03:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237650AbhINB1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 21:27:30 -0400
Received: from shells.gnugeneration.com ([66.240.222.126]:49176 "EHLO
        shells.gnugeneration.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236437AbhINB13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 21:27:29 -0400
Received: by shells.gnugeneration.com (Postfix, from userid 1000)
        id 6C04C1A50AD9; Mon, 13 Sep 2021 18:26:12 -0700 (PDT)
Date:   Mon, 13 Sep 2021 18:26:12 -0700
From:   Vito Caputo <vcaputo@pengaru.com>
To:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: Broken WCHAN in modern x86 kernel defconfig? Intentional?
Message-ID: <20210914012612.vwlowt5wsojmyfzr@shells.gnugeneration.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello lkml,

Recently I've been using an Arch machine with the distro-provided
kernel, and noticed the wchan is never set for any processes.  This
seems rather odd for a generic distro-provided kernel, since it breaks
basic functionality like showing WCHAN in `top` or `ps -o wchan`.

Looking at /proc/config.gz I see only CONFIG_SCHED_OMIT_FRAME_POINTER=y
set WRT frame pointers, but I thought this meant I'd still see 
non-zero wchans in /proc/*/wchan.  It's not like it contains
CONFIG_FRAME_POINTER=n, it simply doesn't mention it at all.

For many years I've been running custom kernels on Debian built from
the same .config that's just kept evolving over time.  So I wouldn't
have noticed if at some point CONFIG_FRAME_POINTER vanished from a
fresh x86_64 defconfig, and I doubt I originally explicitly turned
that on when seeding my .config back in the day.

To see if this indeed is a defconfig regression of sorts, I just tried
a `make defconfig; grep FRAME_POINTER .config` for both v4.0 and
master:

v4.0:
CONFIG_SCHED_OMIT_FRAME_POINTER=y
CONFIG_ARCH_WANT_FRAME_POINTERS=y
CONFIG_FRAME_POINTER=y

master:
CONFIG_SCHED_OMIT_FRAME_POINTER=y
# CONFIG_UNWINDER_FRAME_POINTER is not set

Is this intentional?  At a glance, commit 81d3871 looks suspect in
removing ARCH_WANT_FRAME_POINTERS from x86/Kconfig.

Thanks,
Vito Caputo
