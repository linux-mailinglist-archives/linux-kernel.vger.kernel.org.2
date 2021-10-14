Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4498342E34F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 23:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbhJNVhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 17:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbhJNVhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 17:37:12 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A971C061570;
        Thu, 14 Oct 2021 14:35:07 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id w14so29528193edv.11;
        Thu, 14 Oct 2021 14:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0G1ek7ZBrsfvEMx8aW2NfxaGqkDzfGWBoT86b86MplI=;
        b=FToFnMkKD4MKFnKjPCwfsoy2mnqVDS3sRZgXtzPItTWybAxQwe2cMJhIghTLzkEmj9
         9idEwv9rNR3SMPkWxaOc3HLd0xKUqO98kvf+SzXgUfdZbXgLMMSkyRHGmNH2GCRyuxmS
         LgRQvte/s4lmjMMlRtuLYHAsmPIfdnbDIl6rm17rJ+bH57P+tI879CPN+3tI4bWA1yLH
         XMqpaFQA6yzjwLMcUANR2rHQOZF0WjDp0WHc39wvkRC/JC/oijVYp/NBJH6VNRvXe9WJ
         oTnJleLPpHS4xZVGS01WNvVAIlVh+VPh1oIIghiStnGEqUrPAB5OyzSQTUiwnZwwbtM6
         d3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0G1ek7ZBrsfvEMx8aW2NfxaGqkDzfGWBoT86b86MplI=;
        b=CGLapjVzhcIn+/3kiK9oF6NCpYi7Bnch4YTDAyEM3Rd896sDT6+GW+RjGAVvXUTzh3
         lSJYniFiwJU8eY0UMI7AlBbNwVB5VVU9mhCPsEeljtZCmxP9lvmOMJL92fTX2gglgers
         wDRRAwE2ZBKjWw40ae1rtCmwuqE2wMShZFNo5aXkW1UQ1U+CvInY/PK30M/A/3zScd/l
         0HcjK69lK+/7F7UnCseAfnyXRWTsJj0DxV1QnXnJIW7/S9VUeOornDTm/gc7zvhECEBl
         pQ0tlAZ83Slr+g9y0MBgREU6PyJnALM7So9ORlTmC620gY3TmEk+b19qniKT4NX9L7Ly
         YwGQ==
X-Gm-Message-State: AOAM533KB7hSP/wyBoRoeWYA1HIWoCly2lRm8Qk4vituICfc6lzqExQ2
        3cWBCFhsTQL19IpZ27+V8Kh9hC8x0+t9J8yvRmk=
X-Google-Smtp-Source: ABdhPJzORGdgNpjOsgsBrBuZdbuHJElu7UP9TCOUZhE7TsVvIol5NVSNsCn0gWoGeRkjNYNGJzzImLTf5YHoihr0h6E=
X-Received: by 2002:a17:906:a986:: with SMTP id jr6mr1858072ejb.520.1634247305465;
 Thu, 14 Oct 2021 14:35:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210702225145.2643303-1-martin.blumenstingl@googlemail.com>
 <20210702225145.2643303-2-martin.blumenstingl@googlemail.com>
 <4eb964ac-4fff-b59d-2660-2f84d8af5901@gmail.com> <CAFBinCAVtd8gmcuvGU79-85CqhSU8a3mBCa_jweeZBd59u+amQ@mail.gmail.com>
In-Reply-To: <CAFBinCAVtd8gmcuvGU79-85CqhSU8a3mBCa_jweeZBd59u+amQ@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 14 Oct 2021 23:34:54 +0200
Message-ID: <CAFBinCAT-FxcHpt=NCt4g-OfzEUhvxh8TNRcY2hb5kdxna0Uyw@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] clk: divider: Implement and wire up
 .determine_rate by default
