Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2223FE9C9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 09:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243112AbhIBHLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 03:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242504AbhIBHLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 03:11:30 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1F5C061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 00:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=wsEUpJDilSHKQhB8V4biJ9qqXdXIwzngZTn7EDF2jGE=;
        t=1630566632; x=1631776232; b=QTk7gxor1qd3aki0bN5ixnuRNBKDEvG6xMIp9MOWb4GUSJl
        nIOiNHAWdFsGkAqdjrTBC11h5Reln9QFEfyfXjazS2AaDH4kVuD7puFgQs6GcEI5s1YXWmx3iVdiG
        cvsbfj9Yy7dH1vhAkvJ68ZbUPs/azJk0jPOC5KWX5TSeXestGxntk+7yKeWsjLfRlSJIEkVZy5uiT
        VRlGur/LZLdMdFHSJKDxiiP9rIgWjYduch/w6Lt9jFj8NzaHnmv+hER1VQnZGni52lhxw5ex4qsmG
        +sWX/tAdBVzEpyWaZqUddy7wymSPdZZmObB7hsA3/XiS5phYiswIv2rmoo1vYPjw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mLgrd-001VVH-8J; Thu, 02 Sep 2021 09:10:21 +0200
Message-ID: <626cc3f828c2dab14cd66e8cac0c8ea84e7ba088.camel@sipsolutions.net>
Subject: Re: [PATCH] drm/r128: fix build for UML
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org
Date:   Thu, 02 Sep 2021 09:10:20 +0200
In-Reply-To: <20210902021721.27274-1-rdunlap@infradead.org>
References: <20210902021721.27274-1-rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-09-01 at 19:17 -0700, Randy Dunlap wrote:
> Fix a build error on CONFIG_UML, which does not support (provide)
> wbinvd(). UML can use the generic mb() instead.
> 
> ../drivers/gpu/drm/r128/ati_pcigart.c: In function ‘drm_ati_pcigart_init’:
> ../drivers/gpu/drm/r128/ati_pcigart.c:218:2: error: implicit declaration of function ‘wbinvd’ [-Werror=implicit-function-declaration]
>   wbinvd();
>   ^~~~~~
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2") # pre-git

Arguably, that could be

Fixes: 68f5d3f3b654 ("um: add PCI over virtio emulation driver")

because prior to that, Kconfig options depending on PCI couldn't be
selected on ARCH=um.

johannes

