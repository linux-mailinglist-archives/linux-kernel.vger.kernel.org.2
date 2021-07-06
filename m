Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D14463BD711
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 14:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241856AbhGFMwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 08:52:14 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38432 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234097AbhGFMvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 08:51:55 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 166CmqW9104182;
        Tue, 6 Jul 2021 07:48:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1625575732;
        bh=X05FnYoKxRSCne0OLVScHDWZqgGbTTdX6wSsjOf0axM=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=OoWAhqpiKRWPhBTfnLSs875Xj53JKi20JbZWjMtbJM4yCoSrXiKMjAm0Ad2oYFICw
         fnseG/bVkoQFnifwvApxfWO9T6QCeBEx3nDXj1JalogsL+cpITjfVusfpYXnRoAf+v
         tD6MyAMIXe69WhyRich7p3dhImFdkwL2TdsF7UQ4=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 166CmqVk002776
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Jul 2021 07:48:52 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 6 Jul
 2021 07:48:52 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 6 Jul 2021 07:48:52 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 166CmqoE083682;
        Tue, 6 Jul 2021 07:48:52 -0500
Date:   Tue, 6 Jul 2021 07:48:52 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Jonathan Corbet <corbet@lwn.net>
CC:     Thorsten Leemhuis <linux@leemhuis.info>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <linux-spdx@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Rahul T R <r-ravikumar@ti.com>
Subject: Re: [PATCH] LICENSES/dual/CC-BY-4.0: Lets switch to utf-8
Message-ID: <20210706124852.qo7safg4va5nxmvu@reoccur>
References: <20210703012931.30604-1-nm@ti.com>
 <875yxokdd0.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875yxokdd0.fsf@meer.lwn.net>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09:08-20210705, Jonathan Corbet wrote:
> Nishanth Menon <nm@ti.com> writes:
> 
> > Lets drop the unicode characters that peeped in and replace with
> > equivalent utf-8 characters. This makes the CC-BY-4.0 file inline with
> > rest of license files.
> >
> > This messes up code such as scripts/spdxcheck.py which assumed utf-8
> > LICENSE files.
> >
> > Fixes: bc41a7f36469 ("LICENSES: Add the CC-BY-4.0 license")
> 
> So...this file *is* in UTF-8; I'm finding your changelog a bit
> confusing. 

Arrgh, you are right.
> 
> > Cc: Thorsten Leemhuis <linux@leemhuis.info>
> > CC: Thomas Gleixner <tglx@linutronix.de>
> > CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > CC: Christoph Hellwig <hch@lst.de>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> >
> > Reported-by: Rahul T R <r-ravikumar@ti.com>
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > ---
> > also see: https://lore.kernel.org/linux-spdx/20210703012128.27946-1-nm@ti.com/T/#u
> >
> >  LICENSES/dual/CC-BY-4.0 | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/LICENSES/dual/CC-BY-4.0 b/LICENSES/dual/CC-BY-4.0
> > index 45a81b8e4669..869cad3d1643 100644
> > --- a/LICENSES/dual/CC-BY-4.0
> > +++ b/LICENSES/dual/CC-BY-4.0
> > @@ -392,7 +392,7 @@ Section 8 -- Interpretation.
> >  Creative Commons is not a party to its public
> >  licenses. Notwithstanding, Creative Commons may elect to apply one of
> >  its public licenses to material it publishes and in those instances
> > -will be considered the “Licensor.” The text of the Creative Commons
> > +will be considered the "Licensor." The text of the Creative Commons
> 
> It seems that what you're really doing is replacing "smart quotes" with
> the basic ASCII variety?  That seems like a fine thing to do, but that's
> not really what the changelog says.

Yes, that was the intent, the description and $subject came out all
wrong.
> 
> I can tweak it when I apply this.

Thanks. Let me know if it turns out that I need to respin the patch.
> 
> Meanwhile, though, if there's a bug it's the spdxcheck.py issue reported
> by Rahul.  That problem doesn't reproduce here; he must be running in an
> environment where ASCII is assumed.  Being explicit about the encoding
> expected is the right fix in any case...  Maybe I'll snag that patch as
> well if nobody else beats me to it.

Thanks again.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
