Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8723EA818
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 17:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238444AbhHLP4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 11:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238391AbhHLP4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 11:56:34 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB5CC061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 08:56:09 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id g138so4864686wmg.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 08:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pPNKnS5Ix8iGJ7X1MCd22TX0QP9wob6pEQFzSDZ/a84=;
        b=Eu0U/5pD4E2SyrujqQ5SY+2rnHneMiZfihM/bIuhJxxqXmyXqw1/bIULm0P4zCvJPo
         e3OSoPUMgTQhtzF4Jf7rq4ekh6Wjr4d30tADM7cknrDXc/dNhD5eUV5cAMiYbb9IzesD
         irWUpCsYXO1b0gzSzeHi1TkTfvd1Yzb8v7pFvtI+Nm/VQUWtrMPvQnZrnvJ54EVqEMgt
         18ZApcImZJAmGkBOOkmKffqqDpjObci7ZNtCEVNmI6T8dH4FKlQK/WyRSwRZN6d09dlt
         xczOSuwo7FZ/zK3bIFLIm/MLlDhOBvEbaaknGmpFMsg/gtpNKOQdlQmOK1+ocaxmP4JY
         he1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pPNKnS5Ix8iGJ7X1MCd22TX0QP9wob6pEQFzSDZ/a84=;
        b=lZ0YjO8snV8afmSuCxk97Wrm7x3ymEhIMzPaXH4YaK2VeHnvLjtkWave5eTyIfXYjW
         F9ODz7snu1OEb/xQ1EQhhcbMWzpDnAj5JkMpwyO7JosIs9tA2kV10Gc7UMQcqNcaK6St
         MVw4XRwSJj40G1oDt+92HfRjDVDeR9Mx9DcnU/cX4J/zTAQRtuQTvcgOQUA+SpjDVTR+
         fCnEZ2RPkIjDTr4V8ht2Ujn8lPkehdYaU1zhAE4nYZA7zhVitlh+hAm6gmyEse3x+t99
         b9rCCRNKmbnjPWipY6VcGV2zNKGSt5nXOnpKaK3Nt/OdM8g/CzDwvK31zyZ9p/VNgd3A
         MNAA==
X-Gm-Message-State: AOAM530IUYcXjB2xVBuIfrbzG1zymvbUFtdTQHwFiIxuuQHAebAl5fIL
        r5eBdayAoURD18rDwMLsbnYSkcxdqlRpBQVgocQ=
X-Google-Smtp-Source: ABdhPJwYIND/zpCosIhlDrZ7uVFgfeY107U7j1nBOeFNpI0XHT45rRdeinZaMKIOr0qZHNmsUSH1N6h47toBnmClnw0=
X-Received: by 2002:a1c:f008:: with SMTP id a8mr4733799wmb.83.1628783767678;
 Thu, 12 Aug 2021 08:56:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5msrRdGmFGht+rN7_UgkmrpT8eaAoQ46EyLvxhm7M-fKmg@mail.gmail.com>
 <69c2a565-c3e4-3127-9203-1179609a07d7@infradead.org> <CAH2r5ms4ixXBdvvE+3Yr8XaPJmEN0HJgqXc1krbTFkpO7X1Lsg@mail.gmail.com>
In-Reply-To: <CAH2r5ms4ixXBdvvE+3Yr8XaPJmEN0HJgqXc1krbTFkpO7X1Lsg@mail.gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 12 Aug 2021 10:55:56 -0500
Message-ID: <CAH2r5ms_+ZgzsbUb=ghFpaN-qGLUumpkwD43A8rhqGEPWE12VQ@mail.gmail.com>
Subject: Re: signed integer overflow in atomic.h
To:     ronnie sahlberg <ronniesahlberg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, Paulo Alcantara <pc@cjr.nz>
Content-Type: multipart/mixed; boundary="000000000000e4276205c95ec5c7"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000e4276205c95ec5c7
Content-Type: text/plain; charset="UTF-8"

