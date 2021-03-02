Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA8A32A13D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347564AbhCBFa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 00:30:56 -0500
Received: from regular1.263xmail.com ([211.150.70.205]:58134 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574079AbhCBD3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 22:29:08 -0500
Received: from localhost (unknown [192.168.167.16])
        by regular1.263xmail.com (Postfix) with ESMTP id 9DB1AA76;
        Tue,  2 Mar 2021 11:22:21 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-CHECKED: 0
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from localhost (unknown [61.183.83.60])
        by smtp.263.net (postfix) whith ESMTP id P32470T140679093151488S1614655340737397_;
        Tue, 02 Mar 2021 11:22:21 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <4f7c211292cf42a0a29263a794746c6a>
X-RL-SENDER: huangjianghui@uniontech.com
X-SENDER: huangjianghui@uniontech.com
X-LOGIN-NAME: huangjianghui@uniontech.com
X-FST-TO: corbet@lwn.net
X-SENDER-IP: 61.183.83.60
X-ATTACHMENT-NUM: 1
X-System-Flag: 0
Date:   Tue, 2 Mar 2021 11:22:20 +0800
From:   huangjianghui <huangjianghui@uniontech.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Harry Wei <harryxiyou@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PATCH Documentation translations:translate
 sound/hd-audio/controls to chinese
Message-ID: <20210302032220.GA938@akg>
Reply-To: huangjianghui@uniontech.com
References: <20210301122019.80234-1-huangjianghui@uniontech.com>
 <8735xe4lsb.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8735xe4lsb.fsf@meer.lwn.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 01, 2021 at 02:16:36PM -0700, Jonathan Corbet wrote:
> 
> So you have sent me two versions of this in the last 24 hours with no
> indication of what has changed or why I should prefer one over the
> other.  Always include that information (under the "---" line) when you
> send updated versions.
> 
> It looks like you got a Reviewed-by tag from Alex on the other version,
> but that doesn't appear here; why?
> 
> [...]
> 
Thank you very much for your advices, I sent two emails ,and As a
result,I lost the reviewed information of Mr. Alex,I'm sorry for causing of
the result.

[...]
> So you list a bunch of files here, but most of them are not added in
> your patch.  That will, of course, break the docs build.
> 
> 
> What are all of these files?
> 
> Please fix these issues and make sure that the docs build runs correctly
> before resubmitting.
> 
> Thanks,
> 
> jon
> 
> 
In the next patch ,I deleted the index of the untranstated files,and i
used checkpatch.pl to detect doc errors and tried to built the htmldocs
on my pc.

Thanks,

Huang Jianghui

--FL5UXtIhxfXey3p5
Content-Type: text/x-diff; charset=gb2312
Content-Disposition: attachment; filename="0001-PATCH-Documentation-translations-translate-sound-hd-.patch"
Content-Transfer-Encoding: 8bit

From 47c05e4fe540e938fc7a9fa13a2f8698579a4744 Mon Sep 17 00:00:00 2001
From: hjh <huangjianghui@uniontech.com>
Date: Tue, 2 Mar 2021 10:52:18 +0800
Subject: [PATCH] PATCH Documentation translations:translate
 sound/hd-audio/controls to chinese

Signed-off-by: hjh <huangjianghui@uniontech.com>
---
 Documentation/translations/zh_CN/index.rst    |   1 +
 .../zh_CN/sound/hd-audio/controls.rst         | 102 ++++++++++++++++++
 .../zh_CN/sound/hd-audio/index.rst            |  14 +++
 .../translations/zh_CN/sound/index.rst        |  22 ++++
 4 files changed, 139 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/sound/hd-audio/controls.rst
 create mode 100644 Documentation/translations/zh_CN/sound/hd-audio/index.rst
 create mode 100644 Documentation/translations/zh_CN/sound/index.rst

diff --git a/Documentation/translations/zh_CN/index.rst b/Documentation/translations/zh_CN/index.rst
index be6f11176200..2767dacfe86d 100644
--- a/Documentation/translations/zh_CN/index.rst
+++ b/Documentation/translations/zh_CN/index.rst
@@ -20,6 +20,7 @@
    process/index
    filesystems/index
    arm64/index
+   sound/index
 
 目录和表格
 ----------
diff --git a/Documentation/translations/zh_CN/sound/hd-audio/controls.rst b/Documentation/translations/zh_CN/sound/hd-audio/controls.rst
new file mode 100644
index 000000000000..54c028ab9a40
--- /dev/null
+++ b/Documentation/translations/zh_CN/sound/hd-audio/controls.rst
@@ -0,0 +1,102 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Chinese translator: Huang Jianghui <huangjianghui@uniontech.com>
+---------------------------------------------------------------------
+.. include:: ../../disclaimer-zh_CN.rst
+以下为正文
+---------------------------------------------------------------------
+======================================
+高清音频编解码器特定混音器控件
+======================================
+
+
+此文件解释特定于编解码器的混音器控件.
+
+瑞昱编解码器
+------------
+
+声道模式
+  这是一个用于更改环绕声道设置的枚举控件,仅在环绕声道打开时显示出现。
+  它给出要使用的通道数:"2ch","4ch","6ch"，和"8ch"。根据配置，这还控
+  制多I/O插孔的插孔重分配。
+
+自动静音模式
+  这是一个枚举控件，用于更改耳机和线路输出插孔的自动静音行为。如果内
+  置扬声器、耳机和/或线路输出插孔在机器上可用，则显示该控件。当只有
+  耳机或者线路输出的时候，它给出”禁用“和”启用“状态。当启用后，插孔插
+  入后扬声器会自动静音。
+
+  当耳机和线路输出插孔都存在时，它给出”禁用“、”仅扬声器“和”线路输出+扬
+  声器“。当”仅扬声器“被选择，插入耳机或者线路输出插孔可使扬声器静音，
+  但不会使线路输出静音。当线路输出+扬声器被选择，插入耳机插孔会同时使扬
+  声器和线路输出静音。
+
+
+矽玛特编解码器
+--------------
+
+模拟环回
+   此控件启用/禁用模拟环回电路。只有在编解码器提示中将”lookback“设置为真
+   时才会出现(见HD-Audio.txt)。请注意，在某些编解码器上，模拟环回和正常
+   PCM播放是独占的,即当此选项打开时，您将听不到任何PCM流。
+
+交换中置/低频
+   交换中置和低频通道顺序，通常情况下，左侧对应中置，右侧对应低频,启动此
+   项后，左边低频，右边中置。
+
+耳机作为线路输出
+   当此控制开启时，将耳机视为线路输出插孔。也就是说，耳机不会自动静音其他
+   线路输出，没有耳机放大器被设置到引脚上。
+
+麦克风插口模式、线路插孔模式等
+   这些枚举控制输入插孔引脚的方向和偏置。根据插孔类型，它可以设置为”麦克风
+   输入“和”线路输入“以确定输入偏置,或者当引脚是环绕声道的多I/O插孔时，它
+   可以设置为”线路输出“。
+
+
+威盛编解码器
+------------
+
+智能5.1
+   一个枚举控件，用于为环绕输出重新分配多个I/O插孔的任务。当它打开时，相应
+   的输入插孔（通常是线路输入和麦克风输入）被切换为环绕和中央低频输出插孔。
+
+独立耳机
+   启用此枚举控制时，耳机输出从单个流（第三个PCM，如hw:0,2）而不是主流路由。
+   如果耳机DAC与侧边或中央低频通道DAC共享，则DAC将自动切换到耳机。
+
+环回混合
+   一个用于确定是否启动了模拟环回路由的枚举控件。当它启用后，模拟环回路由到
+   前置通道。同样，耳机与扬声器输出也采用相同的路径。作为一个副作用，当设置
+   此模式后，单个音量控制将不再适用于耳机和扬声器，因为只有一个DAC连接到混
+   音器小部件。
+
+动态电源控制
+   此控件决定是否启动每个插孔的动态电源控制检测。启用时，根据插孔的插入情况
+   动态更改组件的电源状态（D0/D3）以节省电量消耗。但是，如果您的系统没有提
+   供正确的插孔检测，这将无法工作;在这种情况下，请关闭此控件。
+
+插孔检测
+   此控件仅为VT1708编解码器提供，它不会为每个插孔插拔提供适当的未请求事件。
+   当此控件打开，驱动将轮询插孔检测，以便耳机自动静音可以工作，而关闭此控
+   件将降低功耗。
+
+
+科胜讯编解码器
+--------------
+
+自动静音模式
+   见瑞昱解码器
+
+
+
+模拟编解码器
+------------
+
+通道模式
+   这是一个用于更改环绕声道设置的枚举控件,仅在环绕声道可用时显示。它提供了能
+   被使用的通道数:”2ch“、”4ch“和”6ch“。根据配置，这还控制多I/O插孔的插孔重
+   分配。
+
+独立耳机
+   启动此枚举控制后，耳机输出从单个流（第三个PCM，如hw:0,2）而不是主流路由。
diff --git a/Documentation/translations/zh_CN/sound/hd-audio/index.rst b/Documentation/translations/zh_CN/sound/hd-audio/index.rst
new file mode 100644
index 000000000000..d9885d53b069
--- /dev/null
+++ b/Documentation/translations/zh_CN/sound/hd-audio/index.rst
@@ -0,0 +1,14 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: ../../disclaimer-zh_CN.rst
+
+:Original: :doc:`../../../../sound/hd-audio/index`
+:Translator: Huang Jianghui <huangjianghui@uniontech.com>
+
+
+高清音频
+========
+
+.. toctree::
+   :maxdepth: 2
+
+   controls
diff --git a/Documentation/translations/zh_CN/sound/index.rst b/Documentation/translations/zh_CN/sound/index.rst
new file mode 100644
index 000000000000..28d5dca34a63
--- /dev/null
+++ b/Documentation/translations/zh_CN/sound/index.rst
@@ -0,0 +1,22 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: :doc:`../../../sound/index`
+:Translator: Huang Jianghui <huangjianghui@uniontech.com>
+
+
+====================
+Linux 声音子系统文档
+====================
+
+.. toctree::
+   :maxdepth: 2
+
+   hd-audio/index
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
-- 
2.20.1


--FL5UXtIhxfXey3p5--


