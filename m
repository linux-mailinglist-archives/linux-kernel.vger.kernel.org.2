Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBF1F36F193
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 23:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbhD2VKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 17:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbhD2VKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 17:10:36 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332F1C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 14:09:49 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id b21so5701983ljf.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 14:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EZk56/tKMCbIPvV8YNaRO6wo8Irr+WK10NbZxDJf+z4=;
        b=fkpQe5JdXBXmFB1qTx5+TPACFa+jtEGsa1I1mrclX9AXJwSW+9J/MPIJxxqqZGl1Pz
         VpHU4C0wFKTS5y0jqEI4k9lXvfxwa2TtqnQaSbTKItswKxvHU4RDAD2vc07U2tW1FVVf
         z570BZJFXzNjzvtbXe4+NwHpNaeF/c7rppDqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EZk56/tKMCbIPvV8YNaRO6wo8Irr+WK10NbZxDJf+z4=;
        b=jSYpMUvgNTYOfsM+XGy4eurJQRtEHJbVpZ/dowP2mcF9YH8LCmCJqnzU6hhJTCa5uO
         A8r1ByLi2GDWDEinglN6k6P0HOoIX6YEVx5Jibt80V8l143QZI+xu7om4PDCEf/SBMnT
         w/p7vcMY205EACG2C+BKNlU4KNsrsHDeDv1tS5lHvIs5C3LRAlM9BAPGsikWGOYn8b3V
         N7dCWXvm/xMKm1SmeuSBONMC3rptggEEuazxOOQUMU9np63e2w/yTwOP3Vct0ka+TWeM
         o1TXZB3jwV4ZI2poq2qb6xFGoHXMWeIEBuUAdl+O8PJiMpzRkbsW74D2Al4ODpsfc1P3
         B4XQ==
X-Gm-Message-State: AOAM530/EbYYIksIICCYT4WKUVd1KTw/wn2G90ypZge9RJlnehjGlmV7
        7Nmtw0mMO8wnUBcfu6ZY1fwKAgoxbOpRqE5HCe1wOA==
X-Google-Smtp-Source: ABdhPJwl1zm2hxsWtYR4UHYAXOKAwBbQiMsY/xAufPPqF+RVf0CrZPw0VzO6RrwwkpQmpsxZ2B08H5lQO1JhmX/0a5g=
X-Received: by 2002:a2e:9e98:: with SMTP id f24mr1185878ljk.442.1619730587668;
 Thu, 29 Apr 2021 14:09:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210422120459.447350175@infradead.org> <20210422123308.196692074@infradead.org>
 <CABk29Ntop2nX+z1bV7giG8ToR_w3f_+GYGAw+hFQ6g9rCZunmw@mail.gmail.com>
 <YIZ6ZpkrMGQ9A9x2@hirez.programming.kicks-ass.net> <CABk29NvicqM_c2ssYnDrEy_FPsfD5GH38rB_XHooErALOabe5g@mail.gmail.com>
 <CAOY2WoyTq0AYMz+z=USxSpdcJqWMjkq-FDkuLN++brwhAkwTaQ@mail.gmail.com>
 <CABk29Nuz-FDCk23ajcr9gS4KD-wMpwyn=ASu+yuTTT445rwTvw@mail.gmail.com>
 <CAERHkrvU2Xzi5p9Dph3zZ7zkoYjSV1krK-UhqE7+Qb80FodEGg@mail.gmail.com>
 <5c289c5a-a120-a1d0-ca89-2724a1445fe8@linux.intel.com> <CAERHkrsoCR7d3N2rhwKCeFDDBv4-S4HzD567mOaV_pngXn_Hkg@mail.gmail.com>
 <CAOY2WowOR6HhoKMsGrg+2VFD6ySY67E7Kr1s2GCuO4LdyusyUw@mail.gmail.com> <CABk29Nt_xBaoawiyMv1RG+Yzg_a9w5RMc6Zy0ggmS5K-9LzrUA@mail.gmail.com>
In-Reply-To: <CABk29Nt_xBaoawiyMv1RG+Yzg_a9w5RMc6Zy0ggmS5K-9LzrUA@mail.gmail.com>
From:   Don Hiatt <dhiatt@digitalocean.com>
Date:   Thu, 29 Apr 2021 14:09:36 -0700
Message-ID: <CAOY2WozkceZ+B+AGTVLJ1H-jZDAbr2c7ksjtgrnr7DQ8h5raAg@mail.gmail.com>
Subject: Re: [PATCH 04/19] sched: Prepare for Core-wide rq->lock
To:     Josh Don <joshdon@google.com>
Cc:     Aubrey Li <aubrey.intel@gmail.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: multipart/mixed; boundary="0000000000004fe2d805c122eafa"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000004fe2d805c122eafa
Content-Type: text/plain; charset="UTF-8"

