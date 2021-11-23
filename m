Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B79F145A450
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 15:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234867AbhKWOEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 09:04:21 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:47671 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234163AbhKWOET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 09:04:19 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 45A4E22175;
        Tue, 23 Nov 2021 15:01:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1637676070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xsVVJ9IgbGCSjuveXkfALvgXLimlp1wqns8vX3ov7SE=;
        b=iJjECdFeGoMNs4OTlEDhnquq+u55uGZuorKXxXe01rg8RKmu9eceZmnKxQkGuvQT6uPerZ
        dzTNJ4l9gu5W/OHBLkpDVZnjSROH2vVyRzBS+WJPlQVaeMg8DVz8OgPcaORZycb99AtkbI
        danKd/aeuxgyRub0PiCo3yAHGHFe5xk=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 23 Nov 2021 15:01:10 +0100
From:   Michael Walle <michael@walle.cc>
To:     Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc:     linux-mtd@lists.infradead.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spi-nor: mt25qu: Ignore 6th ID byte
In-Reply-To: <46f438c2-6f5f-645e-23b4-95216ec23ca3@nokia.com>
References: <20211119080402.20262-1-alexander.sverdlin@nokia.com>
 <9a158e2ef6635212c1e353590e3b773b@walle.cc>
 <1e133bc6-5edb-c4ce-ad44-3de77048acf2@nokia.com>
 <e9589af968d7b9dafbce17325dbf8472@walle.cc>
 <2bf37a35-1ccf-f4fa-c999-42b9154a2914@nokia.com>
 <88db136a146edf53801d86509b52d40f@walle.cc>
 <46f438c2-6f5f-645e-23b4-95216ec23ca3@nokia.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <06ce3d8eabd689f8755021d7ce08c3e0@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 2021-11-23 13:40, schrieb Alexander Sverdlin:
> On 23/11/2021 09:14, Michael Walle wrote:
>>> 
>>> Some people ask themselves why this table keeps growing if there is 
>>> SFDP...
>>> I see the point in fixups, but maybe at some point we will be able to 
>>> support
>>> some devices just out of the box?
>> 
>> Are these features detectable by SFDP? Without knowing anything, as 
>> you ignored
>> my former question, I'd say no.
> 
> Well, I just had nothing to say on your question.
> It wasn't my intention to study security features of a chip, which I 
> don't use.

Like I said, without that information its hard for me do decide if we 
can just
ignore that last byte. (And yes I've already tried to get that NDA PDF 
via $WORK,
but I don't have high hopes with that).

-michael