To:     Alex Bee <knaerzche@gmail.com>
Cc:     linux-clk@vger.kernel.org, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Content-Type: multipart/mixed; boundary="0000000000001e2ebd05ce56dabf"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000001e2ebd05ce56dabf
Content-Type: text/plain; charset="UTF-8"

On Thu, Oct 14, 2021 at 2:11 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
[...]
> > Reverting this commit makes it work again: Unless there is a quick and
> > obvious fix for that, I guess this should be done for 5.15 - even if the
> > real issue is somewhere else.
> Reverting this patch is fine from the Amlogic SoC point of view.
> The main goal was to clean up / improve the CCF code.
> Nothing (that I am aware of) is going to break in Amlogic land if we
> revert this.
Unfortunately only now I realized that reverting this patch would also
require reverting the other five patches in this series (since they
depend on this one).
For this reason I propose changing the order of the checks in
clk-composite.c - see the attached patch (which I can send as a proper
one once agreed that this is the way to go forward)

Off-list Alex also suggested that I should use rate_ops.determine_rate
if available.
While I agree that this makes sense in general my plan is to do this
in a follow-up patch.
Changing the order of the conditions is needed anyways and it *should*
fix the issue reported here (but I have no way of testing that
unfortunately).

Alex, it would be great if you (or someone with Rockchip boards) could
test the attached patch and let me know if it fixes the reported
problem.


Best regards,
Martin

--0000000000001e2ebd05ce56dabf
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-clk-composite-Also-consider-.determine_rate-for-rate.patch"
Content-Disposition: attachment; 
	filename="0001-clk-composite-Also-consider-.determine_rate-for-rate.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kurgk0ha0>
X-Attachment-Id: f_kurgk0ha0

