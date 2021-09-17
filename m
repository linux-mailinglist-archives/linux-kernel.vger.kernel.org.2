Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A30540F322
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 09:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245207AbhIQHWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 03:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245309AbhIQHWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 03:22:32 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650C6C0613E9;
        Fri, 17 Sep 2021 00:21:04 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id f129so8803981pgc.1;
        Fri, 17 Sep 2021 00:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o04KVDqW6D3wX8X1Cre/VXEIVNZmQV2zmdh96ibeAQY=;
        b=BR/QS+2JAgrBOeZu0YkY6PvalYMyvVrsEkwrBac4pHtqkCmtexbIGm2fdHRc1znkUQ
         8lp5ZV8amAjYWFrj3s1VEHxESU26rhkUE0QBoIage67K1s4ivjKYsD+KfiVM5P/6H8pQ
         uX8FUrnlnOARWkLuaDKnJIi8W/A94mY5GW4douzfiJ5I/uQvxqQfS4Q/zSwD1wJKyeye
         rJ43GfyvFNRtyVawhHBvhIKslSkGcgwqmL7T225knXZKNnSvImL/fjyF6QQ6negGKQuF
         Q/zRX3waDIWp5bpYiNNQ3XhzWqlrHXehYsGLFl8etiTwEjQE1iLPG/ctIs9BrTcK9fg2
         qQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o04KVDqW6D3wX8X1Cre/VXEIVNZmQV2zmdh96ibeAQY=;
        b=QxUx6NW+gsD14c1Hpf7ccCN0NOxiU+C4NCbuBReRELGF4bADY9m9+3XW0XunBeYiHc
         ckLXHbg7hsKpRxniwo3gEbo4foC9WBiEKyHXeV38T3OvWmr9pvjCVoK+S+d6S5qix/HW
         cW1OFcb+5VlEprfMilhuMQqGTk2078POgZsjNtC+MM8x8ItV+AeSXSVRB2Ju/ljj8mcv
         C/TEJ5jtOGzbfgXAmkQXuT2ZHPXFoHOqY6VwMxnZ8geVFklxDNisIn5kQ4caOAlTQ6eX
         q0B7rGYl7jEH7tI7umdPZUx2euflaItbfYZ5ldC3ev3jTPlhUtt3Xys0uAukW3ACwGzb
         5OXQ==
X-Gm-Message-State: AOAM530SPZHNlUTyoNLO+f3UghJETJ0qsZ2MQa9hjbDvoFbJ/biDUowi
        kjA3JT0IHdoSInWX9xwSAFF1c/qJKI0=
X-Google-Smtp-Source: ABdhPJyzW/d4w8I9XbSWslHMQAs4RC0lfXl8awU/+YvWa2vzUCeG4mu5GXIyOhBjtRnI5g2PsqNqJA==
X-Received: by 2002:a62:55c2:0:b0:3ec:c066:495c with SMTP id j185-20020a6255c2000000b003ecc066495cmr9264712pfb.38.1631863263838;
        Fri, 17 Sep 2021 00:21:03 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id gp11sm9353954pjb.2.2021.09.17.00.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 00:21:03 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: yang.yang29@zte.com.cn
To:     alexs@kernel.org, siyanteng@loongson.cn
Cc:     corbet@lwn.net, yang.yang29@zte.com.cn, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] docs/zh_CN: Add zh_CN/accounting/delay-accounting.rst
Date:   Fri, 17 Sep 2021 07:20:48 +0000
Message-Id: <20210917072047.228685-1-yang.yang29@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Yang <yang.yang29@zte.com.cn>

Add translation zh_CN/accounting/delay-accounting.rst and links it
to zh_CN/accounting/index.rst while clean its todo entry.

Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
---
v2: delete useless blackline
---
 .../zh_CN/accounting/delay-accounting.rst     | 113 ++++++++++++++++++
 .../translations/zh_CN/accounting/index.rst   |   2 +-
 2 files changed, 114 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/translations/zh_CN/accounting/delay-accounting.rst

