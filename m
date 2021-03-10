Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A10D334B44
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 23:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbhCJWNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 17:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233889AbhCJWNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 17:13:38 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BBAC061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 14:13:37 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id t5-20020a1c77050000b029010e62cea9deso11624691wmi.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 14:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:message-id:references:mime-version:content-disposition
         :in-reply-to:subject:resent-from:resent-to:resent-cc:date:user-agent
         :content-transfer-encoding;
        bh=f6b0ySB65gAluU5jkcMgJzHgnrlwCgvwd9FpZIquqBY=;
        b=dUOutTFWzecLpw/uH1JQ7qFklqMkd1HC0mHP4hUFIznvT0XIZcvRdVnhV4JznL1zyg
         GcorLaiY44LNgaoPg283+dUDbyX4eawoN4xnjnmeb0dvehqLfIfj7LfnseGbl5Fn/nyb
         kt5dbbShu6NOpJjSQ+pVy1PHHWIaLszqK/HJpZp5F4SpEwA+HlJLSDsRXjvsC5BIhMAH
         g5bR004z4zxJpfr5HCYMjrmDzlZm8O7P9bBGPk/7Vsf4AZp0Igv4Mie/diTvrTfj7LIs
         vLXdT0N7Gmv1k6vL0+Ve/Z5YLdt5bh1FxEryctQwrAHPPCCeOONFfEPGuCQopZ2fUv5G
         nnwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:message-id:references:mime-version
         :content-disposition:in-reply-to:subject:resent-from:resent-to
         :resent-cc:date:user-agent:content-transfer-encoding;
        bh=f6b0ySB65gAluU5jkcMgJzHgnrlwCgvwd9FpZIquqBY=;
        b=GIIVnCL8qinVDkPi9xPysAeGEWHHXEZ7RDKmCCDVaIobAfSvf6mcPIK8HWckbxaCat
         JepaCVCL5/KESjo2cFEAw4hfWgWfhtkoxFyk360KGEqJMFGbD/NdYyJmDcmODDI3gjCt
         QU0TFKlhlMJbfISn49SMppHJXH1/b/9v5YFXPkX9BHFRiM3UuOT0RglWMtDzkF2n5MAc
         DQtfZJxb+ALQ64KTJyA8p+sKVcQG8aZVvslahN5qELq1cmEpUrI1UU5NhqzVj8sP8iIx
         k+0kg43QoxXOBrAexlNHv+Q10WkhMwdyeZTZfzBj2/JCVkfpIb9v0VuhxqS5eFLBkSvV
         EK5g==
X-Gm-Message-State: AOAM532TmjTBZqPjfME7ZTsjoWqs0qL2wxBZ0UkGEN4OFtqxD7ex9lWa
        Kfxe3I/GmLevqXnB9HJqrHYuoaVexcY=
X-Google-Smtp-Source: ABdhPJy+jaRhQfyr5OAeh4pDipJ/SdY0izbXnb/3YYJI9iW5xj0hYSCcuVsquyReoZH6DrILWwTnWw==
X-Received: by 2002:a05:600c:19ce:: with SMTP id u14mr4701474wmq.109.1615414416742;
        Wed, 10 Mar 2021 14:13:36 -0800 (PST)
Received: from [192.168.43.236] ([5.171.72.165])
        by smtp.gmail.com with ESMTPSA id b65sm760286wmh.4.2021.03.10.14.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 14:13:36 -0800 (PST)
Received: from agape.jhs ([151.47.162.135]) by smtp.gmail.com with ESMTPSA
 id f21sm10126639ejw.124.2021.03.10.08.09.50 for
 <gregkh@linuxfoundation.org> (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384
 bits=256/256); Wed, 10 Mar 2021 08:09:50 -0800 (PST)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Message-ID: <20210310160946.GA6421@agape.jhs>
References: <20210310153717.GA5741@agape.jhs>
 <YEjrEErDZTH47gto@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEjrEErDZTH47gto@kroah.com>
