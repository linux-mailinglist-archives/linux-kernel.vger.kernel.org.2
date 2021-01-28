Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4FF0307F88
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 21:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbhA1UYQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 28 Jan 2021 15:24:16 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:47986 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbhA1UYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 15:24:12 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 036DC6083270;
        Thu, 28 Jan 2021 21:23:30 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id wydx1ZZ3JqXG; Thu, 28 Jan 2021 21:23:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 8E6986083271;
        Thu, 28 Jan 2021 21:23:29 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nM_5qrai2wzW; Thu, 28 Jan 2021 21:23:29 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 6A9DA6083270;
        Thu, 28 Jan 2021 21:23:29 +0100 (CET)
Date:   Thu, 28 Jan 2021 21:23:29 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Tomas Winkler <tomas.winkler@intel.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1363048722.339069.1611865409332.JavaMail.zimbra@nod.at>
In-Reply-To: <10c2e98c393a486cab3bc953e9926e38@intel.com>
References: <20210127200319.662842-1-tomas.winkler@intel.com> <c8d0f22c5fdf443cb8dda1f996b148d9@intel.com> <1776363776.325713.1611782270873.JavaMail.zimbra@nod.at> <a6cb6eb10bbb48989d3a9e087951e50e@intel.com> <1665542284.336646.1611820031174.JavaMail.zimbra@nod.at> <f91d7eff1d764ba7b47f023bc0fafacb@intel.com> <20210128100032.5eb542c6@xps13> <10c2e98c393a486cab3bc953e9926e38@intel.com>
Subject: Re: [PATCH] mtd: use refcount to prevent corruption
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Topic: use refcount to prevent corruption
Thread-Index: AQHW9OeD00Da249Jw0qJn6+VIZAeUao7z7AAgAAh5BBxoBSOfPxzntFAEGBJdu//fSiMQP//4NkAAA+XK+AnHY02HQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas,

----- Ursprüngliche Mail -----
>> As Richard was saying, we are really open to enhance MTD refcounting.
>> 
>> However, the issue you are facing is, IMHO, not related to MTD but to MFD.
>> There should be a way to avoid MFD to vanish by taking a reference of it
>> through mtd->_get_device(). I don't think addressing the case where MFD
>> vanishes while MTD (as a user) is still active is the right approach.
> 
> I think it won't work because MFD sub-driver remove() is called   and it must
> succeed because the main device  is not accessible unlike glueubi which just
> returns -EBUSY.

Well, the trick in glubi (and other MTDs with "hotplug" support) is not to reject
removal of the sub-device. ->_put_device() is of return type void.
The key is grabbing a reference on the sub-device in ->_get_device() such that
the layer below doesn't even try to remove while the MTD is in use.

> so we postpone the mtd unregister to  mtd_info->_put_device()  but it that state
> we have nothing to hold
> on as the device is gone in remove()
> User will fail anyway, as the underlying device is not functional in that state.
> Anyway I've tried your suggestion, the kernel is crashing, hope I haven't done
> some silly bug.

Can you point us to the affected code?
This would help a lot to understand the issue better.
I'm sure we can find a solution.

Thanks,
//richard
