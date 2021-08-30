Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3984F3FB74D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 15:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236875AbhH3Nxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 09:53:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46853 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233874AbhH3Nxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 09:53:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630331579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3QR26H90I5oa/Aq9g2W/STFicF2YahgcF3x4I6vga0I=;
        b=S/k9zRw6K75t1gDFPMhswnsnyLWnJvu8nq+OeEpBfH3gcYA1awHfpxHJ7O8VewG15lEK8B
        bTZfoLdq08HI/QdvdlHWDs1dbO+dT5QASwY0SChQqZFcnOhmnxzj/sTQVmWLA0eT6yu0Mn
        kJc4QAOc6ZyRFfOxL2b3RyDUIALdU0I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523-Hu_ttGf_MNif7ihmnGQo_w-1; Mon, 30 Aug 2021 09:52:58 -0400
X-MC-Unique: Hu_ttGf_MNif7ihmnGQo_w-1
Received: by mail-wm1-f72.google.com with SMTP id f19-20020a1c1f13000000b002e6bd83c344so15808wmf.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 06:52:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=3QR26H90I5oa/Aq9g2W/STFicF2YahgcF3x4I6vga0I=;
        b=OHtbBkX8/QDPI0pyEGM+tYZslwjCr7mnImgXb+YK552VeqJiiVgwUf8JV7hWTXRxOJ
         VUs6MVzepz74o0Bnjw59XuyIHMrQzAbTeYIdKEvMrtbJf6/ipmBnCdsgKH+Rnhu5Ir1I
         gO8fCfSdbkKelT2kNgPEVpz7yNiMH6N0KbbaocPockUIZRk7DSionyVatua7tkQU9vvH
         /oJoXnjbN1gCVdMLjaaTWoW5GK00qfNTkdNTDC4itp/a6/C/P5EoFo6ZzBUqHPbfcz9K
         mFbYcgocEVfWvpelFUdu4IwpkN4Drf5tvSVJoSu3KldKRQ90IrCjl+7I62jaY7Hn9190
         ienQ==
X-Gm-Message-State: AOAM532jryBiax7YMWSijKtbUzq4qETpjAGnCSGIinwXvtFvV+9M02Gn
        Lt2Xy1yJsYgiOpiz64Qo5h2O+vPYTVus0nVFxQcxXMj/6Jd96DKeyLGMLCdZQA42Xjg5RsuIplc
        X4qF4dxJm8UdNpou0VXSm3Mdc
X-Received: by 2002:a5d:5452:: with SMTP id w18mr25817928wrv.221.1630331577193;
        Mon, 30 Aug 2021 06:52:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxiV6tn32BvkOpeVK88NLS2VPjgTEoDc32JCI++maS/PsNPJcd4rRPkS2cfkSHGgjR69mI1Yg==
X-Received: by 2002:a5d:5452:: with SMTP id w18mr25817911wrv.221.1630331577024;
        Mon, 30 Aug 2021 06:52:57 -0700 (PDT)
Received: from ?IPv6:2a0c:5a80:3c08:b500:afb2:5ebc:3fd2:26de? ([2a0c:5a80:3c08:b500:afb2:5ebc:3fd2:26de])
        by smtp.gmail.com with ESMTPSA id w9sm13490938wmc.19.2021.08.30.06.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 06:52:56 -0700 (PDT)
Message-ID: <e1ca1f086c180f04044996ccf59981d59fbdbc6b.camel@redhat.com>
Subject: Re: [PATCH] ARM: dts: bcm2711-rpi-4-b: Fix pcie0's unit address
From:   nsaenzju@redhat.com
To:     Rob Herring <robh@kernel.org>
Cc:     f.fainelli@gmail.com, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stefan.wahren@i2se.com
Date:   Mon, 30 Aug 2021 15:52:54 +0200
In-Reply-To: <YSzfoyesEzAuLkSS@robh.at.kernel.org>
References: <20210830103909.323356-1-nsaenzju@redhat.com>
         <YSzfoyesEzAuLkSS@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-08-30 at 08:39 -0500, Rob Herring wrote:
> On Mon, Aug 30, 2021 at 12:39:09PM +0200, Nicolas Saenz Julienne wrote:
> > dtbs_check currently complains that:
> > 
> > arch/arm/boot/dts/bcm2711-rpi-4-b.dts:220.10-231.4: Warning
> > (pci_device_reg): /scb/pcie@7d500000/pci@1,0: PCI unit address format
> > error, expected "0,0"
> > 
> > Unsurprisingly pci@0,0 is the right address, as illustrated by its reg
> > property:
> > 
> > 	&pcie0 {
> > 		pci@0,0 {
> > 			/*
> > 			 * As defined in the IEEE Std 1275-1994 document,
> > 			 * reg is a five-cell address encoded as (phys.hi
> > 			 * phys.mid phys.lo size.hi size.lo). phys.hi
> > 			 * should contain the device's BDF as 0b00000000
> > 			 * bbbbbbbb dddddfff 00000000. The other cells
> > 			 * should be zero.
> > 			 */
> > 			reg = <0 0 0 0 0>;
> > 		};
> > 	};
> > 
> > The bus is clearly 0. So fix it.
> 
> s/bus/device/
> 
> The unit-address format is '<device>,<function>' (and function is 
> optional). The bus number is not part of the unit-address because that 
> is dynamic and then the path would not be fixed/known. The bus is part 
> of 'reg' for true OpenFirmware, but for FDT I think it should always be 
> 0 as the DT is static. 
> 
> Looks like the child node is wrong (both unit-address and reg) as well:
> 
>                 usb@1,0 {
>                         reg = <0x10000 0 0 0 0>;
>                         resets = <&reset RASPBERRYPI_FIRMWARE_RESET_ID_USB>;
>                 };
> 
> It doesn't warn because the bridge node is also missing 'device_type = 
> "pci";'.
> 
> This is all fairly hard to get right (see recent hikey970 patches for a 
> complex example). I'm thinking about writing a tool that generates a DT 
> with PCI nodes by reading the PCI hierachy from sysfs.

Thanks for the review, I'll fix all those. That tool would be very helpful.

-- 
Nicolás Sáenz