Subject: Re: [PATCH] staging: rtl8723bs: align comments
Date:   Wed, 10 Mar 2021 23:13:35 +0100
User-Agent: Evolution 3.30.5-1.1 
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 04:51:44PM +0100, Greg KH wrote:
> On Wed, Mar 10, 2021 at 04:37:21PM +0100, Fabio Aiuto wrote:
> > fix the following checkpatch warnings:
> >=20
> > WARNING: Block comments use * on subsequent lines
> > +	/*
> > +		AMPDU_para [1:0]:Max AMPDU Len =3D> 0:8k , 1:16k, 2:32k, 3:64k
> > --
> > WARNING: Block comments use * on subsequent lines
> > +/*
> > +op_mode
> >=20
> > Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> > ---
> >  drivers/staging/rtl8723bs/core/rtw_ap.c | 28 ++++++++++++-------------
> >  1 file changed, 14 insertions(+), 14 deletions(-)
> >=20
> > diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/=
rtl8723bs/core/rtw_ap.c
> > index b6f944b37b08..3a0e4f64466a 100644
> > --- a/drivers/staging/rtl8723bs/core/rtw_ap.c
> > +++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
> > @@ -721,9 +721,9 @@ static void update_hw_ht_param(struct adapter *pada=
pter)
> > =20
> >  	/* handle A-MPDU parameter field */
> >  	/*
> > -		AMPDU_para [1:0]:Max AMPDU Len =3D> 0:8k , 1:16k, 2:32k, 3:64k
> > -		AMPDU_para [4:2]:Min MPDU Start Spacing
> > -	*/
> > +	 *	AMPDU_para [1:0]:Max AMPDU Len =3D> 0:8k , 1:16k, 2:32k, 3:64k
> > +	 *	AMPDU_para [4:2]:Min MPDU Start Spacing
> > +	 */
> >  	max_AMPDU_len =3D pmlmeinfo->HT_caps.u.HT_cap_element.AMPDU_para & 0x=
03;
> > =20
> >  	min_MPDU_spacing =3D (
> > @@ -1815,17 +1815,17 @@ void update_beacon(struct adapter *padapter, u8=
 ie_id, u8 *oui, u8 tx)
> >  }
> > =20
> >  /*
> > -op_mode
> > -Set to 0 (HT pure) under the following conditions
> > -	- all STAs in the BSS are 20/40 MHz HT in 20/40 MHz BSS or
> > -	- all STAs in the BSS are 20 MHz HT in 20 MHz BSS
> > -Set to 1 (HT non-member protection) if there may be non-HT STAs
> > -	in both the primary and the secondary channel
> > -Set to 2 if only HT STAs are associated in BSS,
> > -	however and at least one 20 MHz HT STA is associated
> > -Set to 3 (HT mixed mode) when one or more non-HT STAs are associated
> > -	(currently non-GF HT station is considered as non-HT STA also)
> > -*/
> > + *op_mode
> > + *Set to 0 (HT pure) under the following conditions
> > + *	 - all STAs in the BSS are 20/40 MHz HT in 20/40 MHz BSS or
> > + *	 - all STAs in the BSS are 20 MHz HT in 20 MHz BSS
> > + *Set to 1 (HT non-member protection) if there may be non-HT STAs
> > + *	 in both the primary and the secondary channel
> > + *Set to 2 if only HT STAs are associated in BSS,
> > + *	 however and at least one 20 MHz HT STA is associated
> > + *Set to 3 (HT mixed mode) when one or more non-HT STAs are associated
> > + *	 (currently non-GF HT station is considered as non-HT STA also)
> > + */
>=20
> Add a space after the ' ' to make it look correct please.
>=20
> thanks,
>=20
> greg k-h
I am sorry, I fear I don't understand, checkpatch.sh script says the patch =
is ok.
Where have I to add a ' ' (a blank?)?

thank you,

fabio

