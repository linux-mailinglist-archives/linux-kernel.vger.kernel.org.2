Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2F0324148
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 17:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236050AbhBXPpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 10:45:38 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:17930 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236848AbhBXPcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 10:32:25 -0500
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 11OFVM0R013852
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 00:31:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 11OFVM0R013852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1614180682;
        bh=NIWEdfGUaXEX61U7ewWCrRL/WDTFKxJMVqc8souGXLc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ipGu0GmGri8+0bHRB5q3meEs9UQ+CidKup2plvxzqNw2HXnG8G5inGjoILgYdHZWH
         ls3zbv9Q7yhuo4BXu+B+zCw+sEmUvl6+x8xwVvfBMrU+TZ5RfzHxGRs1XyPVPQeS48
         K7T/zmqXzUoYu+NIeMok3KfKDUVZfVfFN9EAUAXkXbqdzjMFsRiSgQAhDXjYpT8Sla
         pYycS+yzmW8eoWJdqcPasel5dH1FBdKX6BHmemJUqtxFNBWMBTHOei8E3jVXORDU88
         IHRCWffn5COOoFEUMLtJImKOop7sQQ2rfc8xvXi4c62iLS0RionbROCQQDTXPhPDOD
         C9fHnFsnKMbcw==
X-Nifty-SrcIP: [209.85.210.178]
Received: by mail-pf1-f178.google.com with SMTP id b145so1551028pfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 07:31:22 -0800 (PST)
X-Gm-Message-State: AOAM531G+6w4knjIOWh1fceTtn4T37Lixw2iwbMO4B1I2bR8apOIZY/E
        8M3TfDvj2FSePX50QAJjuE2gwD35CHJlhYUOgwU=
X-Google-Smtp-Source: ABdhPJyQO+w2VB769iQczXSzMuIYSt7WbSl25Nrpjc6Vp1QHQQgzVNm8//JOTENtyjqs2w5mSaFZUoqCs3IQGo6IwHU=
X-Received: by 2002:a63:cc4f:: with SMTP id q15mr14513218pgi.47.1614180681653;
 Wed, 24 Feb 2021 07:31:21 -0800 (PST)
MIME-Version: 1.0
References: <YDUibKAt5tpA1Hxs@gunter> <CAHk-=wipCbbXswcFvnrGae01H54dY1+XoaL+9YaiU71zGzko3Q@mail.gmail.com>
 <CAHk-=wh8vHL43v7GWK9MWrWitSmOmrEw1B0AJD9CrhBc4FvpxA@mail.gmail.com>
 <CAHk-=wiuoRKa=F3txoVHvnca+H=7gJyL3SFYwd3549v-sa0+QQ@mail.gmail.com>
 <20210223200130.GA8059@lst.de> <CAHk-=wj27tmZBzFRTZTAEPd6eRBzP5xCkQM+1cuSx7vzv8K4=g@mail.gmail.com>
 <CAHk-=whudLzx0zmn+xLDmC1su6DF4oMQT6uEgjDEq0RsHRsDwA@mail.gmail.com>
 <20210224075220.GA546@lst.de> <YDZfGFhgZl0xBlZl@gunter> <CAK7LNASjyTjqoJG=EtPFTUzYv2v96qYBaaymSirS2HLGoRLpGA@mail.gmail.com>
In-Reply-To: <CAK7LNASjyTjqoJG=EtPFTUzYv2v96qYBaaymSirS2HLGoRLpGA@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 25 Feb 2021 00:30:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNARoLOvNo=EqDeYEW1QBJqxj5t11UyA7DGjweKEoHPjANw@mail.gmail.com>
Message-ID: <CAK7LNARoLOvNo=EqDeYEW1QBJqxj5t11UyA7DGjweKEoHPjANw@mail.gmail.com>
Subject: Re: [GIT PULL] Modules updates for v5.12
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?=EF=BF=BCMiroslav_Benes?= <mbenes@suse.cz>,
        Emil Velikov <emil.l.velikov@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000002288ab05bc16ba0a"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000002288ab05bc16ba0a
Content-Type: text/plain; charset="UTF-8"

On Wed, Feb 24, 2021 at 11:46 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Wed, Feb 24, 2021 at 11:13 PM Jessica Yu <jeyu@kernel.org> wrote:
> >
> > +++ Christoph Hellwig [24/02/21 08:52 +0100]:
> > >On Tue, Feb 23, 2021 at 12:07:39PM -0800, Linus Torvalds wrote:
> > >> On Tue, Feb 23, 2021 at 12:03 PM Linus Torvalds
> > >> <torvalds@linux-foundation.org> wrote:
> > >> >
> > >> > This is unacceptably slow. If that symbol trimming takes 30% of the
> > >> > whole kernel build time, it needs to be fixed or removed.
> > >>
> > >> I think I'm going to mark TRIM_UNUSED_KSYMS as "depends on BROKEN".
> > >> There's no way I can accept that horrible overhead, and the rationale
> > >> for that config option is questionable at best,
> > >
> > >I think it is pretty useful for embedded setups.
> > >
> > >BROKEN seems pretty strong for something that absolutely works as
> > >intendended.  I guess to make you (and possibly others) not grumpy
> > >we just need to ensure it doesn't get pulled in by allmodconfig.
> > >
> > >So maybe just invert the symbol, default the KEEP_UNUSED_SYMBOL, and
> > >add a message to the helptext explaining the slowdown?
> >
> > Hm, something like this maybe? (untested)
>

