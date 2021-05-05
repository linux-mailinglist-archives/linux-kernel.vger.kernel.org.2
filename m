Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8AC3748B1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 21:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbhEET1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 15:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhEET1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 15:27:07 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AB0C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 12:26:10 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id l2so3045595wrm.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 12:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=XEwMNNDXi/KppCW3JytfH+jQjQHZOFhwz7ZznyF4Arc=;
        b=vGExAaoe+7u+OuPu2eMXTvSntYE8g1OveBoRD+8uEam2cM5Chntd8SkyQKc6as6w06
         ngwka3iFcfvWmFc1d3ToKR0RUkAI/sIeUXOxz8fAphJvGlxFbKdheGH6YwIB31lZkb5P
         c9WiP73Qi9mnGl8V30NHkrNnfFZanCRUqfwdkPuzQKX+8gBgHftyne09t2O9dvAdZwxm
         7FPB2zIF+z7CfOiH8UrtO0tKHNsSBlyqEAjdOkgpMitO/WbjkqwMsjgGrDj3licJV+ih
         5eP3A53jQQgLipHlu6u+FpRPEr3cqMuU4qL7Fsn1GHerp/XJExYbWqiHqZr2oMqRR2OQ
         0iGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XEwMNNDXi/KppCW3JytfH+jQjQHZOFhwz7ZznyF4Arc=;
        b=nzRP35vEWYbp8RFuAaJANV590/Jvx6bKrRHcKmY69jTGAqwCKgfF6731nBZ/4l3/OS
         FMxxJ9WRSaTy+2Z/S8fEPdc7iyuDMRb59krprlqYiwqoth+/FKjlmI+uhOHhaYb8QarQ
         KyOoPPuCk2kmDHByMZ2n1yBc1+R6R4gtnOKOpNJ+InvIEDsO+lDefshYOEXNOeaKhhGV
         bJ+3w1KAHdH0/+1Wy6x2NZ+2O4WqMuWLSnvK8zkATLutYvsDH/a58Rd6NwbPZ+hElL6a
         y1VAtkPxn21ecpXkeDIWM5RGsdyziybXcgYhLsZlxukOd65rSHC+VOMmeQsI6uS82g/T
         72tg==
X-Gm-Message-State: AOAM530NSa+F11CUfyD6JfZ5IHaXW/jgSs/RpooDSR4CQIMBaPSCpEg6
        Cefl4FpGxmlDj/EmFYbmr/U=
X-Google-Smtp-Source: ABdhPJywR4NPXpIQk+Z5hW5jQREghxzG3rQOGoqP1zPusKZZU6JelP0j7h6OhQ3KMEAbft9JMad/FA==
X-Received: by 2002:a5d:51ce:: with SMTP id n14mr643249wrv.239.1620242769104;
        Wed, 05 May 2021 12:26:09 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id x8sm295714wru.70.2021.05.05.12.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 12:26:08 -0700 (PDT)
Date:   Wed, 5 May 2021 21:26:06 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: gemini: sl3516: Mainlining of NS 2502
Message-ID: <YJLxTgVflotKs5Oe@Red>
References: <YGtZeofmBv7hXK+a@Red>
 <CACRpkdZ_barDrLvD2UBKo+GA-F+g72uMQx8CfRK2YLRodpeyUA@mail.gmail.com>
 <YGxOf8pKN8Ip/kCl@Red>
 <CACRpkdYRUXJY_tXamS0vc+RNPDxR2oxdRLbBUk0fmQLp+eYAOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdYRUXJY_tXamS0vc+RNPDxR2oxdRLbBUk0fmQLp+eYAOA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Wed, Apr 07, 2021 at 11:34:29AM +0200, Linus Walleij a écrit :
