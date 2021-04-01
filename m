Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A616352438
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 02:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236234AbhDAX7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 19:59:40 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:56187 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235754AbhDAX7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 19:59:39 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210401235937epoutp044b769f79be0f81e03cd955346576eff7~x4WfvDcFP2690826908epoutp04C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 23:59:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210401235937epoutp044b769f79be0f81e03cd955346576eff7~x4WfvDcFP2690826908epoutp04C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1617321577;
        bh=nAzc2U9VfM9ntLzeXM7WGLSH8q0SUNWP3xrYEnhobT0=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=MnSEHO7m7HkNtlIXbIrp0D24dom5NFV7txHce4LqERyVUfASK6iKf0u5BmnIYAPEK
         Fc8AMUxNLO1pGxSmDstM4cHLIA5gGNspNnXqmhUpANgpr2k2Eoiuc/dfDhoH6+BZgM
         KL/GXEodfoq155bzEfLb9Og4BOsUX0h9qlCy1qxA=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210401235937epcas1p152f06e8dcc7ee11cd5948fd8b8d21e15~x4WfTH7SY0843308433epcas1p1U;
        Thu,  1 Apr 2021 23:59:37 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.161]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4FBKt01rdTz4x9Q0; Thu,  1 Apr
        2021 23:59:36 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        0B.EC.07927.86E56606; Fri,  2 Apr 2021 08:59:36 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210401235935epcas1p3e12f8828448e3e540dd003f431bf82d8~x4Wd833_o0260302603epcas1p3o;
        Thu,  1 Apr 2021 23:59:35 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210401235935epsmtrp13a871470f95364852c1b52da8a22d207~x4Wd8BIPQ2880928809epsmtrp1N;
        Thu,  1 Apr 2021 23:59:35 +0000 (GMT)
X-AuditID: b6c32a35-9a5ff70000011ef7-78-60665e681dd5
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        23.0A.08745.76E56606; Fri,  2 Apr 2021 08:59:35 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20210401235935epsmtip216eb81629e3371d5ada3b894986691d9~x4Wds7t2Z1150511505epsmtip2U;
        Thu,  1 Apr 2021 23:59:35 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Mauro Carvalho Chehab'" <mchehab+huawei@kernel.org>,
        "'Andrew Lunn'" <andrew@lunn.ch>
Cc:     "'Linux Doc Mailing List'" <linux-doc@vger.kernel.org>,
        "'David S. Miller'" <davem@davemloft.net>,
        "'Jonathan Corbet'" <corbet@lwn.net>,
        "'Benedikt Spranger'" <b.spranger@linutronix.de>,
        "'Florian Fainelli'" <f.fainelli@gmail.com>,
        "'Hyunchul Lee'" <hyc.lee@gmail.com>,
        "'Ronnie Sahlberg'" <lsahlber@redhat.com>,
        "'Sergey Senozhatsky'" <sergey.senozhatsky@gmail.com>,
        "'Steve French'" <stfrench@microsoft.com>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <20210401160729.6ee45872@coco.lan>
Subject: RE: [PATCH 30/32] Documentation: net: dsa: update configuration.rst
 reference
