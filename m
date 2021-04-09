Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAB835A896
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 00:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234966AbhDIWE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 18:04:28 -0400
Received: from mx.kolabnow.com ([95.128.36.40]:34494 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234932AbhDIWE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 18:04:26 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id 4AF2D40B5D;
        Sat, 10 Apr 2021 00:04:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        message-id:references:in-reply-to:subject:subject:from:from:date
        :date:content-transfer-encoding:content-type:content-type
        :mime-version:received:received:received; s=dkim20160331; t=
        1618005849; x=1619820250; bh=FEZ8XfP/C/s3g8U/Ca+1kTURK7HIFQDsrey
        PbmLxgvI=; b=KEvbED46Nzzg+zHqlRtDTjdqxabx8uUHB1oR4prVlCNid1pJZQ4
        M3Q3nV8GVfxRdnPfqsnlrtpFvlKQ+Y2XWcuHJXcpb1srAAN/JpcTq1bRm0zLKFJC
        ZggRnnnL6+NWHDG7o8b+xY9RqtwGrIl6XK+sZH3S70O8zZTO0Nkmq6vDGMOEdvAc
        gn18yOHfF33gTfCmHrA5lGFz68ZW4PKqXP4NzawOcHEpdDsbFPSHm1O7UthKAFrS
        ki0p6GmgH/608ut+QNnOphcaa0WWfGRLKcw+ks+193IqyIn3QrpiGYRmzT/bwsz4
        TzhmqUvVWEsFyJCPdHA/biH1wTG9PbgB5oo2OLG/GNmqxFxhI0sgkHEWDjIYJ6hD
        fu9gQLXIvTJwEVUgR/8prYsTbbnoGNE22GRHwbyBOCZjYMlnxzTLK6ztZ4BMwcUg
        S3T0jG28kg5e/9Fis5N6yBC5ahFq0OIJuv32K/dHb4f832qCm9QkY8PzFb/rWg/u
        fOMW0bAXxmA2+l9FPgtcFuBChCPDZmZcIllLWflfTyq5Q1NfcsxdS2l7EVg4CL0h
        2rbDztY55nCeX8iChK5bOnMFXgX7UdM0ksKGT4Rn0AZDqUenyXayq6IVzO/e5L/5
        EaKsDjyDa8amN3cyDqLMdlA3NltW2G3vtucsogxEazDcIhRGuZpYzAVc=
X-Virus-Scanned: amavisd-new at mykolab.com
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 tagged_above=-10 required=5
        tests=[BAYES_00=-1.9] autolearn=ham autolearn_force=no
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yzb_qYtMbBFZ; Sat, 10 Apr 2021 00:04:09 +0200 (CEST)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id D5E1F403F1;
        Sat, 10 Apr 2021 00:04:07 +0200 (CEST)
Received: from int-subm002.mykolab.com (unknown [10.9.37.2])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id CA8D63162;
        Sat, 10 Apr 2021 00:04:05 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 10 Apr 2021 00:04:03 +0200
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Alex Shi <alexs@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Wu XiangCheng <bobwxc@email.cn>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/8] docs: replace transation references for
 reporting-bugs.rst
In-Reply-To: <3c7eb94992f7d85d75c8faf82c6a4690b2666951.1617972339.git.mchehab+huawei@kernel.org>
References: <cover.1617972339.git.mchehab+huawei@kernel.org>
 <3c7eb94992f7d85d75c8faf82c6a4690b2666951.1617972339.git.mchehab+huawei@kernel.org>
Message-ID: <028fa780f186689cddfba701b87c4c87@vaga.pv.it>
X-Sender: federico.vaga@vaga.pv.it
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-04-09 14:47, Mauro Carvalho Chehab wrote:
> Changeset d2ce285378b0 ("docs: make reporting-issues.rst official and
> delete reporting-bugs.rst")
> dropped reporting-bugs.rst, in favor of reporting-issues.rst, but
> translations still need to be updated, in order to point to the
> new file.
> 
> Fixes: d2ce285378b0 ("docs: make reporting-issues.rst official and
> delete reporting-bugs.rst")
> Acked-by: Wu XiangCheng <bobwxc@email.cn>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/translations/it_IT/process/howto.rst            | 2 +-

Acked-by: Federico Vaga <federico.vaga@vaga.pv.it>

>  Documentation/translations/ja_JP/howto.rst                    | 2 +-
>  Documentation/translations/zh_CN/SecurityBugs                 | 2 +-
>  .../translations/zh_CN/admin-guide/reporting-issues.rst       | 4 ++--
>  Documentation/translations/zh_CN/process/howto.rst            | 2 +-
>  5 files changed, 6 insertions(+), 6 deletions(-)

-- 
Federico Vaga
