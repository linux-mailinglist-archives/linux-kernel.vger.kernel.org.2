Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C7A3D3124
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 03:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbhGWAdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 20:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbhGWAdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 20:33:23 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B65AC061575;
        Thu, 22 Jul 2021 18:13:57 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id t21so1190889plr.13;
        Thu, 22 Jul 2021 18:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S5I2BM629PMZrsKD1CUT5xpSIdP7D7TJP/n0T9K3qsA=;
        b=g1EpCCDun5JbZzMp1uhvAMVZx9HhoDIEFUbKjxo6uwWdrwQ6T6awNsmBG/BQMpkmhM
         qUYL/Nr1kkQT4wsM1bVXqN9aFLmyQjtNdTSMcIkrXHNudhV7CNx7IgMXfYSMJ8TT3L62
         OMZV7HLI765tOqR0FoshL61rQADvCXCaoOnUBO+1cRNg0kfZ9om3hMvdlcw9pBUv2HrO
         TNBrn8v3jXUFCDVrCeWCOrZFllztOMYrkRKzGUGI0ZBqPktfiFoKUfxep349BNVHhVhk
         d9lEKyglWO6yOlvIptwPiGg5Wj1Z4EZobkid5On6e0QzA+nTgF/WQ4gKy9tA69h3i7Zx
         k4tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S5I2BM629PMZrsKD1CUT5xpSIdP7D7TJP/n0T9K3qsA=;
        b=XTGKGZqnrXdqV64NpkfbMomi0lPLwVjEMCy59D6bhAYJVhkWi5R0eVulYtKgo371vh
         hWuqtzGHPlwhzP+X6luF8SF1O9ECaL2Rhg9fdsQ0oK7SPv5MinxIQFW4Ic4mhyaBUR3e
         6WJXt3gJCrVYrE6iUB+NCjxWG7ic+zPM212QdjvoXlbQMU4vzSY3MQU87owPsptOqT/y
         676B9gMbA96gppv/gH3P4LmpCbrjfCl8rniIptdX0NcwtwTsE5swq5J+2XJGwIhu9L+f
         IpPzzLWRiJ+y8c4RnLxqmL0O9Y+15oMIGgFRqPMtgi1LzkluYVwAEhooE0/jDIbQKroI
         1NdQ==
X-Gm-Message-State: AOAM533p8lcjNTYHzsjl139CDYe8sDuOJGPUiEnCaYU7g8qMVJtDs+gi
        qw43+Zke8KyWUQfUCZNQLik=
X-Google-Smtp-Source: ABdhPJxrDMkTfsE+n8kPSX8CTOGBsko0o+ZFdxeP8RfEW0GLghp7Rl1h9HIZYuuKDW9677L/c90KGQ==
X-Received: by 2002:a63:d80a:: with SMTP id b10mr2569662pgh.47.1627002836706;
        Thu, 22 Jul 2021 18:13:56 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id t30sm4899762pgl.47.2021.07.22.18.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 18:13:56 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: yang.yang29@zte.com.cn
To:     sterlingteng@gmail.com
Cc:     alexs@kernel.org, corbet@lwn.net, yang.yang29@zte.com.cn,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCHv2] docs/zh_CN: Add zh_CN/accounting/psi.rst
Date:   Thu, 22 Jul 2021 18:14:30 -0700
Message-Id: <20210723011430.404813-1-yang.yang29@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Yang <yang.yang29@zte.com.cn>

Add translation zh_CN/accounting/psi.rst and zh_CN/accounting/index.rst.

Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
---
 .../translations/zh_CN/accounting/index.rst   |  23 +++
 .../translations/zh_CN/accounting/psi.rst     | 154 ++++++++++++++++++
 2 files changed, 177 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/accounting/index.rst
 create mode 100644 Documentation/translations/zh_CN/accounting/psi.rst

