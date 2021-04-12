Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 527AF35BA94
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 09:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236685AbhDLHHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 03:07:10 -0400
Received: from m34-101.88.com ([104.250.34.101]:48985 "EHLO 88.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236723AbhDLHHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 03:07:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=Date:From:To; bh=moVHyQAZ6oxVMQFeudqurqd9+jl+1rUPLRZAJ
        cQBWjw=; b=KFEgSHm61mwojhs0eKBxnu6v4PF1YOTQYQatx5bBAu7hC/PuFvrPh
        N/tbuRIhsltw2FzubzBzLslieQ+EYuKw6QxKkCovoj+aGN243F4do+FghKNZsomy
        TdL/Bh0aRkW9UbacRPD82c1a/ff46rVkanMILEVEoljdKy1SRlXWzg=
Received: from bobwxc.top (unknown [120.238.248.129])
        by v_coremail2-frontend-1 (Coremail) with SMTP id LCKnCgA3qtA98XNg3M1YAA--.2987S2;
        Mon, 12 Apr 2021 15:05:35 +0800 (CST)
Date:   Mon, 12 Apr 2021 15:05:33 +0800
From:   Wu XiangCheng <bobwxc@email.cn>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Alex Shi <alexs@kernel.org>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Tsugikazu Shibata <tshibata@ab.jp.nec.com>,
        SeongJae Park <sjpark@amazon.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC 2/2] docs: doc-guide: Add document for scripts/trslt.py
Message-ID: <374c192541187d9493e83f1f2a99e4b1ca83cf62.1618208899.git.bobwxc@email.cn>
References: <cover.1618208899.git.bobwxc@email.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1618208899.git.bobwxc@email.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CM-TRANSID: LCKnCgA3qtA98XNg3M1YAA--.2987S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuFW5ArykGr4DZrWrJF4ktFb_yoWfCF4rpF
        98KFyxKasrJry7Ar1fGF47JF1fJFWxKw4UArn7twn3JFWqyryvyr47t3s3KF97Gry0vFWj
        qa1jyFWUWr1UZ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgSb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
        cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
        v20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2
        z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0x
        vYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VCjz48v1sIEY20_
        Cr1UJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkIecxEwVAFwVW8CwCF04
        k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26F4UJr1UMxC20s026xCaFVCjc4AY6r1j
        6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
        AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
        2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
        C2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kfnx
        nUUI43ZEXa7IUntxhJUUUUU==
X-Originating-IP: [120.238.248.129]
X-CM-SenderInfo: pere453f6hztlloou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add document for new translation tool scripts/trslt.py
and link it to doc-guide/index.rst

Signed-off-by: Wu XiangCheng <bobwxc@email.cn>
---
 Documentation/doc-guide/index.rst |   1 +
 Documentation/doc-guide/trslt.rst | 233 ++++++++++++++++++++++++++++++
 2 files changed, 234 insertions(+)
 create mode 100644 Documentation/doc-guide/trslt.rst

diff --git a/Documentation/doc-guide/index.rst b/Documentation/doc-guide/index.rst
index 7c7d97784626..441722cdd3fc 100644
--- a/Documentation/doc-guide/index.rst
+++ b/Documentation/doc-guide/index.rst
@@ -12,6 +12,7 @@ How to write kernel documentation
    parse-headers
    contributing
    maintainer-profile
+   trslt
 
 .. only::  subproject and html
 