Date:   Fri, 2 Apr 2021 08:59:35 +0900
Message-ID: <008901d72753$116b4310$3441c930$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIBSHGzKljrB8rUcbyR222+R+DEpgKrLKsmAklXAjEBEb9MuQGuMiJ0qg5u7rA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCJsWRmVeSWpSXmKPExsWy7bCmnm5GXFqCwZsNnBbn7x5itmi/N4XV
        4smBdkaLOedbWCx+vTvCbnHt/nt2i4VtS1gsLu+aw2ax4Kq+xcPZVxkt1n5+zG5xa+J8Ngce
        jy0rbzJ57Jx1l91j06pONo93586xe+zc8ZnJY3HfZFaP1h1/2T3e77vK5vF5k1wAZ1SOTUZq
        YkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QyUoKZYk5pUCh
        gMTiYiV9O5ui/NKSVIWM/OISW6XUgpScAkODAr3ixNzi0rx0veT8XCtDAwMjU6DKhJyMeWvm
        shf0yVY8fbeBpYGxS6KLkZNDQsBE4su/R8wgtpDADkaJOf+Vuxi5gOxPjBJbf39nhHA+M0rs
        6l/BAtOx82EbO0RiF6PEr6lvWSGcl4wSf3dOZgepYhPQlfj3Zz8biC0iECvxbNZFZpAiZoGT
        zBLTL95nAklwCuhL3Jn3lhHEFhaIkJh17yxYM4uAisTeP5dZQWxeAUuJrfNPM0PYghInZz4B
        O4NZQF5i+9s5zBAnKUj8fLqMFWKZn8TF5e/YIWpEJGZ3toEtlhC4wyFxd/dnqAYXiQkLf7BD
        2MISr45vgbKlJF72g/zGAWRXS3zcD1XewSjx4rsthG0scXP9BlaQEmYBTYn1u/QhwooSO3/P
        ZYRYyyfx7msPK8QUXomONiGIElWJvkuHmSBsaYmu9g/sExiVZiF5bBaSx2YheWAWwrIFjCyr
        GMVSC4pz01OLDQsMkSN7EyM4OWuZ7mCc+PaD3iFGJg7GQ4wSHMxKIrw3tqQmCPGmJFZWpRbl
        xxeV5qQWH2I0BQb1RGYp0eR8YH7IK4k3NDUyNja2MDEzNzM1VhLnTTJ4EC8kkJ5YkpqdmlqQ
        WgTTx8TBKdXA5DRPo/u46zUvk90TPcRe1f+5fvwca4PMBZN1/qmP9xe8UDMzYc2++pvfclf1
        pZ1e9j5nxCY2P5i/IOG2bOmWB+/PTPuuKBa2+33rvxJd4cV7wplljliffMW/yfiztc6LzPo5
        Pn1R3p77nec7xPUbuDHG3dzs0rU8oyNQKtD+odPzb56vV62RF17UuVDHxGdhSCnPnTDLzwu/
        7XRtvSM2z3fLxP0luy1eHuFM3P1a/X5zQdzicgmJO/r/23VmBb2v9VnK7hb1/vr8zt7ldZKP
        nB7cu2//NyH866nqz1qlv/mc7/a9/fVwZ/IerdZd+qsqm51qOV6tujT/+Osp8+2OvdPNr/3/
        1D5AasWqcM21WUosxRmJhlrMRcWJAGzP2IpXBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRmVeSWpSXmKPExsWy7bCSvG56XFqCwaKlGhbn7x5itmi/N4XV
        4smBdkaLOedbWCx+vTvCbnHt/nt2i4VtS1gsLu+aw2ax4Kq+xcPZVxkt1n5+zG5xa+J8Ngce
        jy0rbzJ57Jx1l91j06pONo93586xe+zc8ZnJY3HfZFaP1h1/2T3e77vK5vF5k1wAZxSXTUpq
        TmZZapG+XQJXxrw1c9kL+mQrnr7bwNLA2CXRxcjJISFgIrHzYRt7FyMXh5DADkaJZTuOsEIk
        pCWOnTjD3MXIAWQLSxw+XAxR85xRYvmtC0wgNWwCuhL//uxnA7FFBGIldr1ZyQhSxCxwnlli
        /tozjBAdC5gkHv+8AjaVU0Bf4s68t4wgtrBAmMTnPyvAbBYBFYm9fy6D1fAKWEpsnX+aGcIW
        lDg58wkLyBXMAnoSbRvBypkF5CW2v53DDHGogsTPp8tYIY7wk7i4/B07RI2IxOzONuYJjMKz
        kEyahTBpFpJJs5B0LGBkWcUomVpQnJueW2xYYJSXWq5XnJhbXJqXrpecn7uJERylWlo7GPes
        +qB3iJGJg/EQowQHs5II740tqQlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeS90nYwXEkhPLEnN
        Tk0tSC2CyTJxcEo1MEX7Gbop6+/JftV3a7+1T/yNWy2Sb8Rqjur+fiVrrnD0y4MshvU+BdcP
        T17GvjmnMvxW7K2aZbcWrrp1v/nHF28R/6yNlvfvrtBhcHgwy/sMp+frf1/eTam1FI/zdd3O
        kf1y3XTRdwy3fyqarniQGfGQn6tA3XtT89fDfRHBvdtWyccbyCjK+fCdaf+16Ewk83233+Wn
        n12a93z+2545E1M2nlVWubQpe45exSND3bvxuT+3vkpTn1wm09DR6pAQ8OzWTdG2oJ+XBOb4
        G+msrdjE26v55O6ZZsENKsYlHG15uXdT6qI9tJLY38glxUWGKfNG3J0ld/aw9zOfiqSOaYpP
        +z2lPO9MaEsQ4lavVWIpzkg01GIuKk4EAEfsEnRBAwAA
