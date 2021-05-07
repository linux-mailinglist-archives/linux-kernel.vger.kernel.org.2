Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE6143762B7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 11:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235817AbhEGJRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 05:17:18 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3035 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbhEGJP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 05:15:59 -0400
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Fc4Mx2qbPz6rnD2;
        Fri,  7 May 2021 17:07:25 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 7 May 2021 11:13:16 +0200
Received: from localhost (10.52.124.175) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 7 May 2021
 10:13:16 +0100
Date:   Fri, 7 May 2021 10:11:32 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC:     Carlos Bilbao <bilbao@vt.edu>, <corbet@lwn.net>,
        <hdegoede@redhat.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fixed typos in all directories of Documentation/ABI/
Message-ID: <20210507101132.00003aeb@Huawei.com>
In-Reply-To: <20210506084237.1f8363ba@coco.lan>
References: <2219636.ElGaqSPkdT@iron-maiden>
        <20210506084237.1f8363ba@coco.lan>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.124.175]
X-ClientProxiedBy: lhreml733-chm.china.huawei.com (10.201.108.84) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 May 2021 08:42:37 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Wed, 05 May 2021 16:43:59 -0400
> Carlos Bilbao <bilbao@vt.edu> escreveu:
> 
> > Fix the following typos in the Documentation/ABI/ directory:
> > 
> > - In file obsolete/sysfs-cpuidle, change "obselete" for "obsolete".
> > 
> > - In file removed/sysfs-kernel-uids, change "propotional" for "proportional".
> > 
> > - In directory stable/, fix the following words: "associtated" for "associated",
> >   "hexidecimal" for "hexadecimal", "vlue" for "value", "csed" for "caused" and 
> >   "wrtie" for "write". This updates a total of five files.
> > 
> > - In directory testing/, fix the following words: "subystem" for "subsystem", 
> >   isochrnous" for "isochronous", "Desctiptors" for "Descriptors", "picutre" for 
> >   "picture", "capture" for "capture", "occured" for "ocurred", "connnected" for 
> >   "connected","agressively" for "aggressively","manufacturee" for "manufacturer"
> >   and "transaction" for "transaction" and "malformatted" for "malformed". This 
> >   updates a total of ten files.
> > 
> > Signed-off-by: Carlos Bilbao <bilbao@vt.edu>  
> 
> ...
>  
> > diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> > index ef00fada2efb..bfd017204563 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-pci
> > +++ b/Documentation/ABI/testing/sysfs-bus-pci
> > @@ -139,7 +139,7 @@ Description:
> >  		binary file containing the Vital Product Data for the
> >  		device.  It should follow the VPD format defined in
> >  		PCI Specification 2.1 or 2.2, but users should consider
> > -		that some devices may have malformatted data.  If the
> > +		that some devices may have malformed data.  If the
> >  		underlying VPD has a writable section then the
> >  		corresponding section of this file will be writable.
> >    
> 
> (not a native English speaker here)
> 
> I'm in doubt about this one. The description is talking about the
> "VPD format".
> 
> On a quick look, it sounds that malformatted is valid, at least
> in computing:
> 
> 	https://en.wiktionary.org/wiki/malformatted
> 	https://etymologeek.com/eng/malformatted/73029882
> 	https://en.glosbe.com/en/en/malformatted
> 
> Maybe the best here would be to double-check with PCI maintainers
> and/or take a look at PCI specs and see what it is used there.

For reference, PCI specs make heavy use of malformed and very little
(possibly none) of malformatted.  However neither is used wrt to
VPD (that I can see anyway) so this info is largely irrelevant :)

> 
> Thanks,
> Mauro

