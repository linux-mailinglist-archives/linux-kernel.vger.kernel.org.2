Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1609314584
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 02:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhBIBTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 20:19:44 -0500
Received: from mail.loongson.cn ([114.242.206.163]:56828 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230333AbhBIBTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 20:19:02 -0500
Received: from [10.130.0.193] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx7_LK4iFgkGUIAA--.10747S3;
        Tue, 09 Feb 2021 09:18:03 +0800 (CST)
Subject: Re: [PATCH] staging: fix ignoring return value warning
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Sascha Hauer <sha@pengutronix.de>
References: <1612689808-30985-1-git-send-email-tangyouling@loongson.cn>
 <20210208134517.GG2696@kadam> <20210208150618.GI8233@pengutronix.de>
 <20210208190237.GN20820@kadam>
Cc:     devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org
From:   Youling Tang <tangyouling@loongson.cn>
Message-ID: <13779748-ab8e-c7c3-11e4-5232836f5ae6@loongson.cn>
Date:   Tue, 9 Feb 2021 09:18:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20210208190237.GN20820@kadam>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9Dx7_LK4iFgkGUIAA--.10747S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw1rAr1UWF4UtrWrJw1UWrg_yoW8Ar4fpa
        y0kFyjkFZ8tF4UKan0vw40v3WYy3srK348uFnYyw18u345XFyftr4UtrW5Ww15K34SkF1Y
        yFWUXa4jqa4DZFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487
        MxkIecxEwVAFwVWkMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
        0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
        tVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
        CY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf
        9x07b51v-UUUUU=
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Dan


On 02/09/2021 03:02 AM, Dan Carpenter wrote:
> On Mon, Feb 08, 2021 at 04:06:18PM +0100, Sascha Hauer wrote:
>> Hi Dan,
>>
>> On Mon, Feb 08, 2021 at 04:45:17PM +0300, Dan Carpenter wrote:
>>> On Sun, Feb 07, 2021 at 05:23:28PM +0800, Youling Tang wrote:
>>>> Fix the below ignoring return value warning for device_reset.
>>>>
>>>> drivers/staging/mt7621-dma/mtk-hsdma.c:685:2: warning: ignoring return value
>>>> of function declared with 'warn_unused_result' attribute [-Wunused-result]
>>>>          device_reset(&pdev->dev);
>>>>          ^~~~~~~~~~~~ ~~~~~~~~~~
>>>> drivers/staging/ralink-gdma/ralink-gdma.c:836:2: warning: ignoring return value
>>>> of function declared with 'warn_unused_result' attribute [-Wunused-result]
>>>>          device_reset(&pdev->dev);
>>>>          ^~~~~~~~~~~~ ~~~~~~~~~~
>>>>
>>> We can't really do this sort of fix without the hardware to test it.
>>> This could be the correct fix or perhaps switching to device_reset_optional()
>>> is the correct fix.  We can't know unless we have the hardware to test.
>> When device_reset() is the wrong function then adding a return value
>> check will turn this into a runtime error for those who have the
>> hardware which will hopefully trigger them to tell us why reset_device
>> is wrong for them.
>> At least for a staging driver I find this procedure opportune.
>>
> That seems like sort of a jerk move...  What's the rush?  Someone will
> eventually be able to test this if we just wait around for a bit.
> Otherwise if no one has the hardware then eventually the driver will be
> deleted.
>
> regards,
> dan carpenter
We do not have the relevant hardware to test, this is just to solve a
compile-time warning.

Thanks,
Youling.

