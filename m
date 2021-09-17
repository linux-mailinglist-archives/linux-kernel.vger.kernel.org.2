Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C34940F33A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 09:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240009AbhIQH2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 03:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239766AbhIQH2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 03:28:41 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2930C061574;
        Fri, 17 Sep 2021 00:27:19 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id k24so8784894pgh.8;
        Fri, 17 Sep 2021 00:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=jucBYhBid+exWcBESRLEqUkyA1xlpqVGBAYwvhwM29I=;
        b=MGAmWnQoRgtGwgnNsVRlbnD3/iX6Nc8/nyLH7IBn4k3aN7YQxJtXV0kkR2zx349pnU
         Mg5neiuSxFsOAdjH3Lsm6GgJW3lcT2B+1Mj4wZmYhbGLnAxRbSLQL5m+pQQSzsUn+NgY
         W9KNBmf7fZmb7biO9OmTA9blQxtchptjmJA35v1n7byn34krOpe8O8RoxR//Rxqilqhr
         neyNciJmzcyIUkOLV+3pn4SAuRhYEMn6Na+YBcKMKFCdP1VWaFYLk3QofLPFJGBMUDH1
         Mf/Ct+E4qvi1FwqmqcgRbqIAg1fIGtE3Jriz0aiFU6t/lkbrN9Y9MFbpM3Px3Uny7oKG
         MkiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jucBYhBid+exWcBESRLEqUkyA1xlpqVGBAYwvhwM29I=;
        b=6+PKbqe5XYJxH0kk9K6+eHcaVzlh+6oksJNqxEIf9u/7BsPUuXqY/2jpIe9hHZjoyv
         tAr/SlGpcFmz9SyLaowPz7t5mz2ZSwBKjCJtC404o6k/cufitowExeiWY1M2+dOQOFAe
         mikT8qgXXMnCULWUzx2z3Jp1NahMW9oQMhMaQDFXY1Kcz24fIFf5amdbHAgZBd+jCU5K
         dQZ2OoztA74Oj95EBryANbdm/VRSSEhumItLDQf0gMgE3Ih3QNtOqtbsu3cTXw57SGRL
         SkSefoLl86J8CH2IXlNY7B9NFoIaFB38H+ue2rrquhe1+idN1dVq8a8N+1KcTtIrNuBV
         wdGw==
X-Gm-Message-State: AOAM532Klg9TkCSzCvQZLVgq5TtpuZHMqWaP+PpoSFqtSnJzegmthKhq
        JKXoZBCFlBiBjb5upt12tzo=
X-Google-Smtp-Source: ABdhPJz10CEhQYd2rQYzIbC9MpjXev1lSbEHmM2uIRzZuFN10obm0BGZGkFJ9M8XKPyzEOfHcfCXMw==
X-Received: by 2002:a65:6648:: with SMTP id z8mr8676928pgv.418.1631863639342;
        Fri, 17 Sep 2021 00:27:19 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id n41sm5438106pfv.108.2021.09.17.00.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 00:27:18 -0700 (PDT)
Message-ID: <61444356.1c69fb81.aee39.657e@mx.google.com>
X-Google-Original-Message-ID: <20210917072717.GA228747@cgel.zte@gmail.com>
Date:   Fri, 17 Sep 2021 07:27:17 +0000
From:   CGEL <cgel.zte@gmail.com>
To:     teng sterling <sterlingteng@gmail.com>
Cc:     Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
        Jonathan Corbet <corbet@lwn.net>, yang.yang29@zte.com.cn,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs/zh_CN: Add zh_CN/accounting/delay-accounting.rst
References: <20210915132037.169162-1-yang.yang29@zte.com.cn>
 <CAMU9jJqyTipnair8f6oTpP6VYoGhMVft3Qzv95m8TE5NowpHKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMU9jJqyTipnair8f6oTpP6VYoGhMVft3Qzv95m8TE5NowpHKA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 02:53:39PM +0800, teng sterling wrote:
> <cgel.zte@gmail.com> 于2021年9月15日周三 下午9:21写道：
> >
> > From: Yang Yang <yang.yang29@zte.com.cn>
> >
> > Add translation zh_CN/accounting/delay-accounting.rst and links it
> > to zh_CN/accounting/index.rst while clean its todo entry.
> >
> > Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
> > ---
> >  .../zh_CN/accounting/delay-accounting.rst     | 114 ++++++++++++++++++
> >  .../translations/zh_CN/accounting/index.rst   |   2 +-
> >  2 files changed, 115 insertions(+), 1 deletion(-)
> >  create mode 100644 Documentation/translations/zh_CN/accounting/delay-accounting.rst
> >
> > diff --git a/Documentation/translations/zh_CN/accounting/delay-accounting.rst b/Documentation/translations/zh_CN/accounting/delay-accounting.rst
> > new file mode 100644
> > index 000000000000..1df7d2354e07
> > --- /dev/null
> > +++ b/Documentation/translations/zh_CN/accounting/delay-accounting.rst
> > @@ -0,0 +1,114 @@
> > +.. include:: ../disclaimer-zh_CN.rst
> > +
> > +:Original: Documentation/accounting/delay-accounting.rst
> > +:Translator: Yang Yang <yang.yang29@zte.com.cn>
> > +
> > +.. _cn_delay-accounting.rst:
> > +
> > +
> only need one blackline.

