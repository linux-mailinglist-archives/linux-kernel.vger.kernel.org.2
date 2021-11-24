Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11D0B45B766
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 10:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbhKXJ3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 04:29:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23429 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234276AbhKXJ3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 04:29:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637745962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BQgtvg2ZkWrUMM5zFkNCK/e0DkxhsLRFtdrJVemGxaU=;
        b=Gt7Aqd8T5FJ1oKqdiov4H6HXmmzGgmz/0Dfuj9sw6+sn1rqf7HscbnOXCSeJ7PPhMIL+8V
        S5Gt5ue62Yk1Evl4PJ2p9IpBCB7jSktq+d6EWZx/YtypLaCtdB0LQS1GxZZ3TVOfC7JqEy
        3wRu3vjqtYVUnk+krv5fNM6tAl7bOvU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-5-uwWaCc2GMo-kr1FpwvZKcA-1; Wed, 24 Nov 2021 04:23:17 -0500
X-MC-Unique: uwWaCc2GMo-kr1FpwvZKcA-1
Received: by mail-qt1-f197.google.com with SMTP id v17-20020a05622a131100b002aea167e24aso1642863qtk.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 01:23:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BQgtvg2ZkWrUMM5zFkNCK/e0DkxhsLRFtdrJVemGxaU=;
        b=nFAL0+GgUG1y/6MVfJUdt4P0wNkTT83ymITNclOxMDgQDDGDvOFWhcSky0zPaLm71G
         rio7ufqsAYcKVh2/Y1e6GMZs0NlmNqj3a1+G9iFUr37tULzUtInSEBgJZec2Pkt2bOns
         7avzI/qz0atnVCJ+ddX4jIyJYB3FMsR5Cq/+9CqrtSQSd/PFUY0sEuW1Rwsj6X8zmbfz
         0NmR4Rw70U5J/YvH+G/gzn6QozlIVUV72H0iLXrw5WsX8wZOgEECb7dVq/lSn+chIjeK
         l3mZ/15PFCaxN2oTgyjNXZQ2xiefLSW9r1SQQ/qSauR91mgX/6CjdEQJvhd1SlOkFlhN
         Fn3A==
X-Gm-Message-State: AOAM531/3t3+LHzifRSUeV4AWSakl1rgWgM5iOEQqOe9ug6SQQ96piIr
        T3aHjOOUc7NFVAWlkjylNN7VIHyzmQhjDYf2agh1/EThOO2TOEWPSWPfg7M/wqHlztPyv6L5hXm
        wJ6TxWoI/76EC/zpqBGcnS+tJiHPRvnh5FIF9Fkh9
X-Received: by 2002:a05:622a:54d:: with SMTP id m13mr5092360qtx.33.1637745797411;
        Wed, 24 Nov 2021 01:23:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwNMS1eL8lahae3MPzJCH7hPnDtYZBGDghu1c5C5/qpg/nhkqSpg60V9WRgBDtDjpPW2wpna8JeaOAvRjH7+Z4=
X-Received: by 2002:a05:622a:54d:: with SMTP id m13mr5092329qtx.33.1637745797213;
 Wed, 24 Nov 2021 01:23:17 -0800 (PST)
MIME-Version: 1.0
References: <20211115165428.722074685@linuxfoundation.org> <20211115165430.669780058@linuxfoundation.org>
 <CAFxkdAqahwaN0u6u34d4CrMW7rYL=6TpWk1CcOn+uGQdEgkuTQ@mail.gmail.com>
 <CAOssrKd4gHrKNNttZZey9orZ=F+msx4Axa6Mi_XgZw-9M39h-Q@mail.gmail.com> <CAFxkdAqU0peBNm_SB3En99bU+o=a+05t-Bwyds0AUFb+2W=CFw@mail.gmail.com>
In-Reply-To: <CAFxkdAqU0peBNm_SB3En99bU+o=a+05t-Bwyds0AUFb+2W=CFw@mail.gmail.com>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Wed, 24 Nov 2021 10:23:06 +0100
Message-ID: <CAOssrKez1mnF4rWRvWgk4LJ2iDfX8xkpMKvgprFt+-ARs83=nA@mail.gmail.com>
Subject: Re: [PATCH 5.15 056/917] fuse: fix page stealing
To:     Justin Forbes <jmforbes@linuxtx.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Frank Dinoff <fdinoff@google.com>
Content-Type: multipart/mixed; boundary="0000000000007a1a4d05d1856873"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000007a1a4d05d1856873
Content-Type: text/plain; charset="UTF-8"

On Wed, Nov 24, 2021 at 1:40 AM Justin Forbes <jmforbes@linuxtx.org> wrote:
> Thanks, did a scratch build for that and dropped it in the bug. Only
> one user has reported back, but the report was that it did not fix the
> issue.  I have also gotten confirmation now that the issue is occuring
> with 5.16-rc2.