RnJvbSBiMzRjZGUyZDllMWQ4ZWNiMmM3NzVjYmNhZDUxOTkzM2Y2M2I4NGY5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYXJ0aW4gQmx1bWVuc3RpbmdsIDxtYXJ0aW4uYmx1bWVuc3Rp
bmdsQGdvb2dsZW1haWwuY29tPgpEYXRlOiBUaHUsIDE0IE9jdCAyMDIxIDE0OjE2OjIyICswMjAw
ClN1YmplY3Q6IFtQQVRDSF0gY2xrOiBjb21wb3NpdGU6IEFsc28gY29uc2lkZXIgLmRldGVybWlu
ZV9yYXRlIGZvciByYXRlICsgbXV4CiBjb21wb3NpdGVzCgpDb21taXQgNjlhMDBmYjNkNjk3MDYg
KCJjbGs6IGRpdmlkZXI6IEltcGxlbWVudCBhbmQgd2lyZSB1cAouZGV0ZXJtaW5lX3JhdGUgYnkg
ZGVmYXVsdCIpIHN3aXRjaGVzIGNsa19kaXZpZGVyX29wcyB0byBpbXBsZW1lbnQKLmRldGVybWlu
ZV9yYXRlIGJ5IGRlZmF1bHQuIFRoaXMgYnJlYWtzIGNvbXBvc2l0ZSBjbG9ja3Mgd2l0aCBtdWx0
aXBsZQpwYXJlbnRzIGJlY2F1c2UgY2xrLWNvbXBvc2l0ZS5jIGRvZXMgbm90IHVzZSB0aGUgc3Bl
Y2lhbCBoYW5kbGluZyBmb3IKbXV4ICsgZGl2aWRlciBjb21iaW5hdGlvbnMgYW55bW9yZSAodGhh
dCB3YXMgcmVzdHJpY3RlZCB0byByYXRlIGNsb2Nrcwp3aGljaCBvbmx5IGltcGxlbWVudCAucm91
bmRfcmF0ZSwgYnV0IG5vdCAuZGV0ZXJtaW5lX3JhdGUpLgoKQWxleCByZXBvcnRzOgogIFRoaXMg
YnJlYWtzIGxvdCBvZiBjbG9ja3MgZm9yIFJvY2tjaGlwIHdoaWNoIGludGVuc2l2ZWx5IHVzZXMK
ICBjb21wb3NpdGVzLCAgaS5lLiB0aG9zZSBjbG9ja3Mgd2lsbCBhbHdheXMgc3RheSBhdCB0aGUg
aW5pdGlhbCBwYXJlbnQsCiAgd2hpY2ggaW4gc29tZSBjYXNlcyAgaXMgdGhlIFhUQUwgY2xvY2sg
YW5kIEkgc3Ryb25nbHkgZ3Vlc3MgaXQgaXMgdGhlCiAgc2FtZSBmb3Igb3RoZXIgcGxhdGZvcm1z
LCAgd2hpY2ggdXNlIGNvbXBvc2l0ZSBjbG9ja3MgaGF2aW5nIG1vcmUgdGhhbgogIG9uZSBwYXJl
bnQgKGUuZy4gbWVkaWF0ZWssIHRpIC4uLikKCiAgRXhhbXBsZSAoUkszMzk5KQogIGNsa19zZGlv
IGlzIHNldCAoaW5pdGlhbGl6ZWQpIHdpdGggWFRBTCAoMjQgTUh6KSBhcyBwYXJlbnQgaW4gdS1i
b290LgogIEl0IHdpbGwgYWx3YXlzIHN0YXkgYXQgdGhpcyBwYXJlbnQsIGV2ZW4gaWYgdGhlIG1t
YyBkcml2ZXIgc2V0cyBhIHJhdGUKICBvZiAgMjAwIE1IeiAoZmFpbHMsIGFzIHRoZSBuYXR1cmUg
b2YgdGhpbmdzKSwgd2hpY2ggc2hvdWxkIHN3aXRjaCBpdAogIHRvICAgYW55IG9mIGl0cyBwb3Nz
aWJsZSBwYXJlbnQgUExMcyBkZWZpbmVkIGluCiAgbXV4X3BsbF9zcmNfY3BsbF9ncGxsX25wbGxf
cHBsbF91cGxsXzI0bV9wIChzZWUgY2xrLXJrMzM5OS5jKSAgLSB3aGljaAogIG5ldmVyIGhhcHBl
bnMuCgpSZXN0b3JlIHRoZSBvcmlnaW5hbCBiZWhhdmlvciBieSBjaGFuZ2luZyB0aGUgcHJpb3Jp
dHkgb2YgdGhlIGNvbmRpdGlvbnMKaW5zaWRlIGNsay1jb21wb3NpdGUuYy4gTm93IHRoZSBzcGVj
aWFsIHJhdGUgKyBtdXggY2FzZSAod2l0aCByYXRlX29wcwpoYXZpbmcgYSAucm91bmRfcmF0ZSAt
IHdoaWNoIGlzIHN0aWxsIHRoZSBjYXNlIGZvciB0aGUgZGVmYXVsdApjbGtfZGl2aWRlcl9vcHMp
IGlzIHByZWZlcnJlZCBvdmVyIHJhdGVfb3BzIHdoaWNoIGhhdmUgLmRldGVybWluZV9yYXRlCmRl
ZmluZWQgKGFuZCBub3QgZnVydGhlciBjb25zaWRlcmluZyB0aGUgbXV4KS4KCkZpeGVzOiA2OWEw
MGZiM2Q2OTcwNiAoImNsazogZGl2aWRlcjogSW1wbGVtZW50IGFuZCB3aXJlIHVwIC5kZXRlcm1p
bmVfcmF0ZSBieSBkZWZhdWx0IikKUmVwb3J0ZWQtYnk6IEFsZXggQmVlIDxrbmFlcnpjaGVAZ21h
aWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBNYXJ0aW4gQmx1bWVuc3RpbmdsIDxtYXJ0aW4uYmx1bWVu
c3RpbmdsQGdvb2dsZW1haWwuY29tPgotLS0KIGRyaXZlcnMvY2xrL2Nsay1jb21wb3NpdGUuYyB8
IDEwICsrKysrLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDUgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvY2xrLWNvbXBvc2l0ZS5jIGIvZHJpdmVy
cy9jbGsvY2xrLWNvbXBvc2l0ZS5jCmluZGV4IDA1MDYwNDZhNWY0Yi4uNTEwYTk5NjU2MzNiIDEw
MDY0NAotLS0gYS9kcml2ZXJzL2Nsay9jbGstY29tcG9zaXRlLmMKKysrIGIvZHJpdmVycy9jbGsv
Y2xrLWNvbXBvc2l0ZS5jCkBAIC01OCwxMSArNTgsOCBAQCBzdGF0aWMgaW50IGNsa19jb21wb3Np
dGVfZGV0ZXJtaW5lX3JhdGUoc3RydWN0IGNsa19odyAqaHcsCiAJbG9uZyByYXRlOwogCWludCBp
OwogCi0JaWYgKHJhdGVfaHcgJiYgcmF0ZV9vcHMgJiYgcmF0ZV9vcHMtPmRldGVybWluZV9yYXRl
KSB7Ci0JCV9fY2xrX2h3X3NldF9jbGsocmF0ZV9odywgaHcpOwotCQlyZXR1cm4gcmF0ZV9vcHMt
PmRldGVybWluZV9yYXRlKHJhdGVfaHcsIHJlcSk7Ci0JfSBlbHNlIGlmIChyYXRlX2h3ICYmIHJh
dGVfb3BzICYmIHJhdGVfb3BzLT5yb3VuZF9yYXRlICYmCi0JCSAgIG11eF9odyAmJiBtdXhfb3Bz
ICYmIG11eF9vcHMtPnNldF9wYXJlbnQpIHsKKwlpZiAocmF0ZV9odyAmJiByYXRlX29wcyAmJiBy
YXRlX29wcy0+cm91bmRfcmF0ZSAmJgorCSAgICBtdXhfaHcgJiYgbXV4X29wcyAmJiBtdXhfb3Bz
LT5zZXRfcGFyZW50KSB7CiAJCXJlcS0+YmVzdF9wYXJlbnRfaHcgPSBOVUxMOwogCiAJCWlmIChj
bGtfaHdfZ2V0X2ZsYWdzKGh3KSAmIENMS19TRVRfUkFURV9OT19SRVBBUkVOVCkgewpAQCAtMTA3
LDYgKzEwNCw5IEBAIHN0YXRpYyBpbnQgY2xrX2NvbXBvc2l0ZV9kZXRlcm1pbmVfcmF0ZShzdHJ1
Y3QgY2xrX2h3ICpodywKIAogCQlyZXEtPnJhdGUgPSBiZXN0X3JhdGU7CiAJCXJldHVybiAwOwor
CX0gZWxzZSBpZiAocmF0ZV9odyAmJiByYXRlX29wcyAmJiByYXRlX29wcy0+ZGV0ZXJtaW5lX3Jh
dGUpIHsKKwkJX19jbGtfaHdfc2V0X2NsayhyYXRlX2h3LCBodyk7CisJCXJldHVybiByYXRlX29w
cy0+ZGV0ZXJtaW5lX3JhdGUocmF0ZV9odywgcmVxKTsKIAl9IGVsc2UgaWYgKG11eF9odyAmJiBt
dXhfb3BzICYmIG11eF9vcHMtPmRldGVybWluZV9yYXRlKSB7CiAJCV9fY2xrX2h3X3NldF9jbGso
bXV4X2h3LCBodyk7CiAJCXJldHVybiBtdXhfb3BzLT5kZXRlcm1pbmVfcmF0ZShtdXhfaHcsIHJl
cSk7Ci0tIAoyLjMzLjAKCg==
--0000000000001e2ebd05ce56dabf--