It's fixed in patch v2.

> > +========
> > +延迟计数
> > +========
> > +
> > +任务在等待某些内核资源可用时，会造成延迟。例如一个可运行的任务可能会等待
> > +一个空闲CPU来运行。
> > +
> > +基于每任务的延迟计数功能度量由以下情况造成的任务延迟：
> > +
> > +a) 等待一个CPU（任务为可运行）
> > +b) 完成由该任务发起的块I/O同步请求
> > +c) 页面交换
> > +d) 内存回收
> > +
> > +并将这些统计信息通过taskstats接口提供给用户空间。
> > +
> > +这些延迟信息为适当的调整任务CPU优先级、io优先级、rss限制提供反馈。重要任务
> > +长期延迟，表示可能需要提高其相关优先级。
> > +
> > +通过使用taskstats接口，本功能还可提供一个线程组（对应传统Unix进程）所有任务
> > +（或线程）的总延迟统计信息。此类汇总往往是需要的，由内核来完成更加高效。
> > +
> > +用户空间的实体，特别是资源管理程序，可将延迟统计信息汇总到任意组中。为实现
> > +这一点，任务的延迟统计信息在其生命周期内和退出时皆可获取，从而确保可进行
> > +连续、完整的监控
> > +
> > +
> > +接口
> > +----
> > +
> > +延迟计数使用taskstats接口，该接口由本目录另一个单独的文档详细描述。Taskstats
> > +向用户态返回一个通用数据结构，对应每pid或每tgid的统计信息。延迟计数功能填写
> > +该数据结构的特定字段。见
> > +
> > +     include/linux/taskstats.h
> > +
> > +其描述了延迟计数相关字段。系统通常以计数器形式返回 CPU、同步块 I/O、交换、内存
> > +回收等的累积延迟。
> > +
> > +取任务某计数器两个连续读数的差值，将得到任务在该时间间隔内等待对应资源的总延迟。
> > +
> > +当任务退出时，内核会将包含每任务的统计信息发送给用户空间，而无需额外的命令。
> > +若其为线程组最后一个退出的任务，内核还会发送每tgid的统计信息。更多详细信息见
> > +taskstats接口的描述。
> > +
> > +tools/accounting目录中的用户空间程序getdelays.c提供了一些简单的命令，用以显示
> > +延迟统计信息。其也是使用taskstats接口的示例。
> > +
> > +用法
> > +----
> > +
> > +使用以下配置编译内核::
> > +
> > +       CONFIG_TASK_DELAY_ACCT=y
> > +       CONFIG_TASKSTATS=y
> > +
> > +延迟计数在启动时默认关闭。
> > +若需开启，在启动参数中增加::
> > +
> > +   delayacct
> > +
> > +本文后续的说明基于延迟计数已开启。也可在系统运行时，使用sysctl的kernel.task_delayacct
> > +进行开关。注意，只有在启用延迟计数后启动的任务才会有相关信息。
> > +
> > +系统启动后，使用类似getdelays.c的工具获取任务或线程组（tgid）的延迟信息。
> > +
> > +getdelays命令的一般格式::
> > +
> > +       getdelays [-t tgid] [-p pid] [-c cmd...]
> > +
> > +获取pid为10的任务从系统启动后的延迟信息::
> > +
> > +       # ./getdelays -p 10
> > +       （输出信息和下例相似）
> > +
> > +获取所有tgid为5的任务从系统启动后的总延迟信息::
> > +
> > +       # ./getdelays -t 5
> > +
> > +
> > +       CPU     count   real total      virtual total   delay total
> > +               7876    92005750        100000000       24001500
> > +       IO      count   delay total
> > +               0       0
> > +       SWAP    count   delay total
> > +               0       0
> > +       RECLAIM count   delay total
> > +               0       0
> > +
> > +获取指定简单命令运行时的延迟信息::
> > +
> > +  # ./getdelays -c ls /
> > +
> > +  bin   data1  data3  data5  dev  home  media  opt   root  srv        sys  usr
> > +  boot  data2  data4  data6  etc  lib   mnt    proc  sbin  subdomain  tmp  var
> > +
> > +
> > +  CPU  count   real total      virtual total   delay total
> > +       6       4000250         4000000         0
> > +  IO   count   delay total
> > +       0       0
> > +  SWAP count   delay total
> > +       0       0
> > +  RECLAIM      count   delay total
> > +       0       0
> > +
> > diff --git a/Documentation/translations/zh_CN/accounting/index.rst b/Documentation/translations/zh_CN/accounting/index.rst
> > index 362e907b41f9..090f93776faa 100644
> > --- a/Documentation/translations/zh_CN/accounting/index.rst
> > +++ b/Documentation/translations/zh_CN/accounting/index.rst
> > @@ -16,10 +16,10 @@
> >     :maxdepth: 1
> >
> >     psi
> > +   delay-accounting
> >
> >  Todolist:
> >
> >     cgroupstats
> > -   delay-accounting
> >     taskstats
> >     taskstats-struct
> Good job, I'm very interested in this series of documents and I'm
> looking forward to your subsequent translations. This is invaluable
> for Chinese developers who are not good at English, thank you very
> much for your contribution.
>

Thanks for your encourage!
I will translate the series of documents later. PSI is really usefull
for system optimize.

> Thanks,
> 
> Yanteng
