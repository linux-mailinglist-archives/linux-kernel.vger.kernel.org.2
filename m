Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0B03EA7E7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 17:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238241AbhHLPqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 11:46:02 -0400
Received: from [43.250.32.171] ([43.250.32.171]:35548 "EHLO email.cn"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S232854AbhHLPqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 11:46:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=To:From:Date; bh=CFn0e2H7AIgFYK5bRsMKv9jVtbaIb5udBqIFG
        gq5fX8=; b=Q2pUGaKMRpGjkBQzPQryMm6mF3Z43D8KmDSjO579IjIBDk0DZHlcd
        MA/n3M0dc5uQoB7wjP8+lBu9/bZ0N0wIyHUJ1OWV8njpBNYBfu+fNcXI7pR1p/qw
        Rj2ilF6fDCpMO9byu2TcVN6FdK3PP+Fty/9Th5s/QDY8SF6HoODMmw=
Received: from [0.0.0.0] (unknown [113.251.11.184])
        by v_coremail2-frontend-1 (Coremail) with SMTP id LCKnCgAXJAMcQhVh7FInAA--.9551S3;
        Thu, 12 Aug 2021 23:45:33 +0800 (CST)
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
From:   Hu Haowen <src.res@email.cn>
Subject: [GIT PULL] docs: zh_TW translation fixes
Message-ID: <b19c4d3f-9a36-c217-c4ad-0f818f8e864a@email.cn>
Date:   Thu, 12 Aug 2021 23:45:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: LCKnCgAXJAMcQhVh7FInAA--.9551S3
X-Coremail-Antispam: 1UD129KBjvJXoW3JFW7Jw1xXF17Gr4kKF4kJFb_yoW7ArW8p3
        WSkr13Ja47Jr1xJr13Kr17Jry5AF1xGw4UGF17X3Z5try8Ar4Fqrs0qr9FgFy3JrW8XF40
        qr1Utr1Uur12yrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUglb7Iv0xC_tr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
        cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
        v20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j6r4UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4
        CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26F4U
        Jr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY4
        87MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Cr1UJr1l4I8I3I0E4IkC6x0Y
        z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
        AF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
        IxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
        CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVF
        xhVjvjDU0xZFpf9x07UjhFxUUUUU=
X-Originating-IP: [113.251.11.184]
X-CM-SenderInfo: hvufh21hv6vzxdlohubq/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ff17578e267c74db1619b6643a98e8a83ff6b996:

  docs/zh_TW: add translations for zh_TW/process (2021-07-27 23:08:50 +0800)

are available in the Git repository at:

  https://github.com/srcres258/linux-doc.git doc-zh-tw

for you to fetch changes up to d9b28270985fdc551cf4aaae3d8a5b3e9ae2ee9e:

  docs/zh_TW: add translations for zh_TW/filesystems (2021-08-12 22:54:51 +0800)

----------------------------------------------------------------
Hu Haowen (3):
      docs/zh_TW: add translations for zh_TW/arm64
      docs/zh_TW: add translations for zh_TW/cpu-freq
      docs/zh_TW: add translations for zh_TW/filesystems

 Documentation/translations/zh_TW/arm64/amu.rst                 | 104 +++++++++++++++++++++++++++++++++++++
 Documentation/translations/zh_TW/arm64/booting.txt             | 251 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 Documentation/translations/zh_TW/arm64/elf_hwcaps.rst          | 244 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 Documentation/translations/zh_TW/arm64/hugetlbpage.rst         |  49 ++++++++++++++++++
 Documentation/translations/zh_TW/arm64/index.rst               |  23 ++++++++
 Documentation/translations/zh_TW/arm64/legacy_instructions.txt |  77 +++++++++++++++++++++++++++
 Documentation/translations/zh_TW/arm64/memory.txt              | 119 ++++++++++++++++++++++++++++++++++++++++++
 Documentation/translations/zh_TW/arm64/perf.rst                |  88 +++++++++++++++++++++++++++++++
 Documentation/translations/zh_TW/arm64/silicon-errata.txt      |  79 ++++++++++++++++++++++++++++
 Documentation/translations/zh_TW/arm64/tagged-pointers.txt     |  57 ++++++++++++++++++++
 Documentation/translations/zh_TW/cpu-freq/core.rst             | 108 ++++++++++++++++++++++++++++++++++++++
 Documentation/translations/zh_TW/cpu-freq/cpu-drivers.rst      | 256 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 Documentation/translations/zh_TW/cpu-freq/cpufreq-stats.rst    | 132 ++++++++++++++++++++++++++++++++++++++++++++++
 Documentation/translations/zh_TW/cpu-freq/index.rst            |  47 +++++++++++++++++
 Documentation/translations/zh_TW/filesystems/debugfs.rst       | 224 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 Documentation/translations/zh_TW/filesystems/index.rst         |  31 +++++++++++
 Documentation/translations/zh_TW/filesystems/sysfs.txt         | 377 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 Documentation/translations/zh_TW/filesystems/tmpfs.rst         | 148 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 Documentation/translations/zh_TW/filesystems/virtiofs.rst      |  61 ++++++++++++++++++++++
 Documentation/translations/zh_TW/index.rst                     |  13 ++++-
 20 files changed, 2486 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/translations/zh_TW/arm64/amu.rst
 create mode 100644 Documentation/translations/zh_TW/arm64/booting.txt
 create mode 100644 Documentation/translations/zh_TW/arm64/elf_hwcaps.rst
 create mode 100644 Documentation/translations/zh_TW/arm64/hugetlbpage.rst
 create mode 100644 Documentation/translations/zh_TW/arm64/index.rst
 create mode 100644 Documentation/translations/zh_TW/arm64/legacy_instructions.txt
 create mode 100644 Documentation/translations/zh_TW/arm64/memory.txt
 create mode 100644 Documentation/translations/zh_TW/arm64/perf.rst
 create mode 100644 Documentation/translations/zh_TW/arm64/silicon-errata.txt
 create mode 100644 Documentation/translations/zh_TW/arm64/tagged-pointers.txt
 create mode 100644 Documentation/translations/zh_TW/cpu-freq/core.rst
 create mode 100644 Documentation/translations/zh_TW/cpu-freq/cpu-drivers.rst
 create mode 100644 Documentation/translations/zh_TW/cpu-freq/cpufreq-stats.rst
 create mode 100644 Documentation/translations/zh_TW/cpu-freq/index.rst
 create mode 100644 Documentation/translations/zh_TW/filesystems/debugfs.rst
 create mode 100644 Documentation/translations/zh_TW/filesystems/index.rst
 create mode 100644 Documentation/translations/zh_TW/filesystems/sysfs.txt
 create mode 100644 Documentation/translations/zh_TW/filesystems/tmpfs.rst
 create mode 100644 Documentation/translations/zh_TW/filesystems/virtiofs.rst

