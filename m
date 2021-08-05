Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8149E3E0C22
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 03:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237703AbhHEBhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 21:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234640AbhHEBhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 21:37:12 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEFEC061765;
        Wed,  4 Aug 2021 18:36:58 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4GgB6d48lDzQk3V;
        Thu,  5 Aug 2021 03:36:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gorani.run; s=MBO0001;
        t=1628127415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7fIs68ssLG5+hEm5E5iV7zpAj7/6ONqn6FWiNVUPIhg=;
        b=R8biJ9Rjg141WlHgICdlt4pPtmWtlE11HrCDZlrDlAUhat/K+fN1ruH9ti1gY1lmUv/503
        mCUvUyEnD/MjXfvLPO7rCF3niM/VYL4Xn6j3zCzZympTanDnvIg9GyF8tU0E108WSqwO/A
        98fgqSKY4V5TAoozDXqiiAF+hVaSPzDvhv2qq22frS/KBihyTJj99eWYmGqN05vTk5koLM
        KApKgU35c0GYYWZichbShD2v9KaOdXp5PV2lt+HSTuRbG7JlqxfkkEJDs9e/l461RZUDQx
        C0SZce8t42NVQ/3Z9lIyw1PYgagr0doi96ZXzpJmCccT7cemeWXdzwlS1eIgIA==
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de [80.241.56.125]) (amavisd-new, port 10030)
        with ESMTP id qU8BpQ4RqCOB; Thu,  5 Aug 2021 03:36:54 +0200 (CEST)
Subject: Re: [PATCH 0/2] Add MUSB for MT7623
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Min Guo <min.guo@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210803151320.71531-1-mans0n@gorani.run>
 <638a4526-2688-e7c6-c71e-0ebaaeb773b5@gmail.com>
From:   Sungbo Eo <mans0n@gorani.run>
Message-ID: <77ec6aa3-95b8-3328-1587-ca4eaa4c1ef1@gorani.run>
Date:   Thu, 5 Aug 2021 10:36:46 +0900
MIME-Version: 1.0
In-Reply-To: <638a4526-2688-e7c6-c71e-0ebaaeb773b5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 625661823
X-Rspamd-UID: 19b2d8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,
Thanks for your kind review.

On 2021-08-05 00:01, Matthias Brugger wrote:
> Hi Sungbo,
> 
> On 03/08/2021 17:13, Sungbo Eo wrote:
>> These patches add support for the MUSB controller on Mediatek MT7623.
>> Tested on Mercury RUSH-318AC Wi-Fi router.
>>
> 
> Nice to see you are working on Mediatek devices.
> Are you planning to add the device tree for the router to the kernel? I'd be
> happy to see them submitted.

Actually I've never thought about it.
My router device is not for public sale, and the device might have been
locked up in recent versions, so I don't think anyone can ever use it
for that specific model.
Come to think of it, I've tried another model before, which is more in
public, I might submit its device tree if it gets ready someday.

Thanks.

> 
> Regards,
> Matthias
> 
>> I got to know this from a BPI-R2 forum post [1], and managed to make it work on OpenWrt snapshot.
>> I'd like to know if this also works on BPI-R2, I can happily share the details if needed.
>> And I've just copy & pasted nodes from mt2701, please let me know if I missed some big differences between SoCs...
>>
>> [1] http://forum.banana-pi.org/t/bpi-r2-otg-port/10551
>>
>> Sungbo Eo (2):
>>   dt-bindings: usb: mtk-musb: add MT7623 compatible
>>   arm: dts: mt7623: add musb device nodes
>>
>>  .../bindings/usb/mediatek,musb.yaml           |  1 +
>>  arch/arm/boot/dts/mt7623.dtsi                 | 34 +++++++++++++++++++
>>  arch/arm/boot/dts/mt7623a.dtsi                |  4 +++
>>  3 files changed, 39 insertions(+)
>>
