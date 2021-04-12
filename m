Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 390BE35BA8B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 09:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236742AbhDLHEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 03:04:35 -0400
Received: from m32-153.88.com ([43.250.32.153]:28046 "EHLO email.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236569AbhDLHEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 03:04:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=Date:From:To; bh=VPWZ65lUnQvZuYuo0yJodwwNJS4cyARd6jZdX
        94IcDc=; b=X6AyuWFA+nFQBo+yJj3USxCzmYTNOOVeV3DnVxxn1WoUMf7aiN1D9
        qeJ2RZQ/pLpCn5pPtQyIP7y1F75wi/VbzxE+B/FlCi1Bmyb+BipUnVnWTk3hTC7J
        bj1twRDM/I25m4sbUQ2p/zRV38seIMW2CTSZ60juQLFR427izzFeyw=
Received: from bobwxc.top (unknown [120.238.248.129])
        by v_coremail2-frontend-2 (Coremail) with SMTP id GiKnCgCHEyTj8HNgES9rAA--.53829S2;
        Mon, 12 Apr 2021 15:04:05 +0800 (CST)
Date:   Mon, 12 Apr 2021 15:04:03 +0800
From:   Wu XiangCheng <bobwxc@email.cn>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Alex Shi <alexs@kernel.org>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Tsugikazu Shibata <tshibata@ab.jp.nec.com>,
        SeongJae Park <sjpark@amazon.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC 0/2] Add a new translation tool scripts/trslt.py
Message-ID: <cover.1618208899.git.bobwxc@email.cn>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CM-TRANSID: GiKnCgCHEyTj8HNgES9rAA--.53829S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF43KryxKrWUAr15Zr1DZFb_yoW8AFW5pF
        18GasxJF1Dtw1ayr1fCa18uF1fA3WxKr45Gw17trn3ArZ8t3sYqFW7K34Yga4DJryvqa4F
        v3Wjvr4DWFWDZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgqb7Iv0xC_tr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
        cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
        v20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2
        z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0x
        vYzxvE52x082IY62kv0487M2AExVA0xI801c8C04v7Mc02F40EFcxC0VAKzVAqx4xG6I80
        ewAv7VCjz48v1sIEY20_Cr1UJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
        AIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Cr1UJr1l4I8I3I0E4IkC6x0Yz7v_
        Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
        AY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
        cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
        IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVj
        vjDU0xZFpf9x07UjhFxUUUUU=
X-Originating-IP: [120.238.248.129]
X-CM-SenderInfo: pere453f6hztlloou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi all,

This set of patches aim to add a new translation tool - trslt.py, which
can control the transltions version corresponding to source files.

For a long time, kernel documentation translations lacks a way to control the
version corresponding to the source files. If you translate a file and then
someone updates the source file, there will be a problem. It's hard to know
which version the existing translation corresponds to, and even harder to sync
them. 

The common way now is to check the date, but this is not exactly accurate,
especially for documents that are often updated. And some translators write 
corresponding commit ID in the commit log for reference, it is a good way, 
but still a little troublesome.

Thus, the purpose of ``trslt.py`` is to add a new annotating tag to the file
to indicate corresponding version of the source file::

.. translation_origin_commit: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

The script will automatically copy file and generate tag when creating new
translation, and give update suggestions based on those tags when updating
translations.

More details please read doc in [Patch 2/2].

Still need working:
- improve verbose mode
- test on more python 3.x version
- only support linux now, need test on Mac OS, nonsupport Windows
  due to '\'

Any suggestion is welcome!

Thanks!

Wu XiangCheng (2):
  scripts: Add new translation tool trslt.py
  docs: doc-guide: Add document for scripts/trslt.py

 Documentation/doc-guide/index.rst |   1 +
 Documentation/doc-guide/trslt.rst | 233 ++++++++++++++++++++++++++
 scripts/trslt.py                  | 267 ++++++++++++++++++++++++++++++
 3 files changed, 501 insertions(+)
 create mode 100644 Documentation/doc-guide/trslt.rst
 create mode 100755 scripts/trslt.py

-- 
2.20.1


--X1bOJ3K7DJ5YkBrT
Content-Type: text/x-python; charset=utf-8
Content-Disposition: attachment; filename="trslt.py"
Content-Transfer-Encoding: 8bit

