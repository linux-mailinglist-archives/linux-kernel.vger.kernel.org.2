Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2BA23CCBA1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 01:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbhGRX5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 19:57:33 -0400
Received: from smtpq3.tb.ukmail.iss.as9143.net ([212.54.57.98]:57892 "EHLO
        smtpq3.tb.ukmail.iss.as9143.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232582AbhGRX5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 19:57:32 -0400
X-Greylist: delayed 1027 seconds by postgrey-1.27 at vger.kernel.org; Sun, 18 Jul 2021 19:57:32 EDT
Received: from [212.54.57.96] (helo=smtpq1.tb.ukmail.iss.as9143.net)
        by smtpq3.tb.ukmail.iss.as9143.net with esmtp (Exim 4.86_2)
        (envelope-from <sboyce@blueyonder.co.uk>)
        id 1m5GLe-0002w0-U6
        for linux-kernel@vger.kernel.org; Mon, 19 Jul 2021 01:37:26 +0200
Received: from [212.54.57.112] (helo=csmtp8.tb.ukmail.iss.as9143.net)
        by smtpq1.tb.ukmail.iss.as9143.net with esmtp (Exim 4.86_2)
        (envelope-from <sboyce@blueyonder.co.uk>)
        id 1m5GLd-0002Kk-HG
        for linux-kernel@vger.kernel.org; Mon, 19 Jul 2021 01:37:25 +0200
Received: from [192.168.10.232] ([82.40.7.93])
        by cmsmtp with ESMTPA
        id 5GLdm3eezWWOW5GLdmcJt2; Mon, 19 Jul 2021 01:37:25 +0200
X-Originating-IP: [82.40.7.93]
X-Authenticated-Sender: sboyce@blueyonder.co.uk
X-Spam: 0
X-Authority: v=2.4 cv=H5m4f8Ui c=1 sm=1 tr=0 ts=60f4bb35 cx=a_exe
 a=0t5s/6s+ZVRG1rmEzJFcZA==:117 a=0t5s/6s+ZVRG1rmEzJFcZA==:17
 a=IkcTkHD0fZMA:10 a=e_q4qTt1xDgA:10 a=x7bEGLp0ZPQA:10
 a=SstKv4r0OY_JQFghaUIA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=blueyonder.co.uk;
        s=meg.feb2017; t=1626651445;
        bh=eA5aDldhj+zSz6CDPMvBnyYZ6RdIdEFW8z1ejEv9jVo=;
        h=Reply-To:To:From:Subject:Date;
        b=Nvm5DqzlsYIGCyydk2Mzp+ANry6mM1hLSVa8BQY8WPA94sOVvb0r6K7ealZXygN2B
         28FatgRHEUeNi+CGFYwb0IELMBulwybsg8ypeYlE34WwkgK8P1Fwu83qeqDxRwZnYr
         kNhA9800B4q/M79L+sTH21WSBom4kB85g9WK2UANOf4vWe5YfTo4Lo14AjaY+++7Lq
         +UNKC/6eHP6ldPPeIPdGuP/H/1Syx4IcLz8ms5wKJsoLfeTbhlBlwJ/lJxuhvfRa4o
         bB361a2RnXsiVJ74MxTiLJnGqmE0a+FijpC2LoC1JH6NfV8ahesHrMwrbJmlzyeFGi
         UiFWT1CVzuGKg==
Reply-To: sboyce@blueyonder.co.uk
To:     LKML Mailing List <linux-kernel@vger.kernel.org>
From:   Sid Boyce <sboyce@blueyonder.co.uk>
Subject: nouveau failure 5.14-rc1 and -rc2
Organization: blueyonder.co.uk
Message-ID: <dbad0e98-ba13-6f0c-e0f5-6881410d03df@blueyonder.co.uk>
Date:   Mon, 19 Jul 2021 00:37:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-CMAE-Envelope: MS4xfN2JcNYLYoR10R9FO08VUWp7HWzIW5WEpUrUyf/tiO8ASzBotpaQkVReUMIAU0zRq2qu3jRefMSaZy7T87+tvARxPKIb5olJUNYCkMb8WNDeQnSBSMOv
 0aXzud82PbhFFohhpUUg2eoLBhteQnjjgpF9ZyFmA5EVFmby7wst8v7Ez33atPQVdEq5uQUZfbFqKCtCsZyHnlSuFSTWDMpCQQg=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I saw an earlier patch (week 8 - 15 July) that so far hasn't made it 
into 5.14-rc.

GPU's are GeForce GTX 1650, and 2 with GeForce GTX 1050 Ti.

3 systems affected, nothing displayed during boot up. I use ssh from a 
running system to look at dmesg output.

[Mon Jul 19 00:02:06 2021] hid-generic 0003:0CCD:0028.0004: 
input,hidraw3: USB HID v1.00 Device [USB Audio] on usb-0000:05:00.3-4/input3
[Mon Jul 19 00:02:06 2021] usb 5-6: new full-speed USB device number 4 
using xhci_hcd
[Mon Jul 19 00:02:06 2021] usb 5-6: config 1 has an invalid interface 
number: 2 but max is 1
[Mon Jul 19 00:02:06 2021] usb 5-6: config 1 has no interface number 1
[Mon Jul 19 00:02:06 2021] usb 5-6: New USB device found, idVendor=0b05, 
idProduct=18f3, bcdDevice= 1.00
[Mon Jul 19 00:02:06 2021] usb 5-6: New USB device strings: Mfr=1, 
Product=2, SerialNumber=3
[Mon Jul 19 00:02:06 2021] usb 5-6: Product: AURA LED Controller
[Mon Jul 19 00:02:06 2021] usb 5-6: Manufacturer: AsusTek Computer Inc.
[Mon Jul 19 00:02:06 2021] usb 5-6: SerialNumber: 9876543210
[Mon Jul 19 00:02:06 2021] hid-generic 0003:0B05:18F3.0005: 
hiddev96,hidraw4: USB HID v1.11 Device [AsusTek Computer Inc. AURA LED 
Controller] on usb-0000:05:00.3-6/input2
[Mon Jul 19 00:02:07 2021] nouveau 0000:08:00.0: DRM: VRAM: 4096 MiB
[Mon Jul 19 00:02:07 2021] nouveau 0000:08:00.0: DRM: GART: 1048576 MiB
[Mon Jul 19 00:02:07 2021] nouveau 0000:08:00.0: DRM: TMDS table version 2.0
[Mon Jul 19 00:02:07 2021] nouveau 0000:08:00.0: DRM: DCB version 4.0
[Mon Jul 19 00:02:07 2021] nouveau 0000:08:00.0: DRM: DCB outp 00: 
02000300 00000000
[Mon Jul 19 00:02:07 2021] nouveau 0000:08:00.0: DRM: DCB outp 01: 
01000302 00020030
[Mon Jul 19 00:02:07 2021] nouveau 0000:08:00.0: DRM: DCB outp 02: 
04011380 00000000
[Mon Jul 19 00:02:07 2021] nouveau 0000:08:00.0: DRM: DCB outp 03: 
08011382 00020030
[Mon Jul 19 00:02:07 2021] nouveau 0000:08:00.0: DRM: DCB outp 04: 
02022362 00020010
[Mon Jul 19 00:02:07 2021] nouveau 0000:08:00.0: DRM: DCB conn 00: 00001030
[Mon Jul 19 00:02:07 2021] nouveau 0000:08:00.0: DRM: DCB conn 01: 00000100
[Mon Jul 19 00:02:07 2021] nouveau 0000:08:00.0: DRM: DCB conn 02: 00002261
[Mon Jul 19 00:02:07 2021] nouveau 0000:08:00.0: DRM: failed to 
initialise sync subsystem, -28
[Mon Jul 19 00:02:07 2021] nouveau 0000:08:00.0: bus: MMIO write of 
00000002 FAULT at 13c154 [ PRIVRING ]
[Mon Jul 19 00:02:07 2021] nouveau: probe of 0000:08:00.0 failed with 
error -28
[Mon Jul 19 00:02:08 2021] EXT4-fs (sda2): mounted filesystem with 
ordered data mode. Opts: (null). Quota mode: none.
[Mon Jul 19 00:02:08 2021] systemd-journald[286]: Received SIGTERM from 
PID 1 (systemd).
[Mon Jul 19 00:02:09 2021] systemd[1]: systemd 248.3+suse.30.ge9a23d9e06 
running in system mode. (+PAM +AUDIT +SELINUX +APPARMOR -IMA -SMACK 
+SECCOMP +GCRYPT +GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 
+IDN2 -IDN -IPTC +KMOD +LIBCRYPTSETUP +LIBFDISK +PCRE2 +PWQUALITY 
+P11KIT +QRENCODE +BZIP2 +LZ4 +XZ +ZLIB +ZSTD -XKBCOMMON +UTMP +SYSVINIT 
default-hierarchy=unified)
[Mon Jul 19 00:02:09 2021] systemd[1]: Detected architecture x86-64.
[Mon Jul 19 00:02:21 2021] systemd-sysv-generator[619]: SysV service 
'/etc/init.d/vmware-USBArbitrator' lacks a native systemd unit file. 
Automatically generating a unit file for compatibility. Please update 
package to include a native systemd unit file, in order to make it more 
safe and robust.
[Mon Jul 19 00:02:21 2021] systemd-sysv-generator[619]: SysV service 
'/etc/init.d/webmin' lacks a native systemd unit file. Automatically 
generating a unit file for compatibility. Please update package to 
include a native systemd unit file, in order to make it more safe and 
robust.
[Mon Jul 19 00:02:21 2021] systemd-sysv-generator[619]: SysV service 
'/etc/init.d/vmware' lacks a native systemd unit file. Automatically 
generating a unit file for compatibility. Please update package to 
include a native systemd unit file, in order to make it more safe and 
robust.
[Mon Jul 19 00:02:22 2021] systemd[1]: /etc/systemd/system/tmp.mount: 
symlinks are not allowed for units of this type, rejecting.
[Mon Jul 19 00:02:23 2021] systemd[1]: 
/usr/lib/systemd/system/netdata.service:14: PIDFile= references a path 
below legacy directory /var/run/, updating /var/run/netdata/netdata.pid 
→ /run/netdata/netdata.pid; please update the unit file accordingly.
[Mon Jul 19 00:02:23 2021] systemd[1]: 
/usr/lib/systemd/system/plymouth-start.service:15: Unit configured to 
use KillMode=none. This is unsafe, as it disables systemd's process 
lifecycle management for the service. Please update your service to use 
a safer KillMode=, such as 'mixed' or 'control-group'. Support for 
KillMode=none is deprecated and will eventually be removed.
[Mon Jul 19 00:02:23 2021] systemd[1]: haveged.service: Main process 
exited, code=exited, status=1/FAILURE
[Mon Jul 19 00:02:23 2021] systemd[1]: haveged.service: Failed with 
result 'exit-code'.
[Mon Jul 19 00:02:23 2021] systemd[1]: Stopped Entropy Daemon based on 
the HAVEGE algorithm.
[Mon Jul 19 00:02:23 2021] systemd[1]: initrd-switch-root.service: 
Deactivated successfully.
[Mon Jul 19 00:02:23 2021] systemd[1]: Stopped Switch Root.
[Mon Jul 19 00:02:23 2021] systemd[1]: systemd-journald.service: 
Scheduled restart job, restart counter is at 1.
[Mon Jul 19 00:02:23 2021] systemd[1]: Created slice system-getty.slice.
[Mon Jul 19 00:02:23 2021] systemd[1]: Created slice system-modprobe.slice.
[Mon Jul 19 00:02:23 2021] systemd[1]: Created slice User and Session Slice.
[Mon Jul 19 00:02:23 2021] systemd[1]: Set up automount Arbitrary 
Executable File Formats File System Automount Point.

Regards

Sid.

-- 
Sid Boyce ... Hamradio License G3VBV, Licensed Private Pilot
Emeritus IBM/Amdahl Mainframes and Sun/Fujitsu Servers Tech Support
Senior Staff Specialist, Cricket Coach
Microsoft Windows Free Zone - Linux used for all Computing Tasks

