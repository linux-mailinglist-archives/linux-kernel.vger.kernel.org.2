Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37B8041B410
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 18:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241864AbhI1QnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 12:43:14 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:51800 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241862AbhI1QnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 12:43:11 -0400
X-Greylist: delayed 434 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Sep 2021 12:43:11 EDT
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18SGY7oi003138;
        Tue, 28 Sep 2021 11:34:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1632846847;
        bh=xSTXq8R8vgo138+dhfYd3IzStIxHaO1s9BsjwZOMBLA=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=VASFaVffwcLLoVPVobvxVSOnepc8KJZeW9yh3KTCIul8r/ahsukmB2n4U0qNH0AhO
         tenUt9266pe4KizjcUzqr7sSF4wlkPgNZDkR+VD2RaX+hS11nCskGtoDrroYe2UT5D
         EZKbRyOGmZGyLCSQ+/zjFs97yhewrNgWZuZPfUnU=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18SGY7Fl034589
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 Sep 2021 11:34:07 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 28
 Sep 2021 11:34:06 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 28 Sep 2021 11:34:07 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18SGY6LM028980;
        Tue, 28 Sep 2021 11:34:06 -0500
Date:   Tue, 28 Sep 2021 22:04:05 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Daniel Palmer <daniel@0x0f.com>
CC:     <linux-mtd@lists.infradead.org>, <tudor.ambarus@microchip.com>,
        <michael@walle.cc>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: Add support for ZB25VQ128
Message-ID: <20210928163403.iufy6rgn7imiebpz@ti.com>
References: <20210918072256.3505379-1-daniel@0x0f.com>
 <20210920112625.fnqayim5mg5iggag@ti.com>
 <CAFr9PX=xKoa9fCbYf6Mpn=oudnY7A=6meKBSmzNHYLFad364tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAFr9PX=xKoa9fCbYf6Mpn=oudnY7A=6meKBSmzNHYLFad364tw@mail.gmail.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/21 10:15PM, Daniel Palmer wrote:
> Hi Pratyush,
> 
> On Mon, 20 Sept 2021 at 20:26, Pratyush Yadav <p.yadav@ti.com> wrote:
> >
> > Zbit should be in bank 10, so it should be preceeded by 9 0x7f bytes,
> > correct? I don't see any logic to handle that in SPI NOR currently so I
> > assume this manufacturer does not implement the continuation codes.
> >
> > In that case, it should go to the manufacturer collisions driver
> > proposed here [0].
> >
> > [0] https://patchwork.ozlabs.org/project/linux-mtd/patch/20210727045222.905056-6-tudor.ambarus@microchip.com/
> 
> Sorry, I'm not sure what I should do with this information. I didn't
> even know about the continuation codes thing until now.
> Is there something I need to do here or do I just need to wait for the
> collision handling code to get merged?

I think that should be what you need to do. Tudor, any plans on 
re-rolling that patch series in the near future?

> 
> Thanks,
> 
> Daniel

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
