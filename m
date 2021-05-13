Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42EBB37FAF9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 17:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbhEMPqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 11:46:24 -0400
Received: from m12-18.163.com ([220.181.12.18]:37122 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229724AbhEMPqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 11:46:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Vg1i4
        JnEVrC30pUtE31hOKpLd5CgEV4D/izw1/ldg84=; b=dKRCqS4neoJV+S1Vvcelq
        gw2kl9YmmMEFCt636ixXpu4pB3FxBMZZri9ItgOCQuh/RrFCXuE0XdiWulRpxfn1
        6/IJGLV8UcVuVocSCznjn5CrW1nW20jaTuSQ1fb3ySTQVOqp4oBzDnwbMeRauoKr
        1ZYzVzFXixmrYYngf8FDvw=
Received: from localhost.localdomain (unknown [36.170.37.157])
        by smtp14 (Coremail) with SMTP id EsCowACHe7tvSZ1gxy72jA--.63931S2;
        Thu, 13 May 2021 23:44:48 +0800 (CST)
From:   Hailong Liu <liuhailongg6@163.com>
To:     Alex Shi <alexs@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hailong Liu <liu.hailong6@zte.com.cn>
Subject: [PATCH] docs/zh_CN: Add zh_CN/admin-guide/lockup-watchdogs.rst
Date:   Thu, 13 May 2021 23:44:25 +0800
Message-Id: <20210513154425.93603-1-liuhailongg6@163.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EsCowACHe7tvSZ1gxy72jA--.63931S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUDHqcUUUUU
X-Originating-IP: [36.170.37.157]
X-CM-SenderInfo: xolxxtxlor0wjjw6il2tof0z/1tbiDRCRYFQHWILGqAAAsL
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hailong Liu <liu.hailong6@zte.com.cn>

Add translation zh_CN/admin-guide/lockup-watchdogs.rst and link it to
zh_CN/admin-guide/index.rst while clean its todo entry.

Signed-off-by: Hailong Liu <liu.hailong6@zte.com.cn>
---
 .../translations/zh_CN/admin-guide/index.rst  |  2 +-
 .../zh_CN/admin-guide/lockup-watchdogs.rst    | 65 +++++++++++++++++++
 2 files changed, 66 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/translations/zh_CN/admin-guide/lockup-watchdogs.rst

diff --git a/Documentation/translations/zh_CN/admin-guide/index.rst b/Documentation/translations/zh_CN/admin-guide/index.rst
index be835ec8e632..460034cbc2ab 100644
--- a/Documentation/translations/zh_CN/admin-guide/index.rst
+++ b/Documentation/translations/zh_CN/admin-guide/index.rst
@@ -65,6 +65,7 @@ Todolist:
 
    clearing-warn-once
    cpu-load
+   lockup-watchdogs
    unicode
 
 Todolist:
@@ -100,7 +101,6 @@ Todolist:
    laptops/index
    lcd-panel-cgram
    ldm
-   lockup-watchdogs
    LSM/index
    md
    media/index
diff --git a/Documentation/translations/zh_CN/admin-guide/lockup-watchdogs.rst b/Documentation/translations/zh_CN/admin-guide/lockup-watchdogs.rst
new file mode 100644
index 000000000000..1dd1e8061781
--- /dev/null
+++ b/Documentation/translations/zh_CN/admin-guide/lockup-watchdogs.rst
@@ -0,0 +1,65 @@
+===============================================================
+Softlockup与hardlockup检测机制(又名:nmi_watchdog)
+===============================================================
+
+Linux中内核实现了一种用以检测系统发生softlockup和hardlockup的
+看门狗机制。
+
+Softlockup是一种在内核持续循使用CPU超过20秒（详见下面“实现”小节）
+导致其他任务无法得到运行的内核问题。一旦检测到'softlockup'发生，默认
+情况下系统会打印当前堆栈跟踪信息并进入锁定状态。也可配置使其在检测到
+'softlockup'后进入panic状态；通过sysctl命令设置
+“kernel.softlockup_panic”、使用内核启动参数“softlockup_panic”（详见
+Documentation/admin-guide/kernel-parameters.rst）以及使能内核编译选项
+“BOOTPARAM_SOFTLOCKUP_PANIC”都可实现这种配置。
+
+而'hardlockup'是内核中持续循环超过10秒钟（详见"实现"小节）导致其他中
+断无法运行的问题。与'softlockup'情况类似，除了使用sysctl命令设置
+'hardlockup_panic'、使能内核选项“BOOTPARAM_HARDLOCKUP_PANIC”以及使用
+内核参数"nmi_watchdog"(详见:
+”Documentation/admin-guide/kernel-parameters.rst“)外，一旦检测到
+'hardlockup'默认情况下系统打印当前堆栈跟踪信息，然后进入锁定状态。
+
+这个panic选项也可以与panic_timeout结合使用（这个panic_timeout是通过稍
+具迷惑性的sysctl命令"kernel.panic"来设置），使系统在panic指定时间后自
+动重启。
+
+实现
+==============
+
+Softlockup和hardlockup分别建立hrtimer(高精度定时器)和perf两个子系统上
+而实现。这也就意味着理论上任何架构只要实现了这两个子系统就支持这两种
+检测机制。
+
+Hrtimer用于周期性产生中断并唤醒watchdog任务；而NMI perf事件则以
+”watchdog_thresh“(编译时默认初始化为10秒，也可通过”watchdog_thresh“这
+个sysctl接口来进行配置修改)为间隔周期产生以检测 hardlockups。如果一个
+CPU在这个时间段内没有检测到hrtimer中断发生，'hardlockup 检测器'(即
+NMI perf事件处理函数)将会视系统配置而选择产生内核告警或者直接panic。
+
+而watchdog任务本质上是一个高优先级内核线程，每调度一次就对时间戳进行一
+次更新。如果在时间戳在2*watchdog_thresh秒(这个是softlockup的触发门限)
+都未更新那么"softlocup 检测器"(内部hrtimer定时器回调函数)会将相关的调试
+信息打印到系统日志中，然后如果系统配置了进入panic流程则进入panic，否则
+内核继续执行。
+
+Hrtimer定时器的周期是2*watchdog_thresh/5，也就是说在hardlockup被触发前
+hrtimer有2~3次机会产生时钟中断。
+
+如上所述,内核相当于为系统管理员提供了一个可调节hrtimer定时器和perf事件
+的周期长短的旋钮。对于特定的场景通过这个旋钮配置一个合理的周期值需要权
+衡lockups检测的响应速度和检测的开销。
+
+默认情况下所有在线cpu上都会运行一个watchdog任务。不过在内核配置了
+”NO_HZ_FULL“的情况下watchdog默认只会运行在管家(housekeeping)cpu上，而
+”nohz_full“启动参数指定的cpu上则不会有watchdog任务运行。想象一下，如果
+我们允许watchdog任务在”nohz_full“指定的cpu上运行，这些cpu上必须得运行时
+钟定时器来激发watchdog任务调度；这样一来就会使”nohz_full“保护用户程序免
+受内核干扰的功能失效。当然，副作用就是”nohz_full“指定的cpu即使在内核产生
+了lockup问题我们也无法检测到。不过，至少我们可以允许watchdog在管家
+(non-tickless)核上继续运行以便我们能够继续正常的监测这些cpus上的lockups
+事件。
+
+不论哪种情况都可以通过sysctl命令kernel.watchdog_cpumask来调节未运行
+watchdog的cpu集合.对于nohz_full而言,如果nohz_full cpu上有异常挂住的情况,
+通过这种方式打开这些cpu上的watchdog进行调试可能会有所作用。
-- 
2.17.1


