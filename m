Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF75E3B9603
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 20:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbhGASQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 14:16:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42860 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230014AbhGASQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 14:16:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625163224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CywOQuoVk5N72tkIO6gfgUt+pTez87wevGV8+pLajjo=;
        b=hv3clhl4ANFcmDgXTajiYKQar8RI+L7e0e7Gau7IdNMzyFSvzOEt/kdYBFerC6GS6k05Y0
        +qpclpoH58YQroYyDvJHPBb2tCLgpPQB8grbJe46tlIxgPkWWSWwRGSGV7Uk/wmj8ormqR
        xuyuLB1aeGfDuzB3MB/OSk9EFL4+Kv0=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-ghj_IwjnMX2j4NiqA5vHGg-1; Thu, 01 Jul 2021 14:13:43 -0400
X-MC-Unique: ghj_IwjnMX2j4NiqA5vHGg-1
Received: by mail-il1-f198.google.com with SMTP id x2-20020a056e021bc2b02901ee78f516b4so4429624ilv.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 11:13:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=CywOQuoVk5N72tkIO6gfgUt+pTez87wevGV8+pLajjo=;
        b=dMKvn4Pd2p5QLPslaeCNqwYyde6zSWHmwq3hheG3G4MzGL+7Xs+gzEqGsSsAd9eR/i
         H9nrtVKTDToWaPOW4YO5mAZHoUQ17N7QbwoXqAJMzCbkp+/xc0DBQ9UO/S3E6scISl5O
         yzIdq5Q3j2C7+mwpCaNduSXK2V3SBgf498pxOVJEp+G3yMcxITBrdOiEYguTQo3ZTM8f
         ul3DLurTsCNaegDOLANy0go9Jkto3FuPLH7pjRd2q28QkC3NBSZtCr3+QAYbkPqu8KJB
         2IcGGaIO+MZBd81SeKDsM4I4T37umhJWvFcMnVOfwFGHRz5hXhKzTykOwLljFY0ND0hR
         /pKw==
X-Gm-Message-State: AOAM531FnhVzqYpa3DHc9/E/ff+53c5cHIqR4s+7/wiCqZUOUFgEPLsc
        k75s758nKnSANPpmzFMWN7l+TBF+6IiBS5iu9NSeMjPWIEwPSTfvfODlmcwpmm7za7B0gqu2OEB
        ND2boiabu80kZSMMlxmEo7fJJ
X-Received: by 2002:a92:ddc6:: with SMTP id d6mr472164ilr.51.1625163222654;
        Thu, 01 Jul 2021 11:13:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzHTXwr1EsWNLVHHiri1W3U3TZItD53EsA6YVI/BP/RUPjAgrPo2OaUFyrUry8nZ0eZOCOiCw==
X-Received: by 2002:a92:ddc6:: with SMTP id d6mr472153ilr.51.1625163222422;
        Thu, 01 Jul 2021 11:13:42 -0700 (PDT)
Received: from kasuf.ausil.us (207-179-239-100.mtco.com. [207.179.239.100])
        by smtp.gmail.com with ESMTPSA id q8sm285806iot.30.2021.07.01.11.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 11:13:42 -0700 (PDT)
Message-ID: <9a144e2fed4fe6f4eb3c1c88a51d72e3db5a3cee.camel@redhat.com>
Subject: Re: [PATCH 1/4] arm64: dts: rockchip: helios64: fixup USB setup
From:   Dennis Gilmore <dgilmore@redhat.com>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        linux-rockchip@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Thu, 01 Jul 2021 13:13:26 -0500
In-Reply-To: <dbb04649-d56c-32ac-913c-5b5795851bf4@kleine-koenig.org>
References: <20210701004043.18585-1-dgilmore@redhat.com>
         <01f1b032-14a8-a6fa-9063-23de65fc6f43@kleine-koenig.org>
         <f46b234e0aaf4356804d5e1446910bbedcbddb51.camel@redhat.com>
         <dbb04649-d56c-32ac-913c-5b5795851bf4@kleine-koenig.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.2 (3.40.2-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-07-01 at 15:35 +0200, Uwe Kleine-König wrote:
> Hello Dennis,
> 
> On 7/1/21 2:59 PM, Dennis Gilmore wrote:
> > On Thu, 2021-07-01 at 11:31 +0200, Uwe Kleine-König wrote:
> > > Hello,
> > > 
> > > On 7/1/21 2:40 AM, Dennis Gilmore wrote:
> > > > Without the usbdrd_dwc3_1 node defined u-boot will throw an
> > > > error
> > > > and
> > > > reset the system.
> > > 
> > > I wonder if this should better be fixed in u-boot then?!
> > > 
> > > > All other rk3399 systems use this format
> > > 
> > > This is true for the dwc nodes, however for the usb2 nodes there
> > > are
> > > several that use this idiom (and even repeat the label name), see
> > > for
> > > example the &u2phy0 node in
> > > arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi .
> > > 
> > 
> > looking at that file is where I got the idea to set it up as I have
> > proposed, it follows the format I have submitted
> 
> I guess you didn't read exactly what I wrote and only looked at
> &usbdrd* 
> but not &u2phy0.

Hi Uwe,

I did read what you pointed at, the issue is that is already defined in
arch/arm64/boot/dts/rockchip/rk3399.dtsi and all that is needed it to
set the status to okay and minor enablement. as DTC merges all the
snippets together they end up in the right place and doing the right
thing, the approach you took is different to all the other boards I
looked at and seemingly causes issues in u-boot. I did not get far
enough in booting to verify the state in linux as I am updating u-boot
as I go and testing using u-boots dtb for simplicty sake. It quite
likely is a bug in u-boot that it resets the system, at the same time I
do not think that doing it differently to how the other boards are
implemented is right either. There is still a lot of the hardware in
the system that is not defined in the devicetree file, including a lot
of the usb stack.

Dennis

