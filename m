Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F892362C3D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 02:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234761AbhDQAGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 20:06:18 -0400
Received: from mout.gmx.net ([212.227.17.22]:37635 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229719AbhDQAGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 20:06:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1618617928;
        bh=KjFgAhHrkpNz9EPaCLaTNNTqXBQS/P/3r7U4JKhYPqI=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=Ql1z4G/QUAp0bQJ60lrDbszRKAfdauHD7jjObsNfAfPwaeSRScQS+XiwnZ5asucfs
         jJGL16gxGIIyEri8M3w/2Gfuvjh+wKMvPqS2EF1c3gBjAHiYDlpT/BFo82rvVHKD5y
         5y2ORCbMsmPOQfNngdhBlaaMN+OIebSrVWSZ9fb8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.218.101]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mlw3X-1lxmTj0Jox-00iz88; Sat, 17
 Apr 2021 02:05:28 +0200
Message-ID: <d725b19b4c02273eaab38a10853fa6fb6d5bc76c.camel@gmx.de>
Subject: Re: [patch] x86/crash: fix crash_setup_memmap_entries()
 out-of-bounds access
From:   Mike Galbraith <efault@gmx.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, DaveYoung <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org,
        x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>
Date:   Sat, 17 Apr 2021 02:05:27 +0200
In-Reply-To: <87sg3puco5.ffs@nanos.tec.linutronix.de>
References: <9efaad2ba042b8791cbe8c3e7cad491fe05e06eb.camel@gmx.de>
         <20210416110701.GA3835@dhcp-128-65.nay.redhat.com>
         <063a63ddea914ac654cbe9a1d1d6c76986af7882.camel@gmx.de>
         <20210416114708.GB79779@dhcp-128-65.nay.redhat.com>
         <725fa3dc1da2737f0f6188a1a9701bead257ea9d.camel@gmx.de>
         <20210416121636.GA22348@zn.tnic>
         <a853ea8535151fd8b267d8e68a45b33748978d8a.camel@gmx.de>
         <20210416144459.GB22348@zn.tnic>
         <7826c19ecd583700f56d2db33360e8032e812ecf.camel@gmx.de>
         <87sg3puco5.ffs@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sBg6Es7fLrlg9PB225h4Bij43J9yGqJTutgGTFbK1oHimitSIms
 kqGJNFI5Xizlrs5Xw/veeWOQusUlhLejKVQ3rasDMJYyYkDUi2GNpA1ajaYqdR0R4dbA4rU
 JOUqQZ9EC+9ECXpqg0AxuDaKAeQulEjLeJ7kPhQH3ENh5YXT0deedSfGwifFtTiGtwbJZ+K
 0Pfq4QXiW8wYH9FcdVu3w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:bevRDzDpV+s=:8YKDRaa9+WHmHpFjWv6bU+
 GwgwW3qowiu0ds258hRIF6wWP/1fsaUArHxBSzr6G2uxpUQGQTWUYDlvg4nxlxi6UEQrTBVD2
 x5BWLJpd5xJfo4C52HVBzoBpWOquMhjcWjmP1E5LwEB5t1S3Lox/cAgqEK+nrVdry+qiayOcX
 /HhWyLLbVuqAqQqDRH+hF6/0xDpmAwEWPf/WXmnktcbAH1LOm1wFYua0VKm/AhiNvfzDU9iDe
 7L5wHkPnTvM53kN79k0SGeJFGpxcUs5gJByk/vf4OW3U3h5pbCebGBOTRjmDK8qtlK3W2+OdT
 rW31KMc+602u93wuBIVv/K0x8dDrBiSrkdAD8qk9HjmU5AWV2a6TRpH4S9NzOieADRcZaYOQc
 Yxj/Lr6qcXAZg93S3E6h7M1GBgFxI5Mrt2pVV/Q8kH3KNfLyE8GTGQOAU/f7H2qvsOcvJLazu
 +bp4IXEuiXVYq3mx/uyAJ7yq/o4YeLyAfRySytMhFZKjpnjtZ0uP+ip0PuAzqvnoMJMvqaFW/
 PsfsVeFTErdR41FcfLbnV33rBNb25ahuY6XSTl8vD1J2KLLiMGuvm8e+HtJsZoeijM5olPNHq
 aVnCKxgrRY6ea8GFXo1icw2M5N5KknDSBRZiVZVcVi5j3cPlt5SVy3kdzsSSXu1Qo4sTecpXC
 GDU1+OyGexd1t6EgV8RPEqJUvHBx4nQkz8kHnXnSySulP5uG8Va1UnwAYlHdKK2Wgd+ty1AOb
 1K7T3M4S3rR/YKESDULIPFYv1d/2Vk5hZeAhUTYZ7s7qfT1gfAHLwv5OCiSCwaOLWA6HRsFJs
 WcDQmKA4X95adZBA2XucyOGtimgKxS+0g2kTH6njM5weRtAX6MwfemcxlQUXnY6yRbBtMWaTs
 VYkrEnfo5C6IndmBBi9tqdXbnggfkZ3yAbhxjE3k/Y1kSMajb5AMfLiMQnmlfz7dL60u7MGVa
 yVeurRp9Pa9hrHjCe2jfK1U93igQ09tT3c3VnY8VtxL4msg8L4kFyrM09dCGCBA/p3gh6aaOs
 GQhlzTTru+VMLLAKsah+JLeFW6kHr67jhEu1d4I+2aZvWC3WQodOeP3GfPWOYCcWzQC60KEzc
 KUdCYvbq6aO1jVSedb6WBFUEVfFm3C/S8UCRSUiYuJARRGwDe0xaZ2Vb/iPN29FHLShkaUHA2
 KGTuYaC7f95gi2AjzLyrQVUbmzBpKFRrYr8BJcPoFpdmJAu4sHuTAOIxulZ8tbRsCoFt4=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-04-16 at 23:44 +0200, Thomas Gleixner wrote:
>
> Can all of you involved stop this sandpit fight and do something useful
> to fix that obvious bug already?

?? We're not fighting afaik.  Boris hated my changelog enough to offer
to write a better one, and I'm fine with that.  It's a seven year old
*latent* buglet of microscopic proportions, hardly a pressing issue.

	-Mike