#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0+
#
# Kernel Documentation Translation File tool
# Document see: Documentation/doc-guide/trslt.rst
#
# Wu XiangCheng <bobwxc@email.cn>, 2021.

import os
import argparse
import subprocess

# global verbose mode flag
VERBOSE_FLAG = False

# change to source root dir
def cdpath():
    # at source ROOT
    if os.path.isdir("Documentation/translations") and os.path.isfile("MAINTAINERS"):
        return 0
    # at Documentation/
    elif os.path.isdir("translations") and os.path.isfile("../MAINTAINERS"):
        os.chdir("../")
        return 0
    # at Documentation/translation/
    elif os.path.isdir("zh_CN") and os.path.isfile("../../MAINTAINERS"):
        os.chdir("../../")
        return 0
    # at Documentation/translations/ll_NN/
    elif os.path.isdir("translations") == False and os.path.isdir("../../translations") and os.path.isfile("../../../MAINTAINERS"):
        os.chdir("../../../")
        return 0
    # anywhere else
    else:
        print("ERROR: Please run this script under linux kernel source ROOT dir")
        return -1

# argv
def arg():
    parser = argparse.ArgumentParser(
        description='Linux Kernel Documentation Translation File Tool')
    # file path
    parser.add_argument('file', help="specific file path")
    # verbose mode
    parser.add_argument('-v', '--verbose',
                        help="enable verbose mode",
                        action='store_true')
    # language choose
    parser.add_argument('-l', '--language',
                        help="choose translation language, default: zh_CN",
                        type=str,
                        choices=["it_IT", "ja_JP", "ko_KR", "zh_CN"],
                        default="zh_CN")
    # required action group
    ch = parser.add_mutually_exclusive_group(required=True)
    # \_ copy
    ch.add_argument('-c', '--copy',
                    help="copy a origin file to translation directory",
                    action='store_true')
    # \_ update
    ch.add_argument('-u', '--update',
                    help="get a translation file's update information",
                    action='store_true')

    argv_ = parser.parse_args()

    # modify global VERBOSE_FLAG
    if argv_.verbose:
        global VERBOSE_FLAG
        VERBOSE_FLAG = True
        print(argv_)

    return argv_

# get newest commit id of a origin doc file
def get_newest_commit(fp):
    cmd = "git log --format=oneline --no-merges "+fp
    p = subprocess.Popen(cmd,
                         shell=True,
                         stdout=subprocess.PIPE,
                         errors="replace")
    log = p.stdout.readline()
    commit_id = log[:log.find(' ')]
    return commit_id

# add language special header
def la_head(fp, la):
    if la == "zh_CN":
        cfp = fp[0:14]+"translations/"+la+'/'+fp[14:]
        r = ".. include:: " + \
            os.path.relpath(
                "Documentation/translations/zh_CN/disclaimer-zh_CN.rst",
                cfp[0:cfp.rfind('/')]) + "\n\n"
        r += ":Original: "+fp+"\n\n"
        r += ".. translation_origin_commit: "+get_newest_commit(fp)+"\n\n"
        r += ":译者: 姓名 EnglishName <email@example.com>\n\n"
    else:
        r = ":Original: "+fp+"\n\n"
        r += ".. translation_origin_commit: "+get_newest_commit(fp)+"\n\n"
        r += ":Translator: Name <email@example.com>\n\n"

    return r

# copy mode
def copy(fp, la):
    if os.path.isfile(fp) == False:
        return -2

    if fp.find("/translations/") != fp.rfind("/translations/"):
        print("WARNING: seems you are copying a file only exist in translations/ dir")
        return -3

    f = open(fp, 'r')
    try:
        first = f.read(2048)
    except:
        print("ERROR: can not read file", fp)
        return -2

    spdx_id = first.find(".. SPDX-License-Identifier: ")
    if spdx_id != -1:
        insert_id = first.find('\n', spdx_id)+1
        first = first[:insert_id]+'\n'+la_head(fp, la)+first[insert_id:]
    else:
        first = la_head(fp, la)+first

    if fp[0:14] == "Documentation/":
        cfp = fp[0:14]+"translations/"+la+'/'+fp[14:]

        if cfp[cfp.rfind('.'):] != ".rst":
            print("WARNING: this is not a rst file, may cause problems.",
                  "copy will continue, but please \033[31mcheck it!\033[0m")

        cfp_dir = cfp[0:cfp.rfind('/')]

        if not os.path.exists(cfp_dir):
            os.makedirs(cfp_dir)

        if os.path.isfile(cfp):
            print("WARNING:\033[31m", cfp,
                  "\033[0mis existing, can not use copy, please try -u/--update!")
            return -3

        cf = open(cfp, 'w')
        cf.write(first)

        while True:
            a = f.read(2048)
            if a != '':
                cf.write(a)
            else:
                break

        cf.close()
        print("INFO: \033[32m" + cfp +
              "\033[0m has been created, please remember to edit it.")
    else:
        return -2

    return 0

