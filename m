Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF563378333
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 12:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbhEJKmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 06:42:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:40468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232723AbhEJKfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 06:35:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9268F6162C;
        Mon, 10 May 2021 10:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620642492;
        bh=Jr32Em6/L3P6Xd7P62C+N9WlG+AenS41r32uNCvD1N4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ap8OFiDvXZp5SnBRAQIDS2BlWpwo+dVYEi6B8nd7lorjEpjA8iy2DcgXo+7uoKS44
         qy4PzcOz8rce9XI9qqP7WfM3Lo3i/NVfA1QccJsyZNUoYfyPffxfm4le8He/Te60BK
         hvTX3n/2a5iqm4d7okebAXvhR3GfSIXWlC191c1YFtQXCSMYE4PrCMqqYpy1tZvHdJ
         8U2lkN3mDVNotVqzwZ5pTiJ8eu0EEo/qc8AtoQ2yusz8oh4OZIDDUabS1Intvh+49k
         Fcko9q2x3/Hdpbi/SD8cQkzu2I9YlCxjBMF+LGwz76KTYLzzgdB4ylpNOxTyb21NpN
         w/up5r2E9xLWA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lg38z-000UY3-CT; Mon, 10 May 2021 12:28:09 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@protonmail.com>, Jaroslav Kysela <perex@perex.cz>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 45/53] docs: sound: kernel-api: writing-an-alsa-driver.rst: avoid using UTF-8 chars
Date:   Mon, 10 May 2021 12:26:57 +0200
Message-Id: <8ac9e0ecd6e3b89c4a213f2d33de6344122401a3.1620641727.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1620641727.git.mchehab+huawei@kernel.org>
References: <cover.1620641727.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While UTF-8 characters can be used at the Linux documentation,
the best is to use them only when ASCII doesn't offer a good replacement.
So, replace the occurences of the following UTF-8 characters:

	- U+00a0 (' '): NO-BREAK SPACE
	- U+201c ('“'): LEFT DOUBLE QUOTATION MARK
	- U+201d ('”'): RIGHT DOUBLE QUOTATION MARK

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../kernel-api/writing-an-alsa-driver.rst     | 68 +++++++++----------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/Documentation/sound/kernel-api/writing-an-alsa-driver.rst b/Documentation/sound/kernel-api/writing-an-alsa-driver.rst
index e6365836fa8b..201ced3bba6e 100644
--- a/Documentation/sound/kernel-api/writing-an-alsa-driver.rst
+++ b/Documentation/sound/kernel-api/writing-an-alsa-driver.rst
@@ -533,7 +533,7 @@ Management of Cards and Components
 Card Instance
 -------------
 
-For each soundcard, a “card” record must be allocated.
+For each soundcard, a "card" record must be allocated.
 
 A card record is the headquarters of the soundcard. It manages the whole
 list of devices (components) on the soundcard, such as PCM, mixers,
@@ -980,7 +980,7 @@ The role of destructor is simple: disable the hardware (if already
 activated) and release the resources. So far, we have no hardware part,
 so the disabling code is not written here.
 
-To release the resources, the “check-and-release” method is a safer way.
+To release the resources, the "check-and-release" method is a safer way.
 For the interrupt, do like this:
 
 ::
@@ -1133,7 +1133,7 @@ record:
 
 The ``probe`` and ``remove`` functions have already been defined in
 the previous sections. The ``name`` field is the name string of this
-device. Note that you must not use a slash “/” in this string.
+device. Note that you must not use a slash "/" in this string.
 
 And at last, the module entries:
 
@@ -1692,8 +1692,8 @@ Typically, you'll have a hardware descriptor as below:
 
    The other possible flags are ``SNDRV_PCM_INFO_PAUSE`` and
    ``SNDRV_PCM_INFO_RESUME``. The ``PAUSE`` bit means that the pcm
