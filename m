Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4727F453EE0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 04:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbhKQDZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 22:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbhKQDZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 22:25:58 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794B7C061570;
        Tue, 16 Nov 2021 19:23:00 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id bf8so3210187oib.6;
        Tue, 16 Nov 2021 19:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=yzCXfvPM/BMluuYB8E8uCiWLd3xZlSImFb3HDkJyyrM=;
        b=GBPXXd/O2CgXHXLCWOAYURbl66v2HqSFNPCMcyp4m+Kf9kyj4CLlZp4cEcrln6xIgn
         g30T4EJkJBEPox0B/nlfhewv3rJVgVI2W7lMgC9ZAGlyRYSWD+ilg0jLnlGwjF/elJcN
         tO71BT85giyNApFipMjAbqND5XTg2asnmLCGkxKMsFwPF6N39zQYxVO8xpzl0gOvFsu+
         6ALFg3gF5tUFaHUig/DMIdG9hHS/nV+pVX7ia9begZdBd31pVdr7jogdS67q8D5hEWGd
         m5nM2wEaWqexgV2u5CUQXNOjrgMfZTtiFEj+CUQ2NtytkPV0E1laEJ0tEOw1Td6erITl
         nufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=yzCXfvPM/BMluuYB8E8uCiWLd3xZlSImFb3HDkJyyrM=;
        b=y6egk4eQAPUFjnZXUndc2OtvzrdkDZL5nDTQ+E5ffTR47E/j9+foFKswPMwnDG1Lgv
         b28jN/Lpu54nbq/y6EkRrzJ35XUXRCA6/glqsfFlphW5UxT8rq5aLSAcOsbN9ok+nX+v
         UFHMQgYUms05tU/EER04LVLHTd9pCLmUDPo9oyolQC4kKZ5cJwln4T3rciIpi5oLNCmu
         UjkkUVeoIbQugQsYKtO+u+wsk3N4dVOeG7+KTqAV9vgddK+4vZXImPwWkRgOazgZszVW
         lfcYKNHvQ61qkY44gnl6BbO5ENukAVWAwBvifP4g02eVlh05MzOFdb8E75LxSGXFSSpb
         HQ0Q==
X-Gm-Message-State: AOAM530iM89qzqA4Y9XfJt/YmHc5/hmCzGkJgydyJtvlrdpLeEm/ipsD
        BzMu36oBoFC7VO6aWMgeaIWgPZcAAQlPtnpGMzvoPZxgN9zJDQ==
X-Google-Smtp-Source: ABdhPJxw/WlBxUZTRFPmy4yUhUapXKQTUXS29SEyPWnz+OJsCUZ5NeXSpvHiHrPXYvmlLyNZxHbicCkV62QW+kZXNAc=
X-Received: by 2002:aca:a989:: with SMTP id s131mr11580159oie.71.1637119379566;
 Tue, 16 Nov 2021 19:22:59 -0800 (PST)
MIME-Version: 1.0
References: <CAHP4M8UvwsS6QpV6PX-qf=d2u9Qw35Hafv-BTMGUWeSc0nUBXA@mail.gmail.com>
In-Reply-To: <CAHP4M8UvwsS6QpV6PX-qf=d2u9Qw35Hafv-BTMGUWeSc0nUBXA@mail.gmail.com>
From:   Ajay Garg <ajaygargnsit@gmail.com>
Date:   Wed, 17 Nov 2021 08:52:47 +0530
Message-ID: <CAHP4M8V4ow_JUj9gjcrZoyFtnTcqngHqiD2da-v-w4VZ2WL1hg@mail.gmail.com>
Subject: Re: Mouse stops working at random intervals in latest kernel
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looping in linux-usb list members.
Pasting the original content again, to avoid top-posting visual headaches :)


Hello everyone,

I have been seeing following errors at random times.
When this happens, the (wireless-)mouse stops working. The USB-dongle
has to be removed, and re-inserted again to get the mouse working
again.

