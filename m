Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9473B209D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 20:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbhFWSw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 14:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhFWSw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 14:52:27 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8219BC061574
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 11:50:08 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id l12so3036530wrt.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 11:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t9g61bv+JZ07tY5UuVmyIiDTVqgatmyK1QRV0XqD+Hc=;
        b=KLXuHll2RXbwuztCykmE1EQTu6vmTzU1QQjpNTWzNCxaM1/Ps+7XEiFt8zUeOZ1baA
         xe7gg6HXyDZ4KaB5Rul1MiFZoKZ0NCIbHMmtoCQwOsmnIQiG+kgYk7+D1Nwn5IGm+2zB
         +ei/17jncOmir+dd9UyMDCtbBeqxpGTR5rZqJk0gYytyX0CnJeaGFqWYDEu6HFskFOOE
         nDzu6jGbO5UvY6TkF6GoI2grAJpQLbjUvI6cQO7vFjzZCaOOWSL1cuXCzLO2WUEC+XMu
         tRtnxpuK28KFSNdjX7/SGtxLwQUIkf75kqAgcewqO+eglB9DMfpSiAc0IPNPS5ithG0y
         BKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=t9g61bv+JZ07tY5UuVmyIiDTVqgatmyK1QRV0XqD+Hc=;
        b=ncBERrueKKtw81d2xd4SedZoYSk22j1vnecVedfLuDHK1dmAuXICXH2+Osw3sIgcEU
         C1turrHlCBOUsvo8UylA49yIM9MCBEb16vdPPfrzfy7ov6qDHy0PVB+bTJQYHRr3AkH6
         66ilX4otMRgptbo6WpqV7QwRBfrk3ve0QSPHlqovGOMrM84971tqyDI80yHkHlclfh34
         IoDJcOzuIa8AycgYbdsFNYfPScb+OppkV0UZ/mrKwjhgukHmRKt5RNlxrOojmioIW1sU
         ZWkbNbLdSu+sg4wOjJUXvsHJBOTMAT4a9UjDiLK+ipDq2BuDuUcyMCoeoMRFSMhDeCUS
         FK4A==
X-Gm-Message-State: AOAM531XuroBLBR2qleGMZIBH1cLRAUDaD90mSyTz5YtfSqNIERuQYV6
        n8AeGgPO1ydMA8TqDdYsRXc=
X-Google-Smtp-Source: ABdhPJwow7ob1nYUTJTVlm2hcLViMuMJ7U2nNz+pDoNObCJVja/RfxSZArMIJ4rIufME1rWIeSAkvw==
X-Received: by 2002:a5d:6b91:: with SMTP id n17mr1793938wrx.166.1624474207108;
        Wed, 23 Jun 2021 11:50:07 -0700 (PDT)
Received: from eldamar (80-218-24-251.dclient.hispeed.ch. [80.218.24.251])
        by smtp.gmail.com with ESMTPSA id x10sm848038wru.58.2021.06.23.11.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 11:50:06 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Date:   Wed, 23 Jun 2021 20:50:05 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Robin Murphy <robin.murphy@arm.com>,
        989778-maintonly@bugs.debian.org
Cc:     =?utf-8?B?5bCP5aSq?= <nospam@kota.moe>,
        Jianxiong Gao <jxgao@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        xen-devel@lists.xenproject.org
Subject: Re: Bug#989778: Regression in at least 5.10.y and mainline: Firewire
 audio interface fails to work properly (when booted under Xen)
Message-ID: <YNOCXe1cuNDNAB+Z@eldamar.lan>
References: <162352833546.2353.230557992597997974.reportbug@home.kota.moe>
 <YMWl4UnFBAVRDnys@eldamar.lan>
 <162352833546.2353.230557992597997974.reportbug@home.kota.moe>
 <2f7c7d36-b6f4-f8ab-756e-a563fa03b9e4@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f7c7d36-b6f4-f8ab-756e-a563fa03b9e4@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Mon, Jun 14, 2021 at 02:29:08PM +0100, Robin Murphy wrote:
> On 2021-06-13 07:29, Salvatore Bonaccorso wrote:
> > A user in Debian reported the above issue, which was reproducible with
> > 5.13-rc5 and 5.10.y as packaged in Debian and found that 85a5a6875ca9
> > ("swiotlb: don't modify orig_addr in swiotlb_tbl_sync_single") that
> > introduced the issue.
> 
> Sounds like it's probably the same thing as being discussed over here:
> 
> https://lore.kernel.org/linux-iommu/2e899de2-4b69-c4b6-33a6-09fb8949d2fd@nxp.com/

Thanks for the pointer, it seems that now it has been fixed upstream
with 5f89468e2f06 ("swiotlb: manipulate orig_addr when tlb_addr has
offset").

Regards,
Salvatore