> On Tue, Apr 6, 2021 at 2:05 PM Corentin Labbe <clabbe.montjoie@gmail.com> wrote:
> 
> > You could find photos at http://kernel.montjoie.ovh/gemini/
> > There are also photos of another SL3516 SoC based device (a SSI 1328 NAS), but I fail to setup a serial on it, so I keep it for later.
> 
> > > For USB try this patch:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git/commit/?h=gemini-usb&id=cbaf6cdf770b90de5f10bfa5112c679f1dffe948
> > >
> >
> > One of the USB port is now working.
> 
> Hey nice! :D
> 
> The USB patch is not very widely tested, so it may need some shaping
> up.
> 

Hello

It seems that USB is still a bit buggy, device are detected only if plugged before boot.

I hit a problem on the NS2502, sata drives does not work well:
gemini_sata_bridge 46000000.sata: SATA ID 00000e00, PHY ID: 01000100
gemini_sata_bridge 46000000.sata: set up the Gemini IDE/SATA nexus
pata_ftide010 63000000.ide: set up Gemini PATA0
pata_ftide010 63000000.ide: device ID 00000500, irq 27, reg [mem 0x63000000-0x63000fff]
pata_ftide010 63000000.ide: SATA0 (master) start
gemini_sata_bridge 46000000.sata: SATA0 PHY ready
pata_ftide010 63000000.ide: brought 1 bridges online
scsi host0: pata_ftide010
ata1: SATA max UDMA/133 irq 27
libphy: Fixed MDIO Bus: probed
libphy: GPIO Bitbanged MDIO: probed
ata1.00: qc timeout (cmd 0x27)
ata1.00: failed to read native max address (err_mask=0x4)
ata1.00: HPA support seems broken, skipping HPA handling
ata1.00: ATA-8: WDC WD10EAVS-00D7B1, 01.01A01, max UDMA/133
ata1.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 0/32)
scsi 0:0:0:0: Direct-Access     ATA      WDC WD10EAVS-00D 1A01 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 1953525168 512-byte logical blocks: (1.00 TB/932 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1
sd 0:0:0:0: [sda] Attached SCSI disk
tun: Universal TUN/TAP device driver, 1.6
gmac-gemini 60000000.ethernet: Ethernet device ID: 0x000, revision 0x1
gemini-ethernet-port 60008000.ethernet-port: probe 60008000.ethernet-port ID 0
gemini-ethernet-port 60008000.ethernet-port: Old MAC from hw 0x000000000000000000000000
gemini-ethernet-port 60008000.ethernet-port: HW ADDR FROM OF 00:1f:1f:8e:65:e2
gemini-ethernet-port 60008000.ethernet-port (unnamed net_device) (uninitialized): RGMII: set GMAC0 and GMAC1 to MII/RGMII mode
RTL8211B Gigabit Ethernet gpio-0:01: attached PHY driver (mii_bus:phy_addr=gpio-0:01, irq=POLL)
gemini-ethernet-port 60008000.ethernet-port eth0: irq 31, DMA @ 0x0x60008000, GMAC @ 0x0x6000a000
gemini-ethernet-port 6000c000.ethernet-port: probe 6000c000.ethernet-port ID 1
gemini-ethernet-port 6000c000.ethernet-port: ethernet address 0x000000000000000000000000 invalid
gemini-ethernet-port 6000c000.ethernet-port: using a random ethernet address
gemini-ethernet-port 6000c000.ethernet-port (unnamed net_device) (uninitialized): PHY init failed
rtc-ftrtc010 45000000.rtc: registered as rtc0
rtc-ftrtc010 45000000.rtc: setting system clock to 2021-05-05T18:49:18 UTC (1620240558)
gemini-poweroff 4b000000.power-controller: other power management IRQ
gemini-poweroff 4b000000.power-controller: Gemini poweroff driver registered
ata1: lost interrupt (Status 0x58)
ata1: lost interrupt (Status 0x58)
ftwdt010-wdt 41000000.watchdog: FTWDT010 watchdog driver enabled
device-mapper: ioctl: 4.45.0-ioctl (2021-03-22) initialised: dm-devel@redhat.com
sl3516-crypto 62000000.crypto: will run requests pump with realtime priority
sl3516-crypto 62000000.crypto: DEBUG: Register ecb(aes)
sl3516-crypto 62000000.crypto: Fallback for ecb-aes-sl3516 is ecb(aes-generic)
sl3516-crypto 62000000.crypto: SL3516 dev a00 rev 0
random: crng init done
sl3516-crypto 62000000.crypto: SL3516 DMA dev 0 rev 1
NET: Registered protocol family 17
Freeing unused kernel memory: 5320K
Kernel memory protection not selected by kernel config.
Run /init as init process

[...]
# crypsetup stuff
[...]
# mount /dev/mapper/backup /mnt/
ata1: lost interrupt (Status 0x50)
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.00: failed command: WRITE DMA
ata1.00: cmd ca/00:08:00:18:00/00:00:00:00:00/e0 tag 0 dma 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
ata1: soft resetting link
ata1.00: configured for UDMA/133
ata1.00: device reported invalid CHS sector 0
ata1: EH complete
ata1: lost interrupt (Status 0x50)
ata1.00: limiting speed to UDMA/100:PIO4
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.00: failed command: WRITE DMA
ata1.00: cmd ca/00:08:00:18:00/00:00:00:00:00/e0 tag 0 dma 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
ata1: soft resetting link
ata1.00: configured for UDMA/100
ata1.00: device reported invalid CHS sector 0
ata1: EH complete
ata1: lost interrupt (Status 0x50)
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.00: failed command: WRITE DMA
ata1.00: cmd ca/00:08:00:18:00/00:00:00:00:00/e0 tag 0 dma 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
ata1: soft resetting link
ata1.00: configured for UDMA/100
ata1.00: device reported invalid CHS sector 0
ata1: EH complete
ata1: lost interrupt (Status 0x50)
ata1.00: limiting speed to UDMA/33:PIO4
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.00: failed command: WRITE DMA
ata1.00: cmd ca/00:08:00:18:00/00:00:00:00:00/e0 tag 0 dma 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
ata1: soft resetting link
ata1.00: configured for UDMA/33
ata1.00: device reported invalid CHS sector 0
ata1: EH complete
ata1: lost interrupt (Status 0x50)
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.00: failed command: WRITE DMA
ata1.00: cmd ca/00:08:00:18:00/00:00:00:00:00/e0 tag 0 dma 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
ata1: soft resetting link
ata1.00: configured for UDMA/33
ata1.00: device reported invalid CHS sector 0
ata1: EH complete
ata1: lost interrupt (Status 0x50)
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.00: failed command: WRITE DMA
ata1.00: cmd ca/00:08:00:18:00/00:00:00:00:00/e0 tag 0 dma 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
ata1: soft resetting link
ata1.00: configured for UDMA/33
ata1.00: device reported invalid CHS sector 0
sd 0:0:0:0: [sda] tag#0 UNKNOWN(0x2003) Result: hostbyte=0x00 driverbyte=0x08 cmd_age=188s
sd 0:0:0:0: [sda] tag#0 Sense Key : 0x5 [current] 
sd 0:0:0:0: [sda] tag#0 ASC=0x21 ASCQ=0x4 
sd 0:0:0:0: [sda] tag#0 CDB: opcode=0x2a 2a 00 00 00 18 00 00 00 08 00
blk_update_request: I/O error, dev sda, sector 6144 op 0x1:(WRITE) flags 0x800 phys_seg 1 prio class 0
blk_update_request: I/O error, dev sda, sector 6144 op 0x1:(WRITE) flags 0x800 phys_seg 1 prio class 0
Buffer I/O error on dev dm-0, logical block 0, lost sync page write
EXT4-fs (dm-0): I/O error while writing superblock
ata1: EH complete
EXT4-fs (dm-0): mount failed

It seems a problem soon after driver probe (qc timeout and HPA error).
Any idea ?

The SATA works well on my other board (SSI1328)
having one or two disk does not change the behavour.
