Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53E873449A3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 16:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbhCVPtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 11:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbhCVPsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 11:48:35 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3318C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 08:48:33 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 10DB722235;
        Mon, 22 Mar 2021 16:48:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1616428112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T3qa2pPQdTQJVJwKBRlFL0u42AQ4SJ4FARdq7h1EuZw=;
        b=lO1d6jyaMhQtRpC6Q6rpr/+nNMsVXAO9o+/jwg8BoCnK0jSFGoDbUpi0wFrfJ4Tg+CqLbW
        /mEzwKUBCNEFCcm0/ElK9GSWpTIorKFrfWkzfH4Aixo+U4UJn8La/QGrY8twqtB/qH8EbT
        rJtzF07IrJcNF0FARrPEGSjTf0j2TxQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 22 Mar 2021 16:48:31 +0100
From:   Michael Walle <michael@walle.cc>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 1/2] mtd: spi-nor: sfdp: save a copy of the SFDP data
In-Reply-To: <0efba47de8737059b4f3c593c26297bf@walle.cc>
References: <20210318092406.5340-1-michael@walle.cc>
 <20210318092406.5340-2-michael@walle.cc>
 <20210322142141.pd7ondg6l76idz7d@ti.com>
 <0efba47de8737059b4f3c593c26297bf@walle.cc>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <9690ceb44cb1a09c03e2ac16569f3c6d@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-03-22 16:32, schrieb Michael Walle:
>>> +
>>> +	sfdp->num_dwords = DIV_ROUND_UP(sfdp_size, sizeof(*sfdp->dwords));
>> 
>> The SFDP spec says that Parameter Table Pointer should be DWORD 
>> aligned
>> and Parameter Table length is specified in number of DWORDs. So,
>> sfdp_size should always be a multiple of 4. Any SFDP table where this 
>> is
>> not true is an invalid one.
>> 
>> Also, the spec says "Device behavior when the Read SFDP command 
>> crosses
>> the SFDP structure boundary is not defined".
>> 
>> So I think this should be a check for alignment instead of a round-up.
> 
> Well, that woundn't help for debugging. I.e. you also want the SFDP 
> data
> in cases like this. IMHO we should try hard enough to actually get a
> reasonable dump.
> 
> OTOH we also rely on the header and the pointers in the header. Any
> other ideas, but just to chicken out?

Oh, forgot to mention, sfdp_size is used to read the data. I just want
to make sure, the allocated area is large enough. We shouldn't hit the
undefined behavior by reading past the SFDP.

Maybe that check should be part of the parsing code.

-michael
