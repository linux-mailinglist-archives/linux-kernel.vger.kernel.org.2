Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23E7732E760
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 12:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbhCELqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 06:46:04 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:32630 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbhCELpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 06:45:31 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20210305114529euoutp02813d4d08d9e0492733dd0d8082183208~pb6zw4Z-G0954009540euoutp022
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 11:45:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20210305114529euoutp02813d4d08d9e0492733dd0d8082183208~pb6zw4Z-G0954009540euoutp022
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1614944729;
        bh=cBiZ7BIddAMyZQfCLI4R7wu/mBj4ssj4hyt8wwdMNKY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ii24ZpnwiObTgI+VCV1BblJqLAf05RC/vVxEc5IqSvVmHcsVlNaBprr70BYmK/XaK
         qjuv3u9S8f8n5wOzq5TqtAlr3dC2TPDHXrMnMW8Hmwo1bUtYNEk3EMIrdURoBUmAor
         +6fX1pEaQ1Xj/uTM0w/LaLxKYy5yMh6XhuwAzZzk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210305114529eucas1p1899a56f1c3cc9d4b0b68984678f0729b~pb6zYjmyb1216212162eucas1p11;
        Fri,  5 Mar 2021 11:45:29 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id D8.CB.44805.9D912406; Fri,  5
        Mar 2021 11:45:29 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210305114529eucas1p1b2019df75b2c9ba3fa741b20dca936b0~pb6y38toi1217212172eucas1p14;
        Fri,  5 Mar 2021 11:45:28 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210305114528eusmtrp2863f4bde178ab84daa1014059086a049~pb6y3NV0t1749917499eusmtrp2B;
        Fri,  5 Mar 2021 11:45:28 +0000 (GMT)
X-AuditID: cbfec7f4-b4fff7000000af05-3b-604219d9a83e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 08.BF.16282.8D912406; Fri,  5
        Mar 2021 11:45:28 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210305114528eusmtip291fe6fbe2d0c3aee30b6ee3bb8184318~pb6yNNM8-1157111571eusmtip2W;
        Fri,  5 Mar 2021 11:45:28 +0000 (GMT)
Subject: Re: [PATCH v3] amba: Remove deferred device addition
To:     Saravana Kannan <saravanak@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Rob Herring <robh@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <30b4141e-11bd-45a2-b890-fddf444548ea@samsung.com>
Date:   Fri, 5 Mar 2021 12:45:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210304195101.3843496-1-saravanak@google.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOKsWRmVeSWpSXmKPExsWy7djPc7o3JZ0SDBb/EbeYO3sSo8WZ37oW
        O7aLWEz5s5zJ4vKuOWwWh6buZbTYNms5m8XdeydYLP7v2cFu0XXoL5vF8lM7WCyOrw134PHY
        tnsbq8eaeWsYPS5fu8jsMfGsrseCTaUem1Z1snncubaHzaP/r4HH5tPVHp83yQVwRXHZpKTm
        ZJalFunbJXBl9G1ZylywTKTi+6NPjA2MBwS6GDk5JARMJG41nGTqYuTiEBJYwSix98spti5G
        DiDnC6PEhyKI+GdGie+Lj7PBNBy51cgKkVjOKHHi8Sx2COcjo8TFs7PBqoQFbCXe7X/OCGKL
        CFRJHL52CcxmFrjDJDF/GSeIzSZgKNH1tgusnlfATmL7nJVgNSwCKhIr16xjBrFFBZIk/v6+
        yQRRIyhxcuYTFpDrOAVsJN7fD4EYKS+x/e0cZghbXOLWk/lg30gIzOeUuDXhETPE1S4S7Q0f
        2SFsYYlXx7dA2TIS/3fCNDQzSjw8t5YdwulhlLjcNIMRospa4s65X+BwYRbQlFi/Sx8i7Cix
        7/5zZpCwhACfxI23ghBH8ElM2jYdKswr0dEmBFGtJjHr+Dq4tQcvXGKewKg0C8lns5C8MwvJ
        O7MQ9i5gZFnFKJ5aWpybnlpslJdarlecmFtcmpeul5yfu4kRmNZO/zv+ZQfj8lcf9Q4xMnEw
        HmKU4GBWEuG1veeYIMSbklhZlVqUH19UmpNafIhRmoNFSZw3acuaeCGB9MSS1OzU1ILUIpgs
        EwenVANT0N7IOxzuHT90f6jd18hQSBaL59Q4ePzKHLUHf3+lNRvKvhB7zM0X/rL4qfcl2fnP
        Dm+UeGE18xrjtiuTU43mPJpQbm10NuNY11QF3z2HUtL1K/m1N626f/lE3sro1SdsHrG/2/Fe
        SH7mqceK3SbrrX+dVuqfJryCp4qD08OoiUkwzuOooMUmlT1CbI3d9ZlNohrr96jKsdx4Mq1e
        5fiHRqWI2L9W+n3eHo+ul7zIrKpxfTj/7fzz0j4vs1/8bXK+dpXriHFVY3tjnZvZh18P3WUL
        4xhWfWlQeP3LTvGl1UPG/b0HrmcxTlm6zFePTydi063wenvX+1XhKztnxqxp+neM++pHS9+n
        V9IX3S5WYinOSDTUYi4qTgQAVHA8Q9oDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsVy+t/xe7o3JJ0SDHqOmFjMnT2J0eLMb12L
        HdtFLKb8Wc5kcXnXHDaLQ1P3Mlpsm7WczeLuvRMsFv/37GC36Dr0l81i+akdLBbH14Y78Hhs
        272N1WPNvDWMHpevXWT2mHhW12PBplKPTas62TzuXNvD5tH/18Bj8+lqj8+b5AK4ovRsivJL
        S1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQy+rYsZS5YJlLx
        /dEnxgbGAwJdjJwcEgImEkduNbJ2MXJxCAksZZQ42LqdCSIhI3FyWgMrhC0s8edaFxtE0XtG
        iU1TvzCDJIQFbCXe7X/OCGKLCFRJ3P62CayIWeAOk8SW6U1g3UIC/YwSh+/wgdhsAoYSXW9B
        JnFy8ArYSWyfsxKsmUVARWLlmnVgQ0UFkiTWT7/JBFEjKHFy5hOWLkYODk4BG4n390NAwswC
        ZhLzNj9khrDlJba/nQNli0vcejKfaQKj0Cwk3bOQtMxC0jILScsCRpZVjCKppcW56bnFRnrF
        ibnFpXnpesn5uZsYgbG87djPLTsYV776qHeIkYmD8RCjBAezkgiv7T3HBCHelMTKqtSi/Pii
        0pzU4kOMpkDvTGSWEk3OByaTvJJ4QzMDU0MTM0sDU0szYyVxXpMja+KFBNITS1KzU1MLUotg
        +pg4OKUamDLm7JPpnhRdsWpumhgD8wGdcztmtK1vzawILn4WIZbgYcKj1NH58s3VmDObUryn
        V9TvnKxxY+aysK1vfxSezMgQm5jxuaqzbtFGDXPrnRqLbtv8Pyt0NeVp98PUU/uO2ec8VV8f
        Z87z59XKYnGOjUrG2/SXLXhrmrvEVfFpXBxrbX2ezUYxlTPtDcs2J7G2Xb66hFv5PGtBcvCM
        FNvVXktvJi6aubHd+chjD1t9TdN3FnWWDnynj+suOTlpbZLHRDWpu2wMNxMMonvePvsmbhl+
        MNKxee9sBv5l5bqOrxeszZt6/3S+3Bv3i0tvz2403jA3MvlIhPZ+zevqMbrSH/0L2hO6M7e3
        pRr1M76YrsRSnJFoqMVcVJwIAJSqd5tuAwAA