A patch attached, if Linus is OK to re-enable this.



-- 
Best Regards
Masahiro Yamada

--0000000000002288ab05bc16ba0a
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-Kbuild-re-enable-TRIM_UNUSED_KSYMS-under-the-conditi.patch"
Content-Disposition: attachment; 
	filename="0001-Kbuild-re-enable-TRIM_UNUSED_KSYMS-under-the-conditi.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kljlgcbn0>
X-Attachment-Id: f_kljlgcbn0

RnJvbSAyZWI4ODY0OGFmZjk1NDdkMWMxMGRmODQxZDFhYzYxYWMyMzY5ZGY2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYXNhaGlybyBZYW1hZGEgPG1hc2FoaXJveUBrZXJuZWwub3Jn
PgpEYXRlOiBXZWQsIDI0IEZlYiAyMDIxIDIzOjUyOjU0ICswOTAwClN1YmplY3Q6IFtQQVRDSF0g
S2J1aWxkOiByZS1lbmFibGUgVFJJTV9VTlVTRURfS1NZTVMgdW5kZXIgdGhlIGNvbmRpdGlvbiBv
ZgogIUNPTVBJTEVfVEVTVAoKVGhpcyBvcHRpb24gaXMgdXNlZnVsIGZvciBlbWJlZGRlZCBzeXN0
ZW1zLCBhbmQgYWN1dGFsbHkgdXNlZCBieSB0aGUKTUlQUyBnZW5lcmljX2RlZmNvbmZpZy4gQ29t
bWl0IDE1MThjNjMzZGY3OCAoImtidWlsZDogYWxsb3cgc3ltYm9sCndoaXRlbGlzdGluZyB3aXRo
IFRSSU1fVU5VU0VEX0tTWU1TIikgYWxzbyBzdGF0ZXMgdGhpcyBpcyB1c2VkIGJ5CkFuZHJvaWQg
R2VuZXJpYyBLZXJuZWwgSW1hZ2UuIEkgZ3Vlc3Mgc29tZWJvZHkgd2lsbCBzdGFydCBjb21wbGFp
bmluZy4KCkRpc2FibGUgdGhpcyBvbmx5IGZvciBDT01QSUxFX1RFU1Qgc28gaXQgaXMgaGlkZGVu
IGZvciBhbGx7eWVzLG1vZH1jb25maWcuCgpGaXhlczogNWNmMGZkNTkxZjJlICgiS2J1aWxkOiBk
aXNhYmxlIFRSSU1fVU5VU0VEX0tTWU1TIG9wdGlvbiIpClNpZ25lZC1vZmYtYnk6IE1hc2FoaXJv
IFlhbWFkYSA8bWFzYWhpcm95QGtlcm5lbC5vcmc+Ci0tLQogaW5pdC9LY29uZmlnIHwgMiArLQog
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0
IGEvaW5pdC9LY29uZmlnIGIvaW5pdC9LY29uZmlnCmluZGV4IDJmZjBiNWE1MDczNi4uMTM1ZTIx
MjllMDRiIDEwMDY0NAotLS0gYS9pbml0L0tjb25maWcKKysrIGIvaW5pdC9LY29uZmlnCkBAIC0y
MjczLDcgKzIyNzMsNyBAQCBjb25maWcgTU9EVUxFX0FMTE9XX01JU1NJTkdfTkFNRVNQQUNFX0lN
UE9SVFMKIAogY29uZmlnIFRSSU1fVU5VU0VEX0tTWU1TCiAJYm9vbCAiVHJpbSB1bnVzZWQgZXhw
b3J0ZWQga2VybmVsIHN5bWJvbHMiCi0JZGVwZW5kcyBvbiBCUk9LRU4KKwlkZXBlbmRzIG9uICFD
T01QSUxFX1RFU1QKIAloZWxwCiAJICBUaGUga2VybmVsIGFuZCBzb21lIG1vZHVsZXMgbWFrZSBt
YW55IHN5bWJvbHMgYXZhaWxhYmxlIGZvcgogCSAgb3RoZXIgbW9kdWxlcyB0byB1c2UgdmlhIEVY
UE9SVF9TWU1CT0woKSBhbmQgdmFyaWFudHMuIERlcGVuZGluZwotLSAKMi4yNy4wCgo=
--0000000000002288ab05bc16ba0a--
