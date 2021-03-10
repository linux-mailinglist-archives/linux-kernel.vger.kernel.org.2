Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D926334A43
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 23:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbhCJV66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 16:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbhCJV6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 16:58:36 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C97C061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 13:58:36 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id u14so25028846wri.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 13:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:message-id:references:mime-version:content-disposition
         :in-reply-to:subject:resent-from:resent-to:resent-cc:date:user-agent
         :content-transfer-encoding;
        bh=f6b0ySB65gAluU5jkcMgJzHgnrlwCgvwd9FpZIquqBY=;
        b=sTiEgF9Iv4fCiL3Fy32ZvjCnLrs4D6vQuKqN8uoGBKyfVHIPjm2LrzI8//JvGYCb1y
         s3lID+lzc+0jNED80PzqxXrm5XnE6xKbobpg7KnI66V/f6DAnsPTBX6u7Yhu7VW0eF7Q
         OizfaRos09J1eykOY5BifFAYVZs3y7R2g4sOT9qIo0lb3KtXFUePcpPcdHqDZxQ+HnjU
         NGNJp9eEIntQQdvuL5IUzGJEbcYPVM9goGKtf5xYASKnQ6Z8LvXV5I0ieJZEHfmu4CHT
         IYaEv0xaruNH2stzyvklmuEx4gE3ghrwZ4JqOMPEpxucYG+/GaEfYiSEsk/xkMUERQ8V
         3tug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:message-id:references:mime-version
         :content-disposition:in-reply-to:subject:resent-from:resent-to
         :resent-cc:date:user-agent:content-transfer-encoding;
        bh=f6b0ySB65gAluU5jkcMgJzHgnrlwCgvwd9FpZIquqBY=;
        b=NovMd+/ioBcAZ0vaddW/bcRL0ti2/JX/U8mO5Ml2N9AzzrC+wveiRnITsQyFt+E61L
         KRXbF0YOy19GOJxClZFBglArqnzRDKhnvA/bc3u/8OEwc8oNDeP4jVwloHYLQ/JNobap
         fr2KS50p4k5x7Fqgth6nCrkSBlbGeGQwN857IVkTP+C96p+O+rsj3dSD6pvcX8qpt8Lc
         RW897zHQS9IkOm5g0fUjVKqtx5JoZvFB+q6RgFBpZFaWsf+OOlvpNzj2KCMJW5oMVkqV
         wYSUE76tA9ewpRrBMrBqLbdZRZTC9ke6LNVuhoVYcZ32Q5JGCAwnSp6kQ2f7bHT1hStV
         mqXg==
X-Gm-Message-State: AOAM532VUviAe72oOspvbGEk7WYTk4YIRGCnOUm9fjJtDvtQphwMg4p6
        4Ag/UAcdurH3LazOiBaOIWbrjVxRKssEiw==
X-Google-Smtp-Source: ABdhPJzAqp1TDvBlhWhHs4lT0gM4vzEdEygAfn3QYyV1nKIi3kGqgBleYJHJyCu3Cupn/+7/E54qxA==
X-Received: by 2002:adf:e412:: with SMTP id g18mr5656234wrm.159.1615413514837;
        Wed, 10 Mar 2021 13:58:34 -0800 (PST)
Received: from [192.168.43.236] ([5.171.80.77])
        by smtp.gmail.com with ESMTPSA id u15sm684371wmq.4.2021.03.10.13.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 13:58:34 -0800 (PST)
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
Date:   Wed, 10 Mar 2021 22:58:32 +0100
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

