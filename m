Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCD5F32A3D3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382594AbhCBJkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 04:40:06 -0500
Received: from regular1.263xmail.com ([211.150.70.206]:42332 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1838103AbhCBJUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 04:20:02 -0500
Received: from localhost (unknown [192.168.167.235])
        by regular1.263xmail.com (Postfix) with ESMTP id BD4561B4F;
        Tue,  2 Mar 2021 17:13:40 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from localhost (unknown [61.183.83.60])
        by smtp.263.net (postfix) whith ESMTP id P19727T140184846857984S1614676420050086_;
        Tue, 02 Mar 2021 17:13:41 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <a3313f4476994487b62986d71a2f37a4>
X-RL-SENDER: huangjianghui@uniontech.com
X-SENDER: huangjianghui@uniontech.com
X-LOGIN-NAME: huangjianghui@uniontech.com
X-FST-TO: alex.shi@linux.alibaba.com
X-SENDER-IP: 61.183.83.60
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Date:   Tue, 2 Mar 2021 17:13:39 +0800
From:   huangjianghui <huangjianghui@uniontech.com>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Harry Wei <harryxiyou@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PATCH Documentation translations:translate
 sound/hd-audio/controls to chinese
Message-ID: <20210302091339.GA12203@akg>
Reply-To: huangjianghui@uniontech.com
References: <20210301122019.80234-1-huangjianghui@uniontech.com>
 <8735xe4lsb.fsf@meer.lwn.net>
 <20210302032220.GA938@akg>
 <e9937016-3b09-fb43-8fbf-a6c9b21597ac@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e9937016-3b09-fb43-8fbf-a6c9b21597ac@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 03:34:33PM +0800, Alex Shi wrote:
> 
> 
> �� 2021/3/2 ����11:22, huangjianghui д��:
> >>
> > In the next patch ,I deleted the index of the untranstated files,and i
> > used checkpatch.pl to detect doc errors and tried to built the htmldocs
> > on my pc.
> > 
> > Thanks,
> > 
> > Huang Jianghui
> 
> Hi Jianghui,
> 
> we usually include patch into email instead of attach it as attachment.
> You can try use 'git send-email' to post your patches.
> 
> Thanks
> Alex
> 
> 

I am sorry to do those, my patch is shown below:

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

Thanks,
Huang Jianghui


