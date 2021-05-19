Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C23D3389899
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 23:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbhESVbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 17:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbhESVbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 17:31:45 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FCEC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 14:30:25 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id i4so20052417ybe.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 14:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Nx56oQYnaL9/LHbnJm1WdoO+udDpPCRmc528GLgDYWM=;
        b=IGeea9k0wdt0RbRRcg0Z5+TmKtvwXSP8Yn9M5AbYqGfSrV9lPqaD1QYQJ1eSRHgUwC
         pXm4IWpnnSBPTkW0RP0YvDEsT6vFPoMmKPjJhTOQohEihhs0fsbT09mgSoQEatxspbVG
         Gl6AYmVXk3yI5iqukiXqWIvDDMwRF40D/Iee+1pHmAsPVj6dnUWMF0YRKuhyC/3W/PHP
         o/1ib8gp5eGmlwru4T9d3IriW0odr8TiEnFnZ2J90jnjsfTsO8Q+RiwVyGv6azJgp2Qs
         kI+0J6jlts+GQV7Ox1qps4fkf7cPczda+cU3JWU3Kk1BS/JwFa4VG5krNzN+i4HekrMR
         CEgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Nx56oQYnaL9/LHbnJm1WdoO+udDpPCRmc528GLgDYWM=;
        b=nE1EyqA5cJ9sXPVN7C7WoVqjmYa86KOgZFTN60DREQP4TquZKFBOWuhpjtkSjLifHi
         xl2QWuYNBHbNlUDGGJ6Ze1mbAgJocMBjCuol9A2YtpFKvO7yKVECmlRl7eUIi5wGUV9u
         o6SQkgQULYUNxO7s6gNZFM81ako/a4HwoaS9/K5giAVD3ZJExNf2kh2YJkKHUqjaqVBX
         9GLI3yB5EIOiniyBRVEpsjwfn8m/y/ozFci3WV4Y/9GBMxsuhe++2tdYF353/78E9fUm
         EMYBGlMbF6/XV0jgBja1rt8IEs7/YI8dqODLBkU6nbITxNFbFJQdjaqLrVhGptiYKtqT
         oIOg==
X-Gm-Message-State: AOAM531iH9QJpucPBGLMhg9Zrvgr6/el3vUTcH2Vlh0ZGvbcvnJoJ287
        36w5l1YrzRxz5lDDdCGe1UmStWcsfJmu4BMdvBEP1Q==
X-Google-Smtp-Source: ABdhPJwBhGiymGeMFDqFT4AOasZhYB7btPQwTGglNQkdBEaLHoCSZoOkGxExJeoqdBK+hIHNt9WB/YyDKycCzc3Mca8=
X-Received: by 2002:a25:3f47:: with SMTP id m68mr2273157yba.228.1621459824463;
 Wed, 19 May 2021 14:30:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210516170539.2yxe43qwezonuo3r@core> <CAGETcx93RxfsXG51zeaUK+UyKdEDgivqkmS85mcMPp0H42X5ZQ@mail.gmail.com>
 <20210517082957.sddwy2dv5esbzmo4@core>
In-Reply-To: <20210517082957.sddwy2dv5esbzmo4@core>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 19 May 2021 14:29:48 -0700
Message-ID: <CAGETcx-UgSCn9V5W0EgOBbdNGxsXR+ZGPNLL1MMJfHN35WCLRw@mail.gmail.com>
Subject: Re: fw_devlink=on and sunxi HDMI
To:     =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megous@megous.com>,
        Saravana Kannan <saravanak@google.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@lists.linux.dev, mripard@kernel.org, wens@csie.org,
        jernej.skrabec@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, andre.przywara@arm.com
