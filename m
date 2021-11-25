Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5E145E1D3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 21:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350310AbhKYUuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 15:50:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56870 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230468AbhKYUsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 15:48:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637873101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a8msmL+dSCBGccxnAPs58z4VsuX8uw6fgQ0C8pTfMp8=;
        b=WNmVd8s8H0BlN0W9C3x1zBn0q+U3m1o7E+wWJR9OAuiCmBPrFBQvn2lKB7FIwUASGDYIxh
        bk6zsvPAYpmGrl/hGkxoN6Wpwv8uE3SIN28XmPAm3c6mKnmMcbyYpP+VUjDtFWp9Di7ACH
        kypDnMl7r6HlrUVP8lbWBK8FjqrqAW8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-8-FWLHoHC5Ml-j3meeVxeldA-1; Thu, 25 Nov 2021 15:45:00 -0500
X-MC-Unique: FWLHoHC5Ml-j3meeVxeldA-1
Received: by mail-ed1-f69.google.com with SMTP id s12-20020a50ab0c000000b003efdf5a226fso123738edc.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 12:45:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=a8msmL+dSCBGccxnAPs58z4VsuX8uw6fgQ0C8pTfMp8=;
        b=m5+kc+67RR28/msyX+wZXe8zOIrlw4zM7gQhPSksxxEXKcl8fgUtq3f+KeKG1ywhgR
         mI2lVyP5nFyyuNCbjV2iGDWAlVdES8HmIW7vWT5tcp84N6ICKpUb1bgUCTCkwNT+78S7
         8SaGYkN9Bija/+huGI5gSP+FCqRnj4hKtNoExLVxCoDWFySfFTDI5IejMi58Te17fGAc
         BR+GiByjqClOPdqzWkemqESBcLQt0NL7BP1OfgXrFQkiJ2askZIH/L4Ubn7Lv7AISP3h
         GVmfEGNuOeZRVbtNY3ja9vbP30NuUvAfapf9aRoJZYO4CoMojCD4U2qtOCUh2/AT8yTe
         WCjg==
X-Gm-Message-State: AOAM531P5bh8c1opOlv4lvuVzXNZOSmHiSrcBUkeJ2oCg9bqjatzljlr
        1P3aLV1tGTyG3g8MDk0hnJQw/HgyTkzr8XaOS7kp0i3VCE4+TplBHwipUKc9bx2O/HK+R1yOTF9
        ZqxMtCfmtTOltP+E2yCb/t6d7
X-Received: by 2002:aa7:d495:: with SMTP id b21mr42133450edr.363.1637873099231;
        Thu, 25 Nov 2021 12:44:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwTPqNf4VUuW6BEDfui/hzHRpzYVp59pV4nohAawMz1FPQT58MahY5ZHh9BtXtttz+cGKXN+w==
X-Received: by 2002:aa7:d495:: with SMTP id b21mr42133412edr.363.1637873099013;
        Thu, 25 Nov 2021 12:44:59 -0800 (PST)
Received: from redhat.com ([2a03:c5c0:207e:e87:2d40:4ed4:5676:5c1a])
        by smtp.gmail.com with ESMTPSA id x22sm2015527ejc.97.2021.11.25.12.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 12:44:58 -0800 (PST)
Date:   Thu, 25 Nov 2021 15:44:54 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] Bluetooth: virtio_bt: fix device removal
Message-ID: <20211125154314-mutt-send-email-mst@kernel.org>
References: <20211125174200.133230-1-mst@redhat.com>
 <F52F65FE-6A07-486B-8E84-684ED85709E9@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F52F65FE-6A07-486B-8E84-684ED85709E9@holtmann.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 09:02:01PM +0100, Marcel Holtmann wrote:
> Hi Michael,
> 
> > Device removal is clearly out of virtio spec: it attempts to remove
> > unused buffers from a VQ before invoking device reset. To fix, make
> > open/close NOPs and do all cleanup/setup in probe/remove.
> 
> so the virtbt_{open,close} as NOP is not really what a driver is suppose
> to be doing. These are transport enable/disable callbacks from the BT
> Core towards the driver. It maps to a device being enabled/disabled by
> something like bluetoothd for example. So if disabled, I expect that no
> resources/queues are in use.
> 
> Maybe I misunderstand the virtio spec in that regard, but I would like
> to keep this fundamental concept of a Bluetooth driver. It does work
> with all other transports like USB, SDIO, UART etc.
> 
> > The cost here is a single skb wasted on an unused bt device - which
> > seems modest.
> 
> There should be no buffer used if the device is powered off. We also don’t
> have any USB URBs in-flight if the transport is not active.
> 
> > NB: with this fix in place driver still suffers from a race condition if
> > an interrupt triggers while device is being reset. Work on a fix for
> > that issue is in progress.
> 
> In the virtbt_close() callback we should deactivate all interrupts.
> 
> Regards
> 
> Marcel

If you want to do that then device has to be reset on close,
and fully reinitialized on open.
Can you work on a patch like that?
Given I don't have the device such a rework is probably more
than I can undertake.

-- 
MST

