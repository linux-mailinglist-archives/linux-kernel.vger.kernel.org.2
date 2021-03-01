Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B5F327648
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 04:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbhCADCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 22:02:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbhCADCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 22:02:40 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6534C061786
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 19:01:59 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id i14so8501793pjz.4
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 19:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GSiKByfZ5sqEV0qlOVhjWGxYdaWwaDIUdK2lORLzOS0=;
        b=ScCVJ0YypEy9MWpAu9R+ZNlfSdfwEpgJAxQFP/l3D0VDMmjBCQ3vzrVPFWhT25prCj
         QXpGyxHcSbNpVLiMISI/iCjxFsHc4dDIkA4EuVtGQmdynb1UUw3QA3C6177M7HJJpVdQ
         2oHKGLvEm/skQ9iXU55IE9jzrKshZDXrVsz50f78kRmzg/lL+MFtIFxR1Ep2Tyick7TF
         WFSl4S2UJPWN9MUz74NFEXEqpZNcJ8zRf4RchXpZ+64i22hXDYsJWA2BmFOuszbLCYWY
         r/jwOV0+WCDa7Onk+WEWPlrFNUFBH60Ids0G9DKUKvkOOAbTk4gN2Ri1da1QBerJFzlI
         dewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GSiKByfZ5sqEV0qlOVhjWGxYdaWwaDIUdK2lORLzOS0=;
        b=K3sIJ9GpUy69BIIh4OvipBMilX1/j3Al1mxtQWTfSla4bl095lgqqJFvZCjXUyLzBZ
         C/F4FVV62ZldWaHdMlSSe1QkI+XjXiFlaMUFxFkPWP7Y+B1uDaRsecEm2VpI2JWPaN+M
         qaYs/5YYRf8h/MpSPy2pB6Ipinohk4c47JKJgL0gPzveBrn8C/nHlyQX5/m0kXRcIVqJ
         uu2pls6EWhrWpNU+H0woRW/+NHXnPr1PLx822TMaoV3g20O+L4gMFg7qXtKG/kvxFuSF
         x1CRzwuOMBfx6nvkiEDYgEF2yhrh19GNcCJZLHAIxiWHc7lJ1xMSW2+AX/9URoUes7wS
         oAKQ==
X-Gm-Message-State: AOAM5327vSZIIs6CZwW4K2Ehp7gCDFweMzMuhxaO0vifV+MKN+ze9UQp
        74o273KPfmxUtZJhIHfiQjKc/knkaOilgDxHpimkCA==
X-Google-Smtp-Source: ABdhPJwEVjHQ1fPeJFLixQCWUSnlzdl/87wWdv9p8yk+ouhkV58sQu0KSI0Fa2jLhHCKNFak15hUdD0cupv16k+ZTO4=
X-Received: by 2002:a17:902:e54e:b029:e3:9f84:db8e with SMTP id
 n14-20020a170902e54eb02900e39f84db8emr13640880plf.24.1614567719209; Sun, 28
 Feb 2021 19:01:59 -0800 (PST)
MIME-Version: 1.0
References: <FE7425D7-3006-4F31-AE41-07E4EB6D030F@contoso.com>
In-Reply-To: <FE7425D7-3006-4F31-AE41-07E4EB6D030F@contoso.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 1 Mar 2021 11:01:23 +0800
Message-ID: <CAMZfGtUY6z3g1_=mj8_LAWcxc_OKVfwPQq9vrdhdkjs=hyW5rQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v17 1/9] mm: memory_hotplug: factor out
 bootmem core functions to bootmem_info.c
To:     "Bodeddula, Balasubramaniam" <bodeddub@amazon.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "almasrymina@google.com" <almasrymina@google.com>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
        "bp@alien8.de" <bp@alien8.de>, "corbet@lwn.net" <corbet@lwn.net>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "duanxiongchun@bytedance.com" <duanxiongchun@bytedance.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
        "jroedel@suse.de" <jroedel@suse.de>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
        "oneukum@suse.com" <oneukum@suse.com>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "rientjes@google.com" <rientjes@google.com>,
        "song.bao.hua@hisilicon.com" <song.bao.hua@hisilicon.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "willy@infradead.org" <willy@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 27, 2021 at 2:06 AM Bodeddula, Balasubramaniam
<bodeddub@amazon.com> wrote:
>
> Tested-by: bodeddub@amazon.com

Very thanks for your test.

>
>
>
> We are interested in this patch and have tested an earlier version of thi=
s patch on 5.11-rc4 kernel version. I did a functional validation of the ch=
anges and saw that the total memory listed by free command increasing and m=
ore memory was made available when memory was allocated in hugepages. 1G hu=
gepages gave higher improvements compared to 2M, as expected. Is there a fo=
rmal way to publish the results? I can do the same as required (I am new to=
 Linux Kernel patching process).

I don=E2=80=99t know if there is a formal way. But maybe you can share
the test result directly through this thread. If someone knows
this, please let me know. Thanks.

>
>
>
> I have a few follow-up questions on this patch:
>
> 1. What is the overall status of this patch? What is the ballpark timelin=
e we are looking for this patch to be accepted.

There is only one patch of this patchset that has no reviewed-by tag.
I think it might be 5.13 in the best case But I don't have the right to
decide.

>
> 2. Why is this patch not working when memory is allocated as hugepages by=
 THP (transparent hugepages). THP uses AnonHugePages, doesn=E2=80=99t this =
patch generalize for all =E2=80=98type=E2=80=99 of hugepages?

Now it only supports HugeTLB pages. THP is a little different
and complex compared to HugeTLB. I need to investigate THP
in depth to determine the possible problems.

>
>
>
> Please let me know if there are any additional tasks that I can help. Hap=
py to help.
>
>
>
> Thanks.
