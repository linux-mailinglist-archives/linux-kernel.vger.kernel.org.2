Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E01083B1D51
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 17:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhFWPOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 11:14:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:38142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230061AbhFWPOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 11:14:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 66965601FF;
        Wed, 23 Jun 2021 15:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624461145;
        bh=2BXvozL35GZ2CwrGnA16lbsGHp087RB1g1dC5lovYoo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SBxsEvU3I4FbVb1pf9qT+5J5hV2P/E+e6ZCjQpb2F8OywRoVYXBSDvRktTrlaXbqp
         cVK1FS71jDf3U+RDyFgq974dFfirLM8vbLvMM1J91xvTP85PJ5gzoy6DIknuOmuvMR
         L6UzCJemjmL3LXvsSVfrOMp4JWIhLRnFX6UtYfXc=
Date:   Wed, 23 Jun 2021 17:12:22 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Christian =?iso-8859-1?Q?L=F6hle?= <CLoehle@hyperstone.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>
Subject: Re: [PATCH] kobject: Safe return of kobject_get_path with NULL
Message-ID: <YNNPVumB7LqLLWgW@kroah.com>
References: <CWXP265MB2680094534A5559B0A904B76C4089@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
 <CWXP265MB2680FAA36A50E96193037B4DC4089@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CWXP265MB2680FAA36A50E96193037B4DC4089@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2021 at 02:49:57PM +0000, Christian Löhle wrote:
> This prevents two Oopses I've encountered.
> (Sorry for the older kernel)
> 
> [ 4650.202534] general protection fault: 0000 [#1] PREEMPT SMP
> [ 4650.202554] Modules linked in: serio_raw atkbd libps2 aesni_intel aes_x86_64 crypto_simd glue_helper ahci libahci i8042 fam15h_power hwmon_vid k10temp scsi_mon ftdi_sio usbserial exfat ext4 crc16 mbcache jbd2 fscrypto sg fuse nls_iso8859_1 nls_cp437 vfat fat nfsv3 nfs_acl nfsv4 dns_resolver nfs lockd grace sunrpc fscache e1000e ptp pps_core i915 intel_gtt usbmon button serio ehci_pci ehci_hcd r8169 mii xhci_pci xhci_hcd libcrc32c crc32c_generic crc32c_intel crc32_pclmul radeon i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm drm agpgart ata_piix pata_acpi ata_generic libata uas usb_storage sd_mod scsi_mod isofs loop overlay ip_tables x_tables sch_fq_codel tpm_tis tpm_tis_core tpm lpc_ich ie31200_edac mei_me mei shpchp parport_pc battery fan thermal i2c_i801 intel_rapl_perf
> [ 4650.202746]  intel_cstate ghash_clmulni_intel cryptd crct10dif_pclmul ppdev parport mousedev input_leds iTCO_wdt iTCO_vendor_support kvm irqbypass evdev mac_hid eeepc_wmi asus_wmi sparse_keymap wmi led_class video coretemp intel_powerclamp x86_pkg_temp_thermal intel_rapl cfg80211 rfkill hid_generic usbhid hid usbcore usb_common
> [ 4650.202824] CPU: 0 PID: 20750 Comm: python3 Not tainted 4.13.5-1hyLinux #22

Lots of things have changed since this old kernel version.  Can you see
if this is still needed on Linus's tree?

thanks,

greg k-h
