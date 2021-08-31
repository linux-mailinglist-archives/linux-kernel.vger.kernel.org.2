Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70DAE3FC655
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 13:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241289AbhHaLDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 07:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239606AbhHaLDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 07:03:24 -0400
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050::465:103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E055CC061575;
        Tue, 31 Aug 2021 04:02:28 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [80.241.60.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4GzPR42l6zzQk9k;
        Tue, 31 Aug 2021 13:02:24 +0200 (CEST)
Received: from hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172])
        by smtp202.mailbox.org (Postfix) with ESMTP id 055C3353;
        Tue, 31 Aug 2021 13:02:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gorani.run; s=MBO0001;
        t=1630407742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AFtP0SZ/TdIJGAu7wx7JpHy0mfa2Py8L4R4PbyzOE9w=;
        b=0JpVxrWdAY0ClDyJiZBUcRqALDn9x2pxolPxoLNpL4OZTY0q2pMbd58QII7TkZNzNcMsEi
        6GiP/VtUDGDyL4BEvMF8Bk3FQirhKoGLOVWu2KHSQk47Qis2aYpaYnXNMCgeDwovT7/bN3
        hZTWR2NGczB1Stxsxq2qfHWklomTzuNmEixLMSy7VoVEzacRerPYL7GaU+uZXciOnFdY9l
        h8JHgHgFWrWOx7pputohTeLt1GXY0mODTNldGQ3PunQVHbhK66OZM2nr99xwNyxiOY6UMn
        2/uBjinxXLAJeTNfjlpR4u9UcihELf/DC9jFtl3E7VEfoH6X6SwDGJKIIm+srQ==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp202.mailbox.org ([80.241.60.245])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id 3e6XqoWYfo9i; Tue, 31 Aug 2021 13:02:20 +0200 (CEST)
Received: from localhost (unknown [211.58.59.88])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp202.mailbox.org (Postfix) with ESMTPSA id 1EC6F267;
        Tue, 31 Aug 2021 13:02:15 +0200 (CEST)
Subject: Re: [PATCH v4 1/2] arm: dts: mt7623: add musb device nodes
To:     frank-w@public-files.de, linux-mediatek@lists.infradead.org,
        =?UTF-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>
Cc:     "b-liu@ti.com" <b-liu@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
References: <20210822041333.5264-1-mans0n@gorani.run>
 <20210830155903.13907-1-mans0n@gorani.run>
 <20210830155903.13907-2-mans0n@gorani.run>
 <16f980b95e1f32bb8eb32448f1615bafdc51b792.camel@mediatek.com>
 <14C40B35-3607-49C6-970B-441F9093125A@public-files.de>
From:   Sungbo Eo <mans0n@gorani.run>
Message-ID: <3d57ae38-9d8f-05e3-c5b3-58db73879f16@gorani.run>
Date:   Tue, 31 Aug 2021 20:02:10 +0900
MIME-Version: 1.0
In-Reply-To: <14C40B35-3607-49C6-970B-441F9093125A@public-files.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 055C3353
X-Rspamd-UID: 2b5930
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-31 17:59, Frank Wunderlich wrote:
> Am 31. August 2021 08:27:18 MESZ schrieb "Chunfeng Yun (云春峰)" <Chunfeng.Yun@mediatek.com>:
> 
>> Is the dt-binding patch applied? 
>> It's better to put it into this series due to the new
>> compatible "mediatek,mt7623-musb" is used for the first time.
>>
>> Reviewed-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> 
> Hi,
> 
> I don't see [1] (ack from rob) in [2]/[3]

You can find it here.
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/log/?h=usb-next

> 
> @sungbo: please leave dt-bindings patch in series.

I'll keep it for a while, then.

> You need no new version only for adding tags (acked,tested or reviewed).
> Only for code-changes,but then add tags from previous versions.

Got it. Thanks for the tip. :)

> 
> Imho it is better to take my musb patch [4]
> into the series as well to make depency cleaner

Okay, I'll take it in the next version.

Thanks.

> 
> [1] https://patchwork.kernel.org/project/linux-mediatek/patch/20210808123840.176738-2-mans0n@gorani.run/
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git/log/?h=for-next
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/log/?h=for-next
> [4] https://patchwork.kernel.org/project/linux-mediatek/patch/20210830145958.108605-1-linux@fw-web.de/
> regards Frank
> 
