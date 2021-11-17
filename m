Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA593455137
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 00:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241654AbhKQXmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 18:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241649AbhKQXmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 18:42:18 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784F3C061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 15:39:18 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id l25so1974320eda.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 15:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wP6/vZEmx31mSMqgFaKOf/uSDN9mRpcVV2I9OZFw6jE=;
        b=HIhuXXvL+E70ojPFJEO4rCzWwQ4/LsD2hujd2k3e/tUyT0KAQrMxEonNif1+09K+bg
         BEFhauaHMpifsZsRAw3Lc6MxBKqF5D9BJTyBJsBSfMoQKwUnVCJtzNqDYnvYjwjcx0Sp
         8DEKFQVkVAB+OYr2/TR3bSSCv0Z7YcHc9gy94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wP6/vZEmx31mSMqgFaKOf/uSDN9mRpcVV2I9OZFw6jE=;
        b=yeD36mWeub7Q/YpztvoJk1zTVTBelYEjdsG+zC6PWDQKucmsjjckxyzNqcrHNHsLBr
         b//CFhdMh6l6ig8UykYEaLSdqa2aiY9JxSW50bMSbUu0FVZmF7t6M5EnWVswUFKwcMYI
         HcU+hUJtEypxVbJhwJjiKKAuc0NCgvkxOV9GraJOHMfqZx5PZo2LcSTtwMccbo7wexII
         4yzYK0C1ZtbvrCkJMGed0J4uvyJR12S0HOT4G8aEdoG4ku2+/lvJ5ryFyEjQPAYmOB5D
         ExAvArRT52IYwEnQPqaibI4B69hlZlp6ReUh483N+sOKSmPzs/dKxG0C3olGxcOgMcAa
         lykw==
X-Gm-Message-State: AOAM531gIG5B8uEKY1H5BxP7dlv8GQYj2Gjv1oX0MlGJ4+LWQNIPLuJI
        jR4tZwYK3bUkfE1Ik1uLAhpUicpBl5QzQwe9
