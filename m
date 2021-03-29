Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA92334C464
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 09:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbhC2G7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 02:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbhC2G7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 02:59:24 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F443C061574
        for <linux-kernel@vger.kernel.org>; Sun, 28 Mar 2021 23:59:24 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id f22-20020a7bc8d60000b029010c024a1407so7948168wml.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Mar 2021 23:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iewc-co-za.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=dZtoV8jaMtORqfMr9FpjV/Qb0EUzX/EF4BIgZGFSgTA=;
        b=BAxQiaNEnJ7MU66SVoQLiuGjgbMANbs0PmN2CbRkch3Mz3gv0Pycf9VeAnTvzLOFJs
         6rhJDZFWRoBrsplxHTN3dzs1/Yzzoed9gs33qRwlKczHGlbX2/wUbWaLFK/o91ovU9N2
         0sC1q8Ym8PsVtQ78qStY9FsvR3w5TLAcXz44HXmGJU2KHGF7s8uktaG+939gH/Fn0jQy
         IqyTb5gTuEGCNvRvAE9ycjt6WjJjipd+Gn7Kal2QJ6oU7BQ8d3wKImVYsJ+FuT6S+5nE
         7RCcgQ4SU6pSjdi3Bky96g38tLH51fl7GeRrvyxqZierjJZqlF2tbt33TgZE2dhKTgwg
         OC4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=dZtoV8jaMtORqfMr9FpjV/Qb0EUzX/EF4BIgZGFSgTA=;
        b=E1YnzCNVLpxclLks+HK//WciT3MHy27QVgFpFs2ks1s0KhRTcoraP74qGumxUIu5ih
         p6XMcQX0aPcXxCogy9WVJRZf8YjJ62sQni//pySq2sUFvVvUSqihvfpdzBU9bCNUaSx4
         VuFsuLbSiHYNrbecG8fJWyTzmI3nPkAGbigswhX4njuuYRdCnwmoGQD7KtP4p4v7/2k/
         j0KA5fkTotLJmsqrXYEWQzaUPUjNnDwEVcNYsBAhvrF/JLoJtnzr0BWsvccp2EBGFYMB
         vz1zCgauLXQNEzGc1mtZNYn5VuHA5oYGMxb8NA8yoGUDLkTIkKZwiqUbEu9KklEXErCH
         uUGg==
X-Gm-Message-State: AOAM531XShza5b3/oXrgyhmwFBodfVGAioTtS/UCLDVoAQI/QLBHAY6K
        /QS9u4kNxEbsZKTYYpDde1VJDm8MGpTWUA==
X-Google-Smtp-Source: ABdhPJzrrvVpDoFXhF0aM7m9IgiB6znVcDRzs4i+Edp41qJbRInZ6Saj9iLr8HdvjjP4T10y8vFKJA==
X-Received: by 2002:a1c:1c2:: with SMTP id 185mr23683280wmb.115.1617001162461;
        Sun, 28 Mar 2021 23:59:22 -0700 (PDT)
Received: from ?IPv6:2001:470:1f23:2c4:598a:1e44:6714:44a2? ([2001:470:1f23:2c4:598a:1e44:6714:44a2])
        by smtp.gmail.com with ESMTPSA id h8sm27930357wrt.94.2021.03.28.23.59.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Mar 2021 23:59:21 -0700 (PDT)
To:     linux-kernel@vger.kernel.org
From:   Ian Coetzee <ian@iewc.co.za>
Subject: Periodic locking IO is causing server to stop responding
Message-ID: <01046937-1027-c88c-a0de-6cbdb28132ca@iewc.co.za>
Date:   Mon, 29 Mar 2021 08:59:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

We have run into a slight mishap here on one of our servers, which I am=20
hoping you could help narrow down to a cause.

One of our servers locks up every so often, seemingly because of a disk=20
IO lockup. Symptoms include high load average (106) stemming from the=20
processor waiting around 97-99% for the disk. When this occurs any new=20
ssh sessions is met with a connection timeout.

Kernel version: 5.10.24-uls #1 SMP Fri Mar 19 11:31:52 SAST 2021 x86_64=20
Intel(R) Xeon(R) CPU E5-2603 v3 @ 1.60GHz GenuineIntel GNU/Linux

The following log entries appeared in dmesg around the time the last=20
lock up started occurring.

