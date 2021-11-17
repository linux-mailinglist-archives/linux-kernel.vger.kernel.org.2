Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60686454C77
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 18:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239649AbhKQRvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 12:51:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238352AbhKQRvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 12:51:32 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A86C061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 09:48:32 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id k37so12472033lfv.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 09:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UhCDVJPwIOznU2Q9SLszzqZyzNcrsLiL9kVBidZ8GDM=;
        b=6oppf1N/Yi3Um5K6N5/Gvgzfv3yIKv79bYt9u6Y0BJyVoy97UWCHESLHf0yenOqs6G
         BILKpojT5XFHtJHASdEjjxwjiV5U+kTk4rHSOHWDcSM6jeGF4+xPXz2f442dF7mwpBvd
         y3GPz/kvRXiBK8leq/SswpfNBSo7v15NBEEKheT8XpezSyHO4uB1f4g0VJlY1pkqXZiw
         4xFx6gdDihNOyJffo7Z6Ed8/AqqK/4PEC/ky+zd/huOXcF5aC2fmdmkyuF7UN3cxQejM
         ArT4kG9nsqw470gn24HCpIBHXHZCsjz47C2bPod87C3IcwG72F1oMtGFdpLcqJ6JGnVT
         WalA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UhCDVJPwIOznU2Q9SLszzqZyzNcrsLiL9kVBidZ8GDM=;
        b=QXgaNBtOlRN4eqdUxgDxkgvvh6CKLqU3ucgoX3oYoVTo9Oj2joumw3mQAOpnp7dEl+
         NaHJFIlaTwOht+HuIwxu04dk+Z+4H3VrizbNVBSeoyELLWwPomRYyqFi1QbZDMA/XeUq
         WBX2UsIFjyHxNeumJncQE5/o/5gixCDooEoI+cvcoVEMM1PiO6gqxURkQohw0dM2a6aQ
         H1zssMyOqO7pRiubcsyogJBRNfAlaZ0ROFQ82bXHgj1Kvn6QaEcB6FHBuuP8Zx0bT2E+
         d364lPBDb7RkKSBwMMbI6B1I/E107i33NgMv6sKksxFJ/JhXS/F1NxEstc+OP6EFAPKl
         R96w==
X-Gm-Message-State: AOAM530AU9PY6+6w58BMJHrYdaDjqWls3NulciRipq0c3BPJmGW60xjI
        7LjfBRrUYGnHodx1Yz9vK/q6D2saREHJKpjN
X-Google-Smtp-Source: ABdhPJzjO2AiliQrwEiWj5VDNcEeIpx4h0PD5enUngVK12zaV1D5EChFlDiibZxrJOF28hWmS4y7Tg==
X-Received: by 2002:a19:f10a:: with SMTP id p10mr16598677lfh.487.1637171311185;
        Wed, 17 Nov 2021 09:48:31 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id x12sm43444lfa.243.2021.11.17.09.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 09:48:30 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id C16CE103139; Wed, 17 Nov 2021 20:48:26 +0300 (+03)
Date:   Wed, 17 Nov 2021 20:48:26 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] sound updates for 5.16-rc1
Message-ID: <20211117174826.23eakoivl33tawb2@box.shutemov.name>
References: <s5hwnlpmt9x.wl-tiwai@suse.de>
 <20211117161855.m45mxcqszkfcetai@box.shutemov.name>
 <s5hmtm2lphf.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="unbtckrxrxtuxppn"
