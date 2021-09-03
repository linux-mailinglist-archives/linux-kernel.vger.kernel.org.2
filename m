Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFF83FFBD0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 10:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348299AbhICIVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 04:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348317AbhICIVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 04:21:32 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43893C061760
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 01:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=IsC4faQkZk61QCM7PdW0HuM61zrmJe+pfyyjTYohJBk=;
        t=1630657232; x=1631866832; b=QWv0XLuaRl95Kp+xhTjn7YtFeD9Dqnjnhjmle39P0WYtMl6
        WaAmEna9/JtXo9mzHV1bz4MGGJlqcloKIV4U7GrOMWiNLuv3BE3wpNe1A1L+UTZMBLn+0ZnZRHVml
        mHoiv+Q6YZrPYWvdoIv2bKI7U2B9sKM3V+EJ+6tkA4UKm0aJTTYyGOlfMIMPQl8EOPyOJT7dTOQpx
        qVTtQZ91U2/HyRVxNGml8YBJzupU4eWBDFSRQheqV5l0svTsUI39mWqGnzAVR47LuzY05rrgAj8QW
        oGODSFVpf9/h2gWId52XK/QeACed8f7sV6xvHOkWNFVB+a9RJitA3ZHdsuvUWh6g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mM4Qo-001zEd-Nu; Fri, 03 Sep 2021 10:20:15 +0200
Message-ID: <93705335a3e6dcdb56de601df566445aa5bcb28e.camel@sipsolutions.net>
Subject: Re: [PATCH -next] um: virt-pci: Fix the application of sizeof to
 pointer
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Yang Li <yang.lee@linux.alibaba.com>, jdike@addtoit.com
Cc:     richard@nod.at, anton.ivanov@cambridgegreys.com,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Fri, 03 Sep 2021 10:20:13 +0200
In-Reply-To: <1630655468-71684-1-git-send-email-yang.lee@linux.alibaba.com>
References: <1630655468-71684-1-git-send-email-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-09-03 at 15:51 +0800, Yang Li wrote:
> sizeof() when applied to a pointer typed expression gives the size of
> the pointer.
> 
> Clean up coccicheck warning:
> ./arch/um/drivers/virt-pci.c:192:20-26: ERROR: application of sizeof to
> pointer
> 

> -	memset(data, 0xff, sizeof(data));
> +	memset(data, 0xff, sizeof(*data));

Oops. I guess I only tested on 64-bit where this is the same, and in
fact on 32-bit it also wouldn't matter since you can't even do 64-bit
reads there :)

A Fixes: tag would be nice, but otherwise

Reviewed-by: Johannes Berg <johannes@sipsolutions.net>

johannes