If the "signed integer overflow" is a compiler bug fixed in last
couple of years - do we even need these two patches that we were
seeing to fix this issue in  a few places in cifs.ko (which we noted
on 5.11 regression test runs, but not 5.14-rc)


On Thu, Aug 12, 2021 at 10:43 AM Steve French <smfrench@gmail.com> wrote:
>
> Ronnie,
> The guest irunning the tests is Fedora (although the host where the
> compile is done is RHEL7.9 IIRC) ... do we need to update the compiler
> on it - we do hit some of these with UBSAN enabled on 5.11 tests
> (strangely I don't see them on 5.14-rc)
>
> ---------- Forwarded message ---------
> From: Randy Dunlap <rdunlap@infradead.org>
> Date: Thu, Aug 12, 2021 at 10:07 AM
> Subject: Re: signed integer overflow in atomic.h
> To: Steve French <smfrench@gmail.com>, LKML
> <linux-kernel@vger.kernel.org>, Netdev <netdev@vger.kernel.org>
>
>
> On 8/11/21 10:41 PM, Steve French wrote:
> > ===============
> > [   28.345189] UBSAN: signed-integer-overflow in
> > ./arch/x86/include/asm/atomic.h:165:11
> > [   28.345196] 484501395 + 2024361625 cannot be represented in type 'int'
> > [   28.345202] CPU: 6 PID: 987 Comm: nmbd Not tainted 5.11.22 #1
> > [   28.345208] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
> > [   28.345212] Call Trace:
> > [   28.345218]  dump_stack+0x8d/0xb5
> > [   28.345233]  ubsan_epilogue+0x5/0x50
> > [   28.345242]  handle_overflow+0xa3/0xb0
> > [   28.345257]  ? rcu_read_lock_sched_held+0x39/0x80
> > [   28.345270]  ip_idents_reserve+0x8d/0xb0
> > [   28.345283]  __ip_select_ident+0x3f/0x70
> > [   28.345292]  __ip_make_skb+0x279/0x450
> > [   28.345302]  ? ip_reply_glue_bits+0x40/0x40
> > [   28.345314]  ip_make_skb+0x10d/0x130
> > [   28.345326]  ? ip_route_output_key_hash+0xee/0x190
> > [   28.345344]  udp_sendmsg+0x79b/0x13b0
> > [   28.345365]  ? ip_reply_glue_bits+0x40/0x40
> > [   28.345403]  ? find_held_lock+0x29/0xb0
> > [   28.345420]  ? sock_sendmsg+0x54/0x60
> > [   28.345426]  sock_sendmsg+0x54/0x60
>
> from net/ipv4/route.c:
>
>         /* If UBSAN reports an error there, please make sure your compiler
>          * supports -fno-strict-overflow before reporting it that was a bug
>          * in UBSAN, and it has been fixed in GCC-8.
>          */
>         return atomic_add_return(segs + delta, p_id) - segs;
>
>
> --
> ~Randy
>
>
>
> --
> Thanks,
>
> Steve



-- 
Thanks,

Steve

--000000000000e4276205c95ec5c7
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0004-cifs-avoid-signed-integer-overflow-in-calculating-bl.patch"
Content-Disposition: attachment; 
	filename="0004-cifs-avoid-signed-integer-overflow-in-calculating-bl.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ks93sh6b1>
X-Attachment-Id: f_ks93sh6b1

RnJvbSA4NGZjYTI1NGZkZTYxMDBjMjU2ODkwMzhmOTFlNjRlMTYxNjFlYzUxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+
CkRhdGU6IFdlZCwgMTEgQXVnIDIwMjEgMjM6MjM6MDIgLTA1MDAKU3ViamVjdDogW1BBVENIIDQv
NF0gY2lmczogYXZvaWQgc2lnbmVkIGludGVnZXIgb3ZlcmZsb3cgaW4gY2FsY3VsYXRpbmcgYmxv
Y2tzCgp4ZnN0ZXN0IGdlbmVyaWMvNTI1IGNhbiBnZW5lcmF0ZSB0aGUgZm9sbG93aW5nIHdhcm5p
bmc6CgogVUJTQU46IHNpZ25lZC1pbnRlZ2VyLW92ZXJmbG93IGluIGZzL2NpZnMvZmlsZS5jOjI2
NDQ6MzEKIDkyMjMzNzIwMzY4NTQ3NzU4MDcgKyA1MTEgY2Fubm90IGJlIHJlcHJlc2VudGVkIGlu
IHR5cGUgJ2xvbmcgbG9uZyBpbnQnCgogQ2FsbCBUcmFjZToKICBkdW1wX3N0YWNrKzB4OGQvMHhi
NQogIHVic2FuX2VwaWxvZ3VlKzB4NS8weDUwCiAgaGFuZGxlX292ZXJmbG93KzB4YTMvMHhiMAog
IGNpZnNfd3JpdGVfZW5kKzB4NDI0LzB4NDQwIFtjaWZzXQogIGdlbmVyaWNfcGVyZm9ybV93cml0
ZSsweGVmLzB4MTkwCgpkdWUgdG8gb3ZlcmZsb3dpbmcgbG9mZl90IChhIHNpZ25lZCA2NCBiaXQp
IHdoZW4gaXQgaXMgcm91bmRlZCB1cAp0byBjYWxjdWxhdGUgbnVtYmVyIG9mIDUxMiBieXRlIGJs
b2NrcyBpbiBhIGZpbGUgaW4gdHdvIHBsYWNlcy4KClNpZ25lZC1vZmYtYnk6IFN0ZXZlIEZyZW5j
aCA8c3RmcmVuY2hAbWljcm9zb2Z0LmNvbT4KLS0tCiBmcy9jaWZzL2ZpbGUuYyAgfCAzICsrLQog
ZnMvY2lmcy9pbm9kZS5jIHwgMiArLQogMiBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZnMvY2lmcy9maWxlLmMgYi9mcy9jaWZzL2Zp
bGUuYwppbmRleCAwMTY2ZjM5ZjE4ODguLjNjYzE3ODcxNDcxYSAxMDA2NDQKLS0tIGEvZnMvY2lm
cy9maWxlLmMKKysrIGIvZnMvY2lmcy9maWxlLmMKQEAgLTI2NDEsNyArMjY0MSw4IEBAIHN0YXRp
YyBpbnQgY2lmc193cml0ZV9lbmQoc3RydWN0IGZpbGUgKmZpbGUsIHN0cnVjdCBhZGRyZXNzX3Nw
YWNlICptYXBwaW5nLAogCQlzcGluX2xvY2soJmlub2RlLT5pX2xvY2spOwogCQlpZiAocG9zID4g
aW5vZGUtPmlfc2l6ZSkgewogCQkJaV9zaXplX3dyaXRlKGlub2RlLCBwb3MpOwotCQkJaW5vZGUt
PmlfYmxvY2tzID0gKDUxMiAtIDEgKyBwb3MpID4+IDk7CisJCQkvKiByb3VuZCB1cCB0byBibG9j
ayBib3VuZGFyeSwgYXZvaWQgb3ZlcmZsb3cgbG9mZl90ICovCisJCQlpbm9kZS0+aV9ibG9ja3Mg
PSAoKF9fdTY0KXBvcyArICg1MTIgLSAxKSkgPj4gOTsKIAkJfQogCQlzcGluX3VubG9jaygmaW5v
ZGUtPmlfbG9jayk7CiAJfQpkaWZmIC0tZ2l0IGEvZnMvY2lmcy9pbm9kZS5jIGIvZnMvY2lmcy9p
bm9kZS5jCmluZGV4IDY1ZjhhNzBjZWNlMy4uZjFkYmNiYzc5YWJiIDEwMDY0NAotLS0gYS9mcy9j
aWZzL2lub2RlLmMKKysrIGIvZnMvY2lmcy9pbm9kZS5jCkBAIC0yNjMxLDcgKzI2MzEsNyBAQCBj
aWZzX3NldF9maWxlX3NpemUoc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGlhdHRyICphdHRy
cywKIAkJICogdGhpcyBpcyBiZXN0IGVzdGltYXRlIHdlIGhhdmUgZm9yIGJsb2NrcyBhbGxvY2F0
ZWQgZm9yIGEgZmlsZQogCQkgKiBOdW1iZXIgb2YgYmxvY2tzIG11c3QgYmUgcm91bmRlZCB1cCBz
byBzaXplIDEgaXMgbm90IDAgYmxvY2tzCiAJCSAqLwotCQlpbm9kZS0+aV9ibG9ja3MgPSAoNTEy
IC0gMSArIGF0dHJzLT5pYV9zaXplKSA+PiA5OworCQlpbm9kZS0+aV9ibG9ja3MgPSAoKF9fdTY0
KWF0dHJzLT5pYV9zaXplICsgKDUxMiAtIDEpKSA+PiA5OwogCiAJCS8qCiAJCSAqIFRoZSBtYW4g
cGFnZSBvZiB0cnVuY2F0ZSBzYXlzIGlmIHRoZSBzaXplIGNoYW5nZWQsCi0tIAoyLjMwLjIKCg==
--000000000000e4276205c95ec5c7
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-cifs-fix-signed-integer-overflow-when-fl_end-is-OFFS.patch"
Content-Disposition: attachment; 
	filename="0001-cifs-fix-signed-integer-overflow-when-fl_end-is-OFFS.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ks93sh5x0>
X-Attachment-Id: f_ks93sh5x0

RnJvbSBhY2NiNmRlM2Y5Yzk1ODNjZjkxNmI2ODFmNWNlY2IwMWE5NDkwYzJiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQYXVsbyBBbGNhbnRhcmEgPHBjQGNqci5uej4KRGF0ZTogVHVl
LCAxMCBBdWcgMjAyMSAxMzoxMDo0NCAtMDMwMApTdWJqZWN0OiBbUEFUQ0ggMS80XSBjaWZzOiBm
aXggc2lnbmVkIGludGVnZXIgb3ZlcmZsb3cgd2hlbiBmbF9lbmQgaXMKIE9GRlNFVF9NQVgKClRo
aXMgZml4ZXMgdGhlIGZvbGxvd2luZyB3aGVuIHJ1bm5pbmcgeGZzdGVzdHMgZ2VuZXJpYy81MDQ6
CgpbICAxMzQuMzk0Njk4XSBDSUZTOiBBdHRlbXB0aW5nIHRvIG1vdW50IFxcd2luMTYudm0udGVz
dFxTaGFyZQpbICAxMzQuNDIwOTA1XSBDSUZTOiBWRlM6IGdlbmVyYXRlX3NtYjNzaWduaW5na2V5
OiBkdW1waW5nIGdlbmVyYXRlZApBRVMgc2Vzc2lvbiBrZXlzClsgIDEzNC40MjA5MTFdIENJRlM6
IFZGUzogU2Vzc2lvbiBJZCAgICAwNSAwMCAwMCAwMCAwMCBjNCAwMCAwMApbICAxMzQuNDIwOTE0
XSBDSUZTOiBWRlM6IENpcGhlciB0eXBlICAgMQpbICAxMzQuNDIwOTE3XSBDSUZTOiBWRlM6IFNl
c3Npb24gS2V5ICAgZWEgMGIgZDkgMjIgMmUgYWYgMDEgNjkgMzAgMWIKMTUgNzQgYmYgODcgNDEg
MTEKWyAgMTM0LjQyMDkyMF0gQ0lGUzogVkZTOiBTaWduaW5nIEtleSAgIDU5IDI4IDQzIDVjIGYw
IGI2IGIxIDZmIGY1IDdiCjY1IGYyIDlmIDllIDU4IDdkClsgIDEzNC40MjA5MjNdIENJRlM6IFZG
UzogU2VydmVySW4gS2V5ICBlYiBhYSA1OCBjOCA5NSAwMSA5YSBmNyA5MSA5OAplNCBmYSBiYyBk
OCA3NCBmMQpbICAxMzQuNDIwOTI2XSBDSUZTOiBWRlM6IFNlcnZlck91dCBLZXkgMDggNWIgMjEg
ZTUgMmUgNGUgODYgZjYgMDUgYzIKNTggZTAgYWYgNTMgODMgZTcKWyAgMTM0Ljc3MTk0Nl0KPT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT0KWyAgMTM0Ljc3MTk1M10gVUJTQU46IHNpZ25lZC1pbnRlZ2Vy
LW92ZXJmbG93IGluIGZzL2NpZnMvZmlsZS5jOjE3MDY6MTkKWyAgMTM0Ljc3MTk1N10gOTIyMzM3
MjAzNjg1NDc3NTgwNyArIDEgY2Fubm90IGJlIHJlcHJlc2VudGVkIGluIHR5cGUKJ2xvbmcgbG9u
ZyBpbnQnClsgIDEzNC43NzE5NjBdIENQVTogNCBQSUQ6IDI3NzMgQ29tbTogZmxvY2sgTm90IHRh
aW50ZWQgNS4xMS4yMiAjMQpbICAxMzQuNzcxOTY0XSBIYXJkd2FyZSBuYW1lOiBSZWQgSGF0IEtW
TSwgQklPUyAwLjUuMSAwMS8wMS8yMDExClsgIDEzNC43NzE5NjZdIENhbGwgVHJhY2U6ClsgIDEz
NC43NzE5NzBdICBkdW1wX3N0YWNrKzB4OGQvMHhiNQpbICAxMzQuNzcxOTgxXSAgdWJzYW5fZXBp
bG9ndWUrMHg1LzB4NTAKWyAgMTM0Ljc3MTk4OF0gIGhhbmRsZV9vdmVyZmxvdysweGEzLzB4YjAK
WyAgMTM0Ljc3MTk5N10gID8gbG9ja2RlcF9oYXJkaXJxc19vbl9wcmVwYXJlKzB4ZTgvMHgxYjAK
WyAgMTM0Ljc3MjAwNl0gIGNpZnNfc2V0bGsrMHg2M2MvMHg2ODAgW2NpZnNdClsgIDEzNC43NzIw
ODVdICA/IF9nZXRfeGlkKzB4NWYvMHhhMCBbY2lmc10KWyAgMTM0Ljc3MjA4NV0gIGNpZnNfZmxv
Y2srMHgxMzEvMHg0MDAgW2NpZnNdClsgIDEzNC43NzIwODVdICBfX3g2NF9zeXNfZmxvY2srMHhm
Yy8weDEyMApbICAxMzQuNzcyMDg1XSAgZG9fc3lzY2FsbF82NCsweDMzLzB4NDAKWyAgMTM0Ljc3
MjA4NV0gIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDQ0LzB4YTkKWyAgMTM0Ljc3
MjA4NV0gUklQOiAwMDMzOjB4N2ZlYTRmODNiM2ZiClsgIDEzNC43NzIwODVdIENvZGU6IGZmIDQ4
IDhiIDE1IDhmIDFhIDBkIDAwIGY3IGQ4IDY0IDg5IDAyIGI4IGZmIGZmCmZmIGZmIGViIGRhIGU4
IDE2IDBiIDAyIDAwIDY2IDBmIDFmIDQ0IDAwIDAwIGYzIDBmIDFlIGZhIGI4IDQ5IDAwIDAwCjAw
IDBmIDA1IDw0OD4gM2QgMDEgZjAgZmYgZmYgNzMgMDEgYzMgNDggOGIgMGQgNWQgMWEgMGQgMDAg
ZjcgZDggNjQgODkKMDEgNDgKCkFuZCBmaXhlcyBhIHNpbWlsYXIgbG9mZl90IG92ZXJmbG93IHBy
b2JsZW0gaW4gc21iMl91bmxvY2tfcmFuZ2UKClNpZ25lZC1vZmYtYnk6IFBhdWxvIEFsY2FudGFy
YSAoU1VTRSkgPHBjQGNqci5uej4KUmV2aWV3ZWQtYnk6IFJvbm5pZSBTYWhsYmVyZyA8bHNhaGxi
ZXJAcmVkaGF0LmNvbT4KU2lnbmVkLW9mZi1ieTogU3RldmUgRnJlbmNoIDxzdGZyZW5jaEBtaWNy
b3NvZnQuY29tPgotLS0KIGZzL2NpZnMvY2lmc2dsb2IuaCB8IDUgKysrKysKIGZzL2NpZnMvY2lm
c3NtYi5jICB8IDMgKystCiBmcy9jaWZzL2ZpbGUuYyAgICAgfCA4ICsrKystLS0tCiBmcy9jaWZz
L3NtYjJmaWxlLmMgfCAyICstCiA0IGZpbGVzIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDYg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZnMvY2lmcy9jaWZzZ2xvYi5oIGIvZnMvY2lmcy9j
aWZzZ2xvYi5oCmluZGV4IGMwYmZjMmYwMTAzMC4uMmQ2MTc4ZGY0MjZmIDEwMDY0NAotLS0gYS9m
cy9jaWZzL2NpZnNnbG9iLmgKKysrIGIvZnMvY2lmcy9jaWZzZ2xvYi5oCkBAIC0xOTY0LDQgKzE5
NjQsOSBAQCBzdGF0aWMgaW5saW5lIGJvb2wgaXNfdGNvbl9kZnMoc3RydWN0IGNpZnNfdGNvbiAq
dGNvbikKIAkJdGNvbi0+c2hhcmVfZmxhZ3MgJiAoU0hJMTAwNV9GTEFHU19ERlMgfCBTSEkxMDA1
X0ZMQUdTX0RGU19ST09UKTsKIH0KIAorc3RhdGljIGlubGluZSB1NjQgY2lmc19mbG9ja19sZW4o
c3RydWN0IGZpbGVfbG9jayAqZmwpCit7CisJcmV0dXJuIGZsLT5mbF9lbmQgPT0gT0ZGU0VUX01B
WCA/IGZsLT5mbF9lbmQgLSBmbC0+Zmxfc3RhcnQgOiBmbC0+ZmxfZW5kIC0gZmwtPmZsX3N0YXJ0
ICsgMTsKK30KKwogI2VuZGlmCS8qIF9DSUZTX0dMT0JfSCAqLwpkaWZmIC0tZ2l0IGEvZnMvY2lm
cy9jaWZzc21iLmMgYi9mcy9jaWZzL2NpZnNzbWIuYwppbmRleCA2NWQxYTY1YmZjMzcuLjZhYjZj
ZjY2OTQzOCAxMDA2NDQKLS0tIGEvZnMvY2lmcy9jaWZzc21iLmMKKysrIGIvZnMvY2lmcy9jaWZz
c21iLmMKQEAgLTI2MDcsNyArMjYwNyw4IEBAIENJRlNTTUJQb3NpeExvY2soY29uc3QgdW5zaWdu
ZWQgaW50IHhpZCwgc3RydWN0IGNpZnNfdGNvbiAqdGNvbiwKIAogCQkJcExvY2tEYXRhLT5mbF9z
dGFydCA9IGxlNjRfdG9fY3B1KHBhcm1fZGF0YS0+c3RhcnQpOwogCQkJcExvY2tEYXRhLT5mbF9l
bmQgPSBwTG9ja0RhdGEtPmZsX3N0YXJ0ICsKLQkJCQkJbGU2NF90b19jcHUocGFybV9kYXRhLT5s
ZW5ndGgpIC0gMTsKKwkJCQkobGU2NF90b19jcHUocGFybV9kYXRhLT5sZW5ndGgpID8KKwkJCQkg
bGU2NF90b19jcHUocGFybV9kYXRhLT5sZW5ndGgpIC0gMSA6IDApOwogCQkJcExvY2tEYXRhLT5m
bF9waWQgPSAtbGUzMl90b19jcHUocGFybV9kYXRhLT5waWQpOwogCQl9CiAJfQpkaWZmIC0tZ2l0
IGEvZnMvY2lmcy9maWxlLmMgYi9mcy9jaWZzL2ZpbGUuYwppbmRleCAwYTcyODQwYTg4ZjEuLmUx
Y2ZkNTA5OTZhMCAxMDA2NDQKLS0tIGEvZnMvY2lmcy9maWxlLmMKKysrIGIvZnMvY2lmcy9maWxl
LmMKQEAgLTEzODUsNyArMTM4NSw3IEBAIGNpZnNfcHVzaF9wb3NpeF9sb2NrcyhzdHJ1Y3QgY2lm
c0ZpbGVJbmZvICpjZmlsZSkKIAkJCWNpZnNfZGJnKFZGUywgIkNhbid0IHB1c2ggYWxsIGJybG9j
a3MhXG4iKTsKIAkJCWJyZWFrOwogCQl9Ci0JCWxlbmd0aCA9IDEgKyBmbG9jay0+ZmxfZW5kIC0g
ZmxvY2stPmZsX3N0YXJ0OworCQlsZW5ndGggPSBjaWZzX2Zsb2NrX2xlbihmbG9jayk7CiAJCWlm
IChmbG9jay0+ZmxfdHlwZSA9PSBGX1JETENLIHx8IGZsb2NrLT5mbF90eXBlID09IEZfU0hMQ0sp
CiAJCQl0eXBlID0gQ0lGU19SRExDSzsKIAkJZWxzZQpAQCAtMTUwMSw3ICsxNTAxLDcgQEAgY2lm
c19nZXRsayhzdHJ1Y3QgZmlsZSAqZmlsZSwgc3RydWN0IGZpbGVfbG9jayAqZmxvY2ssIF9fdTMy
IHR5cGUsCiAJICAgYm9vbCB3YWl0X2ZsYWcsIGJvb2wgcG9zaXhfbGNrLCB1bnNpZ25lZCBpbnQg
eGlkKQogewogCWludCByYyA9IDA7Ci0JX191NjQgbGVuZ3RoID0gMSArIGZsb2NrLT5mbF9lbmQg
LSBmbG9jay0+Zmxfc3RhcnQ7CisJX191NjQgbGVuZ3RoID0gY2lmc19mbG9ja19sZW4oZmxvY2sp
OwogCXN0cnVjdCBjaWZzRmlsZUluZm8gKmNmaWxlID0gKHN0cnVjdCBjaWZzRmlsZUluZm8gKilm
aWxlLT5wcml2YXRlX2RhdGE7CiAJc3RydWN0IGNpZnNfdGNvbiAqdGNvbiA9IHRsaW5rX3Rjb24o
Y2ZpbGUtPnRsaW5rKTsKIAlzdHJ1Y3QgVENQX1NlcnZlcl9JbmZvICpzZXJ2ZXIgPSB0Y29uLT5z
ZXMtPnNlcnZlcjsKQEAgLTE1OTksNyArMTU5OSw3IEBAIGNpZnNfdW5sb2NrX3JhbmdlKHN0cnVj
dCBjaWZzRmlsZUluZm8gKmNmaWxlLCBzdHJ1Y3QgZmlsZV9sb2NrICpmbG9jaywKIAlzdHJ1Y3Qg
Y2lmc190Y29uICp0Y29uID0gdGxpbmtfdGNvbihjZmlsZS0+dGxpbmspOwogCXN0cnVjdCBjaWZz
SW5vZGVJbmZvICpjaW5vZGUgPSBDSUZTX0koZF9pbm9kZShjZmlsZS0+ZGVudHJ5KSk7CiAJc3Ry
dWN0IGNpZnNMb2NrSW5mbyAqbGksICp0bXA7Ci0JX191NjQgbGVuZ3RoID0gMSArIGZsb2NrLT5m
bF9lbmQgLSBmbG9jay0+Zmxfc3RhcnQ7CisJX191NjQgbGVuZ3RoID0gY2lmc19mbG9ja19sZW4o
ZmxvY2spOwogCXN0cnVjdCBsaXN0X2hlYWQgdG1wX2xsaXN0OwogCiAJSU5JVF9MSVNUX0hFQUQo
JnRtcF9sbGlzdCk7CkBAIC0xNzAzLDcgKzE3MDMsNyBAQCBjaWZzX3NldGxrKHN0cnVjdCBmaWxl
ICpmaWxlLCBzdHJ1Y3QgZmlsZV9sb2NrICpmbG9jaywgX191MzIgdHlwZSwKIAkgICB1bnNpZ25l
ZCBpbnQgeGlkKQogewogCWludCByYyA9IDA7Ci0JX191NjQgbGVuZ3RoID0gMSArIGZsb2NrLT5m
bF9lbmQgLSBmbG9jay0+Zmxfc3RhcnQ7CisJX191NjQgbGVuZ3RoID0gY2lmc19mbG9ja19sZW4o
ZmxvY2spOwogCXN0cnVjdCBjaWZzRmlsZUluZm8gKmNmaWxlID0gKHN0cnVjdCBjaWZzRmlsZUlu
Zm8gKilmaWxlLT5wcml2YXRlX2RhdGE7CiAJc3RydWN0IGNpZnNfdGNvbiAqdGNvbiA9IHRsaW5r
X3Rjb24oY2ZpbGUtPnRsaW5rKTsKIAlzdHJ1Y3QgVENQX1NlcnZlcl9JbmZvICpzZXJ2ZXIgPSB0
Y29uLT5zZXMtPnNlcnZlcjsKZGlmZiAtLWdpdCBhL2ZzL2NpZnMvc21iMmZpbGUuYyBiL2ZzL2Np
ZnMvc21iMmZpbGUuYwppbmRleCBjOWQ4YTUwMDYyYjguLjc5MzIzNTRiZjkwYyAxMDA2NDQKLS0t
IGEvZnMvY2lmcy9zbWIyZmlsZS5jCisrKyBiL2ZzL2NpZnMvc21iMmZpbGUuYwpAQCAtMTExLDcg
KzExMSw3IEBAIHNtYjJfdW5sb2NrX3JhbmdlKHN0cnVjdCBjaWZzRmlsZUluZm8gKmNmaWxlLCBz
dHJ1Y3QgZmlsZV9sb2NrICpmbG9jaywKIAlzdHJ1Y3QgY2lmc190Y29uICp0Y29uID0gdGxpbmtf
dGNvbihjZmlsZS0+dGxpbmspOwogCXN0cnVjdCBjaWZzSW5vZGVJbmZvICpjaW5vZGUgPSBDSUZT
X0koZF9pbm9kZShjZmlsZS0+ZGVudHJ5KSk7CiAJc3RydWN0IGNpZnNMb2NrSW5mbyAqbGksICp0
bXA7Ci0JX191NjQgbGVuZ3RoID0gMSArIGZsb2NrLT5mbF9lbmQgLSBmbG9jay0+Zmxfc3RhcnQ7
CisJX191NjQgbGVuZ3RoID0gY2lmc19mbG9ja19sZW4oZmxvY2spOwogCXN0cnVjdCBsaXN0X2hl
YWQgdG1wX2xsaXN0OwogCiAJSU5JVF9MSVNUX0hFQUQoJnRtcF9sbGlzdCk7Ci0tIAoyLjMwLjIK
Cg==
--000000000000e4276205c95ec5c7--
