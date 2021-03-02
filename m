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
 
 Ŀ¼�ͱ��
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
+����Ϊ����
+---------------------------------------------------------------------
+======================================
+������Ƶ��������ض��������ؼ�
+======================================
+
+
+���ļ������ض��ڱ�������Ļ������ؼ�.
+
+���ű������
+------------
+
+����ģʽ
+  ����һ�����ڸ��Ļ����������õ�ö�ٿؼ�,���ڻ���������ʱ��ʾ���֡�
+  ������Ҫʹ�õ�ͨ����:"2ch","4ch","6ch"����"8ch"���������ã��⻹��
+  �ƶ�I/O��׵Ĳ���ط��䡣
+
+�Զ�����ģʽ
+  ����һ��ö�ٿؼ������ڸ��Ķ�������·�����׵��Զ�������Ϊ�������
+  ����������������/����·�������ڻ����Ͽ��ã�����ʾ�ÿؼ�����ֻ��
+  ����������·�����ʱ�������������á��͡����á�״̬�������ú󣬲�ײ�
+  ������������Զ�������
+
+  ����������·�����׶�����ʱ�������������á����������������͡���·���+��
+  ������������������������ѡ�񣬲������������·�����׿�ʹ������������
+  ������ʹ��·�������������·���+��������ѡ�񣬲��������׻�ͬʱʹ��
+  ��������·���������
+
+
+�����ر������
+--------------
+
+ģ�⻷��
+   �˿ؼ�����/����ģ�⻷�ص�·��ֻ���ڱ��������ʾ�н���lookback������Ϊ��
+   ʱ�Ż����(��HD-Audio.txt)����ע�⣬��ĳЩ��������ϣ�ģ�⻷�غ�����
+   PCM�����Ƕ�ռ��,������ѡ���ʱ�������������κ�PCM����
+
+��������/��Ƶ
+   �������ú͵�Ƶͨ��˳��ͨ������£�����Ӧ���ã��Ҳ��Ӧ��Ƶ,������
+   �����ߵ�Ƶ���ұ����á�
+
+������Ϊ��·���
+   ���˿��ƿ���ʱ����������Ϊ��·�����ס�Ҳ����˵�����������Զ���������
+   ��·�����û�ж����Ŵ��������õ������ϡ�
+
+��˷���ģʽ����·���ģʽ��
+   ��Щö�ٿ������������ŵķ����ƫ�á����ݲ�����ͣ�����������Ϊ����˷�
+   ���롰�͡���·���롰��ȷ������ƫ��,���ߵ������ǻ��������Ķ�I/O���ʱ����
+   ��������Ϊ����·�������
+
+
+��ʢ�������
+------------
+
+����5.1
+   һ��ö�ٿؼ�������Ϊ����������·�����I/O��׵����񡣵�����ʱ����Ӧ
+   �������ף�ͨ������·�������˷����룩���л�Ϊ���ƺ������Ƶ�����ס�
+
+��������
+   ���ô�ö�ٿ���ʱ����������ӵ�������������PCM����hw:0,2������������·�ɡ�
+   �������DAC���߻������Ƶͨ��DAC������DAC���Զ��л���������
+
+���ػ��
+   һ������ȷ���Ƿ�������ģ�⻷��·�ɵ�ö�ٿؼ����������ú�ģ�⻷��·�ɵ�
+   ǰ��ͨ����ͬ�������������������Ҳ������ͬ��·������Ϊһ�������ã�������
+   ��ģʽ�󣬵����������ƽ����������ڶ���������������Ϊֻ��һ��DAC���ӵ���
+   ����С������
+
+��̬��Դ����
+   �˿ؼ������Ƿ�����ÿ����׵Ķ�̬��Դ���Ƽ�⡣����ʱ�����ݲ�׵Ĳ������
+   ��̬��������ĵ�Դ״̬��D0/D3���Խ�ʡ�������ġ����ǣ��������ϵͳû����
+   ����ȷ�Ĳ�׼�⣬�⽫�޷�����;����������£���رմ˿ؼ���
+
+��׼��
+   �˿ؼ���ΪVT1708��������ṩ��������Ϊÿ����ײ���ṩ�ʵ���δ�����¼���
+   ���˿ؼ��򿪣���������ѯ��׼�⣬�Ա�����Զ��������Թ��������رմ˿�
+   �������͹��ġ�
+
+
+��ʤѶ�������
+--------------
+
+�Զ�����ģʽ
+   �����Ž�����
+
+
+
+ģ��������
+------------
+
+ͨ��ģʽ
+   ����һ�����ڸ��Ļ����������õ�ö�ٿؼ�,���ڻ�����������ʱ��ʾ�����ṩ����
+   ��ʹ�õ�ͨ����:��2ch������4ch���͡�6ch�����������ã��⻹���ƶ�I/O��׵Ĳ����
+   ���䡣
+
+��������
+   ������ö�ٿ��ƺ󣬶�������ӵ�������������PCM����hw:0,2������������·�ɡ�
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
+������Ƶ
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
+Linux ������ϵͳ�ĵ�
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


