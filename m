Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEEF42AD1F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 21:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbhJLTSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 15:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbhJLTSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 15:18:03 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F162C061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 12:16:01 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id x27so1228553lfa.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 12:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FlkXYxQnX9cVBCYrCYu43bah3uf5UinO45u+04/Rykc=;
        b=SrvvI2ZUyaZ1LhlLNYmdcbMFBohw/ez4k/YvlQbUMbxIjXI3gwpNuwsF1lEWTbNpWT
         9npnSxmYIw57vGlQDfFf3BS35QVZ73agXC/DxeAFrHMjtLk1Z6N72RPSvwPaniXJN0lz
         cwH5Sn1toi5AFngKI+T3hAkx9nywZBi5KetwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FlkXYxQnX9cVBCYrCYu43bah3uf5UinO45u+04/Rykc=;
        b=HDSKgg4CoTrDtuTEmO+tKgtjAb7GXLKzJp/BqQ1Z7785+Uc5otF/3pa/WPrcw4xbzw
         2Vmmcvc2dlcEQXDDkdYcohabWU4wBAM38D0ZMwfprfL8iE6bMHfnWeTF72uCxHvWc21s
         ZkP/3/UZ1O35lwPpFMEhnIw9rucJ+vb1WCxJqva0/yW7YmGLu03O1V0X3WtoV+x0cQ44
         NMkX37YOupGjq8Q3HpuhdW8O/QVzqnBWvGIvMN19QsE2l7R+66+ZHfmkBGD3Y+nSNnun
         6AoZiUV8mSoTKu1sg8jojVWVN6LlMcs7cnFS8HaDCVCvy8Jyy+F2gytq+MSwm6U3PzU9
         KFfg==
X-Gm-Message-State: AOAM532aVvsJgJTsvenbvOBUF8MMQNka20P72DcEY/AQjrkByTvKUfZi
        CA64ssO/i6jJKDwWSoFyAx8/CSWgOizTsBy4
X-Google-Smtp-Source: ABdhPJywfuGB9kYtwHrwj9E6jFzES5Ly04K/Ew2GTte3LXPwvNLkDrmIs7rO0A6WZvTRb1NTd1IxSw==
X-Received: by 2002:a05:651c:160c:: with SMTP id f12mr31333920ljq.80.1634066159512;
        Tue, 12 Oct 2021 12:15:59 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id f17sm934173ljc.46.2021.10.12.12.15.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Oct 2021 12:15:58 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id x27so1228125lfa.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 12:15:57 -0700 (PDT)
X-Received: by 2002:a2e:5cc7:: with SMTP id q190mr23168712ljb.494.1634066157039;
 Tue, 12 Oct 2021 12:15:57 -0700 (PDT)
MIME-Version: 1.0
References: <20211012141131.3c9a2eb1@gandalf.local.home> <CAHk-=wj2SbVnsO7yxgaD20HBaH=0rNM60nD92+BDSwQxofd9SQ@mail.gmail.com>
 <20211012145540.343541e9@gandalf.local.home>
In-Reply-To: <20211012145540.343541e9@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Oct 2021 12:15:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg6fw130AkO72GPFow9PHvP9odnC5LZ0UaY9bJQuF-C5A@mail.gmail.com>
Message-ID: <CAHk-=wg6fw130AkO72GPFow9PHvP9odnC5LZ0UaY9bJQuF-C5A@mail.gmail.com>
Subject: Re: [BUG] WARNING: CPU: 3 PID: 1 at mm/debug_vm_pgtable.c:493
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Gavin Shan <gshan@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: multipart/mixed; boundary="000000000000d4b35f05ce2cac37"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000d4b35f05ce2cac37
Content-Type: text/plain; charset="UTF-8"

On Tue, Oct 12, 2021 at 11:55 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
>
> I saved off that warning from a different branch, and looking at the dmesg,
> it is:
>
>   Linux version 5.14.0-rc2-test+
>
> Which shows this happened on 5.14 as well (and explains why the line
> numbers are different).

Ok, yes, that's the exact same "pud_set_huge()" failure.

So it's the same issue, and has been going on for a while, and
presumably very few people end up enabling DEBUG_VM_PGTABLE (together
with it being hard to trigger).

Or it's something specific to your setup, but that sounds unlikely.

You might add some debugging to the x86 pud_set_huge() function,
something like the attached (obviously entirely untested) patch.

           Linus

--000000000000d4b35f05ce2cac37
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_kuogsax20>
X-Attachment-Id: f_kuogsax20

IGFyY2gveDg2L21tL3BndGFibGUuYyB8IDggKysrKysrLS0KIDEgZmlsZSBjaGFuZ2VkLCA2IGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC94ODYvbW0vcGd0
YWJsZS5jIGIvYXJjaC94ODYvbW0vcGd0YWJsZS5jCmluZGV4IDM0ODFiMzVjYjRlYy4uMGEzZDY3
ZWM3M2Q0IDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9tbS9wZ3RhYmxlLmMKKysrIGIvYXJjaC94ODYv
bW0vcGd0YWJsZS5jCkBAIC03MDYsMTIgKzcwNiwxNiBAQCBpbnQgcHVkX3NldF9odWdlKHB1ZF90
ICpwdWQsIHBoeXNfYWRkcl90IGFkZHIsIHBncHJvdF90IHByb3QpCiAKIAltdHJyID0gbXRycl90
eXBlX2xvb2t1cChhZGRyLCBhZGRyICsgUFVEX1NJWkUsICZ1bmlmb3JtKTsKIAlpZiAoKG10cnIg
IT0gTVRSUl9UWVBFX0lOVkFMSUQpICYmICghdW5pZm9ybSkgJiYKLQkgICAgKG10cnIgIT0gTVRS
Ul9UWVBFX1dSQkFDSykpCisJICAgIChtdHJyICE9IE1UUlJfVFlQRV9XUkJBQ0spKSB7CisJCXBy
X2RlYnVnKCJtdHJyX3R5cGVfbG9va3VwKCkgcmV0dXJuZWQgJWQgKCVkKVxuIiwgbXRyciwgdW5p
Zm9ybSk7CiAJCXJldHVybiAwOworCX0KIAogCS8qIEJhaWwgb3V0IGlmIHdlIGFyZSB3ZSBvbiBh
IHBvcHVsYXRlZCBub24tbGVhZiBlbnRyeTogKi8KLQlpZiAocHVkX3ByZXNlbnQoKnB1ZCkgJiYg
IXB1ZF9odWdlKCpwdWQpKQorCWlmIChwdWRfcHJlc2VudCgqcHVkKSAmJiAhcHVkX2h1Z2UoKnB1
ZCkpIHsKKwkJcHJfZGVidWcoInB1ZCBpcyBhbHJlYWR5IHByZXNlbnQgKCVseClcbiIsICh1bnNp
Z25lZCBsb25nKXB1ZF92YWwoKnB1ZCkpOwogCQlyZXR1cm4gMDsKKwl9CiAKIAlzZXRfcHRlKChw
dGVfdCAqKXB1ZCwgcGZuX3B0ZSgKIAkJKHU2NClhZGRyID4+IFBBR0VfU0hJRlQsCg==
--000000000000d4b35f05ce2cac37--
