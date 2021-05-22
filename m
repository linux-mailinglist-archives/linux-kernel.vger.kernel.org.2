Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E56138D334
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 05:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbhEVDNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 23:13:01 -0400
Received: from [43.250.32.171] ([43.250.32.171]:47136 "EHLO email.cn"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S231166AbhEVDM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 23:12:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=To:From:Date; bh=Y4Iznc8uey3NFWpAiLalqogEHdBBvUvSLJ2Ly
        Ff12Wo=; b=DmSDcd1PxHb78XvtBOkBisIZHsxDlIF22ZqVBaD4TiJju0bUAY9hs
        bXjNqFCi7KnAMYY+42sDIMJrW+4WC5CjjRc4Oi9EoNm/Xg0z1PdfVzfBIQ3hTci1
        VL6AguslE4yPPOWnsyx2jPQqvH/ZXL0mNhhIRL5QJvT4sQJR2uP9po=
Received: from [0.0.0.0] (unknown [113.251.14.223])
        by v_coremail2-frontend-1 (Coremail) with SMTP id LCKnCgCHTkFbdqhga983AA--.22407S3;
        Sat, 22 May 2021 11:11:26 +0800 (CST)
Subject: Re: [PATCH v2 1/2] docs/zh_CN: update a translation in
 zh_CN/dev-tools/gcov
To:     alexs@kernel.org, corbet@lwn.net, bobwxc@email.cn,
        maskray@google.com, bernard@vivo.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210522025545.57275-1-src.res@email.cn>
From:   Hu Haowen <src.res@email.cn>
Message-ID: <ca57cb65-807e-67ad-4345-e78f5e35910c@email.cn>
Date:   Sat, 22 May 2021 11:11:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210522025545.57275-1-src.res@email.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: LCKnCgCHTkFbdqhga983AA--.22407S3
X-Coremail-Antispam: 1UD129KBjvdXoWrZFW5trW8XF48JrWftr4Dtwb_yoWDKrg_Gw
        s7WF4vyF9xJry2gr4Fyrn5Jr4fZF4Fkw1kArs0y398Jw13W397Ga4DX3s5XFW3WFWa9rW3
        CFZ3ZrySqwnFyjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbrkFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWUJVWUGwA2ocxC64kI
        II0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7
        xvwVC0I7IYx2IY6xkF7I0E14v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2
        z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
        8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VWxJr1UJwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0xIA0c2IEe2xFo4
        CEbIxvr21l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VWxJr1UJwCFx2IqxVCF
        s4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
        1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
        JVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r
        1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1U
        YxBIdaVFxhVjvjDU0xZFpf9x0Jj-VyxUUUUU=
X-Originating-IP: [113.251.14.223]
X-CM-SenderInfo: hvufh21hv6vzxdlohubq/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/5/22 上午10:55, Hu Haowen wrote:
> The original file has added some words in commit c797997a244cd2c58908
> ("Documentation: dev-tools: Add Testing Overview"), hence update the
> Chinese translation of them.
>
> Signed-off-by: Hu Haowen <src.res@email.cn>
> ---
>   Documentation/translations/zh_CN/dev-tools/index.rst | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/translations/zh_CN/dev-tools/index.rst b/Documentation/translations/zh_CN/dev-tools/index.rst
> index fd73c479917b..7ba02fc392a6 100644
> --- a/Documentation/translations/zh_CN/dev-tools/index.rst
> +++ b/Documentation/translations/zh_CN/dev-tools/index.rst
> @@ -11,6 +11,9 @@
>   目前这些文档已经整理在一起，不需要再花费额外的精力。
>   欢迎任何补丁。
>   
> +有关测试专用工具的简要概述，参见
> +Documentation/dev-tools/testing-overview.rst
My fault, here is supposed to be Chinese translations. Correcting it.
> +
>   .. class:: toc-title
>   
>   	   目录