Content-Disposition: inline
In-Reply-To: <s5hmtm2lphf.wl-tiwai@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--unbtckrxrxtuxppn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 17, 2021 at 05:24:28PM +0100, Takashi Iwai wrote:
> On Wed, 17 Nov 2021 17:18:55 +0100,
> Kirill A. Shutemov wrote:
> > 
> > On Wed, Nov 03, 2021 at 11:24:10AM +0100, Takashi Iwai wrote:
> > > Linus,
> > > 
> > > please pull sound updates for v5.16-rc1 from:
> > > 
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.16-rc1
> > > 
> > > The topmost commit is df0380b9539b04c1ae8854a984098da06d5f1e67
> > > 
> > > ----------------------------------------------------------------
> > > 
> > > sound updates for 5.16-rc1
> > > 
> > > Lots of code development have been see in ASoC side as usual, while
> > > the continued development on memalloc helper and USB-audio low-
> > > latency support are found in the rest.  Note that a few changes in the
> > > unusual places like arch/sh are included, which are a part of ASoC DAI
> > > format cleanups.
> > > 
> > > ALSA core:
> > > - Continued memallloc helper updates and cleanups, now supporting
> > >   non-coherent and non-contiguous pages
> > > - Fixes for races in mixer OSS layer
> > > 
> > > ASoC:
> > > - A new version of the audio graph card which supports a wider range
> > >   of systems
> > > - Several conversions to YAML DT bindings
> > > - Continuing cleanups to the SOF and Intel code
> > > - Move of the Cirrus DSP framework into drivers/firmware to allow for
> > >   future use by non-audio DSPs
> > > - An overhaul of the cs42l42 driver, correcting many problems
> > > - DAI format terminology conversions over many drivers for cleanups
> > > - Support for AMD Vangogh and Yelow Cap, Cirrus CS35L41, Maxim
> > >   MAX98520 and MAX98360A, Mediatek MT8195, Nuvoton NAU8821, nVidia
> > >   Tegra210, NXP i.MX8ULP, Qualcomm AudioReach, Realtek ALC5682I-VS,
> > >   RT5682S, and RT9120 and Rockchip RV1126 and RK3568
> > > 
> > > USB-audio:
> > > - Continued improvements on low-latency playback
> > > - Quirks for Pioneer devices, Line6 HX-Stomp XL, Audient iD14
> > > 
> > > HD-audio:
> > > - Reduce excessive udelay() calls on Intel platforms; this should
> > >   reduce the CPU load with PulseAudio
> > > - Quirks for HP and Clevo laptops
> > > 
> > > FireWire:
> > > - Support for meter information on MOTU
> > > 
> > 
> > ...
> > 
> > > Takashi Iwai (29):
> > >       ALSA: hda: Reduce udelay() at SKL+ position reporting
> > >       ALSA: hda: Use position buffer for SKL+ again
> > >       ALSA: usb-audio: Restrict rates for the shared clocks
> > >       ALSA: usb-audio: Fix possible race at sync of urb completions
> > >       ALSA: usb-audio: Rename early_playback_start flag with lowlatency_playback
> > >       ALSA: usb-audio: Disable low-latency playback for free-wheel mode
> > >       ALSA: usb-audio: Disable low-latency mode for implicit feedback sync
> > >       ALSA: usb-audio: Check available frames for the next packet size
> > >       ALSA: usb-audio: Add spinlock to stop_urbs()
> > >       ALSA: usb-audio: Improved lowlatency playback support
> > 
> > This commit breaks audio playback for me. The sample plays for fraction of
> > a second than stops.
> > 
> > I use SMSL SA300. Let me know what ifo is needed to track it down.
> > 
> > Also I can test potential fixups if needed.
> 
> Could you give alsa-info.sh output with the device?  Run the script
> with --no-upload option, and attach the output.

Attached. I run it on kernel without the commit. I hope it is fine.

One note: I use monolitic kernel without CONFIG_MODULES. The script
complained about missing /proc/asound/modules and other modules related
stuff.

> Also /proc/asound/card*/stream* file for that usb device, too,
> please.

Attached.

> And, which environment are you testing, more exactly?  Which platform,
> and with PulseAudio, pipewire, JACK, or direct ALSA device use?

Nothing fancy. Direct ALSA. I tested with 'speaker-test -c2 -t wav' during
bisect.

