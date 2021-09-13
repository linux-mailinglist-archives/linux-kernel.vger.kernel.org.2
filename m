Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC354083DF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 07:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbhIMFnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 01:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbhIMFnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 01:43:20 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F52DC061574
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 22:42:05 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id j18so10538628ioj.8
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 22:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=pT2ClmnIgFfU8oVei/i/rA3p8jHSMLyWcdsRiWgh8uY=;
        b=VdAiHfBfW7d0AG4kC7iodj+04Z64/B1QI7ZSPHPubSrcNBB6rEtd1fl4Ep2jh+4LGM
         Wj8vI6Ac0oKPn4TkkDQKorg6a6vHPnNdRY49OPhT0PIx1V6V1OL0TQ+UXSUXF0+88xwD
         qj/tigMYQrjVW5JLtJM3EyKX8WNkmOECI+D4Y4/Aiv1FcuV7ICKLTBDLXEQ4W4Wqklzj
         14H3xigbHJlySn6J9s1kLMCh0NK/ARuqlfP2/MJ3lulMf2ZNMXtu8a5Ii9XPk1qAdv6e
         HiKa0seUtuMZItogwWQbJhvvhLWBEVisTamPwTjMX08VwT5ZDBuvzEekiNHAv8O5xXtq
         5mvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=pT2ClmnIgFfU8oVei/i/rA3p8jHSMLyWcdsRiWgh8uY=;
        b=a2IcMUuqmT0AtOzjqACP0OljJUz3ZMysVPUutJlE5F8onQwoexZ5Nuna+opMXcC5jd
         4MxccZ3LizcjAWRkW71H5ZS6kRIvKBeQHiNhIUlYbFypntpq1cWGtUblOmcg37VfclBL
         rRsvHwMHKsCTwwgutlJyzhYFX6berIJFNL4G+Hre4HzgCHbFrzqR27WNG0bNIBNrWIWw
         K/MLSfuLVBTgPcyp3U/gGJQ7fykQkmC6uZ14XjvVnGejRX68YADOsjjqkGt1QqHpCyVP
         I3ohic3Xe6bZkB2A8+YKtpH/VPyCxmZ7RUnVVofzWDT4IvMszMYMXD2uGU/3Mq0NhXKM
         AukQ==
X-Gm-Message-State: AOAM533X0vIFMpl7fIIf8Zhf44KX7yeiqSatV2immN0NMhBj8IaC7Ai6
        ccU+0+jJ0PtIXA56Ha2hdIsUcy+XK1SyiB1DZvY=
X-Google-Smtp-Source: ABdhPJyTrwwJmXJ2liiSSpaVRKju2XWAPrNWWmc5M41AUx4AQEjFBz5N+6wnCtlWUqMZNXDjC9s1TX/txGxe8v/olG0=
X-Received: by 2002:a5e:a913:: with SMTP id c19mr7473214iod.31.1631511724654;
 Sun, 12 Sep 2021 22:42:04 -0700 (PDT)
MIME-Version: 1.0
From:   zhao xc <xinchao.zhao.kernelz@gmail.com>
Date:   Mon, 13 Sep 2021 13:41:53 +0800
Message-ID: <CAP7CzPcLhtXDyLudfmR2pWR5fzSQ_jhJSoRheH=cytoDnb_ujg@mail.gmail.com>
Subject: 
To:     tglx@linutronix.de
Cc:     mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        nathan@kernel.org, ndesaulniers@google.com, tony.luck@intel.com,
        linux@rasmusvillemoes.dk, mpe@ellerman.id.au,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: multipart/mixed; boundary="000000000000cba3f405cbd9ecfd"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000cba3f405cbd9ecfd
Content-Type: text/plain; charset="UTF-8"

Hi maintainer:
        This is a patch fix the unused macro definition

--000000000000cba3f405cbd9ecfd
Content-Type: application/octet-stream; 
	name="0001-x86-uaccess-fix-the-unused-macro-definition-CONFIG_C.patch"
Content-Disposition: attachment; 
	filename="0001-x86-uaccess-fix-the-unused-macro-definition-CONFIG_C.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kti7x59h0>
X-Attachment-Id: f_kti7x59h0

RnJvbSBmM2M0ZGUxNDQzMjI2NTY1ZWFjOTM3ODg0YmU2MjBmZjM4MTEzOTdkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiB6aGFveGluY2hhbyA8d2FuZ2h1b0B1Y2FzLmNvbS5jbj4KRGF0
ZTogVGh1LCA5IFNlcCAyMDIxIDAwOjQ0OjM5IC0wNzAwClN1YmplY3Q6IFtQQVRDSF0geDg2L3Vh
Y2Nlc3M6IGZpeCB0aGUgdW51c2VkIG1hY3JvIGRlZmluaXRpb24KIENPTkZJR19DQ19BU01fR09U
T19PVVRQVVQgdGhpcyBtYWNybyBoYXMgYmVlbiByZWJwbGFjZWQgYnkKIENPTkZJR19DQ19IQVNf
QVNNX0dPVE9fT1VUUFVUCgptb2RpZnkgdGhpcyBjb21tZW50cyB0byBwcmV2ZW50IGFtYmlndWl0
eQoKU2lnbmVkLW9mZi1ieTogemhhb3hpbmNoYW8gPHdhbmdodW9AdWNhcy5jb20uY24+Ci0tLQog
YXJjaC94ODYvaW5jbHVkZS9hc20vdWFjY2Vzcy5oIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVk
ZS9hc20vdWFjY2Vzcy5oIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vdWFjY2Vzcy5oCmluZGV4IGM5
ZmE3YmUzZGY4Mi4uZTdmYzJjNTE1ZTA4IDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2Fz
bS91YWNjZXNzLmgKKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vdWFjY2Vzcy5oCkBAIC00MTEs
NyArNDExLDcgQEAgZG8gewkJCQkJCQkJCVwKIAkJICAgICA6IFt1bWVtXSAibSIgKF9fbShhZGRy
KSksCQkJCVwKIAkJICAgICAgIFtlZmF1bHRdICJpIiAoLUVGQVVMVCksICIwIiAoZXJyKSkKIAot
I2VuZGlmIC8vIENPTkZJR19DQ19BU01fR09UT19PVVRQVVQKKyNlbmRpZiAvLyBDT05GSUdfQ0Nf
SEFTX0FTTV9HT1RPX09VVFBVVAogCiAvKiBGSVhNRTogdGhpcyBoYWNrIGlzIGRlZmluaXRlbHkg
d3JvbmcgLUFLICovCiBzdHJ1Y3QgX19sYXJnZV9zdHJ1Y3QgeyB1bnNpZ25lZCBsb25nIGJ1Zlsx
MDBdOyB9OwotLSAKMi4xNy4xCgo=
--000000000000cba3f405cbd9ecfd--
