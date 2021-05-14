Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8375A38055D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 10:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbhENIlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 04:41:24 -0400
Received: from mail.meine-oma.de ([88.99.114.13]:38632 "EHLO mail.meine-oma.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231658AbhENIlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 04:41:24 -0400
X-Greylist: delayed 932 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 May 2021 04:41:23 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=meine-oma.de; s=x; h=Content-Transfer-Encoding:Content-Type:Message-ID:
        Subject:To:From:Date:MIME-Version:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=j9vfGfTRt2xVVgd/7Q30ckAhaRcWFEupViMBimjbko8=; b=8Wj8zc8xzRWlWWnbXYuCaINJCa
        DGsS41dgI6HAN3vHLg5Ubm1Fd44xFmn/u1me3Yam6bcX3a8HwuQww4ZtTGDG3pcn6J3vSgHx2CjM3
        V3sepPOQguAYv4Be89x791NRtYtT2rdHHRSPFsaNG/mi6RWZKm2Iq1X1BdbHMwOEDojI=;
Received: from localhost ([127.0.0.1] helo=mail.meine-oma.de)
        by mail.meine-oma.de with esmtp (Exim 4.94.2)
        (envelope-from <himbeere@meine-oma.de>)
        id 1lhT7S-00025y-Jc
        for linux-kernel@vger.kernel.org; Fri, 14 May 2021 10:24:26 +0200
MIME-Version: 1.0
Date:   Fri, 14 May 2021 10:24:26 +0200
From:   Thomas Stein <himbeere@meine-oma.de>
To:     linux-kernel@vger.kernel.org
Subject: thinkpad x1 carbon display flickering after update to 5.12. good on
 5.11.x (i915)
Message-ID: <1a6cf0a3dc8a2c6364265ad7249b76b1@meine-oma.de>
X-Sender: himbeere@meine-oma.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Devs.

After upgrading to linux 5.12 the display on my X1 Carbon Gen 2 starts 
to flicker. Well actually it seems to turn off and on again and again. 
Here a link to a video a person posted who has the same issue as me 
obviousely. 
https://linuxove.com/thinkpad-x1-carbon-gen-3-display-flickering-on-linux-kernel-5-12/

This happens without having Xorg running too. So it can't be related to 
Xorg. The kernel boots and after a few seconds, the kernel messages 
scoll through, the flickering starts. Nothing special in dmesg.

dmesg:

himbeere@rather ~ $ dmesg | grep i915
[    0.713595] i915 0000:00:02.0: vgaarb: deactivate vga console
[    0.720280] i915 0000:00:02.0: vgaarb: changed VGA decodes: 
olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    0.741494] i915 0000:00:02.0: [drm] Panel advertises DPCD backlight 
support, but VBT disagrees. If your backlight controls don't work try 
booting with i915.enable_dpcd_backlight=1. If your machine needs this, 
please file a _new_ bug report on drm/i915, see 
https://gitlab.freedesktop.org/drm/intel/-/wikis/How-to-file-i915-bugs 
for details.
[    1.864837] [drm] Initialized i915 1.6.0 20201103 for 0000:00:02.0 on 
minor 0
[    1.875907] fbcon: i915drmfb (fb0) is primary device
[    3.158255] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer 
device
himbeere@rather ~ $

Downgrading to 5.11 solves the issue for me. Any ideas?

cheers, t.