On Thu, Apr 29, 2021 at 1:48 PM Josh Don <joshdon@google.com> wrote:
>
> On Wed, Apr 28, 2021 at 9:41 AM Don Hiatt <dhiatt@digitalocean.com> wrote:
> >
> > I'm still seeing hard lockups while repeatedly setting cookies on qemu
> > processes even with
> > the updated patch. If there is any debug you'd like me to turn on,
> > just let me know.
> >
> > Thanks!
> >
> > don
>
> Thanks for the added context on your repro configuration. In addition
> to the updated patch from earlier, could you try the modification to
> double_rq_lock() from
> https://lkml.kernel.org/r/CABk29NuS-B3n4sbmavo0NDA1OCCsz6Zf2VDjjFQvAxBMQoJ_Lg@mail.gmail.com
> ? I have a feeling this is what's causing your lockup.
>
> Best,
> Josh

Hi Josh,

I've been running Aubrey+Peter's patch (attached) for almost 5 hours
and haven't had a single issue. :)

I'm running a set-cookie script every 5 seconds on the two VMs (each
vm is running
'sysbench --threads=1 --time=0 cpu run' to generate some load in the vm) and
I'm running two of the same sysbench runs on the HV while setting cookies
every 5 seconds.

Unless I jinxed us it looks like a great fix. :)

Let me know if there is anything else you'd like me to try. I'm going
to leave the tests running
and see what happens. I update with what I find.

Thanks!

don

--0000000000004fe2d805c122eafa
Content-Type: application/octet-stream; name="aubrey-cosched.diff"
Content-Disposition: attachment; filename="aubrey-cosched.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_ko3dgfif0>
X-Attachment-Id: f_ko3dgfif0

