Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 623FA3C7FB4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 10:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238435AbhGNIER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 04:04:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36293 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238287AbhGNIEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 04:04:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626249684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=iXoTNlB3iob2gMnywuKCDb+yqav38lEUGUEK1vN/CuE=;
        b=WeUOoSGIsccaW3eOqN/Hi6opssc0UmN3jridT0+sj8KJ/ZFG7M+jpjf9YNoIe2SqmsluH8
        /H0tDnaVn25NazGUDq3fs5LNAUmNPFLTz0o/N/79in87Tithvz7XlfRZ2Y5ylbj6KzwCtg
        5+t6kAnng9dpiHIQHF3a8eOkl0D6ekU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-tHJwKQQBPF2ivgIAz-rdRQ-1; Wed, 14 Jul 2021 04:01:22 -0400
X-MC-Unique: tHJwKQQBPF2ivgIAz-rdRQ-1
Received: by mail-ej1-f70.google.com with SMTP id d2-20020a1709072722b02904c99c7e6ddfso439828ejl.15
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 01:01:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=iXoTNlB3iob2gMnywuKCDb+yqav38lEUGUEK1vN/CuE=;
        b=gYOnYCJRESOYllQ1P3Om1MKOGsPkpEjvib/uFpz+DrrQzCv/93GhXSFD6SEtP2/NDl
         0gJmhNbB1mqq43CODNdSCTzI5PyxnrNA5dxWZv7925r5KRSzspcGF/1cUrxsVuPPgJ48
         2ts6GNYZdnYxuHiJhygnjFma925a/5Z3YLuD1BOAxA5n8uN5yk5beNcTZfEFuoioI3jM
         UCiij6BaNhVx5Y68AEy3B/82Fvx9hoUeXJso83+1pctBvKKr6Z4xKdlNsSOxq6Mf5RV0
         ghNCjJq5yiYYKIko+O6RL/Q42XJuhks3Eotet4iF/C1apJLu0+t4o9L6/pKqMwf84RnA
         HVWQ==
X-Gm-Message-State: AOAM532wJkNUBjSQTyRZeDOHucuq6OFqm6sVCt5ifsTfJbFkvk+KFVbB
        jrXhwVAbePUVPSgwBdYV5i4qbHmMkZV70DlF7KAjadm4BTrAAjYljbHPA+sG+w5PEViN3Sd9W5e
        hkMrNoX8dWsH8nWlIuqlecO+5
X-Received: by 2002:a17:906:4a0a:: with SMTP id w10mr11025133eju.371.1626249681657;
        Wed, 14 Jul 2021 01:01:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyw4G8ONsaFpNUgqwdybfa3B8qxGCHlcdOO9r6+hxGAI9WobpsqhyRAe/cvOi4Dzcb0hl0hrA==
X-Received: by 2002:a17:906:4a0a:: with SMTP id w10mr11025108eju.371.1626249681418;
        Wed, 14 Jul 2021 01:01:21 -0700 (PDT)
Received: from x1.bristot.me (host-79-37-206-118.retail.telecomitalia.it. [79.37.206.118])
        by smtp.gmail.com with ESMTPSA id g11sm581213edt.85.2021.07.14.01.01.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jul 2021 01:01:21 -0700 (PDT)
To:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: 5.13-rt1 + KVM = WARNING: at fs/eventfd.c:74 eventfd_signal()
Message-ID: <df278db6-1fc0-3d42-9c0e-f5a085c6351e@redhat.com>
Date:   Wed, 14 Jul 2021 10:01:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGV5DQoNCkkgdXNlIGt2bS12bSBmb3IgcmVndWxhciBkZXZlbG9wbWVudCwgYW5kIHdoaWxl
IHVzaW5nIHRoZSBrZXJuZWwtcnQgdjUuMTMtcnQxDQoodGhlIGxhdGVzdCkgb24gdGhlIGhv
c3QsIGFuZCBhIHJlZ3VsYXIga2VybmVsIG9uIHRoZSBndWVzdCwgYWZ0ZXIgYSB3aGlsZSwN
CnRoaXMgaGFwcGVuczoNCg0KWyAxNzIzLjQwNDk3OV0gLS0tLS0tLS0tLS0tWyBjdXQgaGVy
ZSBdLS0tLS0tLS0tLS0tDQpbIDE3MjMuNDA0OTgxXSBXQVJOSU5HOiBDUFU6IDEyIFBJRDog
MjU1NCBhdCBmcy9ldmVudGZkLmM6NzQgZXZlbnRmZF9zaWduYWwrMHg3ZS8weDkwDQpbIDE3
MjMuNDA0OTg5XSBNb2R1bGVzIGxpbmtlZCBpbjogdmhvc3RfbmV0IHZob3N0IHZob3N0X2lv
dGxiIHRhcCB0dW4gcmZjb21tIHNuZF9zZXFfZHVtbXkgc25kX2hydGltZXIgeHRfQ0hFQ0tT
VU0geHRfTUFTUVVFUkFERSB4dF9jb25udHJhY2sgaXB0X1JFSkVDVCBuZl9uYXRfdGZ0cCBu
Zl9jb25udHJhY2tfdGZ0cCBicmlkZ2Ugc3RwIGxsYyBjY20gbmZ0X29ianJlZiBuZl9jb25u
dHJhY2tfbmV0Ymlvc19ucyBuZl9jb25udHJhY2tfYnJvYWRjYXN0IG5mdF9maWJfaW5ldCBu
ZnRfZmliX2lwdjQgbmZ0X2ZpYl9pcHY2IG5mdF9maWIgbmZ0X3JlamVjdF9pbmV0IG5mX3Jl
amVjdF9pcHY0IG5mX3JlamVjdF9pcHY2IG5mdF9yZWplY3QgbmZ0X2N0IG5mdF9jaGFpbl9u
YXQgaXA2dGFibGVfbmF0IGlwNnRhYmxlX21hbmdsZSBpcDZ0YWJsZV9yYXcgaXA2dGFibGVf
c2VjdXJpdHkgaXB0YWJsZV9uYXQgbmZfbmF0IG5mX2Nvbm50cmFjayBuZl9kZWZyYWdfaXB2
NiBuZl9kZWZyYWdfaXB2NCBpcHRhYmxlX21hbmdsZSBpcHRhYmxlX3JhdyBpcHRhYmxlX3Nl
Y3VyaXR5IGlwX3NldCBuZl90YWJsZXMgbmZuZXRsaW5rIGlwNnRhYmxlX2ZpbHRlciBpcDZf
dGFibGVzIGlwdGFibGVfZmlsdGVyIGNtYWMgYm5lcCBpbnRlbF9yYXBsX21zciBzdW5ycGMg
aW50ZWxfcmFwbF9jb21tb24ga3ZtX2FtZCBrdm0gYXRoMTBrX3BjaSBzbmRfaGRhX2NvZGVj
X3JlYWx0ZWsgYXRoMTBrX2NvcmUgc25kX2hkYV9jb2RlY19nZW5lcmljIGxlZHRyaWdfYXVk
aW8gc25kX2hkYV9jb2RlY19oZG1pIHNuZF9oZGFfaW50ZWwgc25kX2ludGVsX2RzcGNmZyBz
bmRfaGRhX2NvZGVjIGF0aCBidHVzYiBtYWM4MDIxMSBzbmRfaHdkZXAgYnRydGwgc25kX2hk
YV9jb3JlIGJ0YmNtIHNuZF9zZXEgaXJxYnlwYXNzIHJhcGwgdmZhdCBzbmRfc2VxX2Rldmlj
ZSBidGludGVsIGRlbGxfd21pX2Rlc2NyaXB0b3IgYWxpZW53YXJlX3dtaSB3bWlfYm1vZiBs
aWJhcmM0IGZhdCBwY3Nwa3Igc25kX3BjbQ0KWyAxNzIzLjQwNTAzM10gIGJsdWV0b290aCBq
b3lkZXYgazEwdGVtcCBpMmNfcGlpeDQgY2ZnODAyMTEgc25kX3RpbWVyIHNuZCBzb3VuZGNv
cmUgZWNkaF9nZW5lcmljIGVjYyByZmtpbGwgZ3Bpb19hbWRwdCBncGlvX2dlbmVyaWMgYWNw
aV9jcHVmcmVxIHpyYW0gaXBfdGFibGVzIG5vdXZlYXUgaGlkX2xvZ2l0ZWNoX2hpZHBwIHZp
ZGVvIGRybV90dG1faGVscGVyIHR0bSBpMmNfYWxnb19iaXQgbXhtX3dtaSBkcm1fa21zX2hl
bHBlciBjcmN0MTBkaWZfcGNsbXVsIGNyYzMyX3BjbG11bCBjcmMzMmNfaW50ZWwgY2VjIGRy
bSBnaGFzaF9jbG11bG5pX2ludGVsIHI4MTY5IG52bWUgaGlkX2xvZ2l0ZWNoX2RqIGNjcCBu
dm1lX2NvcmUgc3A1MTAwX3RjbyB3bWkgZnVzZQ0KWyAxNzIzLjQwNTA1MV0gQ1BVOiAxMiBQ
SUQ6IDI1NTQgQ29tbTogdmhvc3QtMjUyOSBOb3QgdGFpbnRlZCA1LjEzLjAtcnQtcnQxKyAj
Mg0KWyAxNzIzLjQwNTA1NF0gSGFyZHdhcmUgbmFtZTogQWxpZW53YXJlIEFsaWVud2FyZSBB
dXJvcmEgUnl6ZW4gRWRpdGlvbi8wVFlSMFgsIEJJT1MgMi4xLjIgMDIvMjUvMjAyMQ0KWyAx
NzIzLjQwNTA1NV0gUklQOiAwMDEwOmV2ZW50ZmRfc2lnbmFsKzB4N2UvMHg5MA0KWyAxNzIz
LjQwNTA1OV0gQ29kZTogMDEgMDAgMDAgMDAgYmUgMDMgMDAgMDAgMDAgNGMgODkgZWYgZTgg
NWIgZWMgZDkgZmYgNjUgZmYgMGQgZTQgMzQgYzkgNWEgNGMgODkgZWYgZTggZWMgYTggODYg
MDAgNGMgODkgZTAgNWIgNWQgNDEgNWMgNDEgNWQgYzMgPDBmPiAwYiA0NSAzMSBlNCA1YiA1
ZCA0YyA4OSBlMCA0MSA1YyA0MSA1ZCBjMyAwZiAxZiAwMCAwZiAxZiA0NCAwMA0KWyAxNzIz
LjQwNTA2MF0gUlNQOiAwMDE4OmZmZmZiNzE5YzJmNjdkNzAgRUZMQUdTOiAwMDAxMDIwMg0K
WyAxNzIzLjQwNTA2Ml0gUkFYOiAwMDAwMDAwMDAwMDAwMDAxIFJCWDogZmZmZjlmNDg5NzM2
NGFlMCBSQ1g6IDAwMDAwMDAwMDAwMDAwMDANClsgMTcyMy40MDUwNjNdIFJEWDogMDAwMDAw
MDAwMDAwMDc5MSBSU0k6IDAwMDAwMDAwMDAwMDAwMDEgUkRJOiBmZmZmOWY0ODlhZTY0N2Uw
DQpbIDE3MjMuNDA1MDY0XSBSQlA6IDAwMDAwMDAwMDAwMDAxMDAgUjA4OiAwMDAwMDAwMDAw
MDAwMDAwIFIwOTogMDAwMDAwMDAwMDAwMDAwMQ0KWyAxNzIzLjQwNTA2NV0gUjEwOiAwMDAw
MDAwMDAwMDQ3MTVlIFIxMTogMDAwMDAwMDAwMDAwMzZlMCBSMTI6IDAwMDAwMDAwMDAwMDAw
MDENClsgMTcyMy40MDUwNjZdIFIxMzogZmZmZjlmNDg5Yjc2NDNjMCBSMTQ6IGZmZmZiNzE5
YzJmNjdlMjAgUjE1OiBmZmZmOWY0ODk3MzY0YWUwDQpbIDE3MjMuNDA1MDY3XSBGUzogIDAw
MDAwMDAwMDAwMDAwMDAoMDAwMCkgR1M6ZmZmZjlmNGY5ZWQwMDAwMCgwMDAwKSBrbmxHUzow
MDAwMDAwMDAwMDAwMDAwDQpbIDE3MjMuNDA1MDY4XSBDUzogIDAwMTAgRFM6IDAwMDAgRVM6
IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzDQpbIDE3MjMuNDA1MDY5XSBDUjI6IDAwMDA3
ZmZhNzgzNTUwMDAgQ1IzOiAwMDAwMDAwMTE0YjdjMDAwIENSNDogMDAwMDAwMDAwMDc1MGVl
MA0KWyAxNzIzLjQwNTA3MV0gUEtSVTogNTU1NTU1NTQNClsgMTcyMy40MDUwNzFdIENhbGwg
VHJhY2U6DQpbIDE3MjMuNDA1MDc4XSAgdmhvc3RfdHhfYmF0Y2guY29uc3Rwcm9wLjArMHg3
ZC8weGMwIFt2aG9zdF9uZXRdDQpbIDE3MjMuNDA1MDgzXSAgaGFuZGxlX3R4X2NvcHkrMHgx
NWIvMHg1YzAgW3Zob3N0X25ldF0NClsgMTcyMy40MDUwODhdICA/IF9fdmhvc3RfYWRkX3Vz
ZWRfbisweDIwMC8weDIwMCBbdmhvc3RdDQpbIDE3MjMuNDA1MDkyXSAgaGFuZGxlX3R4KzB4
YTUvMHhlMCBbdmhvc3RfbmV0XQ0KWyAxNzIzLjQwNTA5NV0gIHZob3N0X3dvcmtlcisweDkz
LzB4ZDAgW3Zob3N0XQ0KWyAxNzIzLjQwNTA5OV0gIGt0aHJlYWQrMHgxODYvMHgxYTANClsg
MTcyMy40MDUxMDNdICA/IF9fa3RocmVhZF9wYXJrbWUrMHhhMC8weGEwDQpbIDE3MjMuNDA1
MTA1XSAgcmV0X2Zyb21fZm9yaysweDIyLzB4MzANClsgMTcyMy40MDUxMTBdIC0tLVsgZW5k
IHRyYWNlIDAwMDAwMDAwMDAwMDAwMDIgXS0tLQ0KDQphbmQgbXkgY29tbXVuaWNhdGlvbiB3
aXRoIHRoZSBWTSBkaWVzLiBSZWJvb3RpbmcgdGhlIFZNIG1ha2VzIGl0IHdvcmsgYWdhaW4u
DQoNCi0tIERhbmllbA0K