diff --git a/Documentation/doc-guide/trslt.rst b/Documentation/doc-guide/trslt.rst
new file mode 100644
index 000000000000..df77c5a13500
--- /dev/null
+++ b/Documentation/doc-guide/trslt.rst
@@ -0,0 +1,233 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+.. _trslt:
+
+===========================================
+Kernel Documentation Translation File tool
+===========================================
+
+:Author: Wu XiangCheng <bobwxc@email.cn>
+
+This document is for ``scripts/trslt.py``.
+
+Motivation
+-----------
+
+For a long time, kernel documentation translations lacks a way to control the
+version corresponding to the source files. If you translate a file and then
+someone updates the source file, there will be a problem. It's hard to know
+which version the existing translation corresponds to, and even harder to sync
+them. The common way now is to check the date, but this is not exactly accurate,
+especially for documents that are often updated.
+
+So, some translators write corresponding commit ID in the commit log for
+reference, it is a good way, but still a little troublesome.
+
+Thus, the purpose of ``trslt.py`` is to add a new annotating tag to the file to
+indicate the corresponding version of the source file::
+
+	.. translation_origin_commit: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
+
+The script will automatically copy file and generate tag when creating new
+translation, and give update suggestions based on those tags when updating
+translations.
+
+Dependency
+-----------
+
+:Language: Python 3.x
+
+:Python Libraries:
+
+ os
+
+ argparse
+
+ subprocess
+
+Usage
+------
+
+``trslt.py`` comes with a help message:: 
+
+	➜ scripts/trslt.py -h                                                         
+	usage: trslt.py [-h] [-v] [-l {it_IT,ja_JP,ko_KR,zh_CN}] (-c | -u) file
+	
+	Linux Kernel Documentation Translation File Tool
+	
+	positional arguments:
+	  file                  specific file path
+	
+	optional arguments:
+	  -h, --help            show this help message and exit
+	  -v, --verbose         enable verbose mode
+	  -l {it_IT,ja_JP,ko_KR,zh_CN}, --language {it_IT,ja_JP,ko_KR,zh_CN}
+	                        choose translation language, default: zh_CN
+	  -c, --copy            copy a origin file to translation directory
+	  -u, --update          get a translation file's update information
+
+We could learn some basic operation methods from this help message. See below
+for details.
+
+.. note::
+
+	``trslt.py`` should be called in Linux kernel source **ROOT** directory or 
+	"Documentation/", "Documentation/translations/", "Documentation/translations/ll_NN/".
+	Anyway, don't worry, it will remind you when using a wrong directory.
+
+Verbose mode
+~~~~~~~~~~~~~
+
+``-v, --verbose``
+
+As its name said, ``-v`` is used to turn on the verbose mode. Then will show
+more informations, something is better than nothing.
+
+
+Choose language
+~~~~~~~~~~~~~~~~
+
+``-l, --language``
+
+As a translator, you need to select the language you prefer. And this script 
+also need to decide which language directory should be used.
+
+Simply give the language after ``-l``, like ``-l zh_CN``. If you do not give
+a choice, default is ``zh_CN``. 
+
+Now, we have four langugue(it_IT,ja_JP,ko_KR,zh_CN) to use, if you need others,
+please feel free to add it, only need to modify language choice list in
+``arg()`` of ``trslt.py`` and this document.
+
+Copy mode
+~~~~~~~~~~
+
+``-c, --copy``
+
+This action is used to copy a origin file to translation directory. If the file
+is existing, it will give a warning::
+
+	➜ scripts/trslt.py -c Documentation/admin-guide/perf-security.rst 
+	INFO: Documentation/translations/zh_CN/admin-guide/perf-security.rst has been created, please remember to edit it.
+
+	➜ scripts/trslt.py -c Documentation/admin-guide/perf-security.rst          
+	WARNING: Documentation/translations/zh_CN/admin-guide/perf-security.rst is existing, can not use copy, please try -u/--update!
+
+Also, it will auto add a commit-id tag and language special header::
+
+	:Original: Documentation/admin-guide/perf-security.rst
+
+	.. translation_origin_commit: a15cb2c1658417f9e8c7e84fe5d6ee0b63cbb9b0
+
+	:Translator: Name <email@example.com>
+
+The header could be used to include a unified declaration or localization tag.
+If you need a special header for your language, please modify ``la_head(fp, la)``
+in ``trslt.py``, simply add a ``elif`` condition.
+
+
+Update mode
+~~~~~~~~~~~~
+
+``-u, --update``
+
+This action is used to update a existing translation file. The translation file
+must have a commit-id tag for generating origin text diff file. If there is no
+commit-id tag or no need to update, it will remind you::
+
+	➜ scripts/trslt.py -u Documentation/translations/zh_CN/admin-guide/perf-security.rst
+	INFO: Documentation/translations/zh_CN/admin-guide/perf-security.rst.diff file has generated
+	INFO: if you want to update Documentation/translations/zh_CN/admin-guide/perf-security.rst, please Do Not Forget to update the translation_origin_commit tag. 
+
+	.. translation_origin_commit: a15cb2c1658417f9e8c7e84fe5d6ee0b63cbb9b0
+
+	➜ scripts/trslt.py -u Documentation/translations/zh_CN/admin-guide/perf-security.rst
+	INFO: Documentation/admin-guide/perf-security.rst does not have any change since a15cb2c1658417f9e8c7e84fe5d6ee0b63cbb9b0
+
+	➜ scripts/trslt.py -u Documentation/translations/zh_CN/admin-guide/index.rst 
+	WARNING: Documentation/translations/zh_CN/admin-guide/index.rst does not have a translation_origin_commit tag, can not generate a diff file, please add a tag if you want to update it.
+
+	.. translation_origin_commit: da514157c4f063527204adc8e9642a18a77fccc9
+
+.. important::
+
+	Please note, this action will auto generate a diff file, but it **will not
+	automatically add or change the commit-id**, only print it, you need to add
+	or change it by yourself!
+
+Workflow
+----------
+
+Describes two common workflows — start new and update existing.
+
+Start a new translation
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+To start a new translation, please use ``-c`` action::
+
+	➜ scripts/trslt.py -c Documentation/any-file
+
+If it's ok, translation file created successfully::
+
+	INFO: Documentation/translations/ll_NN/any-file has been created, please remember to edit it.
+
+Then you can start translation work.
+
+Or, get a warning::
+
+	WARNING: Documentation/translations/ll_NN/any-file is existing, can not use copy, please try -u/--update!
+
+	WARNING: seems you are copying a file only exist in translations/ dir
+
+Or, get a error::
+
+	ERROR: file does not in Linux Kernel source Documentation
+
+Update a existing translation
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+To update a existing translation, please use ``-u`` action::
+
+	➜ scripts/trslt.py -u Documentation/translations/ll_NN/any-file
+
+If everything is ok, script will generate a diff file of origin text from the 
+commit-id tag's id to newest, and print the newset commit-id tag::
+
+	INFO: Documentation/translations/ll_NN/any-file.diff file has generated
+	INFO: if you want to update Documentation/translations/ll_NN/any-file, please Do Not Forget to update the translation_origin_commit tag. 
+
+	.. translation_origin_commit: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
+
+So simply take a look to diff and update translation, also do not forget to 
+modify commit-id tag.
+
+Or the translation no need to update::
+
+	INFO: Documentation/any-file does not have any change since xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
+
+If the translation file does not have a commit-id tag::
+
+	WARNING: Documentation/translations/ll_NN/any-file does not have a translation_origin_commit tag, can not generate a diff file, please add a tag if you want to update it.
+
+	.. translation_origin_commit: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
+
+Please add the tag by hand if you want to update it.
+
+If you give a wrong file::
+
+	ERROR: Documentation/any-file does not belong to ll_NN translation!
+
+Why the name?
+--------------
+
+``trslt.py`` — tr(an)sl(a)t(or).
+
+Issues
+-------
+
+If you find any problem, please report issues to Wu XiangCheng <bobwxc@email.cn>
+
+Thanks
+--------
+
+Will be completed after RFC.
-- 
2.20.1