Content-Type: multipart/mixed; boundary="000000000000db718905c2b5887f"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000db718905c2b5887f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 17, 2021 at 1:29 AM Ond=C5=99ej Jirman <megous@megous.com> wrot=
e:
>
> On Sun, May 16, 2021 at 11:32:47PM -0700, Saravana Kannan wrote:
> > On Sun, May 16, 2021 at 10:05 AM Ond=C5=99ej Jirman <megi@xff.cz> wrote=
:
> > >
> > > Hello,
> > >
> > > Linux 5.13-rc1 again has fw_devlink=3Don enabled by default. I've fou=
nd that this
> > > breaks probing display pipeline and HDMI output on sunxi boards, beca=
use of
> > > fwnode_link between hdmi and hdmi-phy nodes.
> > >
> > > HDMI device probe keeps being avoided with these repeated messages in=
 dmesg:
> > >
> > >   platform 1ee0000.hdmi: probe deferral - supplier 1ef0000.hdmi-phy n=
ot ready
> > >
> > > Both nodes have their own compatible, but are implemented by a single
> > > struct device.
> > >
> > > This looks like a kind of situation that's expected to break fw_devli=
nk
> > > expectations by my reading of the the e-mails about trying the fw_dev=
link=3Don
> > > during 5.12 cycle.
> > >
> > > Is this supposed to be solved by implementing the PHY node as it's ow=
n
> > > device or by breaking the fwnode_link between the hdmi phy and hdmi n=
odes?
> > > Seems like second solution would be quicker now that rc1 is out.
> >
> > Seems like sun8i_hdmi_phy_probe() already does 95% of the work to make
> > the PHY a separate driver. Why not just finish it up by really making
> > it a separate driver? I'd really prefer doing that because this seems
> > unnecessarily messed up. The phy will have a struct device created for
> > it already. You are just not probing it.
>
> Currently it's all just a glue code for dw-hdmi, which is not using a phy
> framework and handles both the controller and phy parts. dw-hdmi needs pa=
ssing
> platform data around
> (https://elixir.bootlin.com/linux/latest/source/include/drm/bridge/dw_hdm=
i.h#L115)
> to get a specific set of phy glue callbacks hooked into platform data of =
dw-hdmi
> prior to calling dw_hdmi_probe.
>
> Looking at other users of dw_hdmi_probe this is the only one that has thi=
s
> unfortunate issue due to using phys binding internally as a part of one d=
evice.
>
> Just making it a platform driver will also change the probe order of phy =
and the
> controller, which I've heard from Jernej needs to have the current order =
of
> (controller and then phy) perserved, for some reason, and will make thing=
s
> still a bit more convoluted.
>
> So this looks like needs quite a bit of thought.

Nothing in sun8i_hdmi_phy_probe() depends on anything from
sun8i_dw_hdmi.c other than getting a struct device pointer to use with
dev_err and some devm_* APIs. So it seems pretty straightforward to
fix this so that you don't have one struct device trying to represent
two distinct hardware blocks. What am I missing?

Anyway, I took a swing at fixing this while preserving the ordering of
the important bits. The changes are fairly trivial/straightforward and
not meant to be final code, but can you test this out please?

-Saravana

--000000000000db718905c2b5887f
Content-Type: application/x-patch; name="0001-Try-fixing-HDMI-probe.patch"
Content-Disposition: attachment; filename="0001-Try-fixing-HDMI-probe.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kovytt0n0>
X-Attachment-Id: f_kovytt0n0

RnJvbSBmNzgzOTQxY2RmNGJkOTJjM2RhN2EwYzg0NDFlNmJkMzc5MDg3Y2M0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTYXJhdmFuYSBLYW5uYW4gPHNhcmF2YW5ha0Bnb29nbGUuY29t
PgpEYXRlOiBXZWQsIDE5IE1heSAyMDIxIDE0OjAzOjI5IC0wNzAwClN1YmplY3Q6IFtQQVRDSF0g
VHJ5IGZpeGluZyBIRE1JIHByb2JlLgoKU2lnbmVkLW9mZi1ieTogU2FyYXZhbmEgS2FubmFuIDxz
YXJhdmFuYWtAZ29vZ2xlLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vc3VuNGkvc3VuOGlfZHdf
aGRtaS5jICB8ICA0ICstLQogZHJpdmVycy9ncHUvZHJtL3N1bjRpL3N1bjhpX2R3X2hkbWkuaCAg
fCAgMyArLQogZHJpdmVycy9ncHUvZHJtL3N1bjRpL3N1bjhpX2hkbWlfcGh5LmMgfCA0MSArKysr
KysrKysrKysrKysrKysrKysrLS0tLQogMyBmaWxlcyBjaGFuZ2VkLCAzOCBpbnNlcnRpb25zKCsp
LCAxMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vc3VuNGkvc3Vu
OGlfZHdfaGRtaS5jIGIvZHJpdmVycy9ncHUvZHJtL3N1bjRpL3N1bjhpX2R3X2hkbWkuYwppbmRl
eCBiYmRmZDVlMjZlYzguLmU4OTJhMDVlNjllOSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJt
L3N1bjRpL3N1bjhpX2R3X2hkbWkuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vc3VuNGkvc3VuOGlf
ZHdfaGRtaS5jCkBAIC0yMDksNyArMjA5LDcgQEAgc3RhdGljIGludCBzdW44aV9kd19oZG1pX2Jp
bmQoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlICptYXN0ZXIsCiAJCWdvdG8gZXJy
X2Rpc2FibGVfY2xrX3RtZHM7CiAJfQogCi0JcmV0ID0gc3VuOGlfaGRtaV9waHlfcHJvYmUoaGRt
aSwgcGh5X25vZGUpOworCXJldCA9IHN1bjhpX2hkbWlfcGh5X2dldChoZG1pLCBwaHlfbm9kZSk7
CiAJb2Zfbm9kZV9wdXQocGh5X25vZGUpOwogCWlmIChyZXQpIHsKIAkJZGV2X2VycihkZXYsICJD
b3VsZG4ndCBnZXQgdGhlIEhETUkgUEhZXG4iKTsKQEAgLTI0Miw3ICsyNDIsNiBAQCBzdGF0aWMg
aW50IHN1bjhpX2R3X2hkbWlfYmluZChzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZpY2Ug
Km1hc3RlciwKIAogY2xlYW51cF9lbmNvZGVyOgogCWRybV9lbmNvZGVyX2NsZWFudXAoZW5jb2Rl
cik7Ci0Jc3VuOGlfaGRtaV9waHlfcmVtb3ZlKGhkbWkpOwogZXJyX2Rpc2FibGVfY2xrX3RtZHM6
CiAJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGhkbWktPmNsa190bWRzKTsKIGVycl9hc3NlcnRfY3Ry
bF9yZXNldDoKQEAgLTI2Myw3ICsyNjIsNiBAQCBzdGF0aWMgdm9pZCBzdW44aV9kd19oZG1pX3Vu
YmluZChzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZpY2UgKm1hc3RlciwKIAlzdHJ1Y3Qg
c3VuOGlfZHdfaGRtaSAqaGRtaSA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOwogCiAJZHdfaGRtaV91
bmJpbmQoaGRtaS0+aGRtaSk7Ci0Jc3VuOGlfaGRtaV9waHlfcmVtb3ZlKGhkbWkpOwogCWNsa19k
aXNhYmxlX3VucHJlcGFyZShoZG1pLT5jbGtfdG1kcyk7CiAJcmVzZXRfY29udHJvbF9hc3NlcnQo
aGRtaS0+cnN0X2N0cmwpOwogCWdwaW9kX3NldF92YWx1ZShoZG1pLT5kZGNfZW4sIDApOwpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3N1bjRpL3N1bjhpX2R3X2hkbWkuaCBiL2RyaXZlcnMv
Z3B1L2RybS9zdW40aS9zdW44aV9kd19oZG1pLmgKaW5kZXggZDRiNTVhZjA1OTJmLi44YThhZGVm
NDhiZTAgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9zdW40aS9zdW44aV9kd19oZG1pLmgK
KysrIGIvZHJpdmVycy9ncHUvZHJtL3N1bjRpL3N1bjhpX2R3X2hkbWkuaApAQCAtMjAxLDggKzIw
MSw3IEBAIGVuY29kZXJfdG9fc3VuOGlfZHdfaGRtaShzdHJ1Y3QgZHJtX2VuY29kZXIgKmVuY29k
ZXIpCiAJcmV0dXJuIGNvbnRhaW5lcl9vZihlbmNvZGVyLCBzdHJ1Y3Qgc3VuOGlfZHdfaGRtaSwg
ZW5jb2Rlcik7CiB9CiAKLWludCBzdW44aV9oZG1pX3BoeV9wcm9iZShzdHJ1Y3Qgc3VuOGlfZHdf
aGRtaSAqaGRtaSwgc3RydWN0IGRldmljZV9ub2RlICpub2RlKTsKLXZvaWQgc3VuOGlfaGRtaV9w
aHlfcmVtb3ZlKHN0cnVjdCBzdW44aV9kd19oZG1pICpoZG1pKTsKK2ludCBzdW44aV9oZG1pX3Bo
eV9nZXQoc3RydWN0IHN1bjhpX2R3X2hkbWkgKmhkbWksIHN0cnVjdCBkZXZpY2Vfbm9kZSAqbm9k
ZSk7CiAKIHZvaWQgc3VuOGlfaGRtaV9waHlfaW5pdChzdHJ1Y3Qgc3VuOGlfaGRtaV9waHkgKnBo
eSk7CiB2b2lkIHN1bjhpX2hkbWlfcGh5X3NldF9vcHMoc3RydWN0IHN1bjhpX2hkbWlfcGh5ICpw
aHksCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vc3VuNGkvc3VuOGlfaGRtaV9waHkuYyBi
L2RyaXZlcnMvZ3B1L2RybS9zdW40aS9zdW44aV9oZG1pX3BoeS5jCmluZGV4IDk5OTRlZGY2NzUw
OS4uYzQ0ZWQyMmQ4YWVmIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vc3VuNGkvc3VuOGlf
aGRtaV9waHkuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vc3VuNGkvc3VuOGlfaGRtaV9waHkuYwpA
QCAtNTk3LDEwICs1OTcsMzAgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgc3Vu
OGlfaGRtaV9waHlfb2ZfdGFibGVbXSA9IHsKIAl7IC8qIHNlbnRpbmVsICovIH0KIH07CiAKLWlu
dCBzdW44aV9oZG1pX3BoeV9wcm9iZShzdHJ1Y3Qgc3VuOGlfZHdfaGRtaSAqaGRtaSwgc3RydWN0
IGRldmljZV9ub2RlICpub2RlKQoraW50IHN1bjhpX2hkbWlfcGh5X2dldChzdHJ1Y3Qgc3VuOGlf
ZHdfaGRtaSAqaGRtaSwgc3RydWN0IGRldmljZV9ub2RlICpub2RlKQoreworCXN0cnVjdCBwbGF0
Zm9ybV9kZXZpY2UgKnBkZXYgPSBvZl9maW5kX2RldmljZV9ieV9ub2RlKG5vZGUpOworCXN0cnVj
dCBzdW44aV9oZG1pX3BoeSAqcGh5OworCisJaWYgKCFwZGV2KQorCQlyZXR1cm4gLUVQUk9CRV9E
RUZFUjsKKworCXBoeSA9IHBsYXRmb3JtX2dldF9kcnZkYXRhKHBkZXYpOworCWlmICghcGh5KQor
CQlyZXR1cm4gLUVQUk9CRV9ERUZFUjsKKworCWhkbWktPnBoeSA9IHBoeTsKKworCXB1dF9kZXZp
Y2UoJnBkZXYtPmRldik7CisKKwlyZXR1cm4gMDsKK30KKworaW50IHN1bjhpX2hkbWlfcGh5X3By
b2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCiB7CiAJY29uc3Qgc3RydWN0IG9mX2Rl
dmljZV9pZCAqbWF0Y2g7Ci0Jc3RydWN0IGRldmljZSAqZGV2ID0gaGRtaS0+ZGV2OworCXN0cnVj
dCBkZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7CisJc3RydWN0IGRldmljZV9ub2RlICpub2RlID0g
ZGV2LT5vZl9ub2RlOwogCXN0cnVjdCBzdW44aV9oZG1pX3BoeSAqcGh5OwogCXN0cnVjdCByZXNv
dXJjZSByZXM7CiAJdm9pZCBfX2lvbWVtICpyZWdzOwpAQCAtNzA0LDcgKzcyNCw3IEBAIGludCBz
dW44aV9oZG1pX3BoeV9wcm9iZShzdHJ1Y3Qgc3VuOGlfZHdfaGRtaSAqaGRtaSwgc3RydWN0IGRl
dmljZV9ub2RlICpub2RlKQogCQljbGtfcHJlcGFyZV9lbmFibGUocGh5LT5jbGtfcGh5KTsKIAl9
CiAKLQloZG1pLT5waHkgPSBwaHk7CisJcGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgcGh5KTsK
IAogCXJldHVybiAwOwogCkBAIC03MjgsOSArNzQ4LDkgQEAgaW50IHN1bjhpX2hkbWlfcGh5X3By
b2JlKHN0cnVjdCBzdW44aV9kd19oZG1pICpoZG1pLCBzdHJ1Y3QgZGV2aWNlX25vZGUgKm5vZGUp
CiAJcmV0dXJuIHJldDsKIH0KIAotdm9pZCBzdW44aV9oZG1pX3BoeV9yZW1vdmUoc3RydWN0IHN1
bjhpX2R3X2hkbWkgKmhkbWkpCit2b2lkIHN1bjhpX2hkbWlfcGh5X3JlbW92ZShzdHJ1Y3QgcGxh
dGZvcm1fZGV2aWNlICpwZGV2KQogewotCXN0cnVjdCBzdW44aV9oZG1pX3BoeSAqcGh5ID0gaGRt
aS0+cGh5OworCXN0cnVjdCBzdW44aV9oZG1pX3BoeSAqcGh5ID0gcGxhdGZvcm1fZ2V0X2RydmRh
dGEocGRldik7CiAKIAljbGtfZGlzYWJsZV91bnByZXBhcmUocGh5LT5jbGtfbW9kKTsKIAljbGtf
ZGlzYWJsZV91bnByZXBhcmUocGh5LT5jbGtfYnVzKTsKQEAgLTc0NCw0ICs3NjQsMTUgQEAgdm9p
ZCBzdW44aV9oZG1pX3BoeV9yZW1vdmUoc3RydWN0IHN1bjhpX2R3X2hkbWkgKmhkbWkpCiAJY2xr
X3B1dChwaHktPmNsa19wbGwxKTsKIAljbGtfcHV0KHBoeS0+Y2xrX21vZCk7CiAJY2xrX3B1dChw
aHktPmNsa19idXMpOworCXJldHVybiAwOwogfQorCitzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2Ry
aXZlciBzdW44aV9oZG1pX3BoeV9kcml2ZXIgPSB7CisJLnByb2JlICA9IHN1bjhpX2hkbWlfcGh5
X3Byb2JlLAorCS5yZW1vdmUgPSBzdW44aV9oZG1pX3BoeV9yZW1vdmUsCisJLmRyaXZlciA9IHsK
KwkJLm5hbWUgPSAic3VuOGktaGRtaS1waHkiLAorCQkub2ZfbWF0Y2hfdGFibGUgPSBzdW44aV9o
ZG1pX3BoeV9vZl90YWJsZSwKKwl9LAorfTsKK21vZHVsZV9wbGF0Zm9ybV9kcml2ZXIoc3VuOGlf
aGRtaV9waHlfZHJpdmVyKTsKLS0gCjIuMzEuMS44MTguZzQ2YWFkNmNiOWUtZ29vZwoK
--000000000000db718905c2b5887f--
