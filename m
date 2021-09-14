Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC87940A994
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 10:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhINItv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 04:49:51 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21]:47164 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229526AbhINItt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 04:49:49 -0400
Received: from localhost.localdomain (unknown [124.16.138.128])
        by APP-01 (Coremail) with SMTP id qwCowAB3+djKYUBh329+AA--.35697S2;
        Tue, 14 Sep 2021 16:48:10 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org
Subject: Re:Re:[PATCH 6/6] irq: Potentially 'offset out of size' bug
Date:   Tue, 14 Sep 2021 08:48:10 +0000
Message-Id: <1631609290-2830831-1-git-send-email-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: qwCowAB3+djKYUBh329+AA--.35697S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JFyxuFy7tw45KFWfKF1rJFb_yoW3Crc_WF
        yvqr15tFZ5Gwn5Xa1DKr4UA343tF45Cryavrs5Jw4fu34xWrZrZr1UAasY9r43J3yDtFn8
        G34vkF47Za429jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb7xYjsxI4VWxJwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
        w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMc
        vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY02Avz4vE14v_GFyl42xK82IY
        c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0x
        vE42xK8VAvwI8IcIk0rVW8JVW3JwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jF38nUUUUU=
X-Originating-IP: [124.16.138.128]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Sep 10 2021 at 03:26, Jiasheng Jiang wrote:
> The find_next_bit() use nr_irqs as size, and using it without
> any check might cause its returned value out of the sizei

On Fri, Sep 10 2021 at 18:28, tglx wrote:
> Why exactly is this a problem? The return value has to be checked at the
> call site anyway.

There is really a check at the call site, but the annotation of the 
irq_get_next_irq() is 'Returns next irq number after offset or nr_irqs 
if none is found', which tells the programmer should not check the
return value of it. In case of a programmer write a new call for the
irq_get_next_irq(), he may not check the return value because of the 
annotation said. Therefore, it had better to add the check inside of
irq_get_next_irq() to fit for the annotation.

Thanks,

        Jiasheng Jiang

