Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 025513E39C6
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Aug 2021 11:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbhHHJNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 05:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbhHHJNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 05:13:51 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8F4C061760
        for <linux-kernel@vger.kernel.org>; Sun,  8 Aug 2021 02:13:32 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id x17so8460006wmc.5
        for <linux-kernel@vger.kernel.org>; Sun, 08 Aug 2021 02:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mozilla.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kI8nripGI9Tg1l//xQOF+aXOzV8hm0gKgjxQAdZFl24=;
        b=LdLFXAZ6el8WqCUMa0Madqw3kjeRWdaa+9eDpvql9nkHJxwqL5ozd4+D1BmWjd7JOJ
         aeq+nMf42mj20qzpRXSLoxYHyVp0wMximjznnT50jtLkrkFMW2UJ7DmeMHnxq0Lnmcoe
         +NXVPtIQmpTY+8sQm1nEdeER00CLNhGcLFLdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kI8nripGI9Tg1l//xQOF+aXOzV8hm0gKgjxQAdZFl24=;
        b=XQlRQFwX8DEN3q9iwGQdy3dZnZgev0ocD2JgJ1WqotUkQ7iQpd8KOzWQ5Vgx4HV+1r
         EM3e2Eix+vLcbzIYKk1txZAl8H6CK1a7nxRx1R4/eLeO51jYhqi04uGSl2qojRKAVdFA
         wBl7cW6KbBdsJAEk5atcJt/C4028EzGJxHp/5KFveWcBclMETA92t+r7y8sHqTzYpdQ5
         g0WLolAijrTw9Qsxdxfe7U1FWDCJD6zS5GcmMxX9QLvmyswf6x5C63antv0jRK1WjwXe
         SDUJIOnoIKfza+BBpA3o7jueoBknZMh7r+3w3W3yPO0qMYYDwHrSFc6VetLQiUs4sShp
         Rpdg==
X-Gm-Message-State: AOAM533h4ruTf4PROeW2E7ruDf2on5GKXEMcnHFQBW5mjJKIFDi6EODt
        WNA8fISVkqJpqQWf1XG9+FkFvQ==
X-Google-Smtp-Source: ABdhPJyJ+/4QFqGB14PICqFFmIE4dEw97fekvnNRSVkoktAelIhBnXMMIXm2ZJ09jcI4YC+6Sw+RIA==
X-Received: by 2002:a7b:cc07:: with SMTP id f7mr6271241wmh.134.1628414010736;
        Sun, 08 Aug 2021 02:13:30 -0700 (PDT)
Received: from [192.168.8.108] (137.red-176-87-227.dynamicip.rima-tde.net. [176.87.227.137])
        by smtp.gmail.com with UTF8SMTPSA id d9sm4978444wrw.26.2021.08.08.02.13.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Aug 2021 02:13:30 -0700 (PDT)
Message-ID: <89b3f65d-b2c8-bd39-24a6-fd6b7f146a98@mozilla.com>
Date:   Sun, 8 Aug 2021 11:13:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0
Subject: Re: ERROR: modpost: "__raw_writesl"
 [drivers/i3c/master/i3c-master-cdns.ko] undefined!
Content-Language: fr
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Philip Li <philip.li@intel.com>
Cc:     Chen Rong <rong.a.chen@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kernel test robot <lkp@intel.com>,
        Brian Cain <bcain@codeaurora.org>,
        Sid Manning <sidneym@codeaurora.org>
References: <202108041936.52T4sUU6-lkp@intel.com>
 <CAKwvOdmOTNTGvGeaRKSp4f6M1PC-HQLjMoaeQU6WM9ygxuU5_w@mail.gmail.com>
 <20210806102246.GB1330186@pl-dbox>
 <CAKwvOdmP1Bb0wkyUJAs-n5wT-obH56jw2zcBpT7jpV84id4tfw@mail.gmail.com>
From:   Sylvestre Ledru <sylvestre@mozilla.com>
In-Reply-To: <CAKwvOdmP1Bb0wkyUJAs-n5wT-obH56jw2zcBpT7jpV84id4tfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Le 06/08/2021 à 18:57, Nick Desaulniers a écrit :
> On Fri, Aug 6, 2021 at 3:28 AM Philip Li <philip.li@intel.com> wrote:
>> On Wed, Aug 04, 2021 at 10:18:10AM -0700, Nick Desaulniers wrote:
>>> On Wed, Aug 4, 2021 at 4:39 AM kernel test robot <lkp@intel.com> wrote:
>>>> Hi Nathan,
>>>>
>>>> First bad commit (maybe != root cause):
>>>>
>>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>>> head:   d5ad8ec3cfb56a017de6a784835666475b4be349
>>>> commit: 6fef087d0d37ba7dba8f3d75566eb4c256cd6742 hexagon: handle {,SOFT}IRQENTRY_TEXT in linker script
>>>> date:   4 weeks ago
>>>> config: hexagon-randconfig-r023-20210804 (attached as .config)
>>> cool, one of the first reports from 0day bot of hexagon :)
>> :-) yeah, we just enabled it. BTW: we use one specific version of clang,
>> does such hexagon support work in latest clang 14.0.0?
> Yes, it ought to; we're using ToT llvm to build it in our CI.  I'm not
> precisely sure about clang-13 yet until the apt.llvm.org binaries
> exist for that branch.

The branch already exists. The webpage wasn't just live yet but it
should be a few hours (CDN):

https://apt.llvm.org/

Cheers

S