X-CMS-MailID: 20210305114529eucas1p1b2019df75b2c9ba3fa741b20dca936b0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20210304195109eucas1p1779060378305d0f9a1eb0c7ddefd1db3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210304195109eucas1p1779060378305d0f9a1eb0c7ddefd1db3
References: <CGME20210304195109eucas1p1779060378305d0f9a1eb0c7ddefd1db3@eucas1p1.samsung.com>
        <20210304195101.3843496-1-saravanak@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

On 04.03.2021 20:51, Saravana Kannan wrote:
> The uevents generated for an amba device need PID and CID information
> that's available only when the amba device is powered on, clocked and
> out of reset. So, if those resources aren't available, the information
> can't be read to generate the uevents. To workaround this requirement,
> if the resources weren't available, the device addition was deferred and
> retried periodically.
>
> However, this deferred addition retry isn't based on resources becoming
> available. Instead, it's retried every 5 seconds and causes arbitrary
> probe delays for amba devices and their consumers.
>
> Also, maintaining a separate deferred-probe like mechanism is
> maintenance headache.
>
> With this commit, instead of deferring the device addition, we simply
> defer the generation of uevents for the device and probing of the device
> (because drivers needs PID and CID to match) until the PID and CID
> information can be read. This allows us to delete all the amba specific
> deferring code and also avoid the arbitrary probing delays.
>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Saravana Kannan <saravanak@google.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>
> v1 -> v2:
> - Dropped RFC tag
> - Complete rewrite to not use stub devices.
> v2 -> v3:
> - Flipped the if() condition for hard-coded periphids.
> - Added a stub driver to handle the case where all amba drivers are
>    modules loaded by uevents.
> - Cc Marek after I realized I forgot to add him.
>
> Marek,
>
> Would you mind testing this? It looks okay with my limited testing.

It looks it works fine on my test systems. I've checked current 
linux-next and this patch. You can add:

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

I've briefly scanned the code and I'm curious how does it work. Does it 
depend on the recently introduced "fw_devlink=on" feature? I don't see 
other mechanism, which would trigger matching amba device if pm domains, 
clocks or resets were not available on time to read pid/cid while adding 
a device...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