Okay.

Morning light brings clarity to the mind.  Here's a patch that should
definitely fix this bug, as well as the very unlikely race of the page
being truncated from the page cache before pipe_buf_release() is
called.

Please test.

Thanks,
Miklos

--0000000000007a1a4d05d1856873
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="fuse-release-pipe-buf-after-its-last-use.patch"
Content-Disposition: attachment; 
	filename="fuse-release-pipe-buf-after-its-last-use.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kwdbjjyl0>
X-Attachment-Id: f_kwdbjjyl0

RnJvbTogTWlrbG9zIFN6ZXJlZGkgPG1zemVyZWRpQHJlZGhhdC5jb20+ClN1YmplY3Q6IGZ1c2U6
IHJlbGVhc2UgcGlwZSBidWYgYWZ0ZXIgbGFzdCB1c2UKCkNoZWNraW5nIGJ1Zi0+ZmxhZ3Mgc2hv
dWxkIGJlIGRvbmUgYmVmb3JlIHRoZSBwaXBlX2J1Zl9yZWxlYXNlKCkgaXMgY2FsbGVkCm9uIHRo
ZSBwaXBlIGJ1ZmZlciwgc2luY2UgcmVsZWFzaW5nIHRoZSBidWZmZXIgbWlnaHQgbW9kaWZ5IHRo
ZSBmbGFncy4KClRoaXMgaXMgZXhhY3RseSB3aGF0IHBhZ2VfY2FjaGVfcGlwZV9idWZfcmVsZWFz
ZSgpIGRvZXMsIGFuZCB3aGljaCByZXN1bHRzCmluIHRoZSBzYW1lIFZNX0JVR19PTl9QQUdFKFBh
Z2VMUlUocGFnZSkpIHRoYXQgdGhlIG9yaWdpbmFsIHBhdGNoIHdhcwp0cnlpbmcgdG8gZml4LgoK
UmVwb3J0ZWQtYnk6IEp1c3RpbiBGb3JiZXMgPGptZm9yYmVzQGxpbnV4dHgub3JnPgpGaXhlczog
NzEyYTk1MTAyNWMwICgiZnVzZTogZml4IHBhZ2Ugc3RlYWxpbmciKQpDYzogPHN0YWJsZUB2Z2Vy
Lmtlcm5lbC5vcmc+ICMgdjIuNi4zNQpTaWduZWQtb2ZmLWJ5OiBNaWtsb3MgU3plcmVkaSA8bXN6
ZXJlZGlAcmVkaGF0LmNvbT4KLS0tCiBmcy9mdXNlL2Rldi5jIHwgICAxMCArKysrKy0tLS0tCiAx
IGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQoKLS0tIGEvZnMv
ZnVzZS9kZXYuYworKysgYi9mcy9mdXNlL2Rldi5jCkBAIC04NDcsMTcgKzg0NywxNyBAQCBzdGF0
aWMgaW50IGZ1c2VfdHJ5X21vdmVfcGFnZShzdHJ1Y3QgZnVzCiAKIAlyZXBsYWNlX3BhZ2VfY2Fj
aGVfcGFnZShvbGRwYWdlLCBuZXdwYWdlKTsKIAorCWdldF9wYWdlKG5ld3BhZ2UpOworCisJaWYg
KCEoYnVmLT5mbGFncyAmIFBJUEVfQlVGX0ZMQUdfTFJVKSkKKwkJbHJ1X2NhY2hlX2FkZChuZXdw
YWdlKTsKKwogCS8qCiAJICogUmVsZWFzZSB3aGlsZSB3ZSBoYXZlIGV4dHJhIHJlZiBvbiBzdG9s
ZW4gcGFnZS4gIE90aGVyd2lzZQogCSAqIGFub25fcGlwZV9idWZfcmVsZWFzZSgpIG1pZ2h0IHRo
aW5rIHRoZSBwYWdlIGNhbiBiZSByZXVzZWQuCiAJICovCiAJcGlwZV9idWZfcmVsZWFzZShjcy0+
cGlwZSwgYnVmKTsKIAotCWdldF9wYWdlKG5ld3BhZ2UpOwotCi0JaWYgKCEoYnVmLT5mbGFncyAm
IFBJUEVfQlVGX0ZMQUdfTFJVKSkKLQkJbHJ1X2NhY2hlX2FkZChuZXdwYWdlKTsKLQogCWVyciA9
IDA7CiAJc3Bpbl9sb2NrKCZjcy0+cmVxLT53YWl0cS5sb2NrKTsKIAlpZiAodGVzdF9iaXQoRlJf
QUJPUlRFRCwgJmNzLT5yZXEtPmZsYWdzKSkK
--0000000000007a1a4d05d1856873--