diff --git a/Documentation/translations/zh_CN/accounting/delay-accounting.rst b/Documentation/translations/zh_CN/accounting/delay-accounting.rst
new file mode 100644
index 000000000000..760f96876ea2
--- /dev/null
+++ b/Documentation/translations/zh_CN/accounting/delay-accounting.rst
@@ -0,0 +1,113 @@
+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: Documentation/accounting/delay-accounting.rst
+:Translator: Yang Yang <yang.yang29@zte.com.cn>
+
+.. _cn_delay-accounting.rst:
+
+========
+延迟计数
+========
+
+任务在等待某些内核资源可用时，会造成延迟。例如一个可运行的任务可能会等待
+一个空闲CPU来运行。
+
+基于每任务的延迟计数功能度量由以下情况造成的任务延迟：
+
+a) 等待一个CPU（任务为可运行）
+b) 完成由该任务发起的块I/O同步请求
+c) 页面交换
+d) 内存回收
+
+并将这些统计信息通过taskstats接口提供给用户空间。
+
+这些延迟信息为适当的调整任务CPU优先级、io优先级、rss限制提供反馈。重要任务
+长期延迟，表示可能需要提高其相关优先级。
+
+通过使用taskstats接口，本功能还可提供一个线程组（对应传统Unix进程）所有任务
+（或线程）的总延迟统计信息。此类汇总往往是需要的，由内核来完成更加高效。
+
+用户空间的实体，特别是资源管理程序，可将延迟统计信息汇总到任意组中。为实现
+这一点，任务的延迟统计信息在其生命周期内和退出时皆可获取，从而确保可进行
+连续、完整的监控
+
+
+接口
+----
+
+延迟计数使用taskstats接口，该接口由本目录另一个单独的文档详细描述。Taskstats
+向用户态返回一个通用数据结构，对应每pid或每tgid的统计信息。延迟计数功能填写
+该数据结构的特定字段。见
+
+     include/linux/taskstats.h
+
+其描述了延迟计数相关字段。系统通常以计数器形式返回 CPU、同步块 I/O、交换、内存
+回收等的累积延迟。
+
+取任务某计数器两个连续读数的差值，将得到任务在该时间间隔内等待对应资源的总延迟。
+
+当任务退出时，内核会将包含每任务的统计信息发送给用户空间，而无需额外的命令。
+若其为线程组最后一个退出的任务，内核还会发送每tgid的统计信息。更多详细信息见
+taskstats接口的描述。
+
+tools/accounting目录中的用户空间程序getdelays.c提供了一些简单的命令，用以显示
+延迟统计信息。其也是使用taskstats接口的示例。
+
+用法
+----
+
+使用以下配置编译内核::
+
+	CONFIG_TASK_DELAY_ACCT=y
+	CONFIG_TASKSTATS=y
+
+延迟计数在启动时默认关闭。
+若需开启，在启动参数中增加::
+
+   delayacct
+
+本文后续的说明基于延迟计数已开启。也可在系统运行时，使用sysctl的kernel.task_delayacct
+进行开关。注意，只有在启用延迟计数后启动的任务才会有相关信息。
+
+系统启动后，使用类似getdelays.c的工具获取任务或线程组（tgid）的延迟信息。
+
+getdelays命令的一般格式::
+
+	getdelays [-t tgid] [-p pid] [-c cmd...]
+
+获取pid为10的任务从系统启动后的延迟信息::
+
+	# ./getdelays -p 10
+	（输出信息和下例相似）
+
+获取所有tgid为5的任务从系统启动后的总延迟信息::
+
+	# ./getdelays -t 5
+
+
+	CPU	count	real total	virtual total	delay total
+		7876	92005750	100000000	24001500
+	IO	count	delay total
+		0	0
+	SWAP	count	delay total
+		0	0
+	RECLAIM	count	delay total
+		0	0
+
+获取指定简单命令运行时的延迟信息::
+
+  # ./getdelays -c ls /
+
+  bin   data1  data3  data5  dev  home  media  opt   root  srv        sys  usr
+  boot  data2  data4  data6  etc  lib   mnt    proc  sbin  subdomain  tmp  var
+
+
+  CPU	count	real total	virtual total	delay total
+	6	4000250		4000000		0
+  IO	count	delay total
+	0	0
+  SWAP	count	delay total
+	0	0
+  RECLAIM	count	delay total
+	0	0
+
diff --git a/Documentation/translations/zh_CN/accounting/index.rst b/Documentation/translations/zh_CN/accounting/index.rst
index 362e907b41f9..090f93776faa 100644
--- a/Documentation/translations/zh_CN/accounting/index.rst
+++ b/Documentation/translations/zh_CN/accounting/index.rst
@@ -16,10 +16,10 @@
    :maxdepth: 1
 
    psi
+   delay-accounting
 
 Todolist:
 
    cgroupstats
-   delay-accounting
    taskstats
    taskstats-struct
-- 
2.25.1

