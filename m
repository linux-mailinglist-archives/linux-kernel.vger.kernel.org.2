Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29B2C460F13
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 07:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbhK2HAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 02:00:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236032AbhK2G6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 01:58:12 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8868C061758;
        Sun, 28 Nov 2021 22:51:50 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id z9so15600125qtj.9;
        Sun, 28 Nov 2021 22:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jX1PdfZQrepYZSd1Km2MxfCByhVbFu5b8QU3N9v3GO8=;
        b=ijkWPIcK+WeoWwqfCjfS1IU/lol3NK5BT5txuTm447JVndmdWF+axARQAUUOFoWl3l
         VwyKYBSvpKPuNx8JMg6CltnSArdXKTMBnOjPph4Sk0KwPd/hQeg9iS1KcUUj0E0me1Rl
         QrCtT8L9SF2MwdOB/kP/qhcXUobAVnZoA414hX/QywnOXSS3OTylmJqZZb5yXRIG5aVP
         mr92RelEMpH4fv1shKZDM+SeBnY6EtfOMvXw8lA130S0K5KHdGh/CBUiUBDvom9NkEFJ
         RWs6nFzmRHwbQif1vu/MNqPAjshdBg5M/pNWR6a+d9uaiYARMC2psIwttnuRY2JTYgqI
         2M7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jX1PdfZQrepYZSd1Km2MxfCByhVbFu5b8QU3N9v3GO8=;
        b=II3MT3eN5tetYEdY0XVqKYEhlxxeyhA6Uoc00rEJx0vnjuGbNMFK2LSpGfBm8RUEaF
         a7nllWu1cJxNDefe/oaYIYklAfFDZtceACu6tSASxdmQjPzgzjIJGtL41WnrLcbS3y72
         PtT6mC+w/lo2TwQt8eUh8J2X3eZvdwZMBOneOxjln5YcdENGVRKDAmCW/3ex2VgSyIAF
         DmjpTT0PHSiZxAqc7hk0b+8RSE80NUBxtV6flkvV6iaY4CHEE7vDbTJ0+L4Twro+8y8X
         fsnEcjuXaHr8Ffk5FUVSvI11PaIzeH63aTEWRWNSr9Uo+EEXBKFkHucmujSZMkzyfF8O
         HENg==
X-Gm-Message-State: AOAM532eab9tO1DkTq5Hj2r8sWSRefAsv82+FNtr3CgvQMcrBkF6eFuc
        FmOE4rX3JkRkzE8wwfu33+Y=
X-Google-Smtp-Source: ABdhPJwm/85Fslv11z0fojGzC3pwFGLhG8rkIpudX1xmRpmNEuHf9/n69F14+lNeqWd60HAXFetlKw==
X-Received: by 2002:ac8:5c91:: with SMTP id r17mr44854444qta.18.1638168709774;
        Sun, 28 Nov 2021 22:51:49 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id k18sm8396492qta.24.2021.11.28.22.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 22:51:49 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: yang.yang29@zte.com.cn
To:     alexs@kernel.org, corbet@lwn.net, siyanteng@loongson.cn,
        seakeel@gmail.com
Cc:     yang.yang29@zte.com.cn, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] docs/zh_CN: Add zh_CN/accounting/taskstats.rst
Date:   Mon, 29 Nov 2021 06:51:14 +0000
Message-Id: <20211129065113.306748-1-yang.yang29@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Yang <yang.yang29@zte.com.cn>

Add translation zh_CN/accounting/taskstats.rst and links it to
zh_CN/accounting/index.rst while clean its todo entry.

Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
Reviewed-by: Alex Shi <alexs@kernel.org>
Reviewed-by: Yanteng Si <siyanteng@loongson.cn>
---
v3:
- add necessary blank line for bullet list.
v2:
- fix incomplete words and long sentences.
---
 .../translations/zh_CN/accounting/index.rst   |   2 +-
 .../zh_CN/accounting/taskstats.rst            | 147 ++++++++++++++++++
 2 files changed, 148 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/translations/zh_CN/accounting/taskstats.rst