diff --git a/Documentation/translations/zh_CN/accounting/index.rst b/Documentation/translations/zh_CN/accounting/index.rst
new file mode 100644
index 000000000000..f50e81bc5e61
--- /dev/null
+++ b/Documentation/translations/zh_CN/accounting/index.rst
@@ -0,0 +1,23 @@
+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: :doc:`../../../accounting/index`
+:Translator: Yang Yang <yang.yang29@zte.com.cn>
+
+.. _cn_accounting_index.rst:
+
+
+====
+计数
+====
+
+.. toctree::
+   :maxdepth: 1
+
+   psi
+
+Todolist:
+
+   cgroupstats
+   delay-accounting
+   taskstats
+   taskstats-struct
diff --git a/Documentation/translations/zh_CN/accounting/psi.rst b/Documentation/translations/zh_CN/accounting/psi.rst
new file mode 100644
index 000000000000..6c999e80e5d4
--- /dev/null
+++ b/Documentation/translations/zh_CN/accounting/psi.rst
@@ -0,0 +1,154 @@
+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: Documentation/accounting/psi.rst
+:Translator: Yang Yang <yang.yang29@zte.com.cn>
+
+.. _cn_accounting_psi.rst:
+
+=================
+PSI——压力阻塞信息
+=================
+
+:日期: April, 2018
+:作者: Johannes Weiner <hannes@cmpxchg.org>
+
+当CPU、memory或IO设备处于竞争状态，业务负载会遭受时延毛刺、吞吐量降低，
+及面临OOM的风险。
+
+如果没有一种准确的方法度量系统竞争程度，则有两种后果：一种是用户过于节制，
+未充分利用系统资源；另一种是过度使用，经常性面临业务中断的风险。
+
+psi特性能够识别和量化资源竞争导致的业务中断，及其对复杂负载乃至整个系统在
+时间上的影响。
+
+准确度量因资源不足造成的生产力损失，有助于用户基于硬件调整业务负载，或基
+于业务负载配置硬件。
+
+psi能够实时的提供相关信息，因此系统可基于psi实现动态的负载管理。如实施
+卸载、迁移、策略性的停止或杀死低优先级或可重启的批处理任务。
+
+psi帮助用户实现硬件资源利用率的最大化。同时无需牺牲业务负载健康度，也无需
+面临OOM等造成业务中断的风险。
+
+压力接口
+========
+
+压力信息可通过/proc/pressure/ --cpu、memory、io文件分别获取。
+
+CPU相关信息格式如下：
+
+        some avg10=0.00 avg60=0.00 avg300=0.00 total=0
+
+内存和IO相关信息如下：
+
+        some avg10=0.00 avg60=0.00 avg300=0.00 total=0
+        full avg10=0.00 avg60=0.00 avg300=0.00 total=0
+
+some行代表至少有一个任务阻塞于特定资源的时间占比。
+
+full行代表所有非idle任务同时阻塞于特定资源的时间占比。在这种状态下CPU资源
+完全被浪费，相对于正常运行，业务负载由于耗费更多时间等待而受到严重影响。
+
+由于此情况严重影响系统性能，因此清楚的识别本情况并与some行所代表的情况区分开，
+将有助于分析及提升系统性能。这就是full独立于some行的原因。
+
+avg代表阻塞时间占比（百分比），为最近10秒、60秒、300秒内的均值。这样我们
+既可观察到短期事件的影响，也可看到中等及长时间内的趋势。total代表总阻塞
+时间（单位微秒），可用于观察时延毛刺，这种毛刺可能在均值中无法体现。
+
+监控压力门限
+============
+
+用户可注册触发器，通过poll()监控资源压力是否超过门限。
+
+触发器定义：指定时间窗口期内累积阻塞时间的最大值。比如可定义500ms内积累
+100ms阻塞，即触发一次唤醒事件。
+
+触发器注册方法：用户打开代表特定资源的psi接口文件，写入门限、时间窗口的值。
+所打开的文件描述符用于等待事件，可使用select()、poll()、epoll()。
+写入信息的格式如下：
+
+        <some|full> <stall amount in us> <time window in us>
+
+示例：向/proc/pressure/memory写入"some 150000 1000000"将新增触发器，将在
+1秒内至少一个任务阻塞于内存的总时间超过150ms时触发。向/proc/pressure/io写入
+"full 50000 1000000"将新增触发器，将在1秒内所有任务都阻塞于io的总时间超过50ms时触发。
+
+触发器可针对多个psi度量值设置，同一个psi度量值可设置多个触发器。每个触发器需要
+单独的文件描述符用于轮询，以区分于其他触发器。所以即使对于同一个psi接口文件，
+每个触发器也需要单独的调用open()。
+
+监控器在被监控资源进入阻塞状态时启动，在系统退出阻塞状态后停用。系统进入阻塞
+状态后，监控psi增长的频率为每监控窗口刷新10次。
+
+内核接受的窗口为500ms~10s，所以监控间隔为50ms~1s。设置窗口下限目的是为了
+防止过于频繁的轮询。设置窗口上限的目的是因为窗口过长则无意义，此时查看
+psi接口提供的均值即可。
+
+监控器在激活后，至少在跟踪窗口期间将保持活动状态。以避免随着系统进入和退出
+阻塞状态，监控器过于频繁的进入和退出活动状态。
+
+用户态通知在监控窗口内会受到速率限制。当对应的文件描述符关闭，触发器会自动注销。
+
+用户态监控器使用示例
+====================
+
+::
+
+  #include <errno.h>
+  #include <fcntl.h>
+  #include <stdio.h>
+  #include <poll.h>
+  #include <string.h>
+  #include <unistd.h>
+
+  /* 监控内存部分阻塞，监控时间窗口为1秒、阻塞门限为150毫秒。*/
+  int main() {
+        const char trig[] = "some 150000 1000000";
+        struct pollfd fds;
+        int n;
+
+        fds.fd = open("/proc/pressure/memory", O_RDWR | O_NONBLOCK);
+        if (fds.fd < 0) {
+                printf("/proc/pressure/memory open error: %s\n",
+                        strerror(errno));
+                return 1;
+        }
+        fds.events = POLLPRI;
+
+        if (write(fds.fd, trig, strlen(trig) + 1) < 0) {
+                printf("/proc/pressure/memory write error: %s\n",
+                        strerror(errno));
+                return 1;
+        }
+
+        printf("waiting for events...\n");
+        while (1) {
+                n = poll(&fds, 1, -1);
+                if (n < 0) {
+                        printf("poll error: %s\n", strerror(errno));
+                        return 1;
+                }
+                if (fds.revents & POLLERR) {
+                        printf("got POLLERR, event source is gone\n");
+                        return 0;
+                }
+                if (fds.revents & POLLPRI) {
+                        printf("event triggered!\n");
+                } else {
+                        printf("unknown event received: 0x%x\n", fds.revents);
+                        return 1;
+                }
+        }
+
+        return 0;
+  }
+
+Cgroup2接口
+===========
+
+对于CONFIG_CGROUP=y及挂载了cgroup2文件系统的系统，能够获取cgroups内任务的psi。
+此场景下cgroupfs挂载点的子目录包含cpu.pressure、memory.pressure、io.pressure文件，
+内容格式与/proc/pressure/下的文件相同。
+
+可设置基于cgroup的psi监控器，方法与系统级psi监控器相同。
-- 
2.25.1