This has not happened before, only observing it since last 2-3 days.
Kernel is mainline at 8ab774587903771821b59471cc723bba6d893942.

Anyone seeing similar issue?


###########################
Nov 16 18:15:19 host-x86-64 kernel: [ 5005.107017] usb 2-1.2: reset
full-speed USB device number 11 using ehci-pci
Nov 16 18:15:19 host-x86-64 kernel: [ 5005.186745] usb 2-1.2: device
descriptor read/64, error -32
Nov 16 18:15:20 host-x86-64 kernel: [ 5005.374638] usb 2-1.2: device
descriptor read/64, error -32
Nov 16 18:15:20 host-x86-64 kernel: [ 5005.562650] usb 2-1.2: reset
full-speed USB device number 11 using ehci-pci
Nov 16 18:15:20 host-x86-64 kernel: [ 5005.642638] usb 2-1.2: device
descriptor read/64, error -32
Nov 16 18:15:20 host-x86-64 kernel: [ 5005.830670] usb 2-1.2: device
descriptor read/64, error -32
Nov 16 18:15:20 host-x86-64 kernel: [ 5006.018544] usb 2-1.2: reset
full-speed USB device number 11 using ehci-pci
Nov 16 18:15:21 host-x86-64 kernel: [ 5006.434527] usb 2-1.2: device
not accepting address 11, error -32
Nov 16 18:15:21 host-x86-64 kernel: [ 5006.514531] usb 2-1.2: reset
full-speed USB device number 11 using ehci-pci
Nov 16 18:15:21 host-x86-64 kernel: [ 5006.930613] usb 2-1.2: device
not accepting address 11, error -32
Nov 16 18:15:21 host-x86-64 kernel: [ 5006.931546] usb 2-1.2: USB
disconnect, device number 11
Nov 16 18:15:21 host-x86-64 upowerd[1241]: treating change event as
add on /sys/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2
Nov 16 18:15:21 host-x86-64 kernel: [ 5007.102858] usb 2-1.2: new
full-speed USB device number 12 using ehci-pci
Nov 16 18:15:21 host-x86-64 libvirtd[855]: internal error: Missing
udev property 'ID_VENDOR_ID' on '2-1.2'
Nov 16 18:15:21 host-x86-64 kernel: [ 5007.182555] usb 2-1.2: device
descriptor read/64, error -32
Nov 16 18:15:22 host-x86-64 kernel: [ 5007.370518] usb 2-1.2: device
descriptor read/64, error -32
Nov 16 18:15:22 host-x86-64 kernel: [ 5007.558677] usb 2-1.2: new
full-speed USB device number 13 using ehci-pci
Nov 16 18:15:22 host-x86-64 kernel: [ 5007.638657] usb 2-1.2: device
descriptor read/64, error -32
Nov 16 18:15:22 host-x86-64 kernel: [ 5007.826664] usb 2-1.2: device
descriptor read/64, error -32
Nov 16 18:15:22 host-x86-64 kernel: [ 5007.935063] usb 2-1-port2:
attempt power cycle
Nov 16 18:15:23 host-x86-64 kernel: [ 5008.538604] usb 2-1.2: new
full-speed USB device number 14 using ehci-pci
Nov 16 18:15:23 host-x86-64 kernel: [ 5008.956553] usb 2-1.2: device
not accepting address 14, error -32
Nov 16 18:15:23 host-x86-64 kernel: [ 5009.034629] usb 2-1.2: new
full-speed USB device number 15 using ehci-pci
Nov 16 18:15:24 host-x86-64 kernel: [ 5009.450570] usb 2-1.2: device
not accepting address 15, error -32
Nov 16 18:15:24 host-x86-64 kernel: [ 5009.450881] usb 2-1-port2:
unable to enumerate USB device
#######################################


Thanks and Regards,
Ajay