> For checking the behavior, we'd need to check hw_params in
> /proc/asound/card*/pcm*/sub*/* for the corresponding device during
> playback/capture operations.

You need this to be collected when the problem triggers, right?
I will follow up with this.

-- 
 Kirill A. Shutemov

--unbtckrxrxtuxppn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="alsa-info.txt"

upload=true&script=true&cardinfo=
!!################################
!!ALSA Information Script v 0.5.0
!!################################

!!Script ran on: Wed Nov 17 17:43:16 UTC 2021


!!Linux Distribution
!!------------------

Gentoo Base System release 2.7 NAME=Gentoo ID=gentoo PRETTY_NAME="Gentoo/Linux" HOME_URL="https://www.gentoo.org/" SUPPORT_URL="https://www.gentoo.org/support/" BUG_REPORT_URL="https://bugs.gentoo.org/"


!!DMI Information
!!---------------

Manufacturer:      Gigabyte Technology Co., Ltd.
Product Name:      X299 AORUS Gaming 3 Pro
Product Version:   Default string
Firmware Version:  F5d
System SKU:        Default string
Board Vendor:      Gigabyte Technology Co., Ltd.
Board Name:        X299 AORUS Gaming 3 Pro-CF


!!ACPI Device Status Information
!!---------------

/sys/bus/acpi/devices/ACPI0004:00/status 	 15
/sys/bus/acpi/devices/INT340E:00/status 	 15
/sys/bus/acpi/devices/LNXCPU:00/status 	 15
/sys/bus/acpi/devices/LNXCPU:01/status 	 15
/sys/bus/acpi/devices/LNXCPU:02/status 	 15
/sys/bus/acpi/devices/LNXCPU:03/status 	 15
/sys/bus/acpi/devices/LNXCPU:04/status 	 15
/sys/bus/acpi/devices/LNXCPU:05/status 	 15
/sys/bus/acpi/devices/LNXCPU:06/status 	 15
/sys/bus/acpi/devices/LNXCPU:07/status 	 15
/sys/bus/acpi/devices/LNXCPU:08/status 	 15
/sys/bus/acpi/devices/LNXCPU:09/status 	 15
/sys/bus/acpi/devices/LNXCPU:0a/status 	 15
/sys/bus/acpi/devices/LNXCPU:0b/status 	 15
/sys/bus/acpi/devices/LNXCPU:0c/status 	 15
/sys/bus/acpi/devices/LNXCPU:0d/status 	 15
/sys/bus/acpi/devices/LNXCPU:0e/status 	 15
/sys/bus/acpi/devices/LNXCPU:0f/status 	 15
/sys/bus/acpi/devices/LNXCPU:10/status 	 15
/sys/bus/acpi/devices/LNXCPU:11/status 	 15
/sys/bus/acpi/devices/LNXCPU:12/status 	 15
/sys/bus/acpi/devices/LNXCPU:13/status 	 15
/sys/bus/acpi/devices/LNXCPU:14/status 	 15
/sys/bus/acpi/devices/LNXCPU:15/status 	 15
/sys/bus/acpi/devices/LNXCPU:16/status 	 15
/sys/bus/acpi/devices/LNXCPU:17/status 	 15
/sys/bus/acpi/devices/LNXCPU:18/status 	 15
/sys/bus/acpi/devices/LNXCPU:19/status 	 15
/sys/bus/acpi/devices/LNXCPU:1a/status 	 15
/sys/bus/acpi/devices/LNXCPU:1b/status 	 15
/sys/bus/acpi/devices/LNXCPU:1c/status 	 15
/sys/bus/acpi/devices/LNXCPU:1d/status 	 15
/sys/bus/acpi/devices/LNXCPU:1e/status 	 15
/sys/bus/acpi/devices/LNXCPU:1f/status 	 15
/sys/bus/acpi/devices/MSFT0101:00/status 	 15
/sys/bus/acpi/devices/PNP0103:00/status 	 15
/sys/bus/acpi/devices/PNP0A08:01/status 	 15
/sys/bus/acpi/devices/PNP0A08:02/status 	 15
/sys/bus/acpi/devices/PNP0A08:03/status 	 15
/sys/bus/acpi/devices/PNP0C02:02/status 	 3
/sys/bus/acpi/devices/PNP0C02:04/status 	 3
/sys/bus/acpi/devices/PNP0C0C:00/status 	 15
/sys/bus/acpi/devices/PNP0C0E:00/status 	 11
/sys/bus/acpi/devices/PNP0C0F:00/status 	 9
/sys/bus/acpi/devices/PNP0C0F:01/status 	 9
/sys/bus/acpi/devices/PNP0C0F:02/status 	 9
/sys/bus/acpi/devices/PNP0C0F:03/status 	 9
/sys/bus/acpi/devices/PNP0C0F:04/status 	 9
/sys/bus/acpi/devices/PNP0C0F:05/status 	 9
/sys/bus/acpi/devices/PNP0C0F:06/status 	 9
/sys/bus/acpi/devices/PNP0C0F:07/status 	 9
/sys/bus/acpi/devices/PNP0C14:00/status 	 15
/sys/bus/acpi/devices/PNP0C14:03/status 	 11


!!Kernel Information
!!------------------

Kernel release:    5.15.0-rc1-00021-g0ef74366bc15
Operating System:  GNU/Linux
Architecture:      x86_64
Processor:         Intel(R) Core(TM) i9-7960X CPU @ 2.80GHz
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     k5.15.0-rc1-00021-g0ef74366bc15
Library version:    1.2.4
Utilities version:  1.2.4


!!Loaded ALSA modules
!!-------------------



!!Sound Servers on this system
!!----------------------------

No sound servers found.


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [Audio          ]: USB-Audio - TX-384Khz Hifi Type-C Audio
                      Generic TX-384Khz Hifi Type-C Audio at usb-0000:00:14.0-1, high speed


!!PCI Soundcards installed in the system
!!--------------------------------------

00:1f.3 Audio device [0403]: Intel Corporation 200 Series PCH HD Audio [8086:a2f0]
	Subsystem: Gigabyte Technology Co., Ltd 200 Series PCH HD Audio [1458:a182]
65:00.1 Audio device [0403]: NVIDIA Corporation GP104 High Definition Audio Controller [10de:10f0] (rev a1)
	Subsystem: Gigabyte Technology Co., Ltd GP104 High Definition Audio Controller [1458:3730]


!!Loaded sound module options
!!---------------------------


!!Sysfs card info
!!---------------

!!Card: /sys/class/sound/card0
Driver: /sys/bus/usb/drivers/snd-usb-audio
Tree:
	/sys/class/sound/card0
	|-- audio
	|   |-- dev
	|   |-- device -> ../../card0
	|   |-- power
	|   |-- subsystem -> ../../../../../../../../../class/sound
	|   `-- uevent
	|-- controlC0
	|   |-- dev
	|   |-- device -> ../../card0
	|   |-- power
	|   |-- subsystem -> ../../../../../../../../../class/sound
	|   `-- uevent
	|-- device -> ../../../1-1:1.0
	|-- dsp
	|   |-- dev
	|   |-- device -> ../../card0
	|   |-- power
	|   |-- subsystem -> ../../../../../../../../../class/sound
	|   `-- uevent
	|-- id
	|-- mixer
	|   |-- dev
	|   |-- device -> ../../card0
	|   |-- power
	|   |-- subsystem -> ../../../../../../../../../class/sound
	|   `-- uevent
	|-- number
	|-- pcmC0D0p
	|   |-- dev
	|   |-- device -> ../../card0
	|   |-- pcm_class
	|   |-- power
	|   |-- subsystem -> ../../../../../../../../../class/sound
	|   `-- uevent
	|-- power
	|   |-- autosuspend_delay_ms
	|   |-- control
	|   |-- runtime_active_time
	|   |-- runtime_status
	|   `-- runtime_suspended_time
	|-- subsystem -> ../../../../../../../../class/sound
	`-- uevent


!!USB Descriptors
!!---------------
--startcollapse--

Bus 001 Device 002: ID 0bda:4c07 Realtek Semiconductor Corp. TX-384Khz Hifi Type-C Audio
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass          239 Miscellaneous Device
  bDeviceSubClass         2 
  bDeviceProtocol         1 Interface Association
  bMaxPacketSize0        64
  idVendor           0x0bda Realtek Semiconductor Corp.
  idProduct          0x4c07 
  bcdDevice            0.01
  iManufacturer           3 Generic
  iProduct                1 TX-384Khz Hifi Type-C Audio
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x011d
    bNumInterfaces          3
    bConfigurationValue     1
    iConfiguration          4 TX-384Khz Hifi Type-C Audio
    bmAttributes         0xa0
      (Bus Powered)
      Remote Wakeup
    MaxPower              100mA
    Interface Association:
      bLength                 8
      bDescriptorType        11
      bFirstInterface         0
      bInterfaceCount         2
      bFunctionClass          1 Audio
      bFunctionSubClass       0 
      bFunctionProtocol      32 
      iFunction               5 TX-384Khz Hifi Type-C Audio
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      1 Control Device
      bInterfaceProtocol     32 
      iInterface              5 TX-384Khz Hifi Type-C Audio
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      1 (HEADER)
        bcdADC               2.00
        bCategory               4
        wTotalLength       0x0050
        bmControls           0x00
      AudioControl Interface Descriptor:
        bLength                 8
        bDescriptorType        36
        bDescriptorSubtype     10 (CLOCK_SOURCE)
        bClockID                4
        bmAttributes            7 Internal programmable clock (synchronized to SOF)
        bmControls           0x07
          Clock Frequency Control (read/write)
          Clock Validity Control (read-only)
        bAssocTerminal          0
        iClockSource            0 
      AudioControl Interface Descriptor:
        bLength                17
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID            10
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bCSourceID              4
        bNrChannels             2
        bmChannelConfig    0x00000003
          Front Left (FL)
          Front Right (FR)
        iChannelNames           0 
        bmControls         0x0000
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID            16
        wTerminalType      0x0302 Headphones
        bAssocTerminal         10
        bSourceID              22
        bCSourceID              4
        bmControls         0x0000
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                18
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                22
        bSourceID              10
        bmaControls(0)     0x00000003
          Mute Control (read/write)
        bmaControls(1)     0x0000000c
          Volume Control (read/write)
        bmaControls(2)     0x0000000c
          Volume Control (read/write)
        iFeature                0 
      AudioControl Interface Descriptor:
        bLength                16
        bDescriptorType        36
        bDescriptorSubtype      9 (EXTENSION_UNIT)
        bUnitID                25
        wExtensionCode     0x0bda
        bNrInPins               1
        baSourceID(0)          22
        bNrChannels             2
        bmChannelConfig    0x00000003
          Front Left (FL)
          Front Right (FR)
        iChannelNames           0 
        bmControls           0x00
        iExtension              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x87  EP 7 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0010  1x 16 bytes
        bInterval               8
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol     32 
      iInterface              5 TX-384Khz Hifi Type-C Audio
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol     32 
      iInterface              5 TX-384Khz Hifi Type-C Audio
      AudioStreaming Interface Descriptor:
        bLength                16
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink          10
        bmControls           0x00
        bFormatType             1
        bmFormats          0x00000001
          PCM
        bNrChannels             2
        bmChannelConfig    0x00000003
          Front Left (FL)
          Front Right (FR)
        iChannelNames           0 
      AudioStreaming Interface Descriptor:
        bLength                 6
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bSubslotSize            2
        bBitResolution         16
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x04  EP 4 OUT
        bmAttributes            9
          Transfer Type            Isochronous
          Synch Type               Adaptive
          Usage Type               Data
        wMaxPacketSize     0x00f8  1x 248 bytes
        bInterval               1
        AudioStreaming Endpoint Descriptor:
          bLength                 8
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x00
          bmControls           0x00
          bLockDelayUnits         0 Undefined
          wLockDelay         0x0000
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       2
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol     32 
      iInterface              5 TX-384Khz Hifi Type-C Audio
      AudioStreaming Interface Descriptor:
        bLength                16
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink          10
        bmControls           0x00
        bFormatType             1
        bmFormats          0x00000001
          PCM
        bNrChannels             2
        bmChannelConfig    0x00000003
          Front Left (FL)
          Front Right (FR)
        iChannelNames           0 
      AudioStreaming Interface Descriptor:
        bLength                 6
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bSubslotSize            3
        bBitResolution         24
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x04  EP 4 OUT
        bmAttributes            9
          Transfer Type            Isochronous
          Synch Type               Adaptive
          Usage Type               Data
        wMaxPacketSize     0x0174  1x 372 bytes
        bInterval               1
        AudioStreaming Endpoint Descriptor:
          bLength                 8
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x00
          bmControls           0x00
          bLockDelayUnits         0 Undefined
          wLockDelay         0x0000
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       3
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol     32 
      iInterface              5 TX-384Khz Hifi Type-C Audio
      AudioStreaming Interface Descriptor:
        bLength                16
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink          10
        bmControls           0x00
        bFormatType             1
        bmFormats          0x00000001
          PCM
        bNrChannels             2
        bmChannelConfig    0x00000003
          Front Left (FL)
          Front Right (FR)
        iChannelNames           0 
      AudioStreaming Interface Descriptor:
        bLength                 6
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bSubslotSize            4
        bBitResolution         32
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x04  EP 4 OUT
        bmAttributes            9
          Transfer Type            Isochronous
          Synch Type               Adaptive
          Usage Type               Data
        wMaxPacketSize     0x01f0  1x 496 bytes
        bInterval               1
        AudioStreaming Endpoint Descriptor:
          bLength                 8
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x00
          bmControls           0x00
          bLockDelayUnits         0 Undefined
          wLockDelay         0x0000
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Device
      bInterfaceSubClass      0 
      bInterfaceProtocol      0 
      iInterface              0 
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.11
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength      35
         Report Descriptors: 
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x88  EP 8 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0010  1x 16 bytes
        bInterval               4
Device Qualifier (for other device speed):
  bLength                10
  bDescriptorType         6
  bcdUSB               2.00
  bDeviceClass          239 Miscellaneous Device
  bDeviceSubClass         2 
  bDeviceProtocol         1 Interface Association
  bMaxPacketSize0        64
  bNumConfigurations      1
Device Status:     0x0000
  (Bus Powered)
--endcollapse--


!!USB Stream information
!!----------------------
--startcollapse--

Generic TX-384Khz Hifi Type-C Audio at usb-0000:00:14.0-1, high speed : USB Audio

Playback:
  Status: Stop
  Interface 1
    Altset 1
    Format: S16_LE
    Channels: 2
    Endpoint: 0x04 (4 OUT) (ADAPTIVE)
    Rates: 44100, 48000, 96000, 192000, 384000
    Data packet interval: 125 us
    Bits: 16
    Channel map: FL FR
  Interface 1
    Altset 2
    Format: S24_3LE
    Channels: 2
    Endpoint: 0x04 (4 OUT) (ADAPTIVE)
    Rates: 44100, 48000, 96000, 192000, 384000
    Data packet interval: 125 us
    Bits: 24
    Channel map: FL FR
  Interface 1
    Altset 3
    Format: S32_LE
    Channels: 2
    Endpoint: 0x04 (4 OUT) (ADAPTIVE)
    Rates: 44100, 48000, 96000, 192000, 384000
    Data packet interval: 125 us
    Bits: 32
    Channel map: FL FR
--endcollapse--


!!USB Mixer information
!!---------------------
--startcollapse--

USB Mixer: usb_id=0x0bda4c07, ctrlif=0, ctlerr=0
Card: Generic TX-384Khz Hifi Type-C Audio at usb-0000:00:14.0-1, high speed
  Unit: 4
    Control: name="Clock Source 4 Validity", index=0
    Info: id=4, control=2, cmask=0x0, channels=1, type="BOOLEAN"
    Volume: min=0, max=1, dBmin=0, dBmax=0
  Unit: 22
    Control: name="PCM Playback Volume", index=0
    Info: id=22, control=2, cmask=0x3, channels=2, type="S16"
    Volume: min=-16800, max=0, dBmin=-6562, dBmax=0
  Unit: 22
    Control: name="PCM Playback Switch", index=0
    Info: id=22, control=1, cmask=0x0, channels=1, type="INV_BOOLEAN"
    Volume: min=0, max=1, dBmin=0, dBmax=0
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw---- 1 root audio 116,  3 Nov 17 18:59 /dev/snd/controlC0
crw-rw---- 1 root audio 116,  2 Nov 17 19:00 /dev/snd/pcmC0D0p
crw-rw---- 1 root audio 116,  1 Nov 17 18:59 /dev/snd/seq
crw-rw---- 1 root audio 116, 33 Nov 17 18:59 /dev/snd/timer

/dev/snd/by-id:
total 0
drwxr-xr-x 2 root root  60 Nov 17 18:59 .
drwxr-xr-x 4 root root 160 Nov 17 18:59 ..
lrwxrwxrwx 1 root root  12 Nov 17 18:59 usb-Generic_TX-384Khz_Hifi_Type-C_Audio-00 -> ../controlC0

/dev/snd/by-path:
total 0
drwxr-xr-x 2 root root  60 Nov 17 18:59 .
drwxr-xr-x 4 root root 160 Nov 17 18:59 ..
lrwxrwxrwx 1 root root  12 Nov 17 18:59 pci-0000:00:14.0-usb-0:1:1.0 -> ../controlC0


!!Aplay/Arecord output
!!--------------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: Audio [TX-384Khz Hifi Type-C Audio], device 0: USB Audio [USB Audio]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****

!!Amixer output
!!-------------

!!-------Mixer controls for card Audio

Card hw:0 'Audio'/'Generic TX-384Khz Hifi Type-C Audio at usb-0000:00:14.0-1, high speed'
  Mixer name	: 'USB Mixer'
  Components	: 'USB0bda:4c07'
  Controls      : 4
  Simple ctrls  : 1
Simple mixer control 'PCM',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 175
  Mono:
  Front Left: Playback 121 [69%] [-20.25dB] [on]
  Front Right: Playback 121 [69%] [-20.25dB] [on]


!!Alsactl output
!!--------------

--startcollapse--
state.Audio {
	control.1 {
		iface PCM
		name 'Playback Channel Map'
		value.0 0
		value.1 0
		comment {
			access read
			type INTEGER
			count 2
			range '0 - 36'
		}
	}
	control.2 {
		iface MIXER
		name 'PCM Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.3 {
		iface MIXER
		name 'PCM Playback Volume'
		value.0 121
		value.1 121
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 175'
			dbmin -6562
			dbmax 0
			dbvalue.0 -2025
			dbvalue.1 -2025
		}
	}
	control.4 {
		iface CARD
		name 'Clock Source 4 Validity'
		value true
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
}
--endcollapse--


!!All Loaded Modules
!!------------------



!!ALSA/HDA dmesg
!!--------------

[    0.771254] ACPI: Added _OSI(Linux-Dell-Video)
[    0.771262] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.771271] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
--
[    5.299506] usbhid: USB HID core driver
[    5.300421] usbcore: registered new interface driver snd-usb-audio
[    5.301484] IPVS: Registered protocols (TCP, UDP)
--
[    5.396384] pstore: Using crash dump compression: deflate
[    5.398338] ALSA device list:
[    5.399328]   No soundcards found.
[    5.405607] Freeing unused kernel image (initmem) memory: 8868K



--unbtckrxrxtuxppn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=card0-stream0

Generic TX-384Khz Hifi Type-C Audio at usb-0000:00:14.0-1, high speed : USB Audio

Playback:
  Status: Stop
  Interface 1
    Altset 1
    Format: S16_LE
    Channels: 2
    Endpoint: 0x04 (4 OUT) (ADAPTIVE)
    Rates: 44100, 48000, 96000, 192000, 384000
    Data packet interval: 125 us
    Bits: 16
    Channel map: FL FR
  Interface 1
    Altset 2
    Format: S24_3LE
    Channels: 2
    Endpoint: 0x04 (4 OUT) (ADAPTIVE)
    Rates: 44100, 48000, 96000, 192000, 384000
    Data packet interval: 125 us
    Bits: 24
    Channel map: FL FR
  Interface 1
    Altset 3
    Format: S32_LE
    Channels: 2
    Endpoint: 0x04 (4 OUT) (ADAPTIVE)
    Rates: 44100, 48000, 96000, 192000, 384000
    Data packet interval: 125 us
    Bits: 32
    Channel map: FL FR

--unbtckrxrxtuxppn--
