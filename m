Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEEC33B02B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 11:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbhCOKny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 06:43:54 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:53749 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhCOKne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 06:43:34 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 1C50A2223A;
        Mon, 15 Mar 2021 11:43:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1615805013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jCM+EVVq0CWc5+9HvUpHIQ1PrIbojDXOLOIwgPt/xc8=;
        b=wAVGM/qmN+S3ZAaoNfPf7QsBV3haTUQGT23CnQ000vPpFI9mzZD1zEz21yWWb3lpaN3wTq
        N/3Rvt4H7hjTn7hLiUIJtKe16qRx1Ze5hUUTJJQkpoxKq8DoHx4D6NtXn93DqwXCrewDRZ
        4yX7E9A0k8yjuTY4XLJ6JQkHKfjPcrQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 15 Mar 2021 11:43:32 +0100
From:   Michael Walle <michael@walle.cc>
To:     Tudor.Ambarus@microchip.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Subject: Re: [PATCH v4 2/4] mtd: spi-nor: implement OTP support for Winbond
 and similar flashes
In-Reply-To: <5f820284-8c48-e111-c46d-f53bb5ed17cb@microchip.com>
References: <20210306000535.9890-1-michael@walle.cc>
 <20210306000535.9890-3-michael@walle.cc>
 <5f820284-8c48-e111-c46d-f53bb5ed17cb@microchip.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <0ef810128e33f581d05ee394893e683d@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-03-15 09:31, schrieb Tudor.Ambarus@microchip.com:
> On 3/6/21 2:05 AM, Michael Walle wrote:
>> +       nor->dirmap.rdesc = NULL;
> 
> why can't we use dirmap?

Dirmap is used if the controller supports (transparent)
memory mapped access, right?

As you see I'm not familiar with that, nor does my
controller has support for it, well at least the driver,
the controller supports it actually.

But it also seems like how the flash is accessed is
set up in

   spi_nor_probe()
     spi_nor_create_read_dirmap()

And because the read opcode has to be changed, that isn't
possible.

Plese correct me if I'm wrong.

-michael
