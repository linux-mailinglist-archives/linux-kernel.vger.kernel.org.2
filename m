Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 604873B438C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 14:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbhFYMsG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 25 Jun 2021 08:48:06 -0400
Received: from aposti.net ([89.234.176.197]:47172 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229470AbhFYMsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 08:48:06 -0400
Date:   Fri, 25 Jun 2021 13:45:35 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2] ALSA: hda: Continue to probe when codec probe fails
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     tiwai@suse.com, SOUND <alsa-devel@alsa-project.org>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mike Rapoport <rppt@kernel.org>
Message-Id: <ZRC9VQ.M548GASAC18G2@crapouillou.net>
In-Reply-To: <20201216124726.2842197-1-kai.heng.feng@canonical.com>
References: <20201214060621.1102931-1-kai.heng.feng@canonical.com>
        <20201216124726.2842197-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kai-Heng,

I am facing the same bug. Unfortunately your patch does not seem to fix 
the bug for me, the nvidia GPU stays constantly active. Only if I 
unbind the snd-hda-intel module for this PCI device that the nvidia GPU 
will eventually go to sleep.

My dmesg (with your patch applied):

[ 1.821358] MXM: GUID detected in BIOS
[ 1.821396] ACPI BIOS Error (bug): AE_AML_PACKAGE_LIMIT, Index 
(0x000000003) is beyond end of object (length 0x0) 
(20200925/exoparg2-393)
[ 1.821406] ACPI Error: Aborting method \_SB.PCI0.GFX0._DSM due to 
previous error (AE_AML_PACKAGE_LIMIT) (20200925/psparse-529)
[ 1.821415] ACPI: \_SB_.PCI0.GFX0: failed to evaluate _DSM (0x300b)
[ 1.821419] ACPI Warning: \_SB.PCI0.GFX0._DSM: Argument #4 type 
mismatch - Found [Buffer], ACPI requires [Package] 
(20200925/nsarguments-61)
[ 1.821528] i915 0000:00:02.0: optimus capabilities: enabled, status 
dynamic power,
[ 1.821554] ACPI BIOS Error (bug): AE_AML_PACKAGE_LIMIT, Index 
(0x000000003) is beyond end of object (length 0x0) 
(20200925/exoparg2-393)
[ 1.821560] ACPI Error: Aborting method \_SB.PCI0.GFX0._DSM due to 
previous error (AE_AML_PACKAGE_LIMIT) (20200925/psparse-529)
[ 1.821565] ACPI Error: Aborting method \_SB.PCI0.PEG0.PEGP._DSM due to 
previous error (AE_AML_PACKAGE_LIMIT) (20200925/psparse-529)
[ 1.821572] ACPI: \_SB_.PCI0.PEG0.PEGP: failed to evaluate _DSM (0x300b)
[ 1.821574] ACPI Warning: \_SB.PCI0.PEG0.PEGP._DSM: Argument #4 type 
mismatch - Found [Buffer], ACPI requires [Package] 
(20200925/nsarguments-61)
[ 1.821683] pci 0000:01:00.0: optimus capabilities: enabled, status 
dynamic power,
[ 1.821685] VGA switcheroo: detected Optimus DSM method 
\_SB_.PCI0.PEG0.PEGP handle
[ 1.821920] nouveau 0000:01:00.0: NVIDIA GK107 (0e71f0a2)
[ 1.830781] nouveau 0000:01:00.0: bios: version 80.07.95.00.07
[ 1.894392] nouveau 0000:01:00.0: fb: 2048 MiB DDR3
[ 1.896669] [drm] Initialized i915 1.6.0 20200917 for 0000:00:02.0 on 
minor 0
[ 1.896862] ACPI: Video Device [PEGP] (multi-head: yes rom: yes post: 
no)
[ 1.897361] input: Video Bus as 
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:02/LNXVIDEO:00/input/input12
[ 1.897974] ACPI: Video Device [GFX0] (multi-head: yes rom: no post: no)
[ 1.898219] nouveau 0000:01:00.0: bus: MMIO write of 0000001f FAULT at 
6013d4 [ IBUS ]
[ 1.900114] input: Video Bus as 
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:01/input/input13
[ 1.969353] vga_switcheroo: enabled
[ 1.969407] [TTM] Zone kernel: Available graphics memory: 3791596 KiB
[ 1.969408] [TTM] Zone dma32: Available graphics memory: 2097152 KiB
[ 1.969409] [TTM] Initializing pool allocator
[ 1.969416] [TTM] Initializing DMA pool allocator
[ 1.969431] nouveau 0000:01:00.0: DRM: VRAM: 2048 MiB
[ 1.969432] nouveau 0000:01:00.0: DRM: GART: 1048576 MiB
[ 1.969436] nouveau 0000:01:00.0: DRM: Pointer to TMDS table not found
[ 1.969438] nouveau 0000:01:00.0: DRM: DCB version 4.0
[ 1.971139] nouveau 0000:01:00.0: DRM: MM: using COPY for buffer copies
[ 1.971485] [drm] Initialized nouveau 1.3.1 20120801 for 0000:01:00.0 
on minor 1

