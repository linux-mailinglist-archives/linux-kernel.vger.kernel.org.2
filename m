Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE415400AC0
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 13:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351057AbhIDKH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 06:07:28 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:45431 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351016AbhIDKH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 06:07:26 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 295335804A3;
        Sat,  4 Sep 2021 06:06:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sat, 04 Sep 2021 06:06:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=ZtKpVg177OTzh0Ohhb3bXC9Gfrs
        WEgSOsLMzs3dNp0E=; b=EXHCOXivVlVVx7Yblbq4QwmWeaFjiHDbOufzUXQl360
        R+/mxC2PPuRFusDB0CZTA9CAI2DDtTMSBUxmhdi3JbNAn93EIuK41NDAaz0BX+1o
        MdMvNhrupBmQP37cQNA6RQARDN0N4FIjMGY0gzqLwia6/VFMXm0GrA/0bO5FhrC+
        p6FIWa/k/aZFwnf1b7cVIoB4wX26ETkjd/kV+68ftrs+upE69ijV8MSD/tcLQXRw
        Y+K/Z069k0gw+Mc8+6KiXPE9CxY08jC19iBGXnRwFKaTXqJ8K0yw9oZbSRmWVIXx
        5B7wf7ajhx52S6NDpW5njZ8qBsDmWy+tkMe8i0t0VhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=ZtKpVg
        177OTzh0Ohhb3bXC9GfrsWEgSOsLMzs3dNp0E=; b=TmiKGB6YYLXLuZmfr57NqH
        6AmQAw0/LpFf4ughNQ+oSEh8M3fkdJEQW1Z0eiaU9A6gCM7BCoDcdZlgEhCD5VP2
        4E+Tp54sWtkR6eK7ja4VHvQ9QmfUsfyKWVfPfl6Mfds/g00FWnsm7a6UltFWcsZf
        ep+c1u60iUMqwvQF3IVNA4LSbi7Bv2Cp01RPPjNtQwIYohPJfMYycn0Qsr0aaRAZ
        gdVuRP3vnc0syTBsRDgdAujZ1Yxl0QaOtjExZ3vmjYHd8/iUaxApWhlYhBeuo/ia
        r93eWdx4u+SfQ8WJDqRva5ETcUptsAzay11CJmk4SPsjRHICmonNKe1PRcl76zUA
        ==
X-ME-Sender: <xms:H0UzYZpljogFzy7H8rH3FaXZG55gslWsbaoWDWCGVzvztAjqj0gUTA>
    <xme:H0UzYbq615H4mcBqX7g8u16kYvO2Du0PEBWzRngd7PLiE-p2_IdlIXfmLDYiV_cqc
    CYUcsQR3JVbVw>
X-ME-Received: <xmr:H0UzYWP1dVGG7LlUjIKwAbvaoPzat_DqQ5Ulogksz6CiQ36-vxR-R_c8A5NYx_hACPEzGxKzbb9B1s_mN6F4wITYsIrtFXPS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvledgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevueehje
    fgfffgiedvudekvdektdelleelgefhleejieeugeegveeuuddukedvteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:H0UzYU7Z1__apsSNOJC4k9tGQOfgdLu_TS1veWL-PbkRQOpd17VU2A>
    <xmx:H0UzYY5eTxCdRW7CO0mh-JLT5I71vPrMecs-6_KBItLlc2VAmOJbew>
    <xmx:H0UzYchyjRDzPeHnTIyGC0ILuFv9SQgMhfiJo30CSOt4cK_8Flfb1Q>
    <xmx:IEUzYXR9QnP-Ds5EoGMaz3rh09ggsL0y5Yj6G-eQ_FpRvo3Ajf2GmQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 4 Sep 2021 06:06:22 -0400 (EDT)
Date:   Sat, 4 Sep 2021 12:06:21 +0200
From:   Greg KH <greg@kroah.com>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        saurav.girepunje@hotmail.com
Subject: Re: [PATCH] staging: r8188eu: os_dep: simplifiy the rtw_resume
 function
Message-ID: <YTNFHd6o0f9rAMO2@kroah.com>
References: <YTM+wayCk2n2CrVP@user>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTM+wayCk2n2CrVP@user>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 04, 2021 at 03:09:13PM +0530, Saurav Girepunje wrote:
> Remove unused variable ret and pwrpriv.
> Remove the condition with no effect (if == else) in usb_intf.c
> file.
> 
> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> ---
>  drivers/staging/r8188eu/os_dep/usb_intf.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
> index bb85ab77fd26..673cd3001183 100644
> --- a/drivers/staging/r8188eu/os_dep/usb_intf.c
> +++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
> @@ -493,14 +493,8 @@ static int rtw_resume(struct usb_interface *pusb_intf)
>  {
>  	struct dvobj_priv *dvobj = usb_get_intfdata(pusb_intf);
>  	struct adapter *padapter = dvobj->if1;
> -	struct pwrctrl_priv *pwrpriv = &padapter->pwrctrlpriv;
> -	int ret = 0;
> 
> -	if (pwrpriv->bInternalAutoSuspend)
> -		ret = rtw_resume_process(padapter);
> -	else
> -		ret = rtw_resume_process(padapter);
> -	return ret;
> +	return rtw_resume_process(padapter);
>  }
> 
>  int rtw_resume_process(struct adapter *padapter)

Why not just delete the rtw_resume_process() declaration line and make
the rtw_resume() function be the whole thing, as rtw_resume_process() is
never called anywhere else.  That would be even more lines of code
removed and simplified here.

thanks,

greg k-h
