Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 578ED354EEF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 10:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244537AbhDFIrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 04:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244528AbhDFIrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 04:47:39 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E01C061756
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 01:47:32 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id DFEE822235;
        Tue,  6 Apr 2021 10:47:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1617698850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RZRoz8Ro0cCt7fIaCtvweHH5BnfiGQ6TA020rkhXs0Y=;
        b=jefZUP9IZoBTB8Uw1AVCKrV+CRyKkrLi/+JRybG+G7ykggqy5N6iJROLp+P5El5cIasfjk
        lzyfmEn9XVfWe9ZPrvuorL1aWqtz/JDgSVN+jgzdzinZQ1Adzi+7XmOUcF0zPOcpJuC8QM
        3GaouHHEo31VSVIYSS9t58VGhbpcctE=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 06 Apr 2021 10:47:29 +0200
From:   Michael Walle <michael@walle.cc>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH 2/2] mtd: spi-nor: add initial sysfs support
In-Reply-To: <658af7ad-c4ee-1c25-b51b-1f66b657aade@ti.com>
References: <20210318092406.5340-1-michael@walle.cc>
 <20210318092406.5340-3-michael@walle.cc>
 <658af7ad-c4ee-1c25-b51b-1f66b657aade@ti.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <4f1de957288118d5a627027ec4c37973@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 2021-04-06 09:56, schrieb Vignesh Raghavendra:
> Hi,
> 
> On 3/18/21 2:54 PM, Michael Walle wrote:
>> Add support to show the name and JEDEC identifier as well as to dump 
>> the
>> SFDP table. Not all flashes list their SFDP table contents in their
>> datasheet. So having that is useful. It might also be helpful in bug
>> reports from users.
>> 
> 
> Sorry for the delay..
> 
> There is already debugfs support for dumping JEDEC ID [1]. Any reason 
> to
> add sysfs entry as well?

This is per mtd while the sfdp is per flash device. IMHO both should
be at the same place.

> That brings up another question. Since SFDP dumps are more of a debug
> aid, should this be a debugfs entry rather than sysfs entry?

And you're not the first one asking that. My argument was that the
debugfs might not be available just when you need it. A developer
could easily rebuild a kernel, but imagine some user with a COTS
distro and some problems, then it is not that easy anymore. But
thats your call to make.

> Note that sysfs entries are userspace ABIs just like syscalls and thus
> need to be documented in Documentation/ABI/testing/ or
> Documentation/ABI/stable. Thus need to be carefully designed compared 
> to
> debugfs which are much more flexible.

Ok. But I don't see a problem adding these read-only files
  /sfdp
  /name
  /jedec-id

Do you?

-michael