X-CMS-MailID: 20210401235935epcas1p3e12f8828448e3e540dd003f431bf82d8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210401140737epcas1p1e4966011d112cbe3a5287a41cf3f3931
References: <cover.1617279355.git.mchehab+huawei@kernel.org>
        <a3d52c1380624f34b4a04e9698f67e1e6d8d23f8.1617279356.git.mchehab+huawei@kernel.org>
        <YGW/a8FuCO+Q6hEg@lunn.ch>
        <CGME20210401140737epcas1p1e4966011d112cbe3a5287a41cf3f3931@epcas1p1.samsung.com>
        <20210401160729.6ee45872@coco.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Em Thu, 1 Apr 2021 14:41:15 +0200
> Andrew Lunn <andrew@lunn.ch> escreveu:
> 
> > On Thu, Apr 01, 2021 at 02:17:50PM +0200, Mauro Carvalho Chehab wrote:
> > > The file name: Documentation/configuration.txt should be, instead:
> > > Documentation/networking/dsa/configuration.rst.
> > >
> > > Update its cross-reference accordingly.
> > >
> > > Fixes: 75b8988dfe83 ("cifsd: add server handler for central
> > > processing and tranport layers")
> > > Fixes: 58dd7a8d9d02 ("Documentation: net: dsa: Describe DSA switch
> > > configuration")
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > ---
> > >  Documentation/filesystems/cifs/cifsd.rst | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/filesystems/cifs/cifsd.rst
> > > b/Documentation/filesystems/cifs/cifsd.rst
> > > index 48ae58f2a53c..082a839535e7 100644
> > > --- a/Documentation/filesystems/cifs/cifsd.rst
> > > +++ b/Documentation/filesystems/cifs/cifsd.rst
> > > @@ -114,7 +114,7 @@ How to run
> > >  	# ksmbd.adduser -a <Enter USERNAME for SMB share access>
> > >
> > >  3. Create /etc/ksmbd/smb.conf file, add SMB share in smb.conf file
> > > -	- Refer smb.conf.example and Documentation/configuration.txt
> > > +	- Refer smb.conf.example and
> > > +Documentation/networking/dsa/configuration.rst
> > >  	  in ksmbd-tools
> >
> > Hi Mauro
> >
> > This looks wrong. There is no relationship between SMB and DSA. I
> > suspect you are looking for some other configuration.txt
> 
> Thanks for reviewing it.
> 
> I'll drop the patch from my series.
> 
> After re-reading cifsd.rst, I suspect that it is actually trying to refer to:
> 
> 	https://protect2.fireeye.com/v1/url?k=28e6ada6-777d956f-28e726e9-0cc47a336fae-
> 3420a4e980f3c5ac&q=1&e=68e90996-b225-48b8-88cd-a32b7a3d23b6&u=https%3A%2F%2Fgithub.com%2Fcifsd-
> team%2Fksmbd-tools%2Fblob%2Fmaster%2FDocumentation%2Fconfiguration.txt
> 
> and not to a local file.
> 
> So, IMO, the right thing to do is to apply the enclosed patch instead.
ksmbd is still in review stage. not yet merged into linus tree.
So please don't include it in your series. I will apply the patch below directly.

Thanks for your patch!
> 
> 
> Thanks,
> Mauro
> 
> [PATCH] docs: cifsd: change the reference to configuration.txt
> 
> Changeset 75b8988dfe83 ("cifsd: add server handler for central processing and tranport layers") added
> documentation for cifsd. There, it points to a file
> named:
> 	Documentation/configuration.txt
> 
> This confuses Kernel scripts, as they think that this is a document within the Kernel tree, instead of
> a file from some other place.
> 
> Replace it by an hyperlink to the ksmbd-tools tree, in order to avoid false-positives.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> 
> diff --git a/Documentation/filesystems/cifs/cifsd.rst b/Documentation/filesystems/cifs/cifsd.rst
> index 48ae58f2a53c..a6ab85e68252 100644
> --- a/Documentation/filesystems/cifs/cifsd.rst
> +++ b/Documentation/filesystems/cifs/cifsd.rst
> @@ -114,8 +114,8 @@ How to run
>  	# ksmbd.adduser -a <Enter USERNAME for SMB share access>
> 
>  3. Create /etc/ksmbd/smb.conf file, add SMB share in smb.conf file
> -	- Refer smb.conf.example and Documentation/configuration.txt
> -	  in ksmbd-tools
> +	- Refer smb.conf.example and
> +
> +https://protect2.fireeye.com/v1/url?k=6eb727bd-312c1f74-6eb6acf2-0cc47a
> +336fae-b5ccd9ba5c41390c&q=1&e=68e90996-b225-48b8-88cd-a32b7a3d23b6&u=ht
> +tps%3A%2F%2Fgithub.com%2Fcifsd-team%2Fksmbd-tools%2Fblob%2Fmaster%2FDoc
> +umentation%2Fconfiguration.txt
> 
>  4. Insert ksmbd.ko module
> 
> 


