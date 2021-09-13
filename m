Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6BE4083DA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 07:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbhIMFiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 01:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbhIMFiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 01:38:17 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EF1C061574
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 22:37:01 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id x2so708727ila.11
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 22:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=oh7WHyHPIl6OfkjK9YdI/MB7zDw5CEnMBG8xs4K2Zvw=;
        b=CZeaOSFw0NZ2z0Y0Q5yxWkdPy7hvan+WLmgxTkMXIkB2qja/9tbeI+2Q5vwXZV/b1F
         ABqzTqu0lgziUwMvyXUD8GieXMqppJJFraFHqeiG21VRTwXCJKA8pZG71OM5B/EawKJx
         JnxmSg55HOicuJeDJAYDcK2BjMynlAD9QJSkz2/frPfFHOtJnGmRFBrTdqqAf5oypa11
         ggFxiGfZswdIPh13oc0kxY0GpLfsDBzmIPgJjzEb+4R5Bdaqj+wTrXZgtHYxum+yNKVP
         zoSCXUxbphCRRCHFzeba4vwstpO9F4AgHvq4lx527u0Lae+uMFIeL1cZWd4u9fc597cQ
         cm9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=oh7WHyHPIl6OfkjK9YdI/MB7zDw5CEnMBG8xs4K2Zvw=;
        b=Lz7+YKZkACbiPyjovetYI1N10OpfDZ6sg6yZYDGLtc5+bAEwbKnleqClJaFIr5snb8
         +E4IZeFld09uTbftZIAsrAIyzboHxrTn6dODLq4zoORgOZBOL7W4Wo3Vu+P7AbRzO2pL
         flnqu1/qPinu3cUUjrNJHdRkkC6jj/Ql4rMFXa1+fhtmgt76PTobf3Ty7sapAlYS8mZd
         VPOZPCPe9/eFvGMJo9oRJZ4UKlXvnyqfRwF6X2GH9n6wwM0XMfrOwkcfoy37AnmIgD4l
         569EhEN6BIGyPOF6mbBDG4bVVxp80XjJ491NI79HIi1Ir7quA6GAWIGc/J1KCzY6EkGu
         0A9A==
X-Gm-Message-State: AOAM532PdAf2xGhW89NE48gddk5H12TROsFum70luRosvdj8e7QJJUJm
        JahkwaddTqGzInd7je55+S1YBs+jMZ8Yh8/itAA=
X-Google-Smtp-Source: ABdhPJycnkcDA0Q+KCcAH2yscM17tFltAAPuSCjoLGzMoUKLZJ833M668j1V/fvH1h7RPKdvtpJ6kCQZvjwOASeL4ho=
X-Received: by 2002:a92:870f:: with SMTP id m15mr6428229ild.2.1631511421299;
 Sun, 12 Sep 2021 22:37:01 -0700 (PDT)
MIME-Version: 1.0
From:   zhao xc <xinchao.zhao.kernelz@gmail.com>
Date:   Mon, 13 Sep 2021 13:36:50 +0800
Message-ID: <CAP7CzPctHkk=eVyFddDDXEtEMzkoJ7XXNeD-f+5DxvEjd7-uRQ@mail.gmail.com>
Subject: 
To:     tglx@linutronix.de
Cc:     peterz@infradead.org, keescook@chromium.org, mingo@kernel.org,
        joe@perches.com, john.garry@huawei.com, song.bao.hua@hisilicon.com,
        linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000b6cf9605cbd9da21"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000b6cf9605cbd9da21
Content-Type: text/plain; charset="UTF-8"

Hi maintainer:
        This is a patch delete blank line between two enum definitions

Thanks!

--000000000000b6cf9605cbd9da21
Content-Type: application/octet-stream; 
	name="0001-linux-interrupt-delete-blank-line-between-two-enum-d.patch"
Content-Disposition: attachment; 
	filename="0001-linux-interrupt-delete-blank-line-between-two-enum-d.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kti7rlnd0>
X-Attachment-Id: f_kti7rlnd0

RnJvbSA2M2Q1Y2I2YzMyNGM3NTIzMTU1OTIwNDA0ZWUwOGMwZmZjMmNiMTgyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiB6aGFveGluY2hhbyA8eGluY2hhby56aGFvQHVjYXMuY29tLmNu
PgpEYXRlOiBTdW4sIDEyIFNlcCAyMDIxIDIyOjI2OjQ3IC0wNzAwClN1YmplY3Q6IFtQQVRDSF0g
bGludXgvaW50ZXJydXB0OiBkZWxldGUgYmxhbmsgbGluZSBiZXR3ZWVuIHR3byBlbnVtCiBkZWZp
bml0aW9ucwoKQWxsIG90aGVyIGVudW1lcmF0aW9uIHN0cnVjdHVyZXMgYXJlIG5leHQgdG8gZWFj
aCBvdGhlci4KClNpZ25lZC1vZmYtYnk6IHpoYW94aW5jaGFvIDx4aW5jaGFvLnpoYW9AdWNhcy5j
b20uY24+Ci0tLQogaW5jbHVkZS9saW51eC9pbnRlcnJ1cHQuaCB8IDEgLQogMSBmaWxlIGNoYW5n
ZWQsIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2ludGVycnVwdC5o
IGIvaW5jbHVkZS9saW51eC9pbnRlcnJ1cHQuaAppbmRleCAyZWQ2NWIwMWM5NjEuLjI4ZDUwYWUw
ZWQ2YiAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9pbnRlcnJ1cHQuaAorKysgYi9pbmNsdWRl
L2xpbnV4L2ludGVycnVwdC5oCkBAIC01MjIsNyArNTIyLDYgQEAgZW51bQogCVNDSEVEX1NPRlRJ
UlEsCiAJSFJUSU1FUl9TT0ZUSVJRLAogCVJDVV9TT0ZUSVJRLCAgICAvKiBQcmVmZXJhYmxlIFJD
VSBzaG91bGQgYWx3YXlzIGJlIHRoZSBsYXN0IHNvZnRpcnEgKi8KLQogCU5SX1NPRlRJUlFTCiB9
OwogCi0tIAoyLjE3LjEKCg==
--000000000000b6cf9605cbd9da21--