-   supports the “pause” operation, while the ``RESUME`` bit means that
-   the pcm supports the full “suspend/resume” operation. If the
+   supports the "pause" operation, while the ``RESUME`` bit means that
+   the pcm supports the full "suspend/resume" operation. If the
    ``PAUSE`` flag is set, the ``trigger`` callback below must handle
    the corresponding (pause push/release) commands. The suspend/resume
    trigger commands can be defined even without the ``RESUME``
@@ -1731,7 +1731,7 @@ Typically, you'll have a hardware descriptor as below:
    ``periods_min`` define the maximum and minimum number of periods in
    the buffer.
 
-   The “period” is a term that corresponds to a fragment in the OSS
+   The "period" is a term that corresponds to a fragment in the OSS
    world. The period defines the size at which a PCM interrupt is
    generated. This size strongly depends on the hardware. Generally,
    the smaller period size will give you more interrupts, that is,
@@ -1756,7 +1756,7 @@ application. This field contains the enum value
 ``SNDRV_PCM_FORMAT_XXX``.
 
 One thing to be noted is that the configured buffer and period sizes
-are stored in “frames” in the runtime. In the ALSA world, ``1 frame =
+are stored in "frames" in the runtime. In the ALSA world, ``1 frame =
 channels \* samples-size``. For conversion between frames and bytes,
 you can use the :c:func:`frames_to_bytes()` and
 :c:func:`bytes_to_frames()` helper functions.
@@ -1999,7 +1999,7 @@ prepare callback
 
   static int snd_xxx_prepare(struct snd_pcm_substream *substream);
 
-This callback is called when the pcm is “prepared”. You can set the
+This callback is called when the pcm is "prepared". You can set the
 format type, sample rate, etc. here. The difference from ``hw_params``
 is that the ``prepare`` callback will be called each time
 :c:func:`snd_pcm_prepare()` is called, i.e. when recovering after
@@ -2436,8 +2436,8 @@ size is aligned with the period size.
 
 The hw constraint is a very much powerful mechanism to define the
 preferred PCM configuration, and there are relevant helpers.
-I won't give more details here, rather I would like to say, “Luke, use
-the source.”
+I won't give more details here, rather I would like to say, "Luke, use
+the source."
 
 Control Interface
 =================
@@ -2518,50 +2518,50 @@ Control Names
 -------------
 
 There are some standards to define the control names. A control is
-usually defined from the three parts as “SOURCE DIRECTION FUNCTION”.
+usually defined from the three parts as "SOURCE DIRECTION FUNCTION".
 
 The first, ``SOURCE``, specifies the source of the control, and is a
-string such as “Master”, “PCM”, “CD” and “Line”. There are many
+string such as "Master", "PCM", "CD" and "Line". There are many
 pre-defined sources.
 
 The second, ``DIRECTION``, is one of the following strings according to
-the direction of the control: “Playback”, “Capture”, “Bypass Playback”
-and “Bypass Capture”. Or, it can be omitted, meaning both playback and
+the direction of the control: "Playback", "Capture", "Bypass Playback"
+and "Bypass Capture". Or, it can be omitted, meaning both playback and
 capture directions.
 
 The third, ``FUNCTION``, is one of the following strings according to
-the function of the control: “Switch”, “Volume” and “Route”.
+the function of the control: "Switch", "Volume" and "Route".
 
-The example of control names are, thus, “Master Capture Switch” or “PCM
-Playback Volume”.
+The example of control names are, thus, "Master Capture Switch" or "PCM
+Playback Volume".
 
 There are some exceptions:
 
 Global capture and playback
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-“Capture Source”, “Capture Switch” and “Capture Volume” are used for the
-global capture (input) source, switch and volume. Similarly, “Playback
-Switch” and “Playback Volume” are used for the global output gain switch
+"Capture Source", "Capture Switch" and "Capture Volume" are used for the
+global capture (input) source, switch and volume. Similarly, "Playback
+Switch" and "Playback Volume" are used for the global output gain switch
 and volume.
 
 Tone-controls
 ~~~~~~~~~~~~~
 
