Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF93E356BCC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 14:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352012AbhDGMJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 08:09:55 -0400
Received: from mx.kolabnow.com ([95.128.36.40]:44668 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235309AbhDGMJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 08:09:49 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id A163840B61;
        Wed,  7 Apr 2021 14:00:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        message-id:references:in-reply-to:subject:subject:from:from:date
        :date:content-transfer-encoding:content-type:content-type
        :mime-version:received:received:received; s=dkim20160331; t=
        1617796842; x=1619611243; bh=f2K5S/OWJqXSu8xFMGUz5ameMNWBDVZMZnD
        l08rBIE0=; b=DkFQMDs1HfEQA24jolEzn6jKLZMt1hZcD+exM3cEzwOn12PWTOe
        6GmIJTydgywI80+SVOS1hs4tIMtz7FbsMakdZ9WfvJfttwJtTnRe7Zz/rMM2j7bl
        NSHvhOYv42qUA3K8mpLME3RbaBZx8AHgPEaYI8sI2mdywFqH0KXiZLmFpxRJq6NI
        szQhHC/f9THGWhrnfvePO0/JIvXwIYjqh2S80Qcluw6iiBu3smEn7if4sPBPS5Ip
        SxV6p/onH5ZEFA+r1zEMaeWwc6w93/eZgqgS8/EGGVkJxa5hHhdWdr9rt+HZICXP
        oacpLVKQVAfy+u7KwKpQhVzrTy71qqjdPi6r73ryDnXhgE/VBkfbEajN/8SR4Kan
        xdgGCd5tvY4veLDtx6dHsx3WSGk/G9SdfrmI9+QYUVfa6i28lNFo46kJAlHEszVV
        LcEJdbTc0ckyTYQBdOHW4SnonOPcATbLzMcIDqOnpHxjzl+9iySaaznXv4S+CV31
        vygz9kcDsujSwL6/1YdydrTiYHJ93R5e+tqbvWVCQ91qVYT6me+/lUvrshlfHmC9
        U9tLrE6GdVRWBfynWD+0wLKj4RG+L+ZEZIhAAe0paR/gCpr/Zq01NPZX6apD69oS
        Y61vbHpLZ2T5Vbjid/rpDIWreecvl/VmUJ0xiVY5HA97B4pUNvFgx3zk=
X-Virus-Scanned: amavisd-new at mykolab.com
X-Spam-Flag: NO
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.899 tagged_above=-10 required=5
        tests=[BAYES_00=-1.9, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ybUBiOnSaMlu; Wed,  7 Apr 2021 14:00:42 +0200 (CEST)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id E2D1A40194;
        Wed,  7 Apr 2021 14:00:41 +0200 (CEST)
Received: from int-subm002.mykolab.com (unknown [10.9.37.2])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id 0FC3A3234;
        Wed,  7 Apr 2021 14:00:37 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 07 Apr 2021 14:00:36 +0200
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Harry Wei <harryxiyou@gmail.com>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Wu XiangCheng <bobwxc@email.cn>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 17/19] docs: replace transation references for
 reporting-bugs.rst
In-Reply-To: <65d1983fb625b5dd38d05f5c75a592e61992a4e0.1617783062.git.mchehab+huawei@kernel.org>
References: <cover.1617783062.git.mchehab+huawei@kernel.org>
 <65d1983fb625b5dd38d05f5c75a592e61992a4e0.1617783062.git.mchehab+huawei@kernel.org>
Message-ID: <91fdf345c72062fed4306fee8f0b7efe@vaga.pv.it>
X-Sender: federico.vaga@vaga.pv.it
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-04-07 10:20, Mauro Carvalho Chehab wrote:
> Changeset d2ce285378b0 ("docs: make reporting-issues.rst official and
> delete reporting-bugs.rst")
> dropped reporting-bugs.rst, in favor of reporting-issues.rst, but
> translations still need to be updated, in order to point to the
> new file.
> 
> Fixes: d2ce285378b0 ("docs: make reporting-issues.rst official and
> delete reporting-bugs.rst")
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
http://www.federicovaga.it/
