Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6C4380A9F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 15:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhENNq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 09:46:26 -0400
Received: from mail.meine-oma.de ([88.99.114.13]:44166 "EHLO mail.meine-oma.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230363AbhENNqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 09:46:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=meine-oma.de; s=x; h=Content-Transfer-Encoding:Content-Type:Message-ID:
        References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XGx/7rOKdm+joqcF3hvgoi0MjdueZKKpV0droN3qfrc=; b=bY8q2dllZqbldesadPpgsKWIfH
        xbtGRBjP6CzAQue5ebzXfhX2rpJ5KoKQrFyTKdRkq3/Yubcrdll1hDgcg7IaPAJxc4KyS0ZvtV8VS
        AyY3CnDdR/w2fQjksT6lyLDdqjd8nQ8y6znLuHNhbw+/vZhfcUOokGnPHjTe1slgQLno=;
Received: from localhost ([127.0.0.1] helo=mail.meine-oma.de)
        by mail.meine-oma.de with esmtp (Exim 4.94.2)
        (envelope-from <himbeere@meine-oma.de>)
        id 1lhY7X-0003ky-5M; Fri, 14 May 2021 15:44:51 +0200
MIME-Version: 1.0
Date:   Fri, 14 May 2021 15:44:51 +0200
From:   Thomas Stein <himbeere@meine-oma.de>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        =?UTF-8?Q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Imre Deak <imre.deak@intel.com>,
        Manasi Navare <manasi.d.navare@intel.com>,
        Lyude Paul <lyude@redhat.com>,
        Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: thinkpad x1 carbon display flickering after update to 5.12. good
 on 5.11.x (i915)
In-Reply-To: <20210514123431.fqvaa437zlw7rq7j@spock.localdomain>
References: <1a6cf0a3dc8a2c6364265ad7249b76b1@meine-oma.de>
 <20210514123431.fqvaa437zlw7rq7j@spock.localdomain>
Message-ID: <e41eba8500f731c979340fd810da203f@meine-oma.de>
X-Sender: himbeere@meine-oma.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Yes, it does indeed! No flicker anymore. Thanks and cheers!

On 2021-05-14 14:34, Oleksandr Natalenko wrote:
> Hello.
> 
> On Fri, May 14, 2021 at 10:24:26AM +0200, Thomas Stein wrote:
>> After upgrading to linux 5.12 the display on my X1 Carbon Gen 2 starts 
>> to
>> flicker. Well actually it seems to turn off and on again and again. 
>> Here a
>> link to a video a person posted who has the same issue as me 
>> obviousely. 
>> https://linuxove.com/thinkpad-x1-carbon-gen-3-display-flickering-on-linux-kernel-5-12/
>> 
>> This happens without having Xorg running too. So it can't be related 
>> to
>> Xorg. The kernel boots and after a few seconds, the kernel messages 
>> scoll
>> through, the flickering starts. Nothing special in dmesg.
>> 
>> dmesg:
>> 
>> himbeere@rather ~ $ dmesg | grep i915
>> [    0.713595] i915 0000:00:02.0: vgaarb: deactivate vga console
>> [    0.720280] i915 0000:00:02.0: vgaarb: changed VGA decodes:
>> olddecodes=io+mem,decodes=io+mem:owns=io+mem
>> [    0.741494] i915 0000:00:02.0: [drm] Panel advertises DPCD 
>> backlight
>> support, but VBT disagrees. If your backlight controls don't work try
>> booting with i915.enable_dpcd_backlight=1. If your machine needs this,
>> please file a _new_ bug report on drm/i915, see
>> https://gitlab.freedesktop.org/drm/intel/-/wikis/How-to-file-i915-bugs 
>> for
>> details.
>> [    1.864837] [drm] Initialized i915 1.6.0 20201103 for 0000:00:02.0 
>> on
>> minor 0
>> [    1.875907] fbcon: i915drmfb (fb0) is primary device
>> [    3.158255] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer 
>> device
>> himbeere@rather ~ $
>> 
>> Downgrading to 5.11 solves the issue for me. Any ideas?
> 
> Does [1] fix your issue?
> 
> [1] 
> https://cgit.freedesktop.org/drm-tip/patch/?id=acca7762eb71bc05a8f28d29320d193150051f79
