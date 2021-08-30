Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3994C3FB29F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 10:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235150AbhH3IkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 04:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234341AbhH3IkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 04:40:24 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16EDAC06175F
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 01:39:31 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id l12-20020a4a94cc0000b02902618ad2ea55so4339702ooi.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 01:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J/hEM3tcQmv5h0aNBtAnL55U1gjZ76bS+5hiezChL/c=;
        b=pHxOO3OtuhjHfPdiacDEiq974c4w7Vh0NHRop798z7zGNHDfuF1sR08sANF9BP1KDz
         RJvEBhsc/I0/7mffxPctm5EiB2CtfnHf9wLJP5pA0hyTIN6/veZ22aB1PIomG9i5xY2w
         dUF8Cvjtbdt6Ya07ORcnNNlsvcBJ7BelF7kRI+L9CC8hgG9b+pPWtdSmQJR2/p7j751q
         41nhL7VkjW41HWWxB8F6vnfLbkBWHzMGVejHkACWRapSu7UbOqFcISZKBzXtjRxaHV36
         S4OuBK3n5+at21KBRC2SrQjGlnL8sy+hX+h+A8iBMKb2NtuxhDdgeXcQigzaBAFaOg8r
         V59Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J/hEM3tcQmv5h0aNBtAnL55U1gjZ76bS+5hiezChL/c=;
        b=eJ+UNDVjePP+ZJNAmhcDIPtpiGvxKFiAXNgESZJYY54y4/sc0Nv72FJ0XtLgybz7As
         VecUfoNvCCX0b8GDikfhRR7gftLKSLFxloaG1UhH7rNsk/w/jHjUa4EIytJUN/IOqsmX
         xnAHHrmfYaZScXs6UKTXTwBfwk7YMIdvTenCPen3SpOljQ60XoAbpYScM2bIofwUaLcH
         t5QIt/HZDkjQKmPv3/FWZ132djT0txrHcDFdOhWryVKQcnHOIeFDwd+g2Rt+OeLCnmwa
         ZkENnuav6I3Xx5iTZmtVdq9b8vHY+bhuHfMQfHduY0GN+jkPDms7VPZbWa/SrKNOnNjX
         lqnw==
X-Gm-Message-State: AOAM5307tV9BR8UqoH7gab3od8c9aXO3Sh5UEZ/0UQpVBD1UDJ12hR43
        Y2f9CIVfI/mmZteLiorgxvIGitElYVASVDqP9npb0A==
X-Google-Smtp-Source: ABdhPJx3lro/NLWpABSvjIvK+fiTNntJeWbovYfVkE68ffqFkYVdlWs5TT/jlT2VXeU+rZtIPm7MpbkCFo3UD4S+9jc=
X-Received: by 2002:a4a:de90:: with SMTP id v16mr9192504oou.42.1630312770009;
 Mon, 30 Aug 2021 01:39:30 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000b575ab05aebfc192@google.com> <00000000000069bb3e05caa2d1f8@google.com>
In-Reply-To: <00000000000069bb3e05caa2d1f8@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 30 Aug 2021 10:39:18 +0200
Message-ID: <CACT4Y+Z1OG0bPB-bfMRS6vN4Ogx8n3_8v+e+WCshLwz7apvnHg@mail.gmail.com>
Subject: Re: [syzbot] WARNING: refcount bug in qrtr_node_lookup
To:     syzbot <syzbot+c613e88b3093ebf3686e@syzkaller.appspotmail.com>
Cc:     anant.thazhemadam@gmail.com, bjorn.andersson@linaro.org,
        butterflyhuangxx@gmail.com, davem@davemloft.net,
        dragonjetli@gmail.com, hdanton@sina.com, kuba@kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, mani@kernel.org,
        manivannan.sadhasivam@linaro.org, masahiroy@kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Aug 2021 at 20:32, syzbot
<syzbot+c613e88b3093ebf3686e@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 7e78c597c3ebfd0cb329aa09a838734147e4f117
> Author: Xiaolong Huang <butterflyhuangxx@gmail.com>
> Date:   Thu Aug 19 19:50:34 2021 +0000
>
>     net: qrtr: fix another OOB Read in qrtr_endpoint_post
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11279a4d300000
> start commit:   ba4f184e126b Linux 5.9-rc6
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=af502ec9a451c9fc
> dashboard link: https://syzkaller.appspot.com/bug?extid=c613e88b3093ebf3686e
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12263dd9900000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13d77603900000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: net: qrtr: fix another OOB Read in qrtr_endpoint_post
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Hi Hillf,

You posted some patch related to refcounts. Do you think "net: qrtr:
fix another OOB Read in qrtr_endpoint_post" is a plausible fix? Or is
there still something wrong with refcounts?