ZGlmZiAtLWdpdCBhL2tlcm5lbC9zY2hlZC9jb3JlLmMgYi9rZXJuZWwvc2NoZWQvY29yZS5jCmlu
ZGV4IGY3MzI2NDJlM2UwOS4uMWQ3YmM4NzAwN2NkIDEwMDY0NAotLS0gYS9rZXJuZWwvc2NoZWQv
Y29yZS5jCisrKyBiL2tlcm5lbC9zY2hlZC9jb3JlLmMKQEAgLTI5MCw2ICsyOTAsMTAgQEAgc3Rh
dGljIHZvaWQgc2NoZWRfY29yZV9hc3NlcnRfZW1wdHkodm9pZCkKIHN0YXRpYyB2b2lkIF9fc2No
ZWRfY29yZV9lbmFibGUodm9pZCkKIHsKIAlzdGF0aWNfYnJhbmNoX2VuYWJsZSgmX19zY2hlZF9j
b3JlX2VuYWJsZWQpOworCS8qCisJICogRW5zdXJlIHJhd19zcGluX3JxXypsb2NrKigpIGhhdmUg
Y29tcGxldGVkIGJlZm9yZSBmbGlwcGluZy4KKwkgKi8KKwlzeW5jaHJvbml6ZV9yY3UoKTsKIAlf
X3NjaGVkX2NvcmVfZmxpcCh0cnVlKTsKIAlzY2hlZF9jb3JlX2Fzc2VydF9lbXB0eSgpOwogfQpA
QCAtNDQ5LDE2ICs0NTMsMjMgQEAgdm9pZCByYXdfc3Bpbl9ycV9sb2NrX25lc3RlZChzdHJ1Y3Qg
cnEgKnJxLCBpbnQgc3ViY2xhc3MpCiB7CiAJcmF3X3NwaW5sb2NrX3QgKmxvY2s7CgorCS8qIE1h
dGNoZXMgc3luY2hyb25pemVfc2NoZWQoKSBpbiBfX3NjaGVkX2NvcmVfZW5hYmxlZCgpICovCisJ
cHJlZW1wdF9kaXNhYmxlKCk7CiAJaWYgKHNjaGVkX2NvcmVfZGlzYWJsZWQoKSkgewogCQlyYXdf
c3Bpbl9sb2NrX25lc3RlZCgmcnEtPl9fbG9jaywgc3ViY2xhc3MpOworCQkvKiBwcmVlbXB0LWNv
dW50ICpNVVNUKiBiZSA+IDEgKi8KKwkJcHJlZW1wdF9lbmFibGVfbm9fcmVzY2hlZCgpOwogCQly
ZXR1cm47CiAJfQoKIAlmb3IgKDs7KSB7CiAJCWxvY2sgPSBfX3JxX2xvY2twKHJxKTsKIAkJcmF3
X3NwaW5fbG9ja19uZXN0ZWQobG9jaywgc3ViY2xhc3MpOwotCQlpZiAobGlrZWx5KGxvY2sgPT0g
X19ycV9sb2NrcChycSkpKQorCQlpZiAobGlrZWx5KGxvY2sgPT0gX19ycV9sb2NrcChycSkpKSB7
CisJCQkvKiBwcmVlbXB0LWNvdW50ICpNVVNUKiBiZSA+IDEgKi8KKwkJCXByZWVtcHRfZW5hYmxl
X25vX3Jlc2NoZWQoKTsKIAkJCXJldHVybjsKKwkJfQogCQlyYXdfc3Bpbl91bmxvY2sobG9jayk7
CiAJfQogfQpAQCAtNDY4LDE0ICs0NzksMjEgQEAgYm9vbCByYXdfc3Bpbl9ycV90cnlsb2NrKHN0
cnVjdCBycSAqcnEpCiAJcmF3X3NwaW5sb2NrX3QgKmxvY2s7CiAJYm9vbCByZXQ7CgotCWlmIChz
Y2hlZF9jb3JlX2Rpc2FibGVkKCkpCi0JCXJldHVybiByYXdfc3Bpbl90cnlsb2NrKCZycS0+X19s
b2NrKTsKKwkvKiBNYXRjaGVzIHN5bmNocm9uaXplX3NjaGVkKCkgaW4gX19zY2hlZF9jb3JlX2Vu
YWJsZWQoKSAqLworCXByZWVtcHRfZGlzYWJsZSgpOworCWlmIChzY2hlZF9jb3JlX2Rpc2FibGVk
KCkpIHsKKwkJcmV0ID0gcmF3X3NwaW5fdHJ5bG9jaygmcnEtPl9fbG9jayk7CisJCXByZWVtcHRf
ZW5hYmxlKCk7CisJCXJldHVybiByZXQ7CisJfQoKIAlmb3IgKDs7KSB7CiAJCWxvY2sgPSBfX3Jx
X2xvY2twKHJxKTsKIAkJcmV0ID0gcmF3X3NwaW5fdHJ5bG9jayhsb2NrKTsKLQkJaWYgKCFyZXQg
fHwgKGxpa2VseShsb2NrID09IF9fcnFfbG9ja3AocnEpKSkpCisJCWlmICghcmV0IHx8IChsaWtl
bHkobG9jayA9PSBfX3JxX2xvY2twKHJxKSkpKSB7CisJCQlwcmVlbXB0X2VuYWJsZSgpOwogCQkJ
cmV0dXJuIHJldDsKKwkJfQogCQlyYXdfc3Bpbl91bmxvY2sobG9jayk7CiAJfQogfQpAQCAtNDkz
LDE0ICs1MTEsMTcgQEAgdm9pZCBkb3VibGVfcnFfbG9jayhzdHJ1Y3QgcnEgKnJxMSwgc3RydWN0
IHJxICpycTIpCiB7CiAJbG9ja2RlcF9hc3NlcnRfaXJxc19kaXNhYmxlZCgpOwoKLQlpZiAocnEx
LT5jcHUgPiBycTItPmNwdSkKLQkJc3dhcChycTEsIHJxMik7Ci0KLQlyYXdfc3Bpbl9ycV9sb2Nr
KHJxMSk7Ci0JaWYgKF9fcnFfbG9ja3AocnExKSA9PSBfX3JxX2xvY2twKHJxMikpCi0JCXJldHVy
bjsKLQotCXJhd19zcGluX3JxX2xvY2tfbmVzdGVkKHJxMiwgU0lOR0xFX0RFUFRIX05FU1RJTkcp
OworCWlmIChfX3JxX2xvY2twKHJxMSkgPT0gX19ycV9sb2NrcChycTIpKSB7CisJCXJhd19zcGlu
X3JxX2xvY2socnExKTsKKwl9IGVsc2UgeworCQlpZiAoX19ycV9sb2NrcChycTEpIDwgX19ycV9s
b2NrcChycTIpKSB7CisJCQlyYXdfc3Bpbl9ycV9sb2NrKHJxMSk7CisJCQlyYXdfc3Bpbl9ycV9s
b2NrX25lc3RlZChycTIsIFNJTkdMRV9ERVBUSF9ORVNUSU5HKTsKKwkJfSBlbHNlIHsKKwkJCXJh
d19zcGluX3JxX2xvY2socnEyKTsKKwkJCXJhd19zcGluX3JxX2xvY2tfbmVzdGVkKHJxMSwgU0lO
R0xFX0RFUFRIX05FU1RJTkcpOworCQl9CisJfQogfQogI2VuZGlmCg==
--0000000000004fe2d805c122eafa--