[ ... ]

[ 4.594245] snd_hda_intel 0000:00:1b.0: bound 0000:00:02.0 (ops 
i915_audio_component_bind_ops [i915])
[ 4.594380] snd_hda_intel 0000:01:00.1: can't change power state from 
D3cold to D0 (config space inaccessible)
[ 4.594410] snd_hda_intel 0000:01:00.1: can't change power state from 
D3cold to D0 (config space inaccessible)
[ 4.594486] snd_hda_intel 0000:01:00.1: Disabling MSI
[ 4.594494] snd_hda_intel 0000:01:00.1: Handle vga_switcheroo audio 
client
[ 4.594526] snd_hda_intel 0000:01:00.1: number of I/O streams is 30, 
forcing separate stream tags

[ ... ]

[ 4.696732] hdaudio hdaudioC1D0: no AFG or MFG node found
[ 4.696745] hdaudio hdaudioC1D1: no AFG or MFG node found
[ 4.696752] hdaudio hdaudioC1D2: no AFG or MFG node found
[ 4.696759] hdaudio hdaudioC1D3: no AFG or MFG node found
[ 4.696765] hdaudio hdaudioC1D4: no AFG or MFG node found
[ 4.696771] hdaudio hdaudioC1D5: no AFG or MFG node found
[ 4.696778] hdaudio hdaudioC1D6: no AFG or MFG node found
[ 4.696785] hdaudio hdaudioC1D7: no AFG or MFG node found
[ 4.696787] snd_hda_intel 0000:01:00.1: no codecs initialized

Cheers,
-Paul


Le mer., déc. 16 2020 at 20:47:24 +0800, Kai-Heng Feng 
<kai.heng.feng@canonical.com> a écrit :
> Similar to commit 9479e75fca37 ("ALSA: hda: Keep the controller
> initialization even if no codecs found"), when codec probe fails, it
> doesn't enable runtime suspend, and can prevent graphics card from
> getting powered down:
> [    4.280991] snd_hda_intel 0000:01:00.1: no codecs initialized
> 
> $ cat /sys/bus/pci/devices/0000:01:00.1/power/runtime_status
> active
> 
> So mark there's no codec and continue probing to let runtime PM to 
> work.
> 
> BugLink: https://bugs.launchpad.net/bugs/1907212
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  sound/pci/hda/hda_intel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index 6852668f1bcb..872a703dee43 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -2328,7 +2328,7 @@ static int azx_probe_continue(struct azx *chip)
>  	if (bus->codec_mask) {
>  		err = azx_probe_codecs(chip, azx_max_codecs[chip->driver_type]);
>  		if (err < 0)
> -			goto out_free;
> +			bus->codec_mask = 0;
>  	}
> 
>  #ifdef CONFIG_SND_HDA_PATCH_LOADER


