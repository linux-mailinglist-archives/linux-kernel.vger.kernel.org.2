Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2AE032F737
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 01:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhCFAUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 19:20:18 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:47721 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbhCFAUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 19:20:09 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 05BDD22205;
        Sat,  6 Mar 2021 01:20:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1614990008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JW5vAf4n5pb2TjxCx8IeaoO6+tLJpPR88IxfEtpUY24=;
        b=gWaahd3QMzy5xCX+tyd7B+XCI4WN/jVVbRnTjCFmB2aKzIt+wlVJjFRtkZJdWWWmjTnE2o
        aOVVYjo7k0FNveBj/gWaOH3S+vXFIyuJ4Eu/rRL6Go9wlLDHPw/125IZD0GjGfjTRgYZPh
        vHqeMWYCxK+r6zO887gCmUl6Qe64Xuk=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 06 Mar 2021 01:20:06 +0100
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v4 4/4] mtd: spi-nor: implement OTP erase for Winbond and
 similar flashes
In-Reply-To: <20210306000535.9890-5-michael@walle.cc>
References: <20210306000535.9890-1-michael@walle.cc>
 <20210306000535.9890-5-michael@walle.cc>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <874f75d980a42abe8df19a9952f5aa5d@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-03-06 01:05, schrieb Michael Walle:
> Winbond flashes with OTP support provide a command to erase the OTP
> data. This might come in handy during development.
> 
> This was tested with a Winbond W25Q32JW on a LS1028A SoC with the
> NXP FSPI controller.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>

This should have had [RFC PATCH] in the subject. That got missing.

-michael