> [Tue Mar 23 06:09:32 2021] scsi target0:0:8: handle(0x0012),=20
> sas_address(0x500304800175f088), phy(8)
> [Tue Mar 23 06:09:32 2021] scsi target0:0:8: enclosure logical=20
> id(0x500304800175f0bf), slot(8)
> [Tue Mar 23 06:09:32 2021] sd 0:0:8:0: No reference found at driver,=20
> assuming scmd(0x0000000029a7ef73) might have completed
> [Tue Mar 23 06:09:32 2021] sd 0:0:8:0: task abort: SUCCESS=20
> scmd(0x0000000029a7ef73)
> [Tue Mar 23 06:09:32 2021] sd 0:0:8:0: attempting task=20
> abort!scmd(0x00000000de97f273), outstanding for 184620 ms & timeout=20
> 180000 ms
> [Tue Mar 23 06:09:32 2021] sd 0:0:8:0: [sdi] tag#1993 CDB: Write(16)=20
> 8a 00 00 00 00 00 34 d5 2c 00 00 00 04 00 00 00
> [Tue Mar 23 06:09:32 2021] scsi target0:0:8: handle(0x0012),=20
> sas_address(0x500304800175f088), phy(8)
> [Tue Mar 23 06:09:32 2021] scsi target0:0:8: enclosure logical=20
> id(0x500304800175f0bf), slot(8)
> [Tue Mar 23 06:09:32 2021] sd 0:0:8:0: No reference found at driver,=20
> assuming scmd(0x00000000de97f273) might have completed
> [Tue Mar 23 06:09:32 2021] sd 0:0:8:0: task abort: SUCCESS=20
> scmd(0x00000000de97f273)
> [Tue Mar 23 06:09:32 2021] sd 0:0:8:0: attempting task=20
> abort!scmd(0x00000000e4cfbc75), outstanding for 184600 ms & timeout=20
> 180000 ms
> [Tue Mar 23 06:09:32 2021] sd 0:0:8:0: [sdi] tag#1987 CDB: Write(16)=20
> 8a 00 00 00 00 00 34 d5 96 a8 00 00 01 58 00 00
> [Tue Mar 23 06:09:32 2021] scsi target0:0:8: handle(0x0012),=20
> sas_address(0x500304800175f088), phy(8)
> [Tue Mar 23 06:09:32 2021] scsi target0:0:8: enclosure logical=20
> id(0x500304800175f0bf), slot(8)
> [Tue Mar 23 06:09:32 2021] sd 0:0:8:0: No reference found at driver,=20
> assuming scmd(0x00000000e4cfbc75) might have completed
> [Tue Mar 23 06:09:32 2021] sd 0:0:8:0: task abort: SUCCESS=20
> scmd(0x00000000e4cfbc75)
> [Tue Mar 23 06:09:32 2021] sd 0:0:8:0: attempting task=20
> abort!scmd(0x000000002282f27d), outstanding for 184620 ms & timeout=20
> 180000 ms
> [Tue Mar 23 06:09:32 2021] sd 0:0:8:0: [sdi] tag#1986 CDB: Write(16)=20
> 8a 00 00 00 00 00 34 d5 3c 00 00 00 04 00 00 00
> [Tue Mar 23 06:09:32 2021] scsi target0:0:8: handle(0x0012),=20
> sas_address(0x500304800175f088), phy(8)
> [Tue Mar 23 06:09:32 2021] scsi target0:0:8: enclosure logical=20
> id(0x500304800175f0bf), slot(8)
> [Tue Mar 23 06:09:32 2021] sd 0:0:8:0: No reference found at driver,=20
> assuming scmd(0x000000002282f27d) might have completed
> [Tue Mar 23 06:09:32 2021] sd 0:0:8:0: task abort: SUCCESS=20
> scmd(0x000000002282f27d)
> [Tue Mar 23 06:09:32 2021] sd 0:0:8:0: device_unblock and setting to=20
> running, handle(0x0012)
> [Tue Mar 23 06:09:33 2021] sd 0:0:8:0: Power-on or device reset occurre=
d

We are running a bank of drives on software raid, all on controller

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *-storage
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 description: Serial Attached SCSI controller
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 product: SAS3008 PCI-Express Fusion-MPT SAS-3
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 vendor: Broadcom / LSI
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 physical id: 0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 bus info: pci@0000:01:00.0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 logical name: scsi0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 version: 02
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 width: 64 bits
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 clock: 33MHz
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 capabilities: storage pm pciexpress vpd msi msix=20
> bus_master cap_list rom
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 configuration: driver=3Dmpt3sas latency=3D0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 resources: irq:24 ioport:e000(size=3D256)=20
> memory:fb200000-fb20ffff memory:fb100000-fb1fffff

So far we have not seen this on any of other servers on the same kernel=20
version.

Please let me know if I can provide anymore information, we have since=20
restarted the server.

Kind regards
Ian Coetzee