X-Google-Smtp-Source: ABdhPJyTjybC1cKEDraGQhJgtK5HHvnE9OBb89zT17f0LsUUNDBCQtzwUyIFE+iM0pAqiB/B4lrfEg==
X-Received: by 2002:a17:906:390:: with SMTP id b16mr21413310eja.123.1637192356841;
        Wed, 17 Nov 2021 15:39:16 -0800 (PST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id g21sm649647edw.86.2021.11.17.15.39.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 15:39:16 -0800 (PST)
Received: by mail-wr1-f52.google.com with SMTP id u1so7772885wru.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 15:39:15 -0800 (PST)
X-Received: by 2002:adf:dcd0:: with SMTP id x16mr25212811wrm.229.1637192355663;
 Wed, 17 Nov 2021 15:39:15 -0800 (PST)
MIME-Version: 1.0
References: <20211117181922.3e9a2329@gandalf.local.home>
In-Reply-To: <20211117181922.3e9a2329@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 17 Nov 2021 15:38:59 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgcrEbFgkw9720H3tW-AhHOoEKhYwZinYJw4FpzSaJ6_Q@mail.gmail.com>
Message-ID: <CAHk-=wgcrEbFgkw9720H3tW-AhHOoEKhYwZinYJw4FpzSaJ6_Q@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Fix double free bug
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kalesh Singh <kaleshsingh@google.com>
Content-Type: multipart/mixed; boundary="000000000000c9fec505d1048cfe"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000c9fec505d1048cfe
Content-Type: text/plain; charset="UTF-8"

On Wed, Nov 17, 2021 at 3:19 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On error, the operands and the histogram expression are destroyed,
> but since the destruction is recursive, do not destroy the operands
> if they already belong to the expression that is about to be destroyed.

Honestly, this seems horribly ugly.

The problem seems to be that the "goto error" cases are simply just wrong.

Why isn't the fix to make the error cases be the right ones, instead
of having one odd error case that then has to do some magic things to
not free the wrong things?

The patch ends up a bit bigger, mainly because I renamed the different
"free" cases, and because I made the non-freeing ones just return the
error directly.

Something like this (UNTESTED!) patch, IOW?

          Linus

--000000000000c9fec505d1048cfe
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_kw461o3l0>
X-Attachment-Id: f_kw461o3l0

IGtlcm5lbC90cmFjZS90cmFjZV9ldmVudHNfaGlzdC5jIHwgNDAgKysrKysrKysrKysrKysrKysr
KysrKy0tLS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKyks
IDE4IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2tlcm5lbC90cmFjZS90cmFjZV9ldmVudHNf
aGlzdC5jIGIva2VybmVsL3RyYWNlL3RyYWNlX2V2ZW50c19oaXN0LmMKaW5kZXggNWVhMmM5ZWM1
NGE2Li40MmVlM2U5NWRlYjcgMTAwNjQ0Ci0tLSBhL2tlcm5lbC90cmFjZS90cmFjZV9ldmVudHNf
aGlzdC5jCisrKyBiL2tlcm5lbC90cmFjZS90cmFjZV9ldmVudHNfaGlzdC5jCkBAIC0yNTc2LDI4
ICsyNTc2LDI3IEBAIHN0YXRpYyBzdHJ1Y3QgaGlzdF9maWVsZCAqcGFyc2VfZXhwcihzdHJ1Y3Qg
aGlzdF90cmlnZ2VyX2RhdGEgKmhpc3RfZGF0YSwKIAogCS8qIFNwbGl0IHRoZSBleHByZXNzaW9u
IHN0cmluZyBhdCB0aGUgcm9vdCBvcGVyYXRvciAqLwogCWlmICghc2VwKQotCQlnb3RvIGZyZWU7
CisJCXJldHVybiBFUlJfUFRSKC1FSU5WQUwpOworCiAJKnNlcCA9ICdcMCc7CiAJb3BlcmFuZDFf
c3RyID0gc3RyOwogCXN0ciA9IHNlcCsxOwogCiAJLyogQmluYXJ5IG9wZXJhdG9yIHJlcXVpcmVz
IGJvdGggb3BlcmFuZHMgKi8KIAlpZiAoKm9wZXJhbmQxX3N0ciA9PSAnXDAnIHx8ICpzdHIgPT0g
J1wwJykKLQkJZ290byBmcmVlOworCQlyZXR1cm4gRVJSX1BUUigtRUlOVkFMKTsKIAogCW9wZXJh
bmRfZmxhZ3MgPSAwOwogCiAJLyogTEhTIG9mIHN0cmluZyBpcyBhbiBleHByZXNzaW9uIGUuZy4g
YStiIGluIGErYitjICovCiAJb3BlcmFuZDEgPSBwYXJzZV9leHByKGhpc3RfZGF0YSwgZmlsZSwg
b3BlcmFuZDFfc3RyLCBvcGVyYW5kX2ZsYWdzLCBOVUxMLCBuX3N1YmV4cHJzKTsKLQlpZiAoSVNf
RVJSKG9wZXJhbmQxKSkgewotCQlyZXQgPSBQVFJfRVJSKG9wZXJhbmQxKTsKLQkJb3BlcmFuZDEg
PSBOVUxMOwotCQlnb3RvIGZyZWU7Ci0JfQorCWlmIChJU19FUlIob3BlcmFuZDEpKQorCQlyZXR1
cm4gRVJSX0NBU1Qob3BlcmFuZDEpOworCiAJaWYgKG9wZXJhbmQxLT5mbGFncyAmIEhJU1RfRklF
TERfRkxfU1RSSU5HKSB7CiAJCWhpc3RfZXJyKGZpbGUtPnRyLCBISVNUX0VSUl9JTlZBTElEX1NU
Ul9PUEVSQU5ELCBlcnJwb3Mob3BlcmFuZDFfc3RyKSk7CiAJCXJldCA9IC1FSU5WQUw7Ci0JCWdv
dG8gZnJlZTsKKwkJZ290byBmcmVlX29wMTsKIAl9CiAKIAkvKiBSSFMgb2Ygc3RyaW5nIGlzIGFu
b3RoZXIgZXhwcmVzc2lvbiBlLmcuIGMgaW4gYStiK2MgKi8KQEAgLTI2MDYsMTIgKzI2MDUsMTIg
QEAgc3RhdGljIHN0cnVjdCBoaXN0X2ZpZWxkICpwYXJzZV9leHByKHN0cnVjdCBoaXN0X3RyaWdn
ZXJfZGF0YSAqaGlzdF9kYXRhLAogCWlmIChJU19FUlIob3BlcmFuZDIpKSB7CiAJCXJldCA9IFBU
Ul9FUlIob3BlcmFuZDIpOwogCQlvcGVyYW5kMiA9IE5VTEw7Ci0JCWdvdG8gZnJlZTsKKwkJZ290
byBmcmVlX29wMTsKIAl9CiAJaWYgKG9wZXJhbmQyLT5mbGFncyAmIEhJU1RfRklFTERfRkxfU1RS
SU5HKSB7CiAJCWhpc3RfZXJyKGZpbGUtPnRyLCBISVNUX0VSUl9JTlZBTElEX1NUUl9PUEVSQU5E
LCBlcnJwb3Moc3RyKSk7CiAJCXJldCA9IC1FSU5WQUw7Ci0JCWdvdG8gZnJlZTsKKwkJZ290byBm
cmVlX29wZXJhbmRzOwogCX0KIAogCXN3aXRjaCAoZmllbGRfb3ApIHsKQEAgLTI2MjksMTIgKzI2
MjgsMTIgQEAgc3RhdGljIHN0cnVjdCBoaXN0X2ZpZWxkICpwYXJzZV9leHByKHN0cnVjdCBoaXN0
X3RyaWdnZXJfZGF0YSAqaGlzdF9kYXRhLAogCQlicmVhazsKIAlkZWZhdWx0OgogCQlyZXQgPSAt
RUlOVkFMOwotCQlnb3RvIGZyZWU7CisJCWdvdG8gZnJlZV9vcGVyYW5kczsKIAl9CiAKIAlyZXQg
PSBjaGVja19leHByX29wZXJhbmRzKGZpbGUtPnRyLCBvcGVyYW5kMSwgb3BlcmFuZDIsICZ2YXIx
LCAmdmFyMik7CiAJaWYgKHJldCkKLQkJZ290byBmcmVlOworCQlnb3RvIGZyZWVfb3BlcmFuZHM7
CiAKIAlvcGVyYW5kX2ZsYWdzID0gdmFyMSA/IHZhcjEtPmZsYWdzIDogb3BlcmFuZDEtPmZsYWdz
OwogCW9wZXJhbmQyX2ZsYWdzID0gdmFyMiA/IHZhcjItPmZsYWdzIDogb3BlcmFuZDItPmZsYWdz
OwpAQCAtMjY1MywxMiArMjY1MiwxMyBAQCBzdGF0aWMgc3RydWN0IGhpc3RfZmllbGQgKnBhcnNl
X2V4cHIoc3RydWN0IGhpc3RfdHJpZ2dlcl9kYXRhICpoaXN0X2RhdGEsCiAJZXhwciA9IGNyZWF0
ZV9oaXN0X2ZpZWxkKGhpc3RfZGF0YSwgTlVMTCwgZmxhZ3MsIHZhcl9uYW1lKTsKIAlpZiAoIWV4
cHIpIHsKIAkJcmV0ID0gLUVOT01FTTsKLQkJZ290byBmcmVlOworCQlnb3RvIGZyZWVfb3BlcmFu
ZHM7CiAJfQogCiAJb3BlcmFuZDEtPnJlYWRfb25jZSA9IHRydWU7CiAJb3BlcmFuZDItPnJlYWRf
b25jZSA9IHRydWU7CiAKKwkvKiBUaGUgb3BlcmFuZHMgYXJlIG5vdyBvd25lZCBhbmQgZnJlZSdk
IGJ5ICdleHByJyAqLwogCWV4cHItPm9wZXJhbmRzWzBdID0gb3BlcmFuZDE7CiAJZXhwci0+b3Bl
cmFuZHNbMV0gPSBvcGVyYW5kMjsKIApAQCAtMjY2OSw3ICsyNjY5LDcgQEAgc3RhdGljIHN0cnVj
dCBoaXN0X2ZpZWxkICpwYXJzZV9leHByKHN0cnVjdCBoaXN0X3RyaWdnZXJfZGF0YSAqaGlzdF9k
YXRhLAogCQlpZiAoIWRpdmlzb3IpIHsKIAkJCWhpc3RfZXJyKGZpbGUtPnRyLCBISVNUX0VSUl9E
SVZJU0lPTl9CWV9aRVJPLCBlcnJwb3Moc3RyKSk7CiAJCQlyZXQgPSAtRURPTTsKLQkJCWdvdG8g
ZnJlZTsKKwkJCWdvdG8gZnJlZV9leHByOwogCQl9CiAKIAkJLyoKQEAgLTI3MDksMTggKzI3MDks
MjIgQEAgc3RhdGljIHN0cnVjdCBoaXN0X2ZpZWxkICpwYXJzZV9leHByKHN0cnVjdCBoaXN0X3Ry
aWdnZXJfZGF0YSAqaGlzdF9kYXRhLAogCQlleHByLT50eXBlID0ga3N0cmR1cF9jb25zdChvcGVy
YW5kMS0+dHlwZSwgR0ZQX0tFUk5FTCk7CiAJCWlmICghZXhwci0+dHlwZSkgewogCQkJcmV0ID0g
LUVOT01FTTsKLQkJCWdvdG8gZnJlZTsKKwkJCWdvdG8gZnJlZV9leHByOwogCQl9CiAKIAkJZXhw
ci0+bmFtZSA9IGV4cHJfc3RyKGV4cHIsIDApOwogCX0KIAogCXJldHVybiBleHByOwotZnJlZToK
LQlkZXN0cm95X2hpc3RfZmllbGQob3BlcmFuZDEsIDApOworCitmcmVlX29wZXJhbmRzOgogCWRl
c3Ryb3lfaGlzdF9maWVsZChvcGVyYW5kMiwgMCk7Ci0JZGVzdHJveV9oaXN0X2ZpZWxkKGV4cHIs
IDApOworZnJlZV9vcDE6CisJZGVzdHJveV9oaXN0X2ZpZWxkKG9wZXJhbmQxLCAwKTsKKwlyZXR1
cm4gRVJSX1BUUihyZXQpOwogCitmcmVlX2V4cHI6CisJZGVzdHJveV9oaXN0X2ZpZWxkKGV4cHIs
IDApOwogCXJldHVybiBFUlJfUFRSKHJldCk7CiB9CiAK
--000000000000c9fec505d1048cfe--
