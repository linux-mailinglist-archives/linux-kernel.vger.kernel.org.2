Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9DCA30EE3A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 09:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234989AbhBDIRs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 4 Feb 2021 03:17:48 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:42326 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234979AbhBDIRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 03:17:40 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id EB9156083275;
        Thu,  4 Feb 2021 09:16:56 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id vGAdpr9ywbHg; Thu,  4 Feb 2021 09:16:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id A62D1627AFCA;
        Thu,  4 Feb 2021 09:16:56 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LfjoeOid8NwN; Thu,  4 Feb 2021 09:16:56 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 862466089E03;
        Thu,  4 Feb 2021 09:16:56 +0100 (CET)
Date:   Thu, 4 Feb 2021 09:16:56 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <429874131.360828.1612426616380.JavaMail.zimbra@nod.at>
In-Reply-To: <20210204091215.38ca0f99@xps13>
References: <1612410921-80984-1-git-send-email-jiapeng.chong@linux.alibaba.com> <20210204091215.38ca0f99@xps13>
Subject: Re: [PATCH] mtd: convert sysfs sprintf/snprintf family to
 sysfs_emit
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Topic: convert sysfs sprintf/snprintf family to sysfs_emit
Thread-Index: PU/qtLePlYN2al0TaSfCrYOqoCJsYg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
>> Fix the following coccicheck warning:
>> 
>> ./drivers/mtd/mtdcore.c: WARNING: use scnprintf or sprintf.
> 
> That's not what you do in the below change :)

Well, sysfs_emit() is the sysfs equivalent of scnprintf().
But the patch fails to explain *why* it is needed. 

Thanks,
//richard