diff --git a/Documentation/translations/zh_CN/accounting/index.rst b/Documentation/translations/zh_CN/accounting/index.rst
index 362e907b41f9..124b590fb01b 100644
--- a/Documentation/translations/zh_CN/accounting/index.rst
+++ b/Documentation/translations/zh_CN/accounting/index.rst
@@ -16,10 +16,10 @@
    :maxdepth: 1
 
    psi
+   taskstats
 
 Todolist:
 
    cgroupstats
    delay-accounting
-   taskstats
    taskstats-struct
diff --git a/Documentation/translations/zh_CN/accounting/taskstats.rst b/Documentation/translations/zh_CN/accounting/taskstats.rst
new file mode 100644
index 000000000000..f88a8d58ec69
--- /dev/null
+++ b/Documentation/translations/zh_CN/accounting/taskstats.rst
@@ -0,0 +1,147 @@
+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: Documentation/accounting/taskstats.rst
+
+:Translator: Yang Yang <yang.yang29@zte.com.cn>
+
+.. _cn_taskstats.rst:
+
+================
+每任务的统计接口
+================
+
+Taskstats是一个基于netlink的接口，用于从内核向用户空间发送每任务及每进程的
+统计信息。
+
+Taskstats设计目的：
+
+- 在任务生命周期内和退出时高效的提供统计信息
+- 统一不同计数子系统的接口
+- 支持未来计数系统的扩展
+
+术语
+----
+
+“pid”、“tid”、“任务”互换使用，用于描述由struct task_struct定义的标准
+Linux任务。“每pid的统计数据”等价于“每任务的统计数据”。
+
+“tgid”、“进程”、“线程组”互换使用，用于描述共享mm_struct的任务集，
+也就是传统的Unix进程。尽管使用了tgid这个词，即使一个任务是线程组组长，
+对它的处理也没有什么不同。只要一个进程还有任何归属它的任务，它就被认为
+活着。
+
+用法
+----
+
+为了在任务生命周期内获得统计信息，用户空间需打开一个单播的netlink套接字
+（NETLINK_GENERIC族）然后发送指定pid或tgid的命令。响应消息中包含单个
+任务的统计信息（若指定了pid）或进程所有任务汇总的统计信息（若指定了tgid）。
+
+为了在任务退出时获取统计信息，用户空间的监听者发送一个指定cpu掩码的注册命令。
+cpu掩码内的cpu上有任务退出时，每pid的统计信息将发送给注册成功的监听者。使用
+cpu掩码可以限制一个监听者收到的数据，并有助于对netlink接口进行流量控制，后文
+将进行更详细的解释。
+
+如果正在退出的任务是线程组中最后一个退出的线程，额外一条包含每tgid统计信息的
+记录也将发送给用户空间。后者包含线程组中所有线程（包括过去和现在）的每pid统计
+信息总和。
+
+getdelays.c是一个简单的示例，用以演示如何使用taskstats接口获取延迟统计信息。
+用户可注册cpu掩码、发送命令和处理响应、监听每tid/tgid退出数据、将收到的数据
+写入文件、通过增大接收缓冲区进行基本的流量控制。
+
+接口
+----
+
+内核用户接口封装在include/linux/taskstats.h。
+
+为避免本文档随着接口的演进而过期，本文仅给出当前版本的概要。当本文与taskstats.h
+不一致时，以taskstats.h为准。
+
+struct taskstats是每pid和每tgid数据共用的计数结构体。它是版本化的，可在内核新增
+计数子系统时进行扩展。taskstats.h中定义了各字段及语义。
+
+用户、内核空间的数据交换是属于NETLINK_GENERIC族的netlink消息，使用netlink属性
+接口。消息格式如下::
+
+    +----------+- - -+-------------+-------------------+
+    | nlmsghdr | Pad |  genlmsghdr | taskstats payload |
+    +----------+- - -+-------------+-------------------+
+
+Taskstats载荷有三种类型：
+
+1. 命令：由用户发送给内核。获取指定pid/tgid数据的命令包含一个类型为
+TASKSTATS_CMD_ATTR_PID/TGID的属性，该属性包含u32的pid或tgid载荷。
+pid/tgid指示用户空间要统计的任务/进程。
+
+注册/注销获取指定cpu集上退出数据的命令包含一个类型为
+TASKSTATS_CMD_ATTR_REGISTER/DEREGISTER_CPUMASK的属性，该属性包含cpu掩码载荷。
+cpu掩码是以ascii码表示，用逗号分隔的cpu范围。例如若需监听1,2,3,5,7,8号cpu的
+退出数据，cpu掩码表示为"1-3,5,7-8"。若用户空间在关闭监听套接字前忘了注销监听
+的cpu集，随着时间的推移，内核会清理此监听集。但是，出于提效的目的，建议明确
+执行注销。
+
+2. 命令的应答：内核发出应答用户空间的命令。载荷有三类属性：
+
+a) TASKSTATS_TYPE_AGGR_PID/TGID： 本属性不包含载荷，用以指示其后为被统计对象
+的pig/tgid。
+
+b) TASKSTATS_TYPE_PID/TGID：本属性的载荷为pig/tgid，其统计信息将被返回。
+
+c) TASKSTATS_TYPE_STATS：本属性的载荷为一个struct taskstats实例。每pid和
+每tgid统计信息共用该结构体。
+
+3. 内核会在任务退出时发送新消息。其载荷包含一系列以下类型的属性：
+
+a) TASKSTATS_TYPE_AGGR_PID：指示其后两个属性为pid+stats。
+b) TASKSTATS_TYPE_PID：包含退出任务的pid。
+c) TASKSTATS_TYPE_STATS：包含退出任务的每pid统计信息
+d) TASKSTATS_TYPE_AGGR_TGID：指示其后两个属性为tgid+stats。
+e) TASKSTATS_TYPE_TGID：包含任务所属进程的tgid
+f) TASKSTATS_TYPE_STATS：包含退出任务所属进程的每tgid统计信息
+
+每tgid的统计
+------------
+
+除了每任务的统计信息，taskstats还提供每进程的统计信息，因为资源管理通常以进程
+粒度完成，并且仅在用户空间聚合任务统计信息效率低下且可能不准确（缺乏原子性）。
+
+然而，除了每任务统计信息，在内核中维护每进程统计信息存在额外的时间和空间开销。
+为解决此问题，taskstats代码将退出任务的统计信息累积到进程范围的数据结构中。
+当进程最后一个任务退出时，累积的进程级数据也会发送到用户空间（与每任务数据一起）。
+
+当用户查询每tgid数据时，内核将指定线程组中所有活动线程的统计信息相加，并添加到
+该线程组的累积总数（含之前退出的线程）。
+
+扩展taskstats
+-------------
+
+有两种方法可在未来修改内核扩展taskstats接口，以导出更多的每任务/进程统计信息：
+
+1. 在现有struct taskstats末尾增加字段。该结构体中的版本号确保了向后兼容性。
+用户空间将仅使用与其版本对应的结构体字段。
+
+2. 定义单独的统计结构体并使用netlink属性接口返回对应的数据。由于用户空间独立
+处理每个netlink属性，所以总是可以忽略其不理解类型的属性（因为使用了旧版本接口）。
+
+在1.和2.之间进行选择，属于权衡灵活性和开销的问题。若仅需增加少数字段，那么1.是
+首选方法，因为内核和用户空间无需承担处理新netlink属性的开销。但若新字段过多的
+扩展现有结构体，导致不同的用户空间计数程序不必要的接收大型结构体，而对结构体
+字段并不感兴趣，那么2.是值得的。
+
+Taskstats的流量控制
+-------------------
+
+当退出任务数速率变大，监听者可能跟不上内核发送每tid/tgid退出数据的速率，而导致
+数据丢失。taskstats结构体变大、cpu数量上升，都会导致这种可能性增加。
+
+为避免统计信息丢失，用户空间应执行以下操作中至少一项：
+
+- 增大监听者用于接收退出数据的netlink套接字接收缓存区。
+
+- 创建更多的监听者，减少每个监听者监听的cpu数量。极端情况下可为每个cpu创建
+  一个监听者。用户还可考虑将监听者的cpu亲和性设置为监听cpu的子集，特别是当他们
+  仅监听一个cpu。
+
+尽管采取了这些措施，若用户空间仍收到指示接收缓存区溢出的ENOBUFS错误消息，
+则应采取其他措施处理数据丢失。
-- 
2.25.1