-tone-control switch and volumes are specified like “Tone Control - XXX”,
-e.g. “Tone Control - Switch”, “Tone Control - Bass”, “Tone Control -
-Center”.
+tone-control switch and volumes are specified like "Tone Control - XXX",
+e.g. "Tone Control - Switch", "Tone Control - Bass", "Tone Control -
+Center".
 
 3D controls
 ~~~~~~~~~~~
 
-3D-control switches and volumes are specified like “3D Control - XXX”,
-e.g. “3D Control - Switch”, “3D Control - Center”, “3D Control - Space”.
+3D-control switches and volumes are specified like "3D Control - XXX",
+e.g. "3D Control - Switch", "3D Control - Center", "3D Control - Space".
 
 Mic boost
 ~~~~~~~~~
 
-Mic-boost switch is set as “Mic Boost” or “Mic Boost (6dB)”.
+Mic-boost switch is set as "Mic Boost" or "Mic Boost (6dB)".
 
 More precise information can be found in
 ``Documentation/sound/designs/control-names.rst``.
@@ -3368,7 +3368,7 @@ This ensures that the device can be closed and the driver unloaded
 without losing data.
 
 This callback is optional. If you do not set ``drain`` in the struct
-snd_rawmidi_ops structure, ALSA will simply wait for 50 milliseconds
+snd_rawmidi_ops structure, ALSA will simply wait for 50 milliseconds
 instead.
 
 Miscellaneous Devices
@@ -3506,20 +3506,20 @@ fixed as 4 bytes array (value.iec958.status[x]). For the ``info``
 callback, you don't specify the value field for this type (the count
 field must be set, though).
 
-“IEC958 Playback Con Mask” is used to return the bit-mask for the IEC958
-status bits of consumer mode. Similarly, “IEC958 Playback Pro Mask”
+"IEC958 Playback Con Mask" is used to return the bit-mask for the IEC958
+status bits of consumer mode. Similarly, "IEC958 Playback Pro Mask"
 returns the bitmask for professional mode. They are read-only controls,
 and are defined as MIXER controls (iface =
 ``SNDRV_CTL_ELEM_IFACE_MIXER``).
 
-Meanwhile, “IEC958 Playback Default” control is defined for getting and
+Meanwhile, "IEC958 Playback Default" control is defined for getting and
 setting the current default IEC958 bits. Note that this one is usually
 defined as a PCM control (iface = ``SNDRV_CTL_ELEM_IFACE_PCM``),
 although in some places it's defined as a MIXER control.
 
 In addition, you can define the control switches to enable/disable or to
 set the raw bit mode. The implementation will depend on the chip, but
-the control should be named as “IEC958 xxx”, preferably using the
+the control should be named as "IEC958 xxx", preferably using the
 :c:func:`SNDRV_CTL_NAME_IEC958()` macro.
 
 You can find several cases, for example, ``pci/emu10k1``,
@@ -3547,7 +3547,7 @@ function.
 
 Usually, ALSA drivers try to allocate and reserve a large contiguous
 physical space at the time the module is loaded for the later use. This
-is called “pre-allocation”. As already written, you can call the
+is called "pre-allocation". As already written, you can call the
 following function at pcm instance construction time (in the case of PCI
 bus).
 
@@ -4163,7 +4163,7 @@ The typical coding would be like below:
 
 Also, don't forget to define the module description and the license.
 Especially, the recent modprobe requires to define the
-module license as GPL, etc., otherwise the system is shown as “tainted”.
+module license as GPL, etc., otherwise the system is shown as "tainted".
 
 ::
 
@@ -4181,7 +4181,7 @@ So far, you've learned how to write the driver codes. And you might have
 a question now: how to put my own driver into the ALSA driver tree? Here
 (finally :) the standard procedure is described briefly.
 
-Suppose that you create a new PCI driver for the card “xyz”. The card
+Suppose that you create a new PCI driver for the card "xyz". The card
 module name would be snd-xyz. The new driver is usually put into the
 alsa-driver tree, ``sound/pci`` directory in the case of PCI
 cards.
-- 
2.30.2