# generete origin text diff file for update
def gen_diff(ofp, old_id):
    new_id = get_newest_commit(ofp)
    if old_id == new_id:
        return 1

    cmd = "git show "+old_id+".."+new_id+" "+ofp
    p = subprocess.Popen(cmd,
                         shell=True,
                         stdout=subprocess.PIPE,
                         errors="replace")
    log = p.stdout.read()
    log = cmd+"\n\n"+log
    return log

# update mode
def update(fp, la):
    if os.path.isfile(fp) == False:
        return -2
    if fp.find("Documentation/translations/"+la) == -1:
        print("ERROR:", fp, "does not belong to", la, "translation!")
        return -3

    # origin file path
    ofp = fp[:fp.find("translations/"+la)] + \
        fp[fp.find("translations/"+la)+14+len(la):]

    if not os.path.isfile(ofp):
        print("ERROR: origin file",ofp,"does not exist or not a file")
        return -2

    f = open(fp, 'r')
    try:
        first = f.read(3072)
    except:
        print("ERROR: can not read file", fp)
        return -2

    commit_id = first.find("\n.. translation_origin_commit: ")
    if commit_id == -1:
        print("WARNING:", fp, "\033[31mdoes not have a translation_origin_commit tag,",
              "can not generate a diff file\033[0m, please add a tag if you want to update it.")
        print("\n\033[33m.. translation_origin_commit: " +
              get_newest_commit(ofp) + "\033[0m")
        return -4
    else:
        commit_id = commit_id+1  # '\n'
        commit_id = first[commit_id:first.find('\n', commit_id)]
        commit_id = commit_id[commit_id.find(' ')+1:]
        commit_id = commit_id[commit_id.find(' ')+1:]

    diff = gen_diff(ofp, commit_id)
    if diff == 1:
        print("INFO:", ofp, "does not have any change since", commit_id)
    else:
        with open(fp+".diff", 'w') as d:
            d.write(diff)
        print("INFO: \033[32m"+fp+".diff\033[0m file has generated",)
        print("INFO: if you want to update " + fp +
              ", please \033[31mDo Not Forget\033[0m to update the translation_origin_commit tag.",
              "\n\n\033[33m.. translation_origin_commit: " +
              get_newest_commit(ofp) + "\033[0m")

    return 0

# main entry
def main():
    argv_ = arg()

    # get file's abspath before cdpath
    file_path = os.path.abspath(argv_.file)
    if VERBOSE_FLAG:
        print(file_path)

    if cdpath() != 0:
        return -1

    # if file_path valid
    if file_path.find("Documentation") == -1:
        print("ERROR: file does not in Linux Kernel source Documentation")
        return -2
    elif os.path.isfile(file_path[file_path.find("Documentation"):]) == False:
        print("ERROR: file does not exist or not a file")
        return -2
    else:
        file_path = file_path[file_path.find("Documentation"):]

        if VERBOSE_FLAG:
            print(file_path)

    if argv_.copy:
        return copy(file_path, argv_.language)
    elif argv_.update:
        return update(file_path, argv_.language)

    return 0


if __name__ == "__main__":
    exit_code = main()
    if VERBOSE_FLAG:
        if exit_code == 0:
            print("exit with code:\033[32m", exit_code, "\033[0m")
        else:
            print("exit with code:\033[31m", exit_code, "\033[0m")
    exit(exit_code)

--X1bOJ3K7DJ5YkBrT--

