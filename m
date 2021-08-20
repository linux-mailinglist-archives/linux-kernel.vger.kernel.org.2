Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E93493F2652
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 07:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238100AbhHTFJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 01:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235390AbhHTFJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 01:09:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070B1C061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 22:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=gtlfkhGirRBJ8Rr1d2z1tTWoOCPLuNEfEmn6mu6cjLA=; b=zsCwN4DVnmIEnuaqX8EyuapcBq
        IZ1aPF0kFZO3gVoseO7Egt7H6jdzUTRt0gK4Mphf+Q1pbWwT8XDv40DZgswofC9kIkx2HObR8Gz57
        5ZB0IYkfY9jTbEjWt6p23Jb8+RGwshevMkxNhO4EC5RfhVZ0DQBjhSh8lrbMFxjAGsq25ss8auMeq
        K7zfgmc9lQs2Oz3e2C7ZjONDPNg+iTU3KXclnFnunOaFrL1q2+aNdYnDSJ8S9QE7jovXWs7cDJEsk
        wssGU9pIDLfne3mEaU9kozsWxurmchofdo/6YmJBIAobmarmm9B77Jk9d+TYUF9yTaxw6JLIsiQEd
        Yrp/6wAA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGwle-00A6pi-EP; Fri, 20 Aug 2021 05:08:34 +0000
To:     alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: HDA codec problem
Message-ID: <12bbf54b-3ef6-8fa8-37fc-5f1e8d134bba@infradead.org>
Date:   Thu, 19 Aug 2021 22:08:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am having problems getting audio working on my computer:

00:1f.3 Audio device: Intel Corporation Device f1c8

I did an internet search that said that I would need 5.13 or later to
have support for this device.


openSUSE 15.3 kernel 5.3.18-59.19-default says:

snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC233: line_outs=1 (0x1b/0x0/0x0/0x0/0x0) type:line
snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
snd_hda_codec_realtek hdaudioC0D0:    inputs:
snd_hda_codec_realtek hdaudioC0D0:      Mic=0x1a
snd_hda_codec_realtek hdaudioC0D0:      Mic=0x19

but produces no sound output.

Kernel 5.13.10 or 5.14-rc6 say:

calling  azx_driver_init+0x0/0x20 @ 1
snd_hda_intel 0000:00:1f.3: enabling device (0000 -> 0002)
snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops i915_audio_component_bind_ops)
snd_hda_intel 0000:00:1f.3: azx_get_response timeout, switching to polling mode: last cmd=0x200f0000
snd_hda_intel 0000:00:1f.3: No response from codec, disabling MSI: last cmd=0x200f0000
snd_hda_intel 0000:00:1f.3: Codec #2 probe error; disabling it...
snd_hda_intel 0000:00:1f.3: azx_get_response timeout, switching to single_cmd mode: last cmd=0x000f0001
hdaudio hdaudioC0D0: no AFG or MFG node found
snd_hda_intel 0000:00:1f.3: no codecs initialized

and of course no sound output.


Anyone have suggestions or has a fix for this already been posted?
or maybe I am just doing something wrong?

thanks.
-- 
~Randy

