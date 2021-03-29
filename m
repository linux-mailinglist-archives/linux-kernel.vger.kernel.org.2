Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7544234D38E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 17:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbhC2PQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 11:16:35 -0400
Received: from m32-153.88.com ([43.250.32.153]:27034 "EHLO email.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230347AbhC2PQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 11:16:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=Date:From:To; bh=hThKDuBMyA+jQcLmsLmdL2nPUseEOjn9tZEmy
        ak3skg=; b=jshfYw1OKwsAB7P2VPftL47H6VIKNHfbESyrTBQXFCXGHJ/p+MBld
        ZMSId9xsyisQlfcDiaZ7cX9wSZo08m9xFJ61DJ0RmdEwbLUuRLGx54Qv4W+OrfM4
        FERl8cb9JJ/pMGDgo53VrHlAsqPvIX+LXcqUZhEMFFAx7lRMDFOnWc=
Received: from mipc (unknown [120.238.248.129])
        by v_coremail2-frontend-2 (Coremail) with SMTP id GiKnCgAHkyMp72FgUiNPAA--.53608S2;
        Mon, 29 Mar 2021 23:15:55 +0800 (CST)
Date:   Mon, 29 Mar 2021 23:15:53 +0800
From:   Wu XiangCheng <bobwxc@email.cn>
To:     Alex Shi <alex.shi@linux.alibaba.com>, Alex Shi <alexs@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Harry Wei <harryxiyou@gmail.com>,
        Weiwei Jia <harrynjit@gmail.com>, Fu Wei <wefu@redhat.com>,
        Li Yang <leoyang.li@nxp.com>,
        Linux-Doc <linux-doc@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>
Subject: [PATCH] doc/zh_CN: Clean zh_CN translation maintainer
Message-ID: <20210329151551.GA10901@mipc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CM-TRANSID: GiKnCgAHkyMp72FgUiNPAA--.53608S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF1DKF4xAw4xZr43Cw48WFg_yoW8CFy7pF
        WrKr1fGF93t3WjyF48Kw4av3W09F97Gw47X39rtwn0yFn2ya1vqFW3K3sIgr1vqF4rWF4F
        kanI9FyFkayYyrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUg2b7Iv0xC_Zr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
        cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
        v20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzx
        vE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VCjz48v1sIEY20_Cr1U
        Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkIecxEwVAFwVW5WwCF04k20x
        vY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26F4UJr1UMxC20s026xCaFVCjc4AY6r1j6r4U
        MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67
        AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0
        cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z2
        80aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI
        43ZEXa7IUjBOJUUUUUU==
X-Originating-IP: [120.238.248.129]
X-CM-SenderInfo: pere453f6hztlloou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove Harry Wei and <xiyoulinuxkernelgroup@googlegroups.com> from
MAINTAINERS Chinese Translation.

According to git logs, Harry Wei (aka WeiWei Jia)
* last submitted at 2012-05-07
commit a9e73211fb0f ("Fix a mistake sentence in the file 'Documentation/zh_CN/magic-number.txt'")
* last Reviewed-by at 2016-02-16
commit 45c73ea7a785 ("Documentation: Chinese translation of arm64/silicon-errata.txt")
* last Signed-off-by at 2019-03-13 (pick by Alex Shi)
commit 95dcdb6e125f ("docs/zh_CN: rename magic-numbers as rst doc")

According to mail list archives, Harry Wei
* last replied at 2016-02-15
<https://lore.kernel.org/lkml/CAD+1EGPFdoD7HHZYfEWVvmesXXG27n=6KmEZ8=B6nrvb+oaLZA@mail.gmail.com/>
* last appeared at 2018-05-12
<https://lore.kernel.org/lkml/CA+scX6kYH8Y9_f1PLcMHG-MD9bhXgd4gGpkJanjzvwwj9L=aOQ@mail.gmail.com/>

He/She did not maintain zh_CN translations for a long time.
<xiyoulinuxkernelgroup@googlegroups.com> is a maillist for Linux group of
Xi'an University of Posts and Telecommunications, not special for zh_CN
translation work.

Anyway, many thanks him/her and Xiyou for their contributions to the early
Chinese translation work!

Signed-off-by: Wu XiangCheng <bobwxc@email.cn>
---
Hope I did not miss something.
If someone know Harry Wei want to come back, please reply this message
before pick up.

 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fb2a3633b719..178927f7e813 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4185,9 +4185,7 @@ S:	Maintained
 F:	scripts/checkpatch.pl
 
 CHINESE DOCUMENTATION
-M:	Harry Wei <harryxiyou@gmail.com>
 M:	Alex Shi <alex.shi@linux.alibaba.com>
-L:	xiyoulinuxkernelgroup@googlegroups.com (subscribers-only)
 S:	Maintained
 F:	Documentation/translations/zh_CN/
 
-- 
2.20.1

