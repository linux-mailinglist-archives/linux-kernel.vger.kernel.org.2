Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55049350E4F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 07:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbhDAE7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 00:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhDAE7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 00:59:38 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7498C0613E6;
        Wed, 31 Mar 2021 21:59:38 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id f3so838280pgv.0;
        Wed, 31 Mar 2021 21:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GNOAI81wqIgifIzVXlS3hqwsnur1loPU+qLes91JfVs=;
        b=S3yQ/S6woUAIlwD6v1v+OYItKf3gixHFTSsg6Mq2C+qpT+peBbzOnwem6YlB88VPic
         eUOxjB72QkzZ4QcVGY9CnK0wgmJe0KZF6guu8XcWVfEnIXaxoJOpZ0t6eld0FDqx4Jq8
         ocnlk8Fu9Hqng1Dd7RMvNZ3FklXWWG7MYqLyNHbmAFxlKixUUmbc3v2LoU7lDmOhu9RY
         je+puR1k8ksYevJnWoJoYxpe0YKttRf99XpJw2Df84wfM5xYYz6EuRXUM25aggBe2vDS
         gSMr2aeOJU8Ot5eVGbTn0RflTC87L3hJD4+FYOb2AAjHxoksHWJ4dZUViiAdL8MjY9U/
         BJxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GNOAI81wqIgifIzVXlS3hqwsnur1loPU+qLes91JfVs=;
        b=pP0qPtG7Ar149YapKW1Puwk/9N05fY1Q22QOWsHL2cMyBmqjDQz+kSCtGhLuF00XD9
         nIp3OOhQ7htWVPflM/BndY5wErzSALqz0B1eIzLzalNgBdSrJjNS+jEaVDD6N4ILf2pQ
         foImYRLuBYXFwEpWwpC4uSErOVDzYOe5fo2kS1obB6FpbFA+rNS7C4NZkoDNUBrWkx+5
         /vHtFiEQCFiHXh/3SlcUZvsQycybD17NXccNApQmpytviU83nvHdl9LkceVb65kOMux9
         1QkTihDnt3eQ3Fkb9AClRRn2MJsNTfGNa04PzqjvNVYhlwI7vdqGFMcEKKhJkk/cQlvh
         iuGQ==
X-Gm-Message-State: AOAM532FH/GvxPjexpr2JWhWHG5uR0VXkzGlqyFy73jqUM0F1rLtb+UB
        20VeRh3C9Zc8WqQVvA3wgbo=
X-Google-Smtp-Source: ABdhPJyqj0mkab+OeT0S0x+MsYP14fRXt0oLJGrrfQkHNzFMBCQMB+lrS3SXU6hfYl6YpxPocmGiBA==
X-Received: by 2002:a62:b412:0:b029:21f:6b06:7bdd with SMTP id h18-20020a62b4120000b029021f6b067bddmr6004419pfn.51.1617253178416;
        Wed, 31 Mar 2021 21:59:38 -0700 (PDT)
Received: from [192.168.2.225] (93.179.119.173.16clouds.com. [93.179.119.173])
        by smtp.gmail.com with ESMTPSA id ge16sm3670854pjb.43.2021.03.31.21.59.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Mar 2021 21:59:37 -0700 (PDT)
Subject: Re: [PATCH v1 1/4] docs: make reporting-issues.rst official and
 delete reporting-bugs.rst
To:     "Wu X.C." <bobwxc@email.cn>,
        Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Alex Shi <alexs@kernel.org>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Greg KH <gregkh@linuxfoundation.org>
References: <cover.1617113469.git.linux@leemhuis.info>
 <49c674c2d304d87e6259063580fda05267e8c348.1617113469.git.linux@leemhuis.info>
 <20210331083337.GA5287@mipc>
From:   Alex Shi <seakeel@gmail.com>
Message-ID: <c55a51bf-d967-02ad-41b5-189dce226d1c@gmail.com>
Date:   Thu, 1 Apr 2021 12:59:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210331083337.GA5287@mipc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/3/31 下午4:33, Wu X.C. wrote:
> Cc Alex Shi's new email <alexs@kernel.org>
> 
> On Tue, Mar 30, 2021 at 04:13:04PM +0200, Thorsten Leemhuis wrote:
>> Removing Documentation/admin-guide/reporting-bugs.rst will break links
>> in some of the translations. I was unsure if simply changing them to
>> Documentation/admin-guide/reporting-issue.rst was wise, so I didn't

A bit time info late won't hurt sth, people would update them soon if it's
their care.

>> touch anything for now and CCed the maintainers for the Chinese and
>> Italian translation. I couldn't find one for the Japanse translation.
>>
>> Please advice. For completeness, this are the places where things will
>> break afaics:
>>
>> $ grep -ri 'reporting-bugs.rst' Documentation/
>> Documentation/translations/zh_CN/SecurityBugs:是有帮助的信息，那就请重温一下admin-guide/reporting-bugs.rst文件中的概述过程。任
>> Documentation/translations/zh_CN/process/howto.rst:内核源码主目录中的:ref:`admin-guide/reporting-bugs.rst <reportingbugs>`
>> Documentation/translations/zh_CN/admin-guide/reporting-issues.rst:   本文档将取代“Documentation/admin-guide/reporting-bugs.rst”。主要的工作
>> Documentation/translations/zh_CN/admin-guide/reporting-issues.rst:   “Documentation/admin-guide/reporting-bugs.rst”中的旧文字非常相似。它和它
> 
> Yeah, as Greg said, we will solve that after you patches be merged in next
> tree. Since I have translate the zh reporting-issues.rst in the next tree,
> will correct the link when I sync it with your new version. May cause 
> Warning for some days, but don't worry about it.

yes, also thanks for generous commitment!

thanks
Alex
