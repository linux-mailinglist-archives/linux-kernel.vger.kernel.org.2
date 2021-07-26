Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2AEE3D56D3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 11:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbhGZJJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 05:09:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:53094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232861AbhGZJJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 05:09:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D9DDA60F49;
        Mon, 26 Jul 2021 09:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627293021;
        bh=LJY0gZ5dzl0O4oIYvQ90kyHhKvNigjB2wcn+SOScISs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mDuEeHuyQTZyn5GAA033iSbYnw4N9lPTCoGbv5k20OtAUsIyyswNZ4S2jYTpun2qL
         cfSWnNjkvGRHrXvyjRoIEdr0V1gSMhjiPRDydKULOHxlHZxePKNWQcjTPoEx90O6rj
         XRErUJEuuC96rUsIWrdLIQrE5lRa24pk5qQKJ4AlkKsfmtvahR8mtgJM08eRvyaPer
         BAVU1kDB/Wg4pozRR1Ab5F1QfNtaLu9XdKOMXK9m/yZXAjewZyqP1RzUKXPgP33xqd
         5SbazlIR8wHT4Qdk85iGhbSxClSTh2PgyWF4nXaR/61ZRRC6ZzeX1sPMfYz/L6vBuS
         Bq4huQrvMwUlw==
Date:   Mon, 26 Jul 2021 11:50:16 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Wei Xu <xuwei5@hisilicon.com>
Cc:     <linuxarm@huawei.com>, <mauro.chehab@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] dts: hisilicon: add support for USB3 on Hikey 970
Message-ID: <20210726115016.46a1cc60@coco.lan>
In-Reply-To: <60FE25A4.4040905@hisilicon.com>
References: <cover.1627116285.git.mchehab+huawei@kernel.org>
 <ec30515cad1247280356943d5f93157330eaa73f.1627116285.git.mchehab+huawei@kernel.org>
 <60FE25A4.4040905@hisilicon.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 26 Jul 2021 11:01:56 +0800
Wei Xu <xuwei5@hisilicon.com> escreveu:

> Hi Mauro,
> 
> On 2021/7/24 16:55, Mauro Carvalho Chehab wrote:
> > Add the USB3 bindings for Kirin 970 phy and Hikey 970 board.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> 
> Fine to me and I can merge this patch once the binding for the 
> "kirin970_hikey_usbhub" and "hi3670-dwc3" are ready.

The compatible:
	"hisilicon,hi3670-dwc3"

was already merged upstream on this patch:

commit b68d9251561f33661e53dd618f1cafe7ec9ec3c2
Author:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
AuthorDate: Tue Sep 8 11:58:23 2020 +0200
Commit:     Felipe Balbi <balbi@kernel.org>
CommitDate: Thu Sep 24 11:56:01 2020 +0300

    usb: dwc3: simple: add support for Hikey 970
    
    This binding driver is needed for Hikey 970 to work,
    as otherwise a Serror is produced:

It follows the DWC3 schema, e. g.:

	Documentation/devicetree/bindings/usb/snps,dwc3.yaml

While double checking for "kirin970_hikey_usbhub", it sounds that
the dt-binding patch was not merged yet, and require further
discussions.

I'll re-start the upstream thread where this was discussed in
the past. I'll re-submit this patch once we finish such
discussions.

Thanks,
Mauro
